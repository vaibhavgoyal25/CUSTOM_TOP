#!/bin/bash
#
#************************************************************************************************************+
#--File Name          :       XXRSARAUD_INSTALL_130304-08345.sh                                              |
#--Program Purpose    :       Install script for Account Updater Components                                  |
#--Author Name        :       Vaibhav Goyal                                                                  |
#--Initial Build Date :       20-MAR-2013                                                                    |
#--Version            :       1.0.0                                                                          |
#--Modification History                                                                                      |
#------------------------------------------------------------------------------------------------------------+
#   | Ver   | Ticket No.   | Author          | Date         | Description                                    |
#------------------------------------------------------------------------------------------------------------+
#   | 1.0.0 | 130304-08345 | Vaibhav Goyal   | 20-MAR-2013  | Account Updater XML update                     |
#------------------------------------------------------------------------------------------------------------+
#************************************************************************************************************/
# /* $Header: XXRSARAUD_INSTALL_130304-08345.sh 1.0.0 20-MAR-2013 15:48:00 PM Vaibhav Goyal $ */
#
#--------------------------------------------------------------------------
# Set the environmental variables and other administrative requirements.
#--------------------------------------------------------------------------
 DATETIMESTAMP=`date +%Y%m%d%H%M%S`
 p_apps_usrn_pwd=$1
 jdbc=`echo $AD_APPS_JDBC_URL`
 CUSTOM_TOP=$XXRS_TOP
 SQL_DIR=$CUSTOM_TOP/install/sql
 LDT_DIR=$CUSTOM_TOP/install/ldt
 XML_DIR=$CUSTOM_TOP/xml
 LOG_DIR=$CUSTOM_TOP/log
 INSTALL_DIR=$CUSTOM_TOP/install
 OUTDIR=$CUSTOM_TOP/out
 OUTFILE=$OUTDIR/XXRSARAUD_INSTALL_130304-08345.out
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
-LOB_CODE XXRSARAUD \
-LANGUAGE en \
-TERRITORY US \
-XDO_FILE_TYPE XML \
-FILE_NAME ${XML_DIR}/XXRSARAUD.xml \
-NLS_LANG AMERICAN_AMERICA.UTF8 \
-CUSTOM_MODE FORCE >> $OUTFILE

  cat *.log >> $OUTFILE
  mv *.log ${LOG_DIR}
}

#--------------------------------------------------------------------------
# Mailing output file
#--------------------------------------------------------------------------
MailOutFile()
{
  /bin/mail vaibhav.goyal@rackspace.com -c bruce.martinez@rackspace.com,tim.cowen@rackspace.com -s "Installation log for Rackspace Account Updater Outbound in ${TWO_TASK}" < $OUTFILE
}

#---------------------------------------------------------------------
# Call the functions					      
#---------------------------------------------------------------------

Psswd

echo -e "\nLOADing XML Publisher objects ...\n" >> $OUTFILE
LoadXMLFiles

echo -e "\nInstallation output file: ${OUTFILE}" 

echo -e "\nDone.\n" >> $OUTFILE

MailOutFile