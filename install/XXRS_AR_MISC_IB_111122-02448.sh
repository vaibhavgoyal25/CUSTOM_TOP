#!/bin/bash
#
#************************************************************************************************************+
#--File Name          :       XXRS_AR_MISC_IB_111122-02448.sh                                                |
#--Program Purpose    :       Install script for Receivables_Miscellaneous_Inbound_Process                   |
#--Author Name        :       Sunil Kumar Mallina                                                            |
#--Initial Build Date :       06-JAN-2012                                                                    |                                                                     |
#--Version            :       1.0                                                                            |
#--Modification History                                                                                      |
#------------------------------------------------------------------------------------------------------------+
#   | Ver     | Ticket Number   | Author                | Date         | Description                         |
#------------------------------------------------------------------------------------------------------------+
#   | 1.0.0   | 111122-02448    | Sunil Kumar Mallina   | 06-JAN-2012  | R12 Upgradation                     |
#------------------------------------------------------------------------------------------------------------+
#************************************************************************************************************/
# $Header: XXRS_AR_MISC_IB_111122-02448.sh 1.0.0 06-JAN-2012 19:57:00 PM Sunil Kumar M $ */

 DATETIMESTAMP=`date +%Y%m%d%H%M%S`
 p_apps_usrn_pwd=$1
 jdbc=$2
 CUSTOM_TOP=$XXRS_TOP
 SQL_DIR=$CUSTOM_TOP/install/sql
 LDT_DIR=$CUSTOM_TOP/install/ldt
 XML_DIR=$CUSTOM_TOP/xml
 INSTALL_DIR=$CUSTOM_TOP/install
 OUTDIR=$CUSTOM_TOP/out
 OUTFILE=$OUTDIR/XXRS_AR_MISC_IB_111122-02448.out
 apps_login=apps
 echo `date` > $OUTFILE

#--------------------------------------------------------------------------
# Define the function to get the APPS and XXRS password.
#--------------------------------------------------------------------------
Psswd()
{
  if [ -n "$p_apps_usrn_pwd" ];then
    apps_pwd=${p_apps_usrn_pwd##*/}
  else
    echo "Please enter apps password =>"
    stty -echo
    read apps_pwd
    p_apps_usrn_pwd=apps/$apps_pwd
    stty echo
  fi
  if [ -n "$jdbc" ];then
    echo ""
  else
    echo "Please enter JDBC TNSNAMES Connection, (hostname:port:SID, dfw1svdevdbs02.ora.rackspace.com:1551:DEV)=>"
    read jdbc
  fi
}
#--------------------------------------------------------------------------
# Create Database Objects
#--------------------------------------------------------------------------
CreateDBObjects()
{
cd $SQL_DIR
sqlplus $p_apps_usrn_pwd << EOF
spool $OUTFILE
@XXRS_AR_MISC_IB_TBL_CR.sql
@XXRS_AR_MISC_IB_PKG.pks
@XXRS_AR_MISC_IB_PKG.pkb
exit;
/
EOF
} 
#--------------------------------------------------------------------------
# Create Directory Structure
#--------------------------------------------------------------------------
 Createdir()
 {
   mkdir -p $XXRS_TOP/data/upload/AR/GB
   echo -e "\nCreated Directory Structure $XXRS_TOP/data/upload/AR/GB\n" >> $OUTFILE 
   chmod -R 775 $XXRS_TOP/data/upload/AR/GB
   echo -e "\nChanged Permissions recursively on $XXRS_TOP/data/upload/AR/GB\n" >> $OUTFILE
   
   mkdir -p $XXRS_TOP/archive/inbound_credit_card_uk
   echo -e "\nCreated Directory Structure $XXRS_TOP/archive/inbound_credit_card_uk\n" >> $OUTFILE 
   chmod -R 775 $XXRS_TOP/archive/inbound_credit_card_uk
   echo -e "\nChanged Permissions recursively on $XXRS_TOP/archive/inbound_credit_card_uk\n" >> $OUTFILE
 } 
#--------------------------------------------------------------------------
# Mailing output file
#--------------------------------------------------------------------------
MailOutFile()
{
  /bin/mail vinodh.bhasker@rackspace.com -c bruce.martinez@rackspace.com,tim.cowen@rackspace.com -s "Installation log for Rackspace Receivables Miscellaneous Inbound Process in ${TWO_TASK}" < $OUTFILE
}
#--------------------------------------------------------------------------
# Using the FNDLOAD to load AOL objects
#--------------------------------------------------------------------------
LoadAOLData()
{
  cd ${LDT_DIR}

  FNDLOAD $p_apps_usrn_pwd 0 Y UPLOAD @FND:patch/115/import/afcpprog.lct XXRSARMPUA.ldt >> $OUTFILE
  FNDLOAD $p_apps_usrn_pwd 0 Y UPLOAD @FND:patch/115/import/afcpprog.lct XXRSARMPP.ldt >> $OUTFILE
  FNDLOAD $p_apps_usrn_pwd 0 Y UPLOAD @FND:patch/115/import/afcprset.lct XXRSARMPIRS.ldt >> $OUTFILE
  FNDLOAD $p_apps_usrn_pwd 0 Y UPLOAD @FND:patch/115/import/afcpreqg.lct XXRSARMPIRS_REQ_ALL.ldt >> $OUTFILE
  FNDLOAD $p_apps_usrn_pwd 0 Y UPLOAD @FND:patch/115/import/afcpreqg.lct XXRSARMPIRS_REQ_HK.ldt >> $OUTFILE
  FNDLOAD $p_apps_usrn_pwd 0 Y UPLOAD @FND:patch/115/import/afcpreqg.lct XXRSARMPIRS_REQ_RS.ldt >> $OUTFILE

  cat *.log >> $OUTFILE
  mv *.log ${LOG_DIR}
}
#--------------------------------------------------------------------------
# Using the XDOLOADER to load XML Publisher Files
#--------------------------------------------------------------------------
LoadXMLFiles()
{
  cd ${INSTALL_DIR}

java oracle.apps.xdo.oa.util.XDOLoader \
UPLOAD \
-DB_USERNAME $apps_login \
-DB_PASSWORD $apps_pwd \
-JDBC_CONNECTION $jdbc \
-LOB_TYPE DATA_TEMPLATE \
-APPS_SHORT_NAME XXRS \
-LOB_CODE XXRSINVSTBCR \
-LANGUAGE en \
-TERRITORY US \
-XDO_FILE_TYPE XML \
-FILE_NAME ${XML_DIR}/XXRS_RAXINV_SEL.xml \
-NLS_LANG AMERICAN_AMERICA.UTF8 \
-CUSTOM_MODE FORCE >> $OUTFILE

  cat *.log >> $OUTFILE
  mv *.log ${LOG_DIR}
}
#--------------------------------------------------------------------------
# Calling Functions
#--------------------------------------------------------------------------
Psswd

echo -e "\nCREATIONG Database Objects...\n" >> $OUTFILE
CreateDBObjects

echo -e "\nCREATIONG Directory...\n" >> $OUTFILE
Createdir

echo -e "\nLOADING AOL Data...\n" >> $OUTFILE
LoadAOLData

echo -e "\nDone.\n" >> $OUTFILE

echo -e "\nEmailing the outfile.\n"
MailOutFile

echo -e "\nOutput file is ${OUTFILE}"
