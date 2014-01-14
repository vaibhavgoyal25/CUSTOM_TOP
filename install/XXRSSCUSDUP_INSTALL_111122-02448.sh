#!/bin/bash
#************************************************************************************************************+
#--File Name          :       XXRSSCUSDUP_INSTALL_111122-02448.sh                                            | 
#--Program Purpose    :       Installation script for Rackspace Duplicate Usage Device Report                |
#--Author Name        :       Vaibhav Goyal                                                                  |
#--Initial Build Date :       14-MAR-2012                                                                    |
#							                                                     |
#--Version            :       1.0.0                                                                          |
#--Modification History                                                                                      |
#   | Ver   | Ticket No.   | Author          | Date        | Description                                     |
#------------------------------------------------------------------------------------------------------------+
#-- | 1.0.0 | 111122-02448 | Vaibhav Goyal   | 14-MAR-2012 | R12 Upgradation                                 |
#------------------------------------------------------------------------------------------------------------+
#************************************************************************************************************/
#/* $Header: XXRSSCUSDUP_INSTALL_111122-02448.sh 1.0.0 01-MAR-2012 15:37:00 PM Vaibhav Goyal $ */
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
 OUTFILE=$OUTDIR/XXRSSCUSDUP_INSTALL_111122-02448.out
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
# Using the FNDLOAD to load Updated Concurrent Program Rackspace Invoice Worksheet Data Load 
#--------------------------------------------------------------------------
CreateAOLObjects()
{
 cd $LDT_DIR

   FNDLOAD $p_apps_usrn_pwd  O Y UPLOAD @FND:patch/115/import/afcpprog.lct $CUSTOM_TOP/install/ldt/XXRSSCUSDUP.ldt CUSTOM_MODE='FORCE'>> $OUTFILE
   FNDLOAD $p_apps_usrn_pwd  O Y UPLOAD @FND:patch/115/import/afcpreqg.lct $CUSTOM_TOP/install/ldt/XXRSSCUSDUP_RG.ldt CUSTOM_MODE='FORCE'>> $OUTFILE

cat $CUSTOM_TOP/install/*.log >> $OUTFILE
mv $CUSTOM_TOP/install/*.log $CUSTOM_TOP/log
}
#--------------------------------------------------------------------------
# Using the XDOLOADER to load XML Publisher Files
#--------------------------------------------------------------------------
 LoadXMLFiles()
 {
  cd $INSTALL_DIR
java oracle.apps.xdo.oa.util.XDOLoader \
UPLOAD \
-DB_USERNAME $apps_login \
-DB_PASSWORD $apps_pwd \
-JDBC_CONNECTION $jdbc \
-LOB_TYPE DATA_TEMPLATE \
-APPS_SHORT_NAME XXRS \
-LOB_CODE XXRSSCUSDUP \
-LANGUAGE en \
-TERRITORY US \
-XDO_FILE_TYPE XML \
-FILE_NAME ${XML_DIR}/XXRSSCUSDUP.xml \
-NLS_LANG AMERICAN_AMERICA.UTF8 \
-CUSTOM_MODE FORCE >> $OUTFILE

java oracle.apps.xdo.oa.util.XDOLoader \
UPLOAD \
-DB_USERNAME apps \
-DB_PASSWORD $apps_pwd \
-JDBC_CONNECTION $jdbc \
-LOB_TYPE TEMPLATE \
-APPS_SHORT_NAME XXRS \
-LOB_CODE XXRSSCUSDUP \
-LANGUAGE en \
-TERRITORY US \
-XDO_FILE_TYPE RTF \
-FILE_NAME ${XML_DIR}/XXRSSCUSDUP.rtf \
-NLS_LANG AMERICAN_AMERICA.UTF8 \
-CUSTOM_MODE FORCE >> $OUTFILE
 }

#--------------------------------------------------------------------------
# Mailing output file
#--------------------------------------------------------------------------
MailOutFile()
{
  /bin/mail vaibhav.goyal@rackspace.com -c vinodh.bhasker@rackspace.com,bruce.martinez@rackspace.com,tim.cowen@rackspace.com -s "Installation log for Rackspace Duplicate Usage Device Report in ${TWO_TASK}" < $OUTFILE
}
#--------------------------------------------------------------------------
# Calling Functions
#--------------------------------------------------------------------------
Psswd

echo -e "\nCREATING AOL Objects...\n" >> $OUTFILE
CreateAOLObjects

echo -e "\nLoadXMLFiles...\n" >> $OUTFILE
LoadXMLFiles

echo -e "\nInstallation output file: ${OUTFILE}" 

echo -e "\nDone.\n" >> $OUTFILE

MailOutFile