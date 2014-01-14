#!/bin/bash

#************************************************************************************************************+
#--File Name          :       XXRS_SC_PROD_STATUS_CHANGE_130424-07042.sh                                     |
#--Program Purpose    :       Installation script for XXRS_SC_PROD_STATUS_CHANGE Form.                       |
#--Author Name        :       Vaibhav Goyal                                                                  |
#--Initial Build Date :       03-May-2013                                                                    |
#--                                                                                                          |
#--Version            :       1.0.0                                                                          |
#--Modification History                                                                                      |
#   | Ver   | Ticket No.   | Author          | Date        | Description                                     |
#------------------------------------------------------------------------------------------------------------+
#-- | 1.0.0 | 130424-07042 | Vaibhav Goyal   | 03-May-2013 | Initial Build                                   |
#------------------------------------------------------------------------------------------------------------+
#************************************************************************************************************/
#
#/* $Header: XXRS_SC_PROD_STATUS_CHANGE_130424-07042.sh  1.0.0 05/03/2013 11:06:24 AM Vaibhav Goyal $ */
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
 OUTFILE=$OUTDIR/XXRS_SC_PROD_STATUS_CHANGE_130424-07042.out
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
# Mailing output file
#--------------------------------------------------------------------------
MailOutFile()
{
  /bin/mail vaibhav.goyal@rackspace.com -c bruce.martinez@rackspace.com,tim.cowen@rackspace.com -s "Installation log for XXRS_SC_PROD_STATUS_CHANGE Form (130424-07042) in ${TWO_TASK}" < $OUTFILE
}
#--------------------------------------------------------------------------
# Compile Forms
#--------------------------------------------------------------------------
CompileForms()
{
  cd ${FRM_DIR} 
  echo "Compiling form XXRS_SC_PROD_STATUS_CHANGE.fmb under ${FRM_DIR}" >> $OUTFILE
  frmcmp_batch.sh userid=${p_apps_usrn_pwd} batch=yes module=XXRS_SC_PROD_STATUS_CHANGE.fmb module_type=FORM compile_all=yes window_state=minimize
# Output the log files to the out file
  mv XXRS_SC_PROD_STATUS_CHANGE.err XXRS_SC_PROD_STATUS_CHANGE.log
  cat  XXRS_SC_PROD_STATUS_CHANGE.log >> $OUTFILE
# Clear the log files from the forms directory
  mv  XXRS_SC_PROD_STATUS_CHANGE.log  $CUSTOM_TOP/log
}
#--------------------------------------------------------------------------
# Calling Functions
#--------------------------------------------------------------------------
Psswd

echo -e "\nCOMPILING Forms ...\n" >> $OUTFILE
CompileForms

echo -e "\nDone.\n" >> $OUTFILE

echo -e "\nEmailing the outfile.\n"
MailOutFile

echo -e "\nOutput file is ${OUTFILE}"