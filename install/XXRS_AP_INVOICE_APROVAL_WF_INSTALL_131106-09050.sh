#!/bin/bash

#************************************************************************************************************+
#--File Name          :       XXRS_AP_INVOICE_APROVAL_WF_INSTALL_131106-09050.sh                             |
#--Program Purpose    :       Install Script For Rackspace AP Invoice Approval workflow                       |
#--Author Name        :       Rahul Boddireddy                                                               |
#--Initial Build Date :       06-Nov-2013                                                                    |
#--                                                                                                          |
#--Version            :       1.0                                                                            |
#------------------------------------------------------------------------------------------------------------+
#--Modification History                                                                                      |
#------------------------------------------------------------------------------------------------------------+
#   | Ver   | Ticket No.   | Author            | Date       | Description                                    |
#------------------------------------------------------------------------------------------------------------+
#   | 1.0   | 131106-09050 | Rahul Boddiredddy | 06-Nov-13  | Initial Build                                  |
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
WFT_DIR=$CUSTOM_TOP/import/US
REPORTS_DIR=$CUSTOM_TOP/reports/US
INSTALL_DIR=$CUSTOM_TOP/install
OUTDIR=$CUSTOM_TOP/out
OUTFILE=$OUTDIR/XXRS_AP_INVOICE_APROVAL_WF_INSTALL_131106-09050_"$DATETIMESTAMP".out

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
  /bin/mail rahul.boddireddy@rackspace.com -c vinodh.bhasker@rackspace.com,bruce.martinez@rackspace.com,Sachin.garg@rackspace.com,tim.cowen@rackspace.com -s "Installation log for Rackspace AP Invoice Approval workflow in ${TWO_TASK}" < $OUTFILE
}


#--------------------------------------------------------------------------
# Using the WFLOAD to load workflow process
#--------------------------------------------------------------------------
LoadWorkflow()
{
  cd $WFT_DIR

  WFLOAD apps/$apps_pwd 0 Y FORCE XXRSAPINVAPR.wft>> $OUTFILE

  #output the FNDLOAD log files to the out file
  cat *.log >> $OUTFILE

  #clear all the FNDLOAD log files from the install directory
  mv *.log $CUSTOM_TOP/log 
}

#--------------------------------------------------------------------------
# Calling Functions
#--------------------------------------------------------------------------
Psswd

echo -e "\nLOADING Workflow...\n" >> $OUTFILE
LoadWorkflow

echo -e "\nDone.\n" >> $OUTFILE
#
echo -e "\nInstallation output file: ${OUTFILE}" 
echo -e "\nEmailing the outfile.\n"
MailOutFile