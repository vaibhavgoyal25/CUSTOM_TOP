#!/bin/bash

#************************************************************************************************************+
#--File Name          :       XXRSFAASSRET_INSTALL_130116-08886.sh                                           |
#--Program Purpose    :       Rackspace Asset Retirements Report	                                     |
#--Author Name        :       Antony Selva B                                                                 |
#--Initial Build Date :       23-JAN-2013                                                                    |
#--                                                                                                          |
#--Version            :       1.0.0                                                                          |
#------------------------------------------------------------------------------------------------------------+
#--Modification History                                                                                      |
#------------------------------------------------------------------------------------------------------------+
#   | Ver   | Ticket No.   | Author          | Date       | Description                                      |
#------------------------------------------------------------------------------------------------------------+
#   | 1.0.0 | 130116-08886 | Antony Selva B  | 23-JAN-2013| Added Column Organization Code		     |
#------------------------------------------------------------------------------------------------------------+
#************************************************************************************************************/
#
#-- $Header: XXRSFAASSRET_INSTALL_130116-08886_DL.sh 1.0.0 23-JAN-2013 08:33:23 AM Antony selva B $ 
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
 OUTFILE=$OUTDIR/XXRSFAASSRET_INSTALL_130116-08886.out
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
  /bin/mail antonyseiva.babu@rackspace.com -c vaibhav.goyal@rackspace.com,vinodh.bhasker@rackspace.com,bruce.martinez@rackspace.com,tim.cowen@rackspace.com -s "Installation log for Rackspace Asset Retirement Report in ${TWO_TASK}" < $OUTFILE
}
#--------------------------------------------------------------------------
# Using the FNDLOAD to load AOL objects
#--------------------------------------------------------------------------
LoadAOLData()
{
  cd ${LDT_DIR}

  $FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $XDO_TOP/patch/115/import/xdotmpl.lct XXRSFAASSRET_XML.ldt CUSTOM_MODE='FORCE' >> $OUTFILE

  cat *.log >> $OUTFILE
  mv *.log ${LOG_DIR}
}
#--------------------------------------------------------------------------
# Using the XDOLOADER to load XML Publisher Files
#--------------------------------------------------------------------------
LoadXMLFiles()
{
  cd ${INSTALL_DIR}

# Loading XML Sample
java oracle.apps.xdo.oa.util.XDOLoader \
UPLOAD \
-DB_USERNAME $apps_login \
-DB_PASSWORD $apps_pwd \
-JDBC_CONNECTION $jdbc \
-LOB_TYPE XML_SAMPLE \
-APPS_SHORT_NAME XXRS \
-LOB_CODE XXRSFAASSRET \
-LANGUAGE en \
-TERRITORY US \
-XDO_FILE_TYPE XML \
-FILE_NAME ${XML_DIR}/XXRSFAASSRET_PREVIEW.xml \
-NLS_LANG AMERICAN_AMERICA.UTF8 \
-CUSTOM_MODE FORCE >> $OUTFILE

# Loading  Data Definition File
java oracle.apps.xdo.oa.util.XDOLoader \
UPLOAD \
-DB_USERNAME $apps_login \
-DB_PASSWORD $apps_pwd \
-JDBC_CONNECTION $jdbc \
-LOB_TYPE DATA_TEMPLATE \
-APPS_SHORT_NAME XXRS \
-LOB_CODE XXRSFAASSRET \
-LANGUAGE en \
-TERRITORY US \
-XDO_FILE_TYPE XML \
-FILE_NAME ${XML_DIR}/XXRSFAASSRET.xml \
-NLS_LANG AMERICAN_AMERICA.UTF8 \
-CUSTOM_MODE FORCE >> $OUTFILE

# Loading Template or rtf file
java oracle.apps.xdo.oa.util.XDOLoader \
UPLOAD \
-DB_USERNAME $apps_login \
-DB_PASSWORD $apps_pwd \
-JDBC_CONNECTION $jdbc \
-LOB_TYPE TEMPLATE \
-APPS_SHORT_NAME XXRS \
-LOB_CODE XXRSFAASSRET \
-LANGUAGE en \
-TERRITORY US \
-XDO_FILE_TYPE RTF-ETEXT \
-FILE_NAME ${XML_DIR}/XXRSFAASSRET.rtf \
-NLS_LANG AMERICAN_AMERICA.UTF8 \
-CUSTOM_MODE FORCE >> $OUTFILE


  cat *.log >> $OUTFILE
  mv *.log ${LOG_DIR}
}
#--------------------------------------------------------------------------
# Calling Functions
#--------------------------------------------------------------------------
Psswd

echo -e "\nLOADING AOL Data...\n" >> $OUTFILE
LoadAOLData

LoadXMLFiles

echo -e "\nDone.\n" >> $OUTFILE

echo -e "\nEmailing the outfile.\n"
MailOutFile

echo -e "\nOutput file is ${OUTFILE}"