#!/bin/bash
#
#************************************************************************************************************+
#--File Name          :       XXRS_FA_BALANCES_PURGE_120807-09152.sh                                         |
#--Program Purpose    :       Install script for FA Balances Purge Program                                   |
#--Author Name        :       Vaibhav Goyal                                                                  |
#--Initial Build Date :       08-AUG-2012                                                                    |
#--Version            :       1.0                                                                            |
#--Modification History                                                                                      |
#------------------------------------------------------------------------------------------------------------+
#   | Ver   | Ticket No.   | Author          | Date       | Description                                      |
#------------------------------------------------------------------------------------------------------------+
#   | 1.0.0 | 120807-09152 | Vaibhav Goyal   | 08-AUG-2012| Initial Build                                    |
#------------------------------------------------------------------------------------------------------------+
#/* $Header: XXRS_FA_BALANCES_PURGE_120807-09152.sh 1.0.0 08-AUG-2012 02:00:00 PM Vaibhav Goyal $ */
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
 OUTFILE=$OUTDIR/XXRS_FA_BALANCES_PURGE_120807-09152.out
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
# Create Database Objects
#--------------------------------------------------------------------------
TruncateTable()
{
sqlplus ${p_apps_usrn_pwd} << EOF
set lines 80 
col num_rows     format 999,999,999,999
col SEGMENT_NAME format a30 
col TOTAL_BYTES  format 999,999,999,999
spool ${OUTFILE}
set echo on 
REM Before deleting the records from FA_BALANCES_REPORTS_ITF
SELECT count (*) num_rows
  FROM FA_BALANCES_REPORTS_ITF;

SELECT segment_name,SUM(bytes) total_bytes
  FROM dba_segments 
 WHERE segment_name LIKE 'FA_BALANCES_REPORTS_ITF%'
GROUP BY segment_name;

TRUNCATE TABLE FA.FA_BALANCES_REPORTS_ITF /*120807-09152*/ ;

REM After deleting the records from FA_BALANCES_REPORTS_ITF
SELECT count (*) num_rows
  FROM FA_BALANCES_REPORTS_ITF;

SELECT segment_name,SUM(bytes) total_bytes
  FROM dba_segments 
 WHERE segment_name LIKE 'FA_BALANCES_REPORTS_ITF%'
GROUP BY segment_name;

execute fnd_stats.gather_table_stats('FA','FA_BALANCES_REPORTS_ITF');
exit;
/
EOF

}
#--------------------------------------------------------------------------
# Running FNDLOAD Scripts
#--------------------------------------------------------------------------
 CreateAOLObjects()
 {
   cd $LDT_DIR 
   
   echo "FNDLOAD For Concurrent Program Rackspace Assets Balance Reports Purge"
   $FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afcpprog.lct ${CUSTOM_TOP}/install/ldt/XXRSFABALPUR.ldt
   $FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afcpreqg.lct ${CUSTOM_TOP}/install/ldt/XXRSFABALPUR_RG.ldt CUSTOM_MODE='FORCE'
   $FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afcpreqg.lct ${CUSTOM_TOP}/install/ldt/XXRSFABALPUR_RG1.ldt CUSTOM_MODE='FORCE'

   # Output the FNDLOAD log files to the out file
   cat *.log >> $OUTFILE
   
   # Clear all the FNDLOAD log files from the install directory
   mv *.log  $CUSTOM_TOP/log
 }
#--------------------------------------------------------------------------
# Mailing output file
#--------------------------------------------------------------------------
MailOutFile()
{
  /bin/mail vaibhav.goyal@rackspace.com -c bruce.martinez@rackspace.com,tim.cowen@rackspace.com -s "Installation log for Rackspace Assets Balance Reports Purge in ${TWO_TASK}" < $OUTFILE
}
#---------------------------------------------------------------------
# Call the functions					      
#---------------------------------------------------------------------
Apps_Psswd

TruncateTable

CreateAOLObjects

echo -e "\nInstallation output file: ${OUTFILE}" 

echo -e "\nDone.\n" >> $OUTFILE

MailOutFile
