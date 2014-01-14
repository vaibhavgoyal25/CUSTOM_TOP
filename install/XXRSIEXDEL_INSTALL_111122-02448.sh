#!/bin/bash

#************************************************************************************************************+
#--File Name          :       XXRSIEXDEL_INSTALL_111122-02448.sh                                             |
#--Program Purpose    :       Installation script for IEX Dunning Notification Delivery                      |
#--Author Name        :       Vinodh Bhasker                                                                 |
#--Initial Build Date :       14-FEB-2012                                                                    |
#--                                                                                                          |
#--Version            :       1.0.0                                                                          |
#--Modification History                                                                                      |
#   | Ver   | Ticket No.   | Author          | Date        | Description                                     |
#------------------------------------------------------------------------------------------------------------+
#-- | 1.0.0 | 111122-02448 | Vinodh Bhasker  | 14-FEB-2012 | Initial Build                                   |
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
 OUTFILE=$OUTDIR/XXRSIEXDEL_INSTALL_111122-02448.out
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
# Using the FNDLOAD to load AOL objects
#--------------------------------------------------------------------------
LoadAOLData()
{
  cd ${LDT_DIR}

  FNDLOAD $p_apps_usrn_pwd O Y UPLOAD @FND:patch/115/import/afcpprog.lct XXRSIEXXMLGEN.ldt CUSTOM_MODE="FORCE" >>$OUTFILE

  cat *.log >> $OUTFILE
  mv *.log ${LOG_DIR}
}
#--------------------------------------------------------------------------
# Set permissions on folders
#--------------------------------------------------------------------------
SetPermisssions()
{
  cd $JAVA_TOP/xxrs/oracle/apps

  chmod -R 750 $JAVA_TOP/xxrs/oracle/apps
} 
#--------------------------------------------------------------------------
# Download OA Framework Files
#--------------------------------------------------------------------------
CreateJavafiles() 
{
  cd $JAVA_TOP/xxrs/oracle/apps

  chmod -R 750 $JAVA_TOP/xxrs/oracle/apps

  tar xvzf $JAVA_TOP/xxrs/install/xxrs_oaf_iex_111122-02448.tar.gz
}
#--------------------------------------------------------------------------
# Mailing output file
#--------------------------------------------------------------------------
MailOutFile()
{
  /bin/mail vinodh.bhasker@rackspace.com -c bruce.martinez@rackspace.com,tim.cowen@rackspace.com -s "Installation log for IEX Dunning Notification Delivery in ${TWO_TASK}" < $OUTFILE
}
#--------------------------------------------------------------------------
# Calling Functions
#--------------------------------------------------------------------------
Psswd

echo -e "\nLOADING AOL Data...\n" >> $OUTFILE
LoadAOLData

echo -e "\nCHANGING permissions recursively on $JAVA_TOP/xxrs/oracle/apps/iex ...\n" >> $OUTFILE
SetPermisssions

echo -e "\nUNZIPPING OA Framework Components for inventory project to $JAVA_TOP/xxrs/oracle/apps/iex ...\n" >> $OUTFILE
CreateJavafiles

echo -e "\nCHANGING permissions recursively on $JAVA_TOP/xxrs/oracle/apps/iex ...\n" >> $OUTFILE
SetPermisssions

echo -e "\nDone.\n" >> $OUTFILE

echo -e "\nEmailing the outfile.\n"
MailOutFile

echo -e "\nOutput file is ${OUTFILE}"
