#!/bin/bash

#************************************************************************************************************+
#--File Name          :       XXRS_AP_QTY_REC_HOLD_NOTIFICATION_111122-02448.sh                              |
#--Program Purpose    :       Installation script for 'Quantity Received Hold Notification'                  |
#--Author Name        :       Vaibhav Goyal                                                                  |
#--Initial Build Date :       14-DEC-2011                                                                    |
#--                                                                                                          |
#--Version            :       1.0                                                                            |
#------------------------------------------------------------------------------------------------------------+
#--Modification History                                                                                      |
#   | Ver   | Ticket No.   | Author          | Date       | Description                                      |
#------------------------------------------------------------------------------------------------------------+
#-- | 1.0.0 | 111122-02448 | Vaibhav Goyal   | 14-DEC-11  | Alert to send notification when already Invoiced |
#-- |       |              |                 |            | items are not received.                          |
#-- |       |              |                 |            |                                                  |
#------------------------------------------------------------------------------------------------------------+
#************************************************************************************************************/
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
OUTFILE=$OUTDIR/XXRS_AP_QTY_REC_HOLD_NOTIFICATION_111122-02448.out
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
    p_apps_usrn_pwd=apps/apps_pwd
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
  /bin/mail vaibhav.goyal@rackspace.com -c bruce.martinez@rackspace.com,tim.cowen@rackspace.com -s "Installation log for Invoiced Quantity Received Hold Notification - Alert ${TWO_TASK}" < $OUTFILE
}
#--------------------------------------------------------------------------
# Using the FNDLOAD to load Meta Data Definitions
#--------------------------------------------------------------------------
 CreateAOLObjects()
 {
   cd $LDT_DIR 

#  Alert Definition

   $FND_TOP/bin/FNDLOAD $apps_login/$apps_pwd O Y UPLOAD $ALR_TOP/patch/115/import/alr.lct XXRS_AP_QTY_REC_NOTIF.ldt CUSTOM_MODE="FORCE" >> $OUTFILE

   $FND_TOP/bin/FNDLOAD $apps_login/$apps_pwd O Y UPLOAD $ALR_TOP/patch/115/import/alr.lct XXRS_AP_QTY_REC_NOTIF_OLD.ldt CUSTOM_MODE="FORCE" >> $OUTFILE

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
