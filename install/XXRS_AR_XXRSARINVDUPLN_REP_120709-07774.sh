#!/bin/bash  
#************************************************************************************************************+
#--File Name          :       XXRS_AR_XXRSARINVDUPLN_REP_120709-07774.sh                                     |
#--Program Purpose    :       Rackspace Duplicate Invoice Lines                                              |
#--Author Name        :       Vinodh Bhasker                                                                 |
#--Initial Build Date :       10-JUL-2012                                                                    |
#--                                                                                                          |
#--Version            :       1.0.0                                                                          |
#------------------------------------------------------------------------------------------------------------+
#--Modification History                                                                                      |
#------------------------------------------------------------------------------------------------------------+
#   | Ver     | Ticket No.   | Author          | Date       | Description                                    |
#------------------------------------------------------------------------------------------------------------+
#   | 1.0.0   | 120709-07774 | Vinodh Bhasker  | 10-JUL-2012| Initial Build.                                 |
#------------------------------------------------------------------------------------------------------------+
#************************************************************************************************************/
#  /* $HEADER: XXRS_AR_XXRSARINVDUPLN_REP_120709-07774.sh 1.0.0 10-JUL-2012  5:43:00 PM Vinodh Bhasker $ */
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
 OUTFILE=$OUTDIR/XXRS_AR_XXRSARINVDUPLN_REP_120709-07774.out
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
  /bin/mail vinodh.bhasker@rackspace.com -c bruce.martinez@rackspace.com,tim.cowen@rackspace.com -s "Installation log for Rackspace Duplicate Invoice Lines in ${TWO_TASK}" < $OUTFILE
}
#--------------------------------------------------------------------------
# Function to create 
#--------------------------------------------------------------------------
UploadAolObjects()
{
cd $CUSTOM_TOP/install/ldt

#concurrent prg
$FND_TOP/bin/FNDLOAD $p_apps_usrn_pwd O Y UPLOAD $FND_TOP/patch/115/import/afffload.lct ${CUSTOM_TOP}/install/ldt/XXRS_AR_CUST_ORDER_BY.ldt CUSTOM_MODE='FORCE' 
$FND_TOP/bin/FNDLOAD $p_apps_usrn_pwd O Y UPLOAD $FND_TOP/patch/115/import/afcpprog.lct ${CUSTOM_TOP}/install/ldt/XXRSARINVDUPLN.ldt CUSTOM_MODE='FORCE' 
$FND_TOP/bin/FNDLOAD $p_apps_usrn_pwd O Y UPLOAD $XDO_TOP/patch/115/import/xdotmpl.lct ${CUSTOM_TOP}/install/ldt/XXRSARINVDUPLN_XML.ldt CUSTOM_MODE='FORCE'
$FND_TOP/bin/FNDLOAD $p_apps_usrn_pwd O Y UPLOAD $FND_TOP/patch/115/import/afcpreqg.lct ${CUSTOM_TOP}/install/ldt/XXRSARINVDUPLN_RG.ldt CUSTOM_MODE='FORCE'
cat *.log >> $OUTFILE
mv *.log ${LOG_DIR}
}

LoadXMLFiles()
{
java oracle.apps.xdo.oa.util.XDOLoader \
UPLOAD \
-DB_USERNAME apps \
-DB_PASSWORD $apps_pwd \
-JDBC_CONNECTION $jdbc \
-LOB_TYPE DATA_TEMPLATE \
-APPS_SHORT_NAME XXRS \
-LOB_CODE XXRSARINVDUPLN \
-LANGUAGE en \
-TERRITORY US \
-XDO_FILE_TYPE XML \
-FILE_NAME ${XML_DIR}/XXRSARINVDUPLN.xml \
-NLS_LANG AMERICAN_AMERICA.UTF8 \
-CUSTOM_MODE FORCE >> $OUTFILE

java oracle.apps.xdo.oa.util.XDOLoader \
UPLOAD \
-DB_USERNAME apps \
-DB_PASSWORD $apps_pwd \
-JDBC_CONNECTION $jdbc \
-LOB_TYPE XML_SAMPLE \
-APPS_SHORT_NAME XXRS \
-LOB_CODE XXRSARINVDUPLN \
-LANGUAGE en \
-TERRITORY US \
-XDO_FILE_TYPE XML \
-FILE_NAME ${XML_DIR}/XXRSARINVDUPLN_DATA.xml \
-NLS_LANG AMERICAN_AMERICA.UTF8 \
-CUSTOM_MODE FORCE >> $OUTFILE

java oracle.apps.xdo.oa.util.XDOLoader \
UPLOAD \
-DB_USERNAME apps \
-DB_PASSWORD $apps_pwd \
-JDBC_CONNECTION $jdbc \
-LOB_TYPE TEMPLATE_SOURCE \
-APPS_SHORT_NAME XXRS \
-LOB_CODE XXRSARINVDUPLN \
-LANGUAGE en \
-TERRITORY US \
-TRANSLATE Y \
-XDO_FILE_TYPE RTF \
-FILE_NAME ${XML_DIR}/XXRSARINVDUPLN.rtf \
-NLS_LANG AMERICAN_AMERICA.UTF8 \
-FILE_CONTENT_TYPE 'application/rtf' \
-CUSTOM_MODE FORCE >> $OUTFILE

java oracle.apps.xdo.oa.util.XDOLoader \
UPLOAD \
-DB_USERNAME apps \
-DB_PASSWORD $apps_pwd \
-JDBC_CONNECTION $jdbc \
-LOB_TYPE TEMPLATE \
-APPS_SHORT_NAME XXRS \
-LOB_CODE XXRSARINVDUPLNLST \
-LANGUAGE en \
-XDO_FILE_TYPE RTF \
-FILE_NAME ${XML_DIR}/XXRSARINVDUPLNLST.rtf \
-NLS_LANG AMERICAN_AMERICA.UTF8 \
-CUSTOM_MODE FORCE >> $OUTFILE
}

#--------------------------------------------------------------------------
# Calling Functions
#--------------------------------------------------------------------------
Psswd

echo -e "\nUploading AOL Objects...\n" >> $OUTFILE
UploadAolObjects >> $OUTFILE

echo -e "\nUploading XML Objects...\n" >> $OUTFILE
LoadXMLFiles >> $OUTFILE

echo -e "\nDone.\n" >> $OUTFILE
echo -e "\nInstallation output file: ${OUTFILE}" 
echo -e "\nEmailing the outfile.\n"
MailOutFile
