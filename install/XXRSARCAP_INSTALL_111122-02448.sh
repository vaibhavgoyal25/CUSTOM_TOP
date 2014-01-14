#!/bin/bash

#************************************************************************************************************+
#--File Name          :       XXRSARCAP_INSTALL_111122-02448.sh                                              |
#--Program Purpose    :       Installation script for Rackspace Cash Application Program                     |
#--Author Name        :       Kalyan                                                                         |
#--Initial Build Date :       20-FEB-2011                                                                    |
#--                                                                                                          |
#--Version            :       1.0.0                                                                          |
#------------------------------------------------------------------------------------------------------------+
#--Modification History                                                                                      |
#   | Ver   | Ticket No.   | Author                  | Date       | Description                              |
#------------------------------------------------------------------------------------------------------------+
#-- | 1.0.0 | 111122-02448 | Kalyan                  | 20-FEB-11  | Initial Build                            |
#------------------------------------------------------------------------------------------------------------+
#************************************************************************************************************/
#   $Header: XXRSARCAP_INSTALL_111122-02448.sh 1.0.0 20-FEB-2011 15:00:00 Kalyan$
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
 OUTFILE=$OUTDIR/XXRSARCAP_INSTALL_111122-02448.out
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
  /bin/mail pavan.amirineni@rackspace.com -c bruce.martinez@rackspace.com,tim.cowen@rackspace.com -s "Installation log for Rackspace Cash Application Program in ${TWO_TASK}" < $OUTFILE
}
#--------------------------------------------------------------------------
# Create Database Objects
#--------------------------------------------------------------------------
CreateDBObjects()
{
cd $SQL_DIR
sqlplus $p_apps_usrn_pwd << EOF
spool $OUTFILE
@XXRS_AR_CASH_APPLICATION_GT.sql
@XXRS_AR_TRX_APPLIED_GT.sql
@XXRS_AR_CASH_APP_PKG.pks
@XXRS_AR_CASH_APP_PKG.pkb
exit;
/
EOF
}

#--------------------------------------------------------------------------
# Using the FNDLOAD to load Meta Data Definitions
#--------------------------------------------------------------------------
 CreateAOLObjects()
 {
   cd $LDT_DIR 
#  Concurrent Program Definition
   $FND_TOP/bin/FNDLOAD $apps_login/$apps_pwd O Y UPLOAD $FND_TOP/patch/115/import/afcpprog.lct $CUSTOM_TOP/install/ldt/XXRSARCAP.ldt CUSTOM_MODE="FORCE">> $OUTFILE
#  Program attached to Request Group
   $FND_TOP/bin/FNDLOAD $apps_login/$apps_pwd O Y UPLOAD $FND_TOP/patch/115/import/afcpreqg.lct $CUSTOM_TOP/install/ldt/XXRSARCAP_REQ_RA.ldt CUSTOM_MODE="FORCE">> $OUTFILE   
   $FND_TOP/bin/FNDLOAD $apps_login/$apps_pwd O Y UPLOAD $FND_TOP/patch/115/import/afcpreqg.lct $CUSTOM_TOP/install/ldt/XXRSARCAP_REQ_HK.ldt CUSTOM_MODE="FORCE">> $OUTFILE   
# Output the FNDLOAD log files to the out file
   cat *.log >> $OUTFILE
# Clear all the FNDLOAD log files from the install directory
   mv *.log $CUSTOM_TOP/log 
 }
#--------------------------------------------------------------------------
# Calling Functions
#--------------------------------------------------------------------------
 Psswd
#
 echo -e "\nDone.\n" >> $OUTFILE

CreateDBObjects
#
 echo -e "\nCREATING AOL Objects and XML MetaData Definitions...\n" >> $OUTFILE
 CreateAOLObjects
#
 echo -e "\nInstallation output file: ${OUTFILE}" 
 echo -e "\nEmailing the outfile.\n"
 MailOutFile
