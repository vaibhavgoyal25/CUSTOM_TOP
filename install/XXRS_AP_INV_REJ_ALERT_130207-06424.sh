#!/bin/bash

#************************************************************************************************************+
#--File Name          :       XXRS_AP_INV_REJ_ALERT_130207-06424.sh                                          |
#--Program Purpose    :       Installation script for 'Rackspace Payables Invoice Rejection Alert'           |
#--Author Name        :       Vaibhav Goyal                                                                  |
#--Initial Build Date :       13-MAR-2013                                                                    |
#--                                                                                                          |
#--Version            :       1.0                                                                            |
#------------------------------------------------------------------------------------------------------------+
#--Modification History                                                                                      |
#   | Ver   | Ticket No.   | Author          | Date       | Description                                      |
#------------------------------------------------------------------------------------------------------------+
#-- | 1.0.0 | 130207-06424 | Vaibhav Goyal   | 13-MAR-2013| Alert to send notification when AP Invoice is    |
#-- |       |              |                 |            | rejected.                                        |
#-- |       |              |                 |            |                                                  |
#------------------------------------------------------------------------------------------------------------+
#************************************************************************************************************/
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
OUTFILE=$OUTDIR/XXRS_AP_INV_REJ_ALERT_130207-06424.out
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
  /bin/mail vaibhav.goyal@rackspace.com -c bruce.martinez@rackspace.com,tim.cowen@rackspace.com -s "Installation log for Rackspace Payables Invoice Rejection - Alert ${TWO_TASK}" < $OUTFILE
}
#--------------------------------------------------------------------------
# Using the FNDLOAD to load Meta Data Definitions
#--------------------------------------------------------------------------
 CreateAOLObjects()
 {
   cd $LDT_DIR 

#  Alert Definition

   $FND_TOP/bin/FNDLOAD $apps_login/$apps_pwd O Y UPLOAD $ALR_TOP/patch/115/import/alr.lct XXRS_AP_INV_REJ_ALERT.ldt CUSTOM_MODE="FORCE" >> $OUTFILE

# Output the FNDLOAD log files to the out file
   cat *.log >> $OUTFILE
# Clear all the FNDLOAD log files from the install directory
   mv *.log $CUSTOM_TOP/log 
 }
#--------------------------------------------------------------------------
# Calling Functions
#--------------------------------------------------------------------------
 echo -e "\nAccept apps user and password...\n" >> $OUTFILE
 Psswd
#
 echo -e "\nDone.\n" >> $OUTFILE
#
 echo -e "\nDefine alert...\n" >> $OUTFILE
 CreateAOLObjects
#
 echo -e "\nInstallation output file: ${OUTFILE}" 
 echo -e "\nEmailing the outfile.\n"
 MailOutFile
