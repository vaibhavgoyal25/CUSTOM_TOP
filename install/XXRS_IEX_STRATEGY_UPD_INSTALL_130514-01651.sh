#!/bin/bash

#************************************************************************************************************+
#--File Name          :       XXRS_IEX_STRATEGY_UPD_INSTALL_130514-01651.sh                                  |
#--Program Purpose    :       Install Script For Rackspace Advance Collection Strategy Update.               |
#--Author Name        :       Vaibhav Goyal                                                                  |
#--Initial Build Date :       21-May-2013                                                                    |
#--                                                                                                          |
#--Version            :       1.0.0                                                                          |
#------------------------------------------------------------------------------------------------------------+
#--Modification History                                                                                      |
#------------------------------------------------------------------------------------------------------------+
#   | Ver   | Ticket No.   | Author          | Date       | Description                                      |
#------------------------------------------------------------------------------------------------------------+
#   | 1.0.0 | 130514-01651 | Vaibhav Goyal   | 21-May-2013| Initial Build                                    |
#------------------------------------------------------------------------------------------------------------+
#************************************************************************************************************/
#   $Header: XXRS_IEX_STRATEGY_UPD_INSTALL_130514-01651.sh 1.0.0 21-May-2013 15:00:00 Vaibhav Goyal$
#
#--------------------------------------------------------------------------
# Set the environmental variables and other administrative requirements.
#--------------------------------------------------------------------------
DATETIMESTAMP=`date +%Y%m%d%H%M%S`
p_apps_usrn_pwd=$1
jdbc=`echo $AD_APPS_JDBC_URL`
CUSTOM_TOP=$XXRS_TOP
DATA_DIR=/tmp
ARCHIVE_DIR=$CUSTOM_TOP/archive/ar
SQL_DIR=$CUSTOM_TOP/install/sql
LDT_DIR=$CUSTOM_TOP/install/ldt
XML_DIR=$CUSTOM_TOP/xml
LOG_DIR=$CUSTOM_TOP/log
WFT_DIR=$CUSTOM_TOP/import/US
REPORTS_DIR=$CUSTOM_TOP/reports/US
INSTALL_DIR=$CUSTOM_TOP/install
OUTDIR=$CUSTOM_TOP/out
OUTFILE=$OUTDIR/XXRS_IEX_STRATEGY_UPD_INSTALL_130514-01651.out
OUTFILE1=$OUTDIR/XXRS_IEX_STRATEGY_UPD_INSTALL_130514-01651_1.out

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
  /bin/mail vaibhav.goyal@rackspace.com -c vinodh.bhasker@rackspace.com,bruce.martinez@rackspace.com,tim.cowen@rackspace.com -s "Installation log for Rackspace Advance Collection Strategy Update in ${TWO_TASK}" < $OUTFILE
}

#--------------------------------------------------------------------------
# Creating Database Objects
#--------------------------------------------------------------------------
CreateTempTable()
{
  cd $SQL_DIR

sqlplus apps/$apps_pwd << EOF
spool $OUTFILE
@XXRS_CUST_SITE_STRATEGY_TMP.sql
exit;
/
EOF
}


#--------------------------------------------------------------------------
# Running Sql Loader to Load the Strategy Data into Custom Table
#--------------------------------------------------------------------------
LoadData()
{
  cd ${DATA_DIR}

echo "Running SQL Loader To Load the Strategy data into Custom Table"
sqlldr apps/$apps_pwd data=${DATA_DIR}/XXRS_CUST_STRATEGY_SEGMENT.csv control=$CUSTOM_TOP/bin/XXRSARADVCOLLSTR.ctl

  cat XXRSARADVCOLLSTR.log >> $OUTFILE
  mv XXRSARADVCOLLSTR.log ${LOG_DIR}
  mv ${DATA_DIR}/XXRS_CUST_STRATEGY_SEGMENT.csv ${ARCHIVE_DIR}/XXRS_CUST_STRATEGY_SEGMENT.csv
}


#--------------------------------------------------------------------------
# Updating Database Objects
#--------------------------------------------------------------------------
CreateDBObjects()
{
  cd $SQL_DIR
sqlplus apps/$apps_pwd << EOF
spool $OUTFILE1
@XXRS_HZ_CUST_ACCT_SITES_BKP.sql
@XXRS_STRATEGY_CUST_SITE_UPD.sql
@XXRS_IEX_F_STRATEGY_VIEWS.sql
@XXRS_IEX_STRATEGY_PKG.pkb
@XXRS_CUST_SITE_STRATEGY_TMP_DROP.sql;
exit;
/
EOF
   # Output the FNDLOAD log files to the out file
     cat $OUTFILE1 >> $OUTFILE
   # Clear all the FNDLOAD log files from the install directory
     mv $OUTFILE1  $CUSTOM_TOP/log
}

#--------------------------------------------------------------------------
# Running FNDLOAD Scripts
#--------------------------------------------------------------------------
 CreateAOLObjects()
 {
   cd $LDT_DIR 

echo "FNDLOAD For Address Information Dff"
FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afffload.lct XXRS_RA_ADDRESSES_HZ.ldt


   # Output the FNDLOAD log files to the out file
     cat *.log >> $OUTFILE
   # Clear all the FNDLOAD log files from the install directory
     mv *.log  $CUSTOM_TOP/log
 }

#--------------------------------------------------------------------------
# Calling Functions
#--------------------------------------------------------------------------
Psswd

echo -e "\nCreating Temporary Table to Hold Customer Strategy Data...\n" >> $OUTFILE
CreateTempTable

echo -e "\nLoading Data...\n" >> $OUTFILE
LoadData

echo -e "\nCREATING DB Objects...\n" >> $OUTFILE
CreateDBObjects

echo -e "\nUpdating Address Information Dff...\n" >> $OUTFILE
CreateAOLObjects

echo -e "\nDone.\n" >> $OUTFILE
#
echo -e "\nInstallation output file: ${OUTFILE}" 
echo -e "\nEmailing the outfile.\n"
MailOutFile