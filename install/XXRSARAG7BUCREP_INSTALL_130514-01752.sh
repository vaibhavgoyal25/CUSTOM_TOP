#!/bin/bash
#************************************************************************************************************+
#--File Name          :       XXRSARAG7BUCREP_INSTALL_130514-01752.sh                                       | 
#--Program Purpose    :       Installation script for Rackspace Aging 7 bucket report.                       |
#--Author Name        :       Vaibhav Goyal                                                                  |
#--Initial Build Date :       31-MAY-2013                                                                    |
#							                                                     |
#--Version            :       1.0.0                                                                          |
#--Modification History                                                                                      |
#   | Ver   | Ticket No.   | Author          | Date        | Description                                     |
#------------------------------------------------------------------------------------------------------------+
#-- | 1.0.0 | 130514-01752 | Mahesh Guddeti  | 31-MAY-2013 | Initial Creation                                |
#------------------------------------------------------------------------------------------------------------+
#************************************************************************************************************/
#/* $Header: XXRSARAG7BUCREP_INSTALL_130514-01752.sh 1.0.0 31-MAY-2013 17:00:00 PM Mahesh Guddeti $ */
#
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
WFT_DIR=$CUSTOM_TOP/import/US
REPORTS_DIR=$CUSTOM_TOP/reports/US
INSTALL_DIR=$CUSTOM_TOP/install
OUTDIR=$CUSTOM_TOP/out
OUTFILE=$OUTDIR/XXRSARAG7BUCREP_INSTALL_130514-01752.out

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
@XXRS_AR_AGING_7_REP_GT_ALTER.sql
@XXRS_UTILITY_PKG.pks
@XXRS_UTILITY_PKG.pkb
@XXRS_AR_AGING_PKG.pkb
Alter PACKAGE APPS."XXRS_SC_ACCOUNT_PRODUCT_PKG" COMPILE BODY;
Alter VIEW APPS."XXRS_SC_ACCOUNT_RESOURCE_VW" COMPILE ;
Alter PACKAGE APPS."XXRS_SC_ACC_PRICE_PKG" COMPILE BODY;
Alter PACKAGE APPS."XXRS_SC_DEVICE_PRODUCT_PKG" COMPILE BODY;
Alter VIEW APPS."XXRS_SC_DEVICE_RESOURCE_VW" COMPILE ;
Alter VIEW APPS."XXRS_SC_INVOICE_WKST_ARCH_VW" COMPILE ;
Alter VIEW APPS."XXRS_SC_INVOICE_WKST_INT_VW" COMPILE ;
Alter PACKAGE APPS."XXRS_SC_INVOICE_WKST_PKG" COMPILE BODY;
Alter VIEW APPS."XXRS_SC_INVOICE_WKST_VW" COMPILE ;
Alter VIEW APPS."XXRS_SC_MIGRATED_DEVICES_VW" COMPILE ;
Alter PACKAGE APPS."XXRS_WS_SC_ACCTLVLPRDPRC_PKG" COMPILE BODY;
exit;
/
EOF
} 

#--------------------------------------------------------------------------
# Mailing output file
#--------------------------------------------------------------------------
MailOutFile()
{
  /bin/mail mahesh.guddeti@rackspace.com -c vinodh.bhasker@rackspace.com,vaibhav.goyal@rackspace.com,bruce.martinez@rackspace.com,tim.cowen@rackspace.com -s "Installation log for Rackspace Aging 7 Bucket Report in ${TWO_TASK}" < $OUTFILE
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
-LOB_CODE XXRSARAG7BUCREP \
-LANGUAGE en \
-TERRITORY US \
-XDO_FILE_TYPE XML \
-FILE_NAME ${XML_DIR}/XXRSARAG7BUCREP.xml \
-NLS_LANG AMERICAN_AMERICA.UTF8 \
-CUSTOM_MODE FORCE


java oracle.apps.xdo.oa.util.XDOLoader \
UPLOAD \
-DB_USERNAME apps \
-DB_PASSWORD $apps_pwd \
-JDBC_CONNECTION $jdbc \
-LOB_TYPE TEMPLATE \
-APPS_SHORT_NAME XXRS \
-LOB_CODE XXRSARAG7BUCREP \
-LANGUAGE en \
-TERRITORY US \
-XDO_FILE_TYPE RTF \
-FILE_NAME ${XML_DIR}/XXRSARAG7BUCREP.rtf \
-NLS_LANG AMERICAN_AMERICA.UTF8 \
-CUSTOM_MODE FORCE

}

#--------------------------------------------------------------------------
# Calling Functions
#--------------------------------------------------------------------------
Psswd
echo -e "\nCreating Database Objects...\n"
CreateDBObjects


echo -e "\nUploading XML Objects...\n" >> $OUTFILE
LoadXMLFiles >> $OUTFILE

echo -e "\nDone.\n" >> $OUTFILE
echo -e "\nInstallation output file: ${OUTFILE}" 
echo -e "\nEmailing the outfile.\n"
MailOutFile
