#!/bin/bash

#************************************************************************************************************+
#--File Name          :       XXRSARAG7BUCREP_INSTALL_121012-06690.sh                                        |
#--Program Purpose    :       Rackspace Aging 7 Bucket Report                                                |
#--Author Name        :       Vinodh Bhasker                                                                         |
#--Initial Build Date :       28-SEP-2012                                                                    |
#--                                                                                                          |
#--Version            :       1.0.0                                                                          |
#------------------------------------------------------------------------------------------------------------+
#--Modification History                                                                                      |
#------------------------------------------------------------------------------------------------------------+
#   | Ver   | Ticket No.   | Author          | Date       | Description                                      |
#------------------------------------------------------------------------------------------------------------+
#   | 1.0.0 | 121012-06690 | Vinodh Bhasker  | 28-SEP-2012| Installation for print group changes             |
#------------------------------------------------------------------------------------------------------------+
#************************************************************************************************************/
#
#-- $Header: XXRSARAG7BUCREP_INSTALL_121012-06690.sh 1.0.0 28-SEP-2012 04:46:00 PM Vinodh $ 
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
 OUTFILE=$OUTDIR/XXRSARAG7BUCREP_INSTALL_121012-06690.out
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
ALTER TABLE XXRS.XXRS_AR_AGING_7_REP_GT
ADD (ATTRIBUTE6 VARCHAR2(150 BYTE));
@XXRS_AR_AGING_PKG.pks;
@XXRS_AR_AGING_PKG.pkb;
exit;
EOF
}
 
#--------------------------------------------------------------------------
# Mailing output file
#--------------------------------------------------------------------------
MailOutFile()
{
  /bin/mail pavan.amirineni@rackspace.com -c vinodh.bhasker@rackspace.com,bruce.martinez@rackspace.com,tim.cowen@rackspace.com -s "Installation log for Rackspace Aging 7 Bucket Report in ${TWO_TASK}" < $OUTFILE
}
#--------------------------------------------------------------------------
# Using the FNDLOAD to load AOL objects
#--------------------------------------------------------------------------
LoadAOLData()
{
  cd ${LDT_DIR}

  FNDLOAD $p_apps_usrn_pwd 0 Y UPLOAD @FND:patch/115/import/afcpprog.lct XXRSARAG7BUCREP.ldt CUSTOM_MODE='FORCE' >> $OUTFILE
  
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
-CUSTOM_MODE FORCE >> $OUTFILE

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
