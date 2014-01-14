#!/bin/bash
#
#************************************************************************************************************+
#--File Name          : XXRS_INV_RESP_INSTALL_130604-09748.sh                                                |
#--Program Purpose    : Install script create new inventory responsibilities                                 |
#--Author Name        : Pavan Amirineni                                                                      |
#--Initial Build Date : 10-JUL-2013                                                                          | 
#--Version            : 1.0.0                                                                                |
#--Modification History                                                                                      |
#------------------------------------------------------------------------------------------------------------+
#   | Ver   | Ticket No.   | Author          | Date       | Description                                      |
#------------------------------------------------------------------------------------------------------------+
#   | 1.0   | 130604-09748 | Pavan Amirineni | 10-JUL-2013| Initial Creation             	                 |
#------------------------------------------------------------------------------------------------------------+
#************************************************************************************************************/
#
#-- $Header: XXRS_INV_RESP_INSTALL_130604-09748.sh 1.0.0 10-JUL-2013 4:30:00 AM Pavan Amirineni $ 
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
OUTFILE=$OUTDIR/XXRS_INV_RESP_INSTALL_130604-09748_${DATETIMESTAMP}.out
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
# Load AOL Objects
#--------------------------------------------------------------------------
LoadAOLObjects()
{
cd $CUSTOM_TOP/install/ldt

$FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afsload.lct XXRS_INV_OPS_SUB.ldt CUSTOM_MODE='FORCE'
$FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct XXRS_AS1_INV_OPS.ldt CUSTOM_MODE='FORCE'
$FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct XXRS_GV1_INV_OPS.ldt CUSTOM_MODE='FORCE'
$FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct XXRS_LN3_INV_OPS.ldt CUSTOM_MODE='FORCE'
$FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct XXRS_SY2_INV_OPS.ldt CUSTOM_MODE='FORCE'
$FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct XXRS_AU1_INV_OPS.ldt CUSTOM_MODE='FORCE'
$FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct XXRS_HE1_INV_OPS.ldt CUSTOM_MODE='FORCE'
$FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct XXRS_LN4_INV_OPS.ldt CUSTOM_MODE='FORCE'
$FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct XXRS_UX1_INV_OPS.ldt CUSTOM_MODE='FORCE'
$FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct XXRS_BL1_INV_OPS.ldt CUSTOM_MODE='FORCE'
$FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct XXRS_HK1_INV_OPS.ldt CUSTOM_MODE='FORCE'
$FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct XXRS_NL1_INV_OPS.ldt CUSTOM_MODE='FORCE'
$FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct XXRS_UX2_INV_OPS.ldt CUSTOM_MODE='FORCE'
$FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct XXRS_CH1_INV_OPS.ldt CUSTOM_MODE='FORCE'
$FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct XXRS_LN1_INV_OPS.ldt CUSTOM_MODE='FORCE'
$FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct XXRS_RI1_INV_OPS.ldt CUSTOM_MODE='FORCE'
$FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct XXRS_EG1_INV_OPS.ldt CUSTOM_MODE='FORCE'
$FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct XXRS_LN2_INV_OPS.ldt CUSTOM_MODE='FORCE'
$FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct XXRS_SA1_INV_OPS.ldt CUSTOM_MODE='FORCE'

cat *.log >> $OUTFILE
mv *.log ${LOG_DIR}
}
#--------------------------------------------------------------------------
# Mailing output file
#--------------------------------------------------------------------------
MailOutFile()
{
  /bin/mail vinodh.bhasker@rackspace.com -c bruce.martinez@rackspace.com,tim.cowen@rackspace.com -s "Installation log for Installation of new Inventory Responsibilities in ${TWO_TASK}" < $OUTFILE
}
#---------------------------------------------------------------------
# Call the functions					      
#---------------------------------------------------------------------

Psswd

echo -e "\nLoadAOLFiles...\n" >> $OUTFILE
LoadAOLObjects

echo -e "\nDone.\n" >> $OUTFILE

echo -e "\nEmailing the outfile.\n"
MailOutFile

echo -e "\nOutput file is ${OUTFILE}"
