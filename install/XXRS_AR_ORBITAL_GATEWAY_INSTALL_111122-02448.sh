#!/bin/bash
#
#************************************************************************************************************+
#--File Name          :       XXRS_AR_ORBITAL_GATEWAY_INSTALL_111122-02448.sh                                |
#--Program Purpose    :       Install script for Orbital Gateway Components                                  |
#--Author Name        :       Kalyan                                                                         |
#--Initial Build Date :       10-JAN-2012                                                                    |
#--Version            :       1.0.0                                                                          |
#--Modification History                                                                                      |
#------------------------------------------------------------------------------------------------------------+
#   | Ver   | Ticket No.   | Author          | Date         | Description                                    |
#------------------------------------------------------------------------------------------------------------+
#   | 1.0.0 | 110121-06252 | Kalyan          | 10-JAN-2012  | Initial Build                                  |
#------------------------------------------------------------------------------------------------------------+
#************************************************************************************************************/
# /* $Header: XXRS_AR_ORBITAL_GATEWAY_INSTALL_111122-02448.sh 1.0.0 10-JAN-2012 15:48:00 PM Kalyan $ */
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
 OUTFILE=$OUTDIR/XXRS_AR_ORBITAL_GATEWAY_INSTALL_111122-02448.out
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
# Create Database Objects
#--------------------------------------------------------------------------
CreateDBObjects()
{
cd $SQL_DIR
sqlplus $p_apps_usrn_pwd << EOF
spool $OUTFILE
@XXRS_AR_ORBITAL_ALTER_TBLS.sql
@XXRS_AR_CUSTOMER_ACCOUNT_VW.sql
@XXRS_AR_ORBITAL_GATEWAY_PKG.pks
@XXRS_AR_ORBITAL_GATEWAY_PKG.pkb
exit;
/
EOF
} 
#--------------------------------------------------------------------------
# Create Directory Structure
#--------------------------------------------------------------------------
 Createdir()
 { 
   mkdir -p $XXRS_TOP/data/ar/globalgateway/request
   echo -e "\nCreated Directory Structure $XXRS_TOP/data/ar/globalgateway/request\n" >> $OUTFILE 
   chmod -R 750 $XXRS_TOP/data/ar/globalgateway/request
   echo -e "\nChanged Permissions recursively on $XXRS_TOP/data/ar/globalgateway/request\n" >> $OUTFILE 
   mkdir -p $XXRS_TOP/archive/ar/globalgateway/request
   echo -e "\nCreated Directory Structure $XXRS_TOP/archive/ar/globalgateway/request\n" >> $OUTFILE 
   chmod -R 750 $XXRS_TOP/archive/ar/globalgateway/request
   echo -e "\nChanged Permissions recursively on $XXRS_TOP/archive/ar/globalgateway/request\n" >> $OUTFILE    
 
   mkdir -p $XXRS_TOP/data/ar/globalgateway/response/US
   echo -e "\nCreated Directory Structure $XXRS_TOP/data/ar/globalgateway/response/US\n" >> $OUTFILE 
   chmod -R 750 $XXRS_TOP/data/ar/globalgateway/response/US
   echo -e "\nChanged Permissions recursively on $XXRS_TOP/data/ar/globalgateway/response/US\n" >> $OUTFILE 
   mkdir -p $XXRS_TOP/archive/ar/globalgateway/response/US
   echo -e "\nCreated Directory Structure $XXRS_TOP/archive/ar/globalgateway/response/US\n" >> $OUTFILE 
   chmod -R 750 $XXRS_TOP/archive/ar/globalgateway/response/US
   echo -e "\nChanged Permissions recursively on $XXRS_TOP/archive/ar/globalgateway/response/US\n" >> $OUTFILE    
 } 
#--------------------------------------------------------------------------
# Using the FNDLOAD to load AOL objects
#--------------------------------------------------------------------------
LoadAOLData()
{
  cd ${LDT_DIR}

  FNDLOAD $p_apps_usrn_pwd 0 Y UPLOAD @FND:patch/115/import/afcpprog.lct XXRSARGGRANGE.ldt CUSTOM_MODE="FORCE" >> $OUTFILE
  
  FNDLOAD $p_apps_usrn_pwd 0 Y UPLOAD @FND:patch/115/import/afcpprog.lct XXRSARPCCP.ldt CUSTOM_MODE="FORCE" >> $OUTFILE
  
  FNDLOAD $p_apps_usrn_pwd 0 Y UPLOAD @FND:patch/115/import/afcpprog.lct XXRSARGGDEC.ldt CUSTOM_MODE="FORCE" >> $OUTFILE
  
  FNDLOAD $p_apps_usrn_pwd 0 Y UPLOAD @FND:patch/115/import/afffload.lct XXRSIBYPMTINSTRDFF.ldt CUSTOM_MODE="FORCE" >> $OUTFILE  
  
  FNDLOAD $p_apps_usrn_pwd 0 Y UPLOAD @FND:patch/115/import/afcpprog.lct XXRSARGGOBPUT.ldt CUSTOM_MODE="FORCE" >> $OUTFILE
  
  FNDLOAD $p_apps_usrn_pwd 0 Y UPLOAD @FND:patch/115/import/afcprset.lct XXRSARPCCOUTSET.ldt CUSTOM_MODE="FORCE" >> $OUTFILE

  FNDLOAD $p_apps_usrn_pwd 0 Y UPLOAD @FND:patch/115/import/afcprset.lct XXRSARPCCOUTSET_LINK.ldt CUSTOM_MODE="FORCE" >> $OUTFILE
  
  FNDLOAD $p_apps_usrn_pwd 0 Y UPLOAD @XDO:patch/115/import/xdotmpl.lct XXRSARPCCP_XML.ldt CUSTOM_MODE="FORCE" >> $OUTFILE
  
  FNDLOAD $p_apps_usrn_pwd 0 Y UPLOAD @FND:patch/115/import/afcpprog.lct XXRSARPCCIB.ldt CUSTOM_MODE="FORCE" >> $OUTFILE
  
  FNDLOAD $p_apps_usrn_pwd 0 Y UPLOAD @FND:patch/115/import/afcpprog.lct XXRSARPMTPOSTPAY.ldt CUSTOM_MODE="FORCE" >> $OUTFILE
  
  FNDLOAD $p_apps_usrn_pwd 0 Y UPLOAD @FND:patch/115/import/afcpprog.lct XXRSARXCPRL.ldt CUSTOM_MODE="FORCE" >> $OUTFILE
  
  FNDLOAD $p_apps_usrn_pwd 0 Y UPLOAD @FND:patch/115/import/afcpreqg.lct XXRSARPCCIB_REQ.ldt CUSTOM_MODE="FORCE" >> $OUTFILE
  
  FNDLOAD $p_apps_usrn_pwd 0 Y UPLOAD @FND:patch/115/import/afcpreqg.lct XXRSARPCCOUTSET_REQ.ldt CUSTOM_MODE="FORCE" >> $OUTFILE
  
  FNDLOAD $p_apps_usrn_pwd 0 Y UPLOAD @FND:patch/115/import/afcpreqg.lct XXRSARXCPRL_REQ.ldt CUSTOM_MODE="FORCE" >> $OUTFILE      

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
-LOB_CODE XXRSARPCCP \
-LANGUAGE en \
-TERRITORY US \
-XDO_FILE_TYPE XML \
-FILE_NAME ${XML_DIR}/XXRSARPCCP_DATA_PREVIEW.xml \
-NLS_LANG AMERICAN_AMERICA.UTF8 \
-CUSTOM_MODE FORCE >> $OUTFILE

java oracle.apps.xdo.oa.util.XDOLoader \
UPLOAD \
-DB_USERNAME $apps_login \
-DB_PASSWORD $apps_pwd \
-JDBC_CONNECTION $jdbc \
-LOB_TYPE DATA_TEMPLATE \
-APPS_SHORT_NAME XXRS \
-LOB_CODE XXRSARPCCP \
-LANGUAGE en \
-TERRITORY US \
-XDO_FILE_TYPE XML \
-FILE_NAME ${XML_DIR}/XXRSARPCCP.xml \
-NLS_LANG AMERICAN_AMERICA.UTF8 \
-CUSTOM_MODE FORCE >> $OUTFILE

java oracle.apps.xdo.oa.util.XDOLoader \
UPLOAD \
-DB_USERNAME apps \
-DB_PASSWORD $apps_pwd \
-JDBC_CONNECTION $jdbc \
-LOB_TYPE TEMPLATE \
-APPS_SHORT_NAME XXRS \
-LOB_CODE XXRSARPCCP \
-LANGUAGE en \
-TERRITORY US \
-XDO_FILE_TYPE XSL-XML \
-FILE_NAME $CUSTOM_TOP/install/XXRSARPCCP.xsl \
-NLS_LANG AMERICAN_AMERICA.UTF8 \
-CUSTOM_MODE FORCE >> $OUTFILE

  cat *.log >> $OUTFILE
  mv *.log ${LOG_DIR}
}

#--------------------------------------------------------------------------
# Mailing output file
#--------------------------------------------------------------------------
MailOutFile()
{
  /bin/mail vaibhav.goyal@rackspace.com -c bruce.martinez@rackspace.com,tim.cowen@rackspace.com -s "Installation log for Rackspace Global Gateway in ${TWO_TASK}" < $OUTFILE
}
#--------------------------------------------------------------------------
# Set permissions on folders
#--------------------------------------------------------------------------
SetPermisssions()
{
  cd $JAVA_TOP/xxrs/oracle/apps/ar

  chmod -R 750 $JAVA_TOP/xxrs/oracle/apps/ar
} 
#--------------------------------------------------------------------------
# Download Java Files
#--------------------------------------------------------------------------
CreateJavafiles() 
{
  cd $JAVA_TOP/xxrs/oracle/apps/ar

  chmod -R 750 $JAVA_TOP/xxrs/oracle/apps/ar

  tar xvzf $JAVA_TOP/xxrs/install/xxrs_oaf_ar_cp_111122-02448.tar.gz
}
#---------------------------------------------------------------------
# Call the functions					      
#---------------------------------------------------------------------

Psswd

CreateDBObjects

echo -e "\nCREATIONG Directory...\n" >> $OUTFILE
Createdir

echo -e "\nLOADing AOL objects...\n" >> $OUTFILE
LoadAOLData

echo -e "\nLOADing XML Publisher objects ...\n" >> $OUTFILE
LoadXMLFiles

echo -e "\nCHANGING permissions recursively on $JAVA_TOP/xxrs/oracle/apps/ar/ ...\n" >> $OUTFILE
SetPermisssions

echo -e "\nUNZIPPING Java files for Global gateway to $JAVA_TOP/xxrs/oracle/apps/ar/ ...\n" >> $OUTFILE
CreateJavafiles

echo -e "\nCHANGING permissions recursively on $JAVA_TOP/xxrs/oracle/apps/ar/ ...\n" >> $OUTFILE
SetPermisssions

echo -e "\nInstallation output file: ${OUTFILE}" 

echo -e "\nDone.\n" >> $OUTFILE

MailOutFile