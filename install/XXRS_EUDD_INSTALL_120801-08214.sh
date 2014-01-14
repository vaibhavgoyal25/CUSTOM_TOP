#!/bin/bash

#************************************************************************************************************+
#--File Name          :       XXRS_EUDD_INSTALL_120801-08214.sh                                              |
#--Program Purpose    :       Installation script for Rackspace European Direct debit process                |
#--Author Name        :       Pavan Amirineni                                                                |
#--Initial Build Date :       28-SEP-2012                                                                    |
#--                                                                                                          |
#--Version            :       1.0.0                                                                          |
#------------------------------------------------------------------------------------------------------------+
#--Modification History                                                                                      |
#   | Ver   | Ticket No.   | Author          | Date        | Description                                     |
#------------------------------------------------------------------------------------------------------------+
#-- | 1.0   | 120801-08214 | Pavan Amirineni | 28-SEP-2012 | Initial Build                                   |
#------------------------------------------------------------------------------------------------------------+
#************************************************************************************************************/
#-- $Header: XXRS_EUDD_INSTALL_120801-08214.sh 1.0.0 28-SEP-2012 08:33:23 PM Pavan Amirineni  $ 
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
 OUTFILE=$OUTDIR/XXRS_EUDD_INSTALL_120801-08214.out
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
# Mailing output file
#--------------------------------------------------------------------------
MailOutFile()
{
  /bin/mail pavan.amirineni@rackspace.com -c bruce.martinez@rackspace.com,tim.cowen@rackspace.com -s "Installation log for Rackspace NL Direct Debit ${TWO_TASK}" < $OUTFILE
}

#--------------------------------------------------------------------------
# Using the XDOLOADER to load XML Publisher Files
#--------------------------------------------------------------------------
 LoadXMLFiles()
 {
  cd $XML_DIR

java oracle.apps.xdo.oa.util.XDOLoader \
UPLOAD \
-DB_USERNAME $apps_login \
-DB_PASSWORD $apps_pwd \
-JDBC_CONNECTION $jdbc \
-LOB_TYPE DATA_TEMPLATE \
-APPS_SHORT_NAME XXRS \
-LOB_CODE XXRSARDDOB \
-LANGUAGE en \
-TERRITORY US \
-XDO_FILE_TYPE XML \
-FILE_NAME ${XML_DIR}/XXRSARDDOB.xml \
-NLS_LANG AMERICAN_AMERICA.UTF8 \
-CUSTOM_MODE FORCE >> $OUTFILE

java oracle.apps.xdo.oa.util.XDOLoader \
UPLOAD \
-DB_USERNAME apps \
-DB_PASSWORD $apps_pwd \
-JDBC_CONNECTION $jdbc \
-LOB_TYPE TEMPLATE \
-APPS_SHORT_NAME XXRS \
-LOB_CODE XXRSARDDOB \
-LANGUAGE en \
-TERRITORY US \
-XDO_FILE_TYPE XSL-XML \
-FILE_NAME ${INSTALL_DIR}/XXRSARDDOB.xsl \
-NLS_LANG AMERICAN_AMERICA.UTF8 \
-CUSTOM_MODE FORCE >> $OUTFILE
 }
#--------------------------------------------------------------------------
# Create Database Objects
#--------------------------------------------------------------------------
CreateDBObjects()
{
cd $SQL_DIR
sqlplus $apps_login/$apps_pwd << EOF
spool $OUTFILE
@XXRS_AR_DIRECT_DEBIT_PKG.pkb
exit;
/
EOF
}
#--------------------------------------------------------------------------
# Calling Functions
#--------------------------------------------------------------------------
 Psswd
#
 echo -e "\nCreating Database Objects XML Files...\n" >> $OUTFILE
 CreateDBObjects
#
 echo -e "\nLOADING XML Files...\n" >> $OUTFILE
 LoadXMLFiles
#
echo -e "\nInstallation output file: ${OUTFILE}" 
echo -e "\nDone.\n" >> $OUTFILE
MailOutFile
