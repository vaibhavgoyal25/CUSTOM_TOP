#!/bin/bash

#************************************************************************************************************+
#--File Name          :       XXRS_CUST_ADDR_CHANGE_111122-02448.sh                                          |
#--Program Purpose    :       Rackspace Customer Address Change installation script                          |
#--Author Name        :       Sudheer Guntu                                                                  |
#--Initial Build Date :       17-FEB-2012                                                                    |
#--                                                                                                          |
#--Version            :       1.0.0                                                                          |
#------------------------------------------------------------------------------------------------------------+
#--Modification History                                                                                      |
#------------------------------------------------------------------------------------------------------------+
#   | Ver   | Ticket No.   | Author          | Date       | Description                                      |
#------------------------------------------------------------------------------------------------------------+
#   | 1.0.0 | 111122-02448 | Sudheer Guntu   | 17-FEB-12   | Initial Build                                   |
#------------------------------------------------------------------------------------------------------------+
#************************************************************************************************************/
# $Header: XXRS_CUST_ADDR_CHANGE_111122-02448.sh 1.0.0 17/02/2012 01:44:00 PM Sudheer Guntu $
#
#--------------------------------------------------------------------------
# Set the environmental variables and other administrative requirements.
#--------------------------------------------------------------------------
 p_apps_usrn_pwd=$1
 jdbc=$2
 CUSTOM_TOP=$XXRS_TOP
 SQL_DIR=$CUSTOM_TOP/install/sql
 LDT_DIR=$CUSTOM_TOP/install/ldt
 XML_DIR=$CUSTOM_TOP/xml
 LOG_DIR=$CUSTOM_TOP/log
 INSTALL_DIR=$CUSTOM_TOP/install
 OUTDIR=$CUSTOM_TOP/out
 OUTFILE=$OUTDIR/XXRS_CUST_ADDR_CHANGE_111122-02448.out
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
  /bin/mail pavan.amirineni@rackspace.com -c vinodh.bhasker@rackspace.com,bruce.martinez@rackspace.com,tim.cowen@rackspace.com -s "Installation log for hz_locations Address change trigger in ${TWO_TASK}" < $OUTFILE
}

#--------------------------------------------------------------------------
# Create database objects
#--------------------------------------------------------------------------
CreateDBObjects()
{
  cd $SQL_DIR
sqlplus $p_apps_usrn_pwd << EOF
spool $OUTFILE
@XXRS_AR_CUSTOMER_ADDR_H.sql
@XXRS_AR_CUSTOMER_ADDR.pks
@XXRS_AR_CUSTOMER_ADDR.pkb
@XXRS_HZ_LOCATIONS_BRU.sql
exit;
/
EOF
}
#--------------------------------------------------------------------------
# Calling Functions
#--------------------------------------------------------------------------
Psswd
echo -e "\nCREATING DB Objects...\n" >> $OUTFILE
CreateDBObjects
echo -e "\nDone.\n" >> $OUTFILE
#
echo -e "\nInstallation output file: ${OUTFILE}"
echo -e "\nEmailing the outfile.\n"
MailOutFile