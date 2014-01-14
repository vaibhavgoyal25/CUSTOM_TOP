#!/bin/bash
#
#************************************************************************************************************+
#--File Name          :       XXRS_IBY_FNDCPT_120807-07718.sh                                                |
#--Program Purpose    :       Install script to execute Oracle Datafix for payment extensions on CM          |
#--Author Name        :       Vinodh Bhasker                                                                 |
#--Initial Build Date :       29-AUG-2012                                                                    |
#--Version            :       1.0                                                                            |
#--Modification History                                                                                      |
#------------------------------------------------------------------------------------------------------------+
#   | Ver   | Ticket No.   | Author          | Date       | Description                                      |
#------------------------------------------------------------------------------------------------------------+
#   | 1.0.0 | 120807-07718 | Vinodh Bhasker  | 29-AUG-2012| Initial Build                                    |
#------------------------------------------------------------------------------------------------------------+
#/* $Header: XXRS_IBY_FNDCPT_120807-07718.sh 1.0.0 29-AUG-2012 02:02:00 PM Vinodh Bhasker $ */
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
 OUTFILE=$OUTDIR/XXRS_IBY_FNDCPT_120807-07718.out
 apps_login=apps

echo `date` > $OUTFILE

#--------------------------------------------------------------------------
# Define the function to get the APPS password.
#--------------------------------------------------------------------------
Apps_Psswd()
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
# Collect incorrect data before and after executing the data fix
#--------------------------------------------------------------------------
SpoolErrorRecords()
{
cd ${SQL_DIR}

sqlplus ${p_apps_usrn_pwd} << EOF
@XXRS_IBY_FNDCPT_120807-07718.sql;
SPOOL OFF;
EOF

}
#--------------------------------------------------------------------------
# Create Database Objects
#--------------------------------------------------------------------------
ExecuteDatafix()
{

cd ${SQL_DIR}

sqlplus ${p_apps_usrn_pwd} << EOF
spool ${OUTFILE}
REM Backing up the records in iby_fndcpt_tx_extensions table
CREATE TABLE xxrs.xxrs_iby_fndcpt_tx_exts_temp
AS
SELECT *
FROM iby_fndcpt_tx_extensions;
REM Executing the file ar120pay_ocm_upg.sql
@ar120pay_ocm_upg.sql;
REM Executing the file script_generic_new.sql
@script_generic_new.sql;
REM Backing up the records in iby_fndcpt_tx_extensions table
CREATE TABLE xxrs.temp_13735383
AS
SELECT *
FROM temp_13735383;
REM Drop temp_13735383 under APPS Schema
DROP TABLE temp_13735383;
CREATE SYNONYM APPS.temp_13735383 FOR xxrs.temp_13735383;
exit;
/
EOF

}
#--------------------------------------------------------------------------
# Mailing output file
#--------------------------------------------------------------------------
MailOutFile()
{
  /bin/mail vinodh.bhasker@rackspace.com -c bruce.martinez@rackspace.com,tim.cowen@rackspace.com -s "Installation log for Populate Bank Instrument Datafix in ${TWO_TASK}" < $OUTFILE
}
#---------------------------------------------------------------------
# Call the functions					      
#---------------------------------------------------------------------
Apps_Psswd

SpoolErrorRecords

ExecuteDatafix

SpoolErrorRecords

echo -e "\nInstallation output file: ${OUTFILE}" 

echo -e "\nDone.\n" >> $OUTFILE

MailOutFile