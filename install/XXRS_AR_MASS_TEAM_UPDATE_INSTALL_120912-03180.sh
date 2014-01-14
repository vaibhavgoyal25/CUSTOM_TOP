#!/bin/bash

#************************************************************************************************************+
#--File Name          :       XXRS_AR_MASS_TEAM_UPDATE_INSTALL_120912-03180.sh                               |
#--Program Purpose    :       Installation script for Customer Mass Team Update process                      |
#--Author Name        :       Pavan Amirineni                                                                |
#--Initial Build Date :       22-APR-2013                                                                    |
#--                                                                                                          |
#--Version            :       1.0.0                                                                          |
#------------------------------------------------------------------------------------------------------------+
#--Modification History                                                                                      |
#   | Ver   | Ticket No.   | Author                  | Date       | Description                              |
#------------------------------------------------------------------------------------------------------------+
#-- | 1.0.0 | 120912-03180 | Pavan Amirineni         | 22-APR-13  | update BU based on team and BU mapping   |
#------------------------------------------------------------------------------------------------------------+
#************************************************************************************************************/
#   $Header: XXRS_AR_MASS_TEAM_UPDATE_INSTALL_120912-03180.sh 1.0.0 22-APR-2013 15:00:00 Pavan Amirineni$
# 
#--------------------------------------------------------------------------
# Set the environmental variables and other administrative requirements.
#--------------------------------------------------------------------------
 DATETIMESTAMP=`date +%Y%m%d%H%M%S`
 p_apps_usrn_pwd=$1
 CUSTOM_TOP=$XXRS_TOP
 SQL_DIR=$CUSTOM_TOP/install/sql
 LDT_DIR=$CUSTOM_TOP/install/ldt
 XML_DIR=$CUSTOM_TOP/xml
 LOG_DIR=$CUSTOM_TOP/log
 INSTALL_DIR=$CUSTOM_TOP/install
 OUTDIR=$CUSTOM_TOP/out
 OUTFILE=$OUTDIR/XXRS_AR_MASS_TEAM_UPDATE_INSTALL_120912-03180_${DATETIMESTAMP}.out
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
# Mailing output file
#--------------------------------------------------------------------------
MailOutFile()
{
  /bin/mail pavan.amirineni@rackspace.com -c bruce.martinez@rackspace.com,tim.cowen@rackspace.com -s "Installation log for Customer Mass Team Update program in ${TWO_TASK}" < $OUTFILE
}
#--------------------------------------------------------------------------
# Create Database Objects
#--------------------------------------------------------------------------
CreateDBObjects()
{
cd $SQL_DIR
sqlplus $p_apps_usrn_pwd << EOF
spool $OUTFILE
@XXRS_ALTER_TEAM_AM_UPD_TBL.sql
@XXRS_AR_TEAM_AM_UPD_PKG.pkb
@XXRS_SC_UTL_0001.pkb
exit;
/
EOF
}
#--------------------------------------------------------------------------
# Calling Functions
#--------------------------------------------------------------------------
 Psswd
#
 echo -e "\nDone.\n" >> $OUTFILE
 CreateDBObjects
#
 echo -e "\nInstallation output file: ${OUTFILE}" 
 echo -e "\nEmailing the outfile.\n"
MailOutFile