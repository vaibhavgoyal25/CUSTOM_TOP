#!/bin/bash
#
#************************************************************************************************************+
#--File Name          :       XXRS_FA_SISIC_UPL_111122-02448.sh                                                           |
#--Program Purpose    :       Install script for SISIC                                                       |
#--Author Name        :       Sunil Kumar Mallina                                                            |
#--Initial Build Date :       31-DEC-2011                                                                    |                                                                     |
#--Version            :       1.0                                                                            |
#--Modification History                                                                                      |
#------------------------------------------------------------------------------------------------------------+
#   | Ver     | Ticket Number   | Author                | Date         | Description                         |
#------------------------------------------------------------------------------------------------------------+
#   | 1.0.0   | 111122-02448    | Sunil Kumar Mallina   | 31-DEC-2011  | R12 Upgradation                     |
#------------------------------------------------------------------------------------------------------------+
#************************************************************************************************************/
#/* $Header: XXRS_FA_SISIC_UPL_111122-02448.sh 1.0.0 31-DEC-2011 13:33:00 PM Sunil Kumar M $ */
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
 INSTALL_DIR=$CUSTOM_TOP/install
 OUTDIR=$CUSTOM_TOP/out
 OUTFILE=$OUTDIR/XXRS_FA_SISIC_UPL_111122-02448.out
 apps_login=apps
 echo `date` > $OUTFILE

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
  if [ -n "$jdbc" ];then
    echo ""
  else
    echo "Please enter JDBC TNSNAMES Connection, (hostname:port:SID, dfw1svdevdbs02.ora.rackspace.com:1551:DEV)=>"
    read jdbc
  fi
}
#--------------------------------------------------------------------------
# Creating Database objects
#--------------------------------------------------------------------------
CreateDBObjects()
{
  cd $SQL_DIR
sqlplus $p_apps_usrn_pwd << EOF
spool $OUTFILE
@XXRS_FA_SISIC_DB_OBJECTS.sql
@XXRS_FA_SISIC_PKG.pks
@XXRS_FA_SISIC_PKG.pkb
exit;
/
EOF
}
#--------------------------------------------------------------------------
# Create Directory Structure
#--------------------------------------------------------------------------
 Createdir()
 {
   mkdir -p $XXRS_TOP/data/upload/FA/US
   echo -e "\nCreated Directory Structure $XXRS_TOP/data/upload/FA/US\n" >> $OUTFILE 
   chmod -R 750 $XXRS_TOP/data/upload/FA/US
   echo -e "\nChanged Permissions recursively on $XXRS_TOP/data/upload/FA/US\n" >> $OUTFILE
   
   mkdir -p $XXRS_TOP/data/upload/FA/GB
   echo -e "\nCreated Directory Structure $XXRS_TOP/data/upload/FA/GB\n" >> $OUTFILE 
   chmod -R 750 $XXRS_TOP/data/upload/FA/GB
   echo -e "\nChanged Permissions recursively on $XXRS_TOP/data/upload/FA/GB\n" >> $OUTFILE
   
   mkdir -p $XXRS_TOP/data/upload/FA/NL
   echo -e "\nCreated Directory Structure $XXRS_TOP/data/upload/FA/NL\n" >> $OUTFILE 
   chmod -R 750 $XXRS_TOP/data/upload/FA/NL
   echo -e "\nChanged Permissions recursively on $XXRS_TOP/data/upload/FA/NL\n" >> $OUTFILE
   
   mkdir -p $XXRS_TOP/data/upload/FA/HK
   echo -e "\nCreated Directory Structure $XXRS_TOP/data/upload/FA/HK\n" >> $OUTFILE 
   chmod -R 750 $XXRS_TOP/data/upload/FA/HK
   echo -e "\nChanged Permissions recursively on $XXRS_TOP/data/upload/FA/HK\n" >> $OUTFILE

   #data directory  
   mkdir -p $XXRS_TOP/data/fa/sisic
   echo -e "\nCreated Directory Structure $XXRS_TOP/data/fa/sisic\n" >> $OUTFILE 
   chmod -R 750 $XXRS_TOP/data/fa/sisic
   echo -e "\nChanged Permissions recursively on $XXRS_TOP/data/fa/sisic\n" >> $OUTFILE 

   #Archive  
   mkdir -p $XXRS_TOP/archive/fa/sisic
   echo -e "\nCreated Directory Structure $XXRS_TOP/archive/fa/sisic\n" >> $OUTFILE 
   chmod -R 750 $XXRS_TOP/archive/fa/sisic
   echo -e "\nChanged Permissions recursively on $XXRS_TOP/archive/fa/sisic\n" >> $OUTFILE 
 } 
#--------------------------------------------------------------------------
# Mailing output file
#--------------------------------------------------------------------------
MailOutFile()
{
  /bin/mail vinodh.bhasker@rackspace.com -c bruce.martinez@rackspace.com,tim.cowen@rackspace.com -s "Installation log for Rackspace Transfer Asset Company Inbound Process in ${TWO_TASK}" < $OUTFILE
}
#--------------------------------------------------------------------------
# Using the FNDLOAD to load AOL objects
#--------------------------------------------------------------------------
LoadAOLData()
{
  cd ${LDT_DIR}
  
  FNDLOAD $p_apps_usrn_pwd 0 Y UPLOAD @FND:patch/115/import/afcpprog.lct XXRSFAXABC.ldt CUSTOM_MODE="FORCE" >> $OUTFILE  
  FNDLOAD $p_apps_usrn_pwd 0 Y UPLOAD @FND:patch/115/import/afcpreqg.lct XXRSFAXABC_REQ_ALL.ldt CUSTOM_MODE="FORCE" >> $OUTFILE  
 cat *.log >> $OUTFILE
  mv *.log ${LOG_DIR}
}
#--------------------------------------------------------------------------
# Calling Functions
#--------------------------------------------------------------------------
Psswd

echo -e "\nCREATIONG Database Objects...\n" >> $OUTFILE
CreateDBObjects

echo -e "\nCREATIONG Directory...\n" >> $OUTFILE
Createdir

echo -e "\nLOADING AOL Data...\n" >> $OUTFILE
LoadAOLData

echo -e "\nDone.\n" >> $OUTFILE

echo -e "\nEmailing the outfile.\n"
MailOutFile

echo -e "\nOutput file is ${OUTFILE}"
