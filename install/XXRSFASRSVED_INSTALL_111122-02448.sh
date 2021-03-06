#!/bin/bash

#************************************************************************************************************+
#--File Name          :       XXRSFASRSVED_INSTALL_111122-02448.sh                                           |
#--Program Purpose    :       Install script for Rackspace CAPEX report for Received items                   |
#--Author Name        :       Sunil Kumar Mallina                                                            |
#--Initial Build Date :       02-FEB-2012                                                                    |                                                                                                                    |
#--Version            :       1.0.0                                                                          |
#--Modification History                                                                                      |
#------------------------------------------------------------------------------------------------------------+
#   | Ver   | Ticket No.   | Author                 | Date         | Description                             |
#------------------------------------------------------------------------------------------------------------+
#   | 1.0.0 | 111122-02448 | Sunil Kumar Mallina     | 02-FEB-2012  | R12 Upgradation                        |
#------------------------------------------------------------------------------------------------------------+
#************************************************************************************************************/
#
#-- $Header: XXRSFASRSVED_INSTALL_111122-02448.sh 1.0.0 02-FEB-2012 08:33:23 PM Sunil Kumar Mallina $ 
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
 OUTFILE=$OUTDIR/XXRSFASRSVED_INSTALL_111122-02448.out
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
# Mailing output file
#--------------------------------------------------------------------------
MailOutFile()
{
  /bin/mail vinodh.bhasker@rackspace.com -c bruce.martinez@rackspace.com,tim.cowen@rackspace.com -s "Installation log for Rackspace Reserve Detail Report in ${TWO_TASK}" < $OUTFILE
}
#--------------------------------------------------------------------------
# Using the FNDLOAD to load AOL objects
#--------------------------------------------------------------------------
LoadAOLData()
{
  cd ${LDT_DIR}

  FNDLOAD $p_apps_usrn_pwd O Y UPLOAD @FND:patch/115/import/afcpprog.lct XXRSFASRSVED.ldt CUSTOM_MODE="FORCE">> $OUTFILE
  FNDLOAD $p_apps_usrn_pwd O Y UPLOAD @FND:patch/115/import/afcpreqg.lct XXRSFASRSVED_REQ_AR.ldt CUSTOM_MODE="FORCE">> $OUTFILE
  FNDLOAD $p_apps_usrn_pwd O Y UPLOAD @FND:patch/115/import/afcpreqg.lct XXRSFASRSVED_REQ_ARP.ldt CUSTOM_MODE="FORCE">> $OUTFILE
  FNDLOAD $p_apps_usrn_pwd O Y UPLOAD @XDO:patch/115/import/xdotmpl.lct XXRSFASRSVED_XML.ldt CUSTOM_MODE="FORCE" >> $OUTFILE
  
  
  cat *.log >> $OUTFILE
  mv *.log ${LOG_DIR}
}
#--------------------------------------------------------------------------
# Using the XDOLOADER to load XML Publisher Files
#--------------------------------------------------------------------------
LoadXMLFiles()
{
  cd ${INSTALL_DIR}

java oracle.apps.xdo.oa.util.XDOLoader \
UPLOAD \
-DB_USERNAME $apps_login \
-DB_PASSWORD $apps_pwd \
-JDBC_CONNECTION $jdbc \
-LOB_TYPE XML_SAMPLE \
-APPS_SHORT_NAME XXRS \
-LOB_CODE XXRSFASRSVED \
-LANGUAGE en \
-TERRITORY US \
-XDO_FILE_TYPE XML \
-FILE_NAME ${XML_DIR}/XXRSFASRSVED.xml \
-NLS_LANG AMERICAN_AMERICA.UTF8 \
-CUSTOM_MODE FORCE >> $OUTFILE

java oracle.apps.xdo.oa.util.XDOLoader \
UPLOAD \
-DB_USERNAME $apps_login \
-DB_PASSWORD $apps_pwd \
-JDBC_CONNECTION $jdbc \
-LOB_TYPE TEMPLATE \
-APPS_SHORT_NAME XXRS \
-LOB_CODE XXRSFASRSVED \
-LANGUAGE en \
-TERRITORY US \
-XDO_FILE_TYPE RTF-ETEXT \
-FILE_NAME ${XML_DIR}/XXRSFASRSVED.rtf \
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

echo -e "\nLOADING XML Files...\n" >> $OUTFILE
LoadXMLFiles

echo -e "\nDone.\n" >> $OUTFILE

echo -e "\nEmailing the outfile.\n"
MailOutFile

echo -e "\nOutput file is ${OUTFILE}"
