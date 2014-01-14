#!/bin/bash
#************************************************************************************************************+
#--File Name          :       XXRS_INV_MISC_TRANSACTION_INSTALL_111122-02448.sh                              |
#--Program Purpose    :       Installation script for Misc Transaction                                       |
#--Author Name        :       Ravi                                                                           |
#--Initial Build Date :       18-JAN-2012                                                                    |
#--                                                                                                          |
#--Version            :       1.0.0                                                                          |
#--Modification History                                                                                      |
#   | Ver   | Ticket No.   | Author          | Date        | Description                                     |
#------------------------------------------------------------------------------------------------------------+
#-- | 1.0.0 | 111122-02448 | Ravi            | 18-JAN-2012 | Initial Build for R12 Upgradation               |
#------------------------------------------------------------------------------------------------------------+
#************************************************************************************************************/
# $Header: XXRS_INV_MISC_TRANSACTION_INSTALL_111122-02448.sh 1.0.0 18-JAN-2012 4:24:51 PM Ravi $ 
#
#--------------------------------------------------------------------------
# Set the environmental variables and other administrative requirements.
#--------------------------------------------------------------------------
 DATETIMESTAMP=`date +%Y%m%d%H%M%S`
 p_apps_usrn_pwd=$1
 jdbc=$2
 CUSTOM_TOP=$XXRS_TOP
 SQL_DIR=$CUSTOM_TOP/install/sql
 LDT_DIR=$CUSTOM_TOP/install/ldt
 XML_DIR=$CUSTOM_TOP/xml
 LOG_DIR=$CUSTOM_TOP/log
 INSTALL_DIR=$CUSTOM_TOP/install
 OUTDIR=$CUSTOM_TOP/out
 OUTFILE=$OUTDIR/XXRS_INV_MISC_TRANSACTION_INSTALL_111122-02448.out
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
@XXRS_INV_MISC_TRX_TAB.sql
@XXRS_INV_MISC_TRX_PKG.pks
@XXRS_INV_MISC_TRX_PKG.pkb
exit;
/
EOF
}
#--------------------------------------------------------------------------
# Create Directory Structure
#--------------------------------------------------------------------------
 Createdir()
 {
   mkdir -p $XXRS_TOP/data/fa/misc_trx
   echo -e "\nCreated Directory Structure $XXRS_TOP/data/fa/misc_trx\n" >> $OUTFILE 
   chmod -R 775 $XXRS_TOP/data/fa/misc_trx
   echo -e "\nChanged Permissions recursively on $XXRS_TOP/data/fa/misc_trx\n" >> $OUTFILE
   mkdir -p $XXRS_TOP/archive/fa/misc_trx
   echo -e "\nCreated Directory Structure $XXRS_TOP/archive/fa/misc_trx\n" >> $OUTFILE 
   chmod -R 775 $XXRS_TOP/archive/fa/misc_trx
   echo -e "\nChanged Permissions recursively on $XXRS_TOP/archive/fa/misc_trx\n" >> $OUTFILE
 } 
#--------------------------------------------------------------------------
# Mailing output file
#--------------------------------------------------------------------------
MailOutFile()
{
  /bin/mail vinodh.bhasker@rackspace.com -c bruce.martinez@rackspace.com,tim.cowen@rackspace.com -s "Installation log for Rackspace Misc Transactions Interface in ${TWO_TASK}" < $OUTFILE
}
#--------------------------------------------------------------------------
# Using the FNDLOAD to load AOL objects
#--------------------------------------------------------------------------
LoadAOLData()
{
  cd ${LDT_DIR}

  FNDLOAD $p_apps_usrn_pwd 0 Y UPLOAD @FND:patch/115/import/afcpprog.lct XXRSINVLOADTRX.ldt CUSTOM_MODE="FORCE">> $OUTFILE
  FNDLOAD $p_apps_usrn_pwd 0 Y UPLOAD @FND:patch/115/import/afcpreqg.lct XXRSINVLOADTRX_REQ.ldt CUSTOM_MODE="FORCE">> $OUTFILE
  FNDLOAD $p_apps_usrn_pwd 0 Y UPLOAD @FND:patch/115/import/afcpreqg.lct XXRSINVLOADTRX_REQ_INV.ldt CUSTOM_MODE="FORCE">> $OUTFILE
  FNDLOAD $p_apps_usrn_pwd 0 Y UPLOAD @FND:patch/115/import/afcpreqg.lct XXRSINVLOADTRX_REQ_TRAN.ldt CUSTOM_MODE="FORCE">> $OUTFILE
# Profile Option
  FNDLOAD $p_apps_usrn_pwd O Y UPLOAD @FND:patch/115/import/afscprof.lct XXRS_RESTR_MISC_TRNS.ldt CUSTOM_MODE="FORCE" >> $OUTFILE
  FNDLOAD $p_apps_usrn_pwd O Y UPLOAD @FND:patch/115/import/aflvmlu.lct XXRS_MISC_TRNS_TYPES.ldt CUSTOM_MODE="FORCE" >> $OUTFILE

  
  cat *.log >> $OUTFILE
  mv *.log ${LOG_DIR}
}
#--------------------------------------------------------------------------
# Using the XDOLOADER to load XML Publisher Files
#--------------------------------------------------------------------------

#--------------------------------------------------------------------------
# Calling Functions
#--------------------------------------------------------------------------
Psswd

echo -e "\nCREATIONG Database Objects...\n" >> $OUTFILE
CreateDBObjects

echo -e "\nCREATIONG Directories...\n" >> $OUTFILE
Createdir

echo -e "\nLOADING AOL Data...\n" >> $OUTFILE
LoadAOLData

echo -e "\nEmailing the outfile.\n"
MailOutFile

echo -e "\nOutput file is ${OUTFILE}"
