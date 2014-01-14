#!/bin/bash

#************************************************************************************************************+
#--File Name          :       XXRSARAG7BUCREP_INSTALL_111122-02448.sh                                        |
#--Program Purpose    :       Rackspace Aging 7 Bucket Report                                                |
#--Author Name        :       Kalyan                                                                         |
#--Initial Build Date :       01-FEB-2012                                                                    |
#--                                                                                                          |
#--Version            :       1.0.0                                                                          |
#------------------------------------------------------------------------------------------------------------+
#--Modification History                                                                                      |
#------------------------------------------------------------------------------------------------------------+
#   | Ver   | Ticket No.   | Author          | Date       | Description                                      |
#------------------------------------------------------------------------------------------------------------+
#   | 1.0.0 | 111122-02448 | Kalyan          | 01-FEB-2012| Initial Build for R12 upgradation                |
#------------------------------------------------------------------------------------------------------------+
#************************************************************************************************************/
#
#-- $Header: XXRSARAG7BUCREP_INSTALL_111122-02448.sh 1.0.0 01-FEB-2012 08:33:23 PM Kalyan $ 
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
 OUTFILE=$OUTDIR/XXRSARAG7BUCREP_INSTALL_111122-02448.out
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
# Function to create database objects 
#--------------------------------------------------------------------------
CreateDBObjects()
{   
cd $SQL_DIR
sqlplus $p_apps_usrn_pwd << EOF
spool $OUTFILE
@XXRS_UTILITY_PKG.pks;
@XXRS_UTILITY_PKG.pkb;
@XXRS_WS_AR_PAPERLESS_PKG.pks;
@XXRS_WS_AR_PAPERLESS_PKG.pkb;
@XXRS_AR_AGING_7_REP_GT.sql
@XXRS_AR_AGING_PKG.pks
@XXRS_AR_AGING_PKG.pkb
exit;
EOF
}
 
#--------------------------------------------------------------------------
# Mailing output file
#--------------------------------------------------------------------------
MailOutFile()
{
  /bin/mail pavan.amirineni@rackspace.com -c prathibha.emany@rackspace.com,vinodh.bhasker@rackspace.com,bruce.martinez@rackspace.com,tim.cowen@rackspace.com -s "Installation log for Rackspace Aging 7 Bucket Report in ${TWO_TASK}" < $OUTFILE
}
#--------------------------------------------------------------------------
# Using the FNDLOAD to load AOL objects
#--------------------------------------------------------------------------
LoadAOLData()
{
  cd ${LDT_DIR}

  FNDLOAD $p_apps_usrn_pwd 0 Y UPLOAD @FND:patch/115/import/afcpprog.lct XXRSARAG7BUCREP.ldt CUSTOM_MODE='FORCE' >> $OUTFILE
     
  FNDLOAD $p_apps_usrn_pwd 0 Y UPLOAD @FND:patch/115/import/afcpreqg.lct XXRSARAG7BUCREP_REQ_HKRA.ldt CUSTOM_MODE='FORCE'>> $OUTFILE
  
  FNDLOAD $p_apps_usrn_pwd 0 Y UPLOAD @FND:patch/115/import/afcpreqg.lct XXRSARAG7BUCREP_REQ_RA.ldt CUSTOM_MODE='FORCE'>> $OUTFILE
  
  FNDLOAD $p_apps_usrn_pwd 0 Y UPLOAD @FND:patch/115/import/afcpreqg.lct XXRSARAG7BUCREP_REQ_RRA.ldt CUSTOM_MODE='FORCE'>> $OUTFILE
  
  FNDLOAD $p_apps_usrn_pwd 0 Y UPLOAD @FND:patch/115/import/afcpreqg.lct XXRSARAG7BUCREP_REQ_RRO.ldt CUSTOM_MODE='FORCE'>> $OUTFILE
  
  FNDLOAD $p_apps_usrn_pwd 0 Y UPLOAD @FND:patch/115/import/afcpreqg.lct XXRSARAG7BUCREP_REQ_CMG.ldt CUSTOM_MODE='FORCE'>> $OUTFILE
  
  FNDLOAD $p_apps_usrn_pwd 0 Y UPLOAD @FND:patch/115/import/afcpreqg.lct XXRSARAG7BUCREP_REQ_IEXR.ldt CUSTOM_MODE='FORCE'>> $OUTFILE
  
  FNDLOAD $p_apps_usrn_pwd 0 Y UPLOAD @XDO:patch/115/import/xdotmpl.lct XXRSARAG7BUCREP_XML.ldt CUSTOM_MODE='FORCE'>> $OUTFILE  
  
  cat *.log >> $OUTFILE
  mv *.log ${LOG_DIR}
}
#--------------------------------------------------------------------------
# Using the XDOLOADER to load XML Publisher Files
#--------------------------------------------------------------------------
LoadXMLFiles()
{
  cd ${INSTALL_DIR}
# Loading Template or rtf file
java oracle.apps.xdo.oa.util.XDOLoader \
UPLOAD \
-DB_USERNAME $apps_login \
-DB_PASSWORD $apps_pwd \
-JDBC_CONNECTION $jdbc \
-LOB_TYPE DATA_TEMPLATE \
-APPS_SHORT_NAME XXRS \
-LOB_CODE XXRSARAG7BUCREP \
-LANGUAGE en \
-TERRITORY US \
-XDO_FILE_TYPE XML \
-FILE_NAME ${XML_DIR}/XXRSARAG7BUCREP.xml \
-NLS_LANG AMERICAN_AMERICA.UTF8 \
-CUSTOM_MODE FORCE

java oracle.apps.xdo.oa.util.XDOLoader \
UPLOAD \
-DB_USERNAME $apps_login \
-DB_PASSWORD $apps_pwd \
-JDBC_CONNECTION $jdbc \
-LOB_TYPE TEMPLATE \
-APPS_SHORT_NAME XXRS \
-LOB_CODE XXRSARAG7BUCREP \
-LANGUAGE en \
-TERRITORY US \
-XDO_FILE_TYPE RTF \
-FILE_NAME ${XML_DIR}/XXRSARAG7BUCREP.rtf \
-NLS_LANG AMERICAN_AMERICA.UTF8 \
-CUSTOM_MODE FORCE >> $OUTFILE
  cat *.log >> $OUTFILE
  mv *.log ${LOG_DIR}
}
#--------------------------------------------------------------------------
# Calling Functions
#--------------------------------------------------------------------------
Psswd

echo -e "\nCREATING DB Objects...\n" >> $OUTFILE
CreateDBObjects >> $OUTFILE

echo -e "\nLOADING AOL Data...\n" >> $OUTFILE
LoadAOLData   

echo -e "\nLOADING XML files...\n" >> $OUTFILE
LoadXMLFiles

echo -e "\nEmailing the outfile.\n"
MailOutFile

echo -e "\nOutput file is ${OUTFILE}"