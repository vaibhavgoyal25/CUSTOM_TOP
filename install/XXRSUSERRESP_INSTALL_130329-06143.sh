#!/bin/bash
#************************************************************************************************************+
#--File Name          :       XXRSUSERRESP_INSTALL_130329-06143.sh                                           | 
#--Program Purpose    :       Installation script for Rackspace User Responsibility Report.                  |
#--Author Name        :       Mahesh Guddeti                                                                 |
#--Initial Build Date :       17-JUN-2013                                                                    |
#							                                                     |
#--Version            :       1.0.0                                                                          |
#--Modification History                                                                                      |
#   | Ver   | Ticket No.   | Author          | Date        | Description                                     |
#------------------------------------------------------------------------------------------------------------+
#-- | 1.0.0 | 130329-06143 | Mahesh Guddeti   | 17-JUN-2013 | Initial Creation                              |
#------------------------------------------------------------------------------------------------------------+
#************************************************************************************************************/
#/* $Header: XXRSUSERRESP_INSTALL_130329-06143.sh 1.0.0 17-JUN-2013 17:00:00 PM Mahesh Guddeti $ */
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
 OUTFILE=$OUTDIR/XXRSUSERRESP_INSTALL_130329-06143.out
 apps_login=apps

echo ${p_apps_usrn_pwd##*/}
echo ${p_apps_usrn_pwd}
echo ${jdbc}

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
  /bin/mail mahesh.guddeti@rackspace.com,vaibhav.goyal@rackspace.com -c vinodh.bhasker@rackspace.com,bruce.martinez@rackspace.com,tim.cowen@rackspace.com -s "Installation log for Rackspace User Responsibility List Report in ${TWO_TASK}" < $OUTFILE
}
#--------------------------------------------------------------------------
# Function to create 
#--------------------------------------------------------------------------

CreateSoftLink()
{
cd $CUSTOM_TOP/bin
ln -s $FND_TOP/bin/fndcpesr XXRSUSERRESPPUT
}

UploadAolObjects()
{
cd $CUSTOM_TOP/install/ldt

#concurrent prg
$FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afcpprog.lct ${CUSTOM_TOP}/install/ldt/XXRSUSERRESP.ldt CUSTOM_MODE='FORCE' 
$FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $XDO_TOP/patch/115/import/xdotmpl.lct ${CUSTOM_TOP}/install/ldt/XXRSUSERRESP_XML.ldt CUSTOM_MODE='FORCE'

$FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afcpprog.lct ${CUSTOM_TOP}/install/ldt/XXRSUSERRESPPUT.ldt CUSTOM_MODE='FORCE' 

$FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afcprset.lct $XXRS_TOP/install/ldt/XXRSUSERRESP_SET.ldt
$FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afcprset.lct $XXRS_TOP/install/ldt/XXRSUSERRESP_SET_LNK.ldt

$FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afcpreqg.lct ${CUSTOM_TOP}/install/ldt/XXRSUSERRESP_SET_RG.ldt CUSTOM_MODE='FORCE'
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
-LOB_CODE XXRSUSERRESP \
-LANGUAGE en \
-TERRITORY US \
-XDO_FILE_TYPE XML \
-FILE_NAME ${XML_DIR}/XXRSUSERRESP_DD_XML.xml \
-NLS_LANG AMERICAN_AMERICA.UTF8 \
-CUSTOM_MODE FORCE


java oracle.apps.xdo.oa.util.XDOLoader \
UPLOAD \
-DB_USERNAME apps \
-DB_PASSWORD $apps_pwd \
-JDBC_CONNECTION $jdbc \
-LOB_TYPE TEMPLATE \
-APPS_SHORT_NAME XXRS \
-LOB_CODE XXRSUSERRESP \
-LANGUAGE en \
-TERRITORY US \
-XDO_FILE_TYPE RTF-ETEXT \
-FILE_NAME ${XML_DIR}/XXRSUSERRESP_ETEXT.rtf \
-NLS_LANG AMERICAN_AMERICA.UTF8 \
-CUSTOM_MODE FORCE

}

#--------------------------------------------------------------------------
# Calling Functions
#--------------------------------------------------------------------------
Psswd

echo -e "\nCreating Softlink...\n" >> $OUTFILE
CreateSoftLink >> $OUTFILE

echo -e "\nUploading AOL Objects...\n" >> $OUTFILE
UploadAolObjects >> $OUTFILE

echo -e "\nUploading XML Objects...\n" >> $OUTFILE
LoadXMLFiles >> $OUTFILE

echo -e "\nDone.\n" >> $OUTFILE
echo -e "\nInstallation output file: ${OUTFILE}" 
echo -e "\nEmailing the outfile.\n"
MailOutFile
