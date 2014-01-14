#!/bin/bash
#
#************************************************************************************************************+
#--File Name          : XXRS_VM_ONL_DATE_INT_INSTALL_130220-05014.sh                                         |
#--Program Purpose    : Install script VM online date automation project                                     |
#--Author Name        : Pavan Amirineni                                                                      |
#--Initial Build Date : 29-MAY-2013                                                                          | 
#--Version            : 1.0.0                                                                                |  
#--Ticket Number      : 130417-07793                                                                         |
#--Modification History                                                                                      |
#------------------------------------------------------------------------------------------------------------+
#   | Ver   | Ticket No.   | Author          | Date       | Description                                      |
#------------------------------------------------------------------------------------------------------------+
#   | 1.0   | 130220-05014 | Pavan Amirineni | 24-APR-2013| Initial Creation             	                  |
#------------------------------------------------------------------------------------------------------------+
#************************************************************************************************************/
#
#-- $Header: XXRS_VM_ONL_DATE_INT_INSTALL_130220-05014.sh 1.0.0 29-MAY-2013 9:00:00 AM Pavan Amirineni $ 
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
OUTFILE=$OUTDIR/XXRS_VM_ONL_DATE_INT_INSTALL_130220-05014_${DATETIMESTAMP}.out
apps_login=apps
l_env=`echo $TWO_TASK | awk '{print substr($0,0,2)}'`
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
# Create Database Objects
#--------------------------------------------------------------------------
CreateDBObjects()
{
cd $SQL_DIR
sqlplus $p_apps_usrn_pwd << EOF
spool $OUTFILE
@XXRS_SC_VM_CHG_PRD_RSRC_DEF_TBL.sql
@XXRS_SC_VM_OLD_INT_TBL.sql
@XXRS_SC_ACCOUNT_RESOURCE_PKG.pkb
exit;
/
EOF
}

InvalidObjects()
{
cd $SQL_DIR
sqlplus -s $p_apps_usrn_pwd @XXRS_COMPILE_INVALID_DB_OBJ.sql 130220-05014<< EOF
exit;
/
EOF
echo "" 
echo "**********************************************************************"
cat XXRS_COMPILE_INVALID_130220-05014*.sql >> $OUTFILE
echo " "
echo "**********************************************************************"
rm -f XXRS_COMPILE_INVALID_130220-05014*.sql
}

#--------------------------------------------------------------------------
# Load AOL Objects
#--------------------------------------------------------------------------
LoadAOLObjects()
{
cd $CUSTOM_TOP/install/ldt
#concurrent prg
$FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afcpprog.lct ${CUSTOM_TOP}/install/ldt/XXRSSCVMCINT.ldt CUSTOM_MODE='FORCE' 
$FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afmdmsg.lct  ${CUSTOM_TOP}/install/ldt/XXRS_SC_CUSTOMER_ATTR_ERROR.ldt  CUSTOM_MODE='FORCE' 
$FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afmdmsg.lct  ${CUSTOM_TOP}/install/ldt/XXRS_SC_DUP_ACC_RES_EXC.ldt CUSTOM_MODE='FORCE' 
$FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afcpreqg.lct ${CUSTOM_TOP}/install/ldt/XXRSSCVMCINT_RG.ldt CUSTOM_MODE='FORCE' 
#
$FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afcpprog.lct ${CUSTOM_TOP}/install/ldt/XXRSSCVMAUDITREP.ldt CUSTOM_MODE='FORCE' 
$FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $XDO_TOP/patch/115/import/xdotmpl.lct  ${CUSTOM_TOP}/install/ldt/XXRSSCVMAUDITREP_XML.ldt CUSTOM_MODE='FORCE'
$FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} O Y UPLOAD $FND_TOP/patch/115/import/afcpreqg.lct ${CUSTOM_TOP}/install/ldt/XXRSSCVMAUDITREP_RG.ldt CUSTOM_MODE='FORCE'
cat *.log >> $OUTFILE
mv *.log ${LOG_DIR}
}
#--------------------------------------------------------------------------
# Load XML Objects
#--------------------------------------------------------------------------
LoadXMLFiles()
{
java oracle.apps.xdo.oa.util.XDOLoader \
UPLOAD \
-DB_USERNAME apps \
-DB_PASSWORD $apps_pwd \
-JDBC_CONNECTION $jdbc \
-LOB_TYPE DATA_TEMPLATE \
-APPS_SHORT_NAME XXRS \
-LOB_CODE XXRSSCVMAUDITREP \
-LANGUAGE en \
-TERRITORY US \
-XDO_FILE_TYPE XML \
-FILE_NAME ${XML_DIR}/XXRSSCVMAUDITREP.xml \
-NLS_LANG AMERICAN_AMERICA.UTF8 \
-CUSTOM_MODE FORCE

java oracle.apps.xdo.oa.util.XDOLoader \
UPLOAD \
-DB_USERNAME apps \
-DB_PASSWORD $apps_pwd \
-JDBC_CONNECTION $jdbc \
-LOB_TYPE TEMPLATE \
-APPS_SHORT_NAME XXRS \
-LOB_CODE XXRSSCVMAUDITREP \
-LANGUAGE en \
-TERRITORY US \
-XDO_FILE_TYPE RTF \
-FILE_NAME ${XML_DIR}/XXRSSCVMAUDITREP.rtf \
-NLS_LANG AMERICAN_AMERICA.UTF8 \
-CUSTOM_MODE FORCE
}

#--------------------------------------------------------------------------
# Set permissions on folders
#--------------------------------------------------------------------------
SetPermisssions()
{
  cd $JAVA_TOP/xxrs/oracle/apps/
  chmod -R 750 $JAVA_TOP/xxrs/oracle/apps
} 

#--------------------------------------------------------------------------
# Download OA Framework Files
#--------------------------------------------------------------------------
Createfwkfiles()
{    
  cd /app/product/prd/
  tar -xvzf $JAVA_TOP/xxrs/install/xxrs_oaf_rest_jar_130220-05014.tar.gz
  export CLASSPATH=/app/product/prd/jar/*:$CLASSPATH
#    
  cd $JAVA_TOP/xxrs/oracle/apps/xxrs/
  tar -xvzf $JAVA_TOP/xxrs/install/xxrs_oaf_vm_opt_eff_dates_130220-05014.tar.gz
  tar -xvzf $JAVA_TOP/xxrs/install/xxrs_oaf_vm_core_int_130220-05014.tar.gz
  cd $JAVA_TOP/xxrs/oracle/apps/xxrs/setups/product/server/  
  javac ProdResourceVORowImpl.java
  cd $JAVA_TOP/xxrs/oracle/apps/xxrs/setups/schema/server/   
  javac XxrsScProductRsrcDefTblEOImpl.java
  cd $JAVA_TOP/xxrs/oracle/apps/xxrs/core
  javac *.java
  cd $JAVA_TOP/xxrs/oracle/apps/xxrs/product/model
  javac AccountProduct.java
  cd $JAVA_TOP/xxrs/oracle/apps/xxrs/product/client
  javac *.java 
  cd $JAVA_TOP/xxrs/oracle/apps/xxrs/cp
  javac VmOnlineDateUpd.java
}
#---------------------------------------------------------------------
# Importing OAF pages
#---------------------------------------------------------------------
ImportOAFPages()
{
  cd $JAVA_TOP
java oracle.jrad.tools.xml.importer.XMLImporter ./xxrs/oracle/apps/xxrs/setups/product/webui/AssignResourcePG.xml -rootdir $JAVA_TOP -username apps -password $apps_pwd -dbconnection $jdbc >> $OUTFILE  
java oracle.jrad.tools.xml.importer.XMLImporter ./xxrs/oracle/apps/xxrs/setups/product/webui/UpdateProductPG.xml -rootdir $JAVA_TOP -username apps -password $apps_pwd -dbconnection $jdbc >> $OUTFILE  
java oracle.jrad.tools.xml.importer.XMLImporter ./xxrs/oracle/apps/xxrs/setups/product/webui/ReviewProductPG.xml -rootdir $JAVA_TOP -username apps -password $apps_pwd -dbconnection $jdbc >> $OUTFILE  
java oracle.jrad.tools.xml.importer.XMLImporter ./xxrs/oracle/apps/xxrs/setups/product/webui/ViewProductPG.xml -rootdir $JAVA_TOP -username apps -password $apps_pwd -dbconnection $jdbc >> $OUTFILE  
}

SubmitConcProg()
{
  #submitting Generate Messages concurrent program
  cd ${INSTALL_DIR}
CONCSUB $p_apps_usrn_pwd SYSADMIN "System Administrator" SYSADMIN WAIT=N CONCURRENT FND FNDMDGEN '"US" "XXRS" "DB_TO_RUNTIME" "" ""'>> $OUTFILE
}

#--------------------------------------------------------------------------
# Compile Forms
#--------------------------------------------------------------------------
CompileForms()
{
  cd ${FRM_DIR} 

  echo "Compiling form XXRS_SC_CONTRACTS.fmb under ${FRM_DIR}" >> $OUTFILE
  frmcmp_batch.sh userid=${p_apps_usrn_pwd} batch=yes module=XXRS_SC_CONTRACTS.fmb module_type=FORM compile_all=yes window_state=minimize
  mv XXRS_SC_CONTRACTS.err XXRS_SC_CONTRACTS.log
  cat XXRS_SC_CONTRACTS.log >> $OUTFILE
  mv XXRS_SC_CONTRACTS.log  $CUSTOM_TOP/log

  echo "Compiling form XXRS_SC_ACCOUNT_PRODUCT_NS.fmb under ${FRM_DIR}" >> $OUTFILE
  frmcmp_batch.sh userid=${p_apps_usrn_pwd} batch=yes module=XXRS_SC_ACCOUNT_PRODUCT_NS.fmb module_type=FORM compile_all=yes window_state=minimize
  mv XXRS_SC_ACCOUNT_PRODUCT_NS.err XXRS_SC_ACCOUNT_PRODUCT_NS.log
  cat XXRS_SC_ACCOUNT_PRODUCT_NS.log >> $OUTFILE
  mv XXRS_SC_ACCOUNT_PRODUCT_NS.log  $CUSTOM_TOP/log

  echo "Compiling form XXRS_SC_ACCOUNT_PRODUCT_REN.fmb under ${FRM_DIR}" >> $OUTFILE
  frmcmp_batch.sh userid=${p_apps_usrn_pwd} batch=yes module=XXRS_SC_ACCOUNT_PRODUCT_REN.fmb module_type=FORM compile_all=yes window_state=minimize
  mv XXRS_SC_ACCOUNT_PRODUCT_REN.err XXRS_SC_ACCOUNT_PRODUCT_REN.log
  cat XXRS_SC_ACCOUNT_PRODUCT_REN.log >> $OUTFILE
  mv XXRS_SC_ACCOUNT_PRODUCT_REN.log  $CUSTOM_TOP/log

  echo "Compiling form XXRS_SC_ACCOUNT_PRODUCT_UP_DN.fmb under ${FRM_DIR}" >> $OUTFILE
  frmcmp_batch.sh userid=${p_apps_usrn_pwd} batch=yes module=XXRS_SC_ACCOUNT_PRODUCT_UP_DN.fmb module_type=FORM compile_all=yes window_state=minimize
  mv XXRS_SC_ACCOUNT_PRODUCT_UP_DN.err XXRS_SC_ACCOUNT_PRODUCT_UP_DN.log
  cat XXRS_SC_ACCOUNT_PRODUCT_UP_DN.log >> $OUTFILE
  mv XXRS_SC_ACCOUNT_PRODUCT_UP_DN.log  $CUSTOM_TOP/log

  echo "Compiling form XXRS_SC_DEVICE_PRODUCT_NS.fmb under ${FRM_DIR}" >> $OUTFILE
  frmcmp_batch.sh userid=${p_apps_usrn_pwd} batch=yes module=XXRS_SC_DEVICE_PRODUCT_NS.fmb module_type=FORM compile_all=yes window_state=minimize
  mv XXRS_SC_DEVICE_PRODUCT_NS.err XXRS_SC_DEVICE_PRODUCT_NS.log
  cat XXRS_SC_DEVICE_PRODUCT_NS.log >> $OUTFILE
  mv XXRS_SC_DEVICE_PRODUCT_NS.log  $CUSTOM_TOP/log

  echo "Compiling form XXRS_SC_DEVICE_PRODUCT_REN.fmb under ${FRM_DIR}" >> $OUTFILE
  frmcmp_batch.sh userid=${p_apps_usrn_pwd} batch=yes module=XXRS_SC_DEVICE_PRODUCT_REN.fmb module_type=FORM compile_all=yes window_state=minimize
  mv XXRS_SC_DEVICE_PRODUCT_REN.err XXRS_SC_DEVICE_PRODUCT_REN.log
  cat XXRS_SC_DEVICE_PRODUCT_REN.log >> $OUTFILE
  mv XXRS_SC_DEVICE_PRODUCT_REN.log  $CUSTOM_TOP/log

  echo "Compiling form XXRS_SC_DEVICE_PRODUCT_UPG_DNG.fmb under ${FRM_DIR}" >> $OUTFILE
  frmcmp_batch.sh userid=${p_apps_usrn_pwd} batch=yes module=XXRS_SC_DEVICE_PRODUCT_UPG_DNG.fmb module_type=FORM compile_all=yes window_state=minimize
  mv XXRS_SC_DEVICE_PRODUCT_UPG_DNG.err XXRS_SC_DEVICE_PRODUCT_UPG_DNG.log
  cat XXRS_SC_DEVICE_PRODUCT_UPG_DNG.log >> $OUTFILE
  mv XXRS_SC_DEVICE_PRODUCT_UPG_DNG.log  $CUSTOM_TOP/log

  echo "Compiling form XXRS_SC_DEVICE_PRODUCT_MIG.fmb under ${FRM_DIR}" >> $OUTFILE
  frmcmp_batch.sh userid=${p_apps_usrn_pwd} batch=yes module=XXRS_SC_DEVICE_PRODUCT_MIG.fmb module_type=FORM compile_all=yes window_state=minimize
  mv XXRS_SC_DEVICE_PRODUCT_MIG.err XXRS_SC_DEVICE_PRODUCT_MIG.log
  cat XXRS_SC_DEVICE_PRODUCT_MIG.log >> $OUTFILE
  mv XXRS_SC_DEVICE_PRODUCT_MIG.log  $CUSTOM_TOP/log
}
#--------------------------------------------------------------------------
# Mailing output file
#--------------------------------------------------------------------------
MailOutFile()
{
  /bin/mail pavan.amirineni@rackspace.com -c vinodh.bhasker@rackspace.com,bruce.martinez@rackspace.com,tim.cowen@rackspace.com -s "Installation log for Rackspace VM Online Date Integration in ${TWO_TASK}" < $OUTFILE
}
#---------------------------------------------------------------------
# Call the functions					      
#---------------------------------------------------------------------

Psswd

echo -e "\nInstall DB Objects...\n" >> $OUTFILE
CreateDBObjects

echo -e "\nCompile invalid DB Objects...\n" >> $OUTFILE
InvalidObjects

echo -e "\nLoadAOLFiles...\n" >> $OUTFILE
LoadAOLObjects

echo -e "\nLoadXMLFiles...\n" >> $OUTFILE
LoadXMLFiles

echo -e "\nSubmitConcProg...\n" >> $OUTFILE
SubmitConcProg

echo -e "\nCHANGING permissions recursively on $JAVA_TOP/xxrs/oracle/apps ...\n" >> $OUTFILE
SetPermisssions

echo -e "\nUNZIPPING OA Framework Components for Min Qty and Max Qty Changes to $JAVA_TOP/xxrs/oracle/apps ...\n" >> $OUTFILE
Createfwkfiles

echo -e "\nCHANGING permissions recursively on $JAVA_TOP/xxrs/oracle/apps ...\n" >> $OUTFILE
SetPermisssions

echo -e "\nIMPORTING OAF pages ...\n" >> $OUTFILE
ImportOAFPages

echo -e "\nCOMPILING Forms ...\n" >> $OUTFILE
CompileForms

echo -e "\nDone.\n" >> $OUTFILE

echo -e "\nEmailing the outfile.\n"
MailOutFile

echo -e "\nOutput file is ${OUTFILE}"