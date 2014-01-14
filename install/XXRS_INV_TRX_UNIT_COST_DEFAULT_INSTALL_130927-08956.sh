#!/bin/bash
#
#************************************************************************************************************+
#--File Name          : XXRS_INV_TRX_UNIT_COST_DEFAULT_INSTALL_130927-08956.sh                               |
#--Program Purpose    : Install script for personalization to default Unit Cost for Inventory Transaction.   |
#--Author Name        : Vaibhav Goyal                                                                        |
#--Initial Build Date : 30-SEP-2013                                                                          | 
#--Version            : 1.0.0                                                                                |  
#--Ticket Number      : 130927-08956                                                                         |
#------------------------------------------------------------------------------------------------------------+
#--Modification History                                                                                      |
#------------------------------------------------------------------------------------------------------------+
#   | Ver   | Ticket No.   | Author          | Date       | Description                                      |
#------------------------------------------------------------------------------------------------------------+
#   | 1.0.0 | 130927-08956 | Vaibhav Goyal   | 30-SEP-2013| Initial Build                                    |
#------------------------------------------------------------------------------------------------------------+
#************************************************************************************************************/
# $Header:XXRS_INV_TRX_UNIT_COST_DEFAULT_INSTALL_130927-08956.sh 1.0 30-SEP-2013 11:29:44 AM Vaibhav Goyal $ 
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
OUTFILE=$OUTDIR/XXRS_INV_TRX_UNIT_COST_DEFAULT_INSTALL_130927-08956_"$DATETIMESTAMP".out
apps_login=apps
#--------------------------------------------------------------------------
# Define the function to get the APPS password.
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
# Using the FNDLOAD to Download AOL objects
#--------------------------------------------------------------------------
LoadAOLData()
{
  cd ${LDT_DIR}

   FNDLOAD apps/$apps_pwd 0 Y UPLOAD $FND_TOP/patch/115/import/affrmcus.lct XXRS_INV_INVTTMTX_MISC.ldt >> $OUTFILE

  cat *.log >> $OUTFILE
  mv *.log ${LOG_DIR}
}


#--------------------------------------------------------------------------
# Mailing output file
#--------------------------------------------------------------------------
MailOutFile()
{
  /bin/mail vaibhav.goyal@rackspace.com -c vinodh.bhasker@rackspace.com,bruce.martinez@rackspace.com,tim.cowen@rackspace.com, sachin.garg@rackspace.com -s "Installation log for Inventory Transaction Unit Cost Default personalization in ${TWO_TASK}" < $OUTFILE
}
#---------------------------------------------------------------------
# Call the functions					      
#---------------------------------------------------------------------

Psswd

echo -e "\nUploading Messages ...\n" >> $OUTFILE
LoadAOLData

echo -e "\nDone.\n" >> $OUTFILE

echo -e "\nEmailing the outfile.\n"
MailOutFile

echo -e "\nOutput file is ${OUTFILE}"
