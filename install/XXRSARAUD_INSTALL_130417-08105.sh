#!/bin/bash

#************************************************************************************************************+
#--File Name          :       XXRSARAUD_INSTALL_130417-08105.sh                                              |
#--Program Purpose    :       UK HK Account Updater installation script.                                     |
#--Author Name        :       Pavan Amirineni                                                                |
#--Initial Build Date :       10-JUN-2013                                                                    |
#--                                                                                                          |
#--Version            :       1.0.0                                                                          |
#--Modification History                                                                                      |
#   | Ver   | Ticket No.   | Author          | Date        | Description                                     |
#------------------------------------------------------------------------------------------------------------+
#-- | 1.0.0 | 130417-08105 | Pavan Amirineni | 10-JUN-2013 | Initial Build                                   |
#------------------------------------------------------------------------------------------------------------+
#************************************************************************************************************/
#
#/* $Header: XXRSARAUD_INSTALL_130417-08105.sh 1.0.0 06/10/2013 11:06:24 AM Pavan Amirineni $ */
#
#--------------------------------------------------------------------------
# Set the environmental variables and other administrative requirements.
#--------------------------------------------------------------------------
 DATETIMESTAMP=`date +%Y%m%d%H%M%S`
 p_apps_usrn_pwd=$1
 jdbc=`echo $AD_APPS_JDBC_URL`
 CUSTOM_TOP=$XXRS_TOP
 FRM_DIR=$CUSTOM_TOP/forms/US
 SQL_DIR=$CUSTOM_TOP/install/sql
 LDT_DIR=$CUSTOM_TOP/install/ldt
 XML_DIR=$CUSTOM_TOP/xml
 LOG_DIR=$CUSTOM_TOP/log
 INSTALL_DIR=$CUSTOM_TOP/install
 OUTDIR=$CUSTOM_TOP/out
 OUTFILE=$OUTDIR/XXRSARAUD_INSTALL_130417-08105_${DATETIMESTAMP}.out
 apps_login=apps
 echo $DATETIMESTAMP > $OUTFILE
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
# Load AOL objects 
#--------------------------------------------------------------------------
LoadAolObjects()
{
  cd ${LDT_DIR}

  FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscprof.lct XXRS_AR_ACC_UPD_PMT_MTHD.ldt CUSTOM_MODE= "FORCE" >> $OUTFILE
  FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscprof.lct XXRS_AR_CHASE_PID.ldt CUSTOM_MODE= "FORCE" >> $OUTFILE
  FNDLOAD ${p_apps_usrn_pwd} O Y UPLOAD $FND_TOP/patch/115/import/aflvmlu.lct  XXRS_AR_CHASE_CURRENCY_CODE.ldt CUSTOM_MODE= "FORCE" >> $OUTFILE
  FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afcpreqg.lct XXRSARAUDINB_RG.ldt CUSTOM_MODE= "FORCE" >> $OUTFILE
  FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afcpreqg.lct XXRSARAUDOB_RG.ldt CUSTOM_MODE= "FORCE" >> $OUTFILE
  
  cat *.log >> $OUTFILE
  mv *.log ${LOG_DIR}
}
 
#--------------------------------------------------------------------------
# Create Database Objects
#--------------------------------------------------------------------------
CreateDBObjects()
{
cd $SQL_DIR
sqlplus $p_apps_usrn_pwd << EOF
spool $OUTFILE
@XXRS_AR_ACCOUNT_UPDATER_PKG.pkb
exit;
/
EOF
} 
#--------------------------------------------------------------------------
# Mailing output file
#--------------------------------------------------------------------------
MailOutFile()
{
  /bin/mail pavan.amirineni@rackspace.com -c bruce.martinez@rackspace.com,tim.cowen@rackspace.com -s "Installation log for Account Updater for UK and HK (130417-08105) in ${TWO_TASK}" < $OUTFILE
}

#--------------------------------------------------------------------------
# Calling Functions
#--------------------------------------------------------------------------
Psswd

echo -e "\nCREATING Database Objects...\n" >> $OUTFILE
CreateDBObjects

echo -e "\nLOADING AOL Objects...\n" >> $OUTFILE
LoadAolObjects 

echo -e "\nDone.\n" >> $OUTFILE

echo -e "\nEmailing the outfile.\n"
MailOutFile

echo -e "\nOutput file is ${OUTFILE}"