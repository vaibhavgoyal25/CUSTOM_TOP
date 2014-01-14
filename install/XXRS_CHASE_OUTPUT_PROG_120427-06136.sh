#!/bin/bash
#************************************************************************************************************+
#--File Name          :       XXRS_CHASE_OUTPUT_PROG_120427-06136.sh                                         | 
#--Program Purpose    :       Installation script for Rackspace Chase Output                                 |
#--Author Name        :       Vaibhav Goyal                                                                  |
#--Initial Build Date :       19-JAN-2012                                                                    |
#							                                                     |
#--Version            :       1.0.0                                                                          |
#--Modification History                                                                                      |
#   | Ver   | Ticket No.   | Author          | Date        | Description                                     |
#------------------------------------------------------------------------------------------------------------+
#-- | 1.0.0 | 120427-06136 | Vaibhav Goyal   | 30-APR-2012 | R12 Upgradation                                 |
#------------------------------------------------------------------------------------------------------------+
#************************************************************************************************************/
#/* $Header: XXRS_CHASE_OUTPUT_PROG_120427-06136.sh 1.0.0 30-APR-2012 15:37:00 PM Vaibhav Goyal $ */
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
 OUTFILE=$OUTDIR/XXRS_CHASE_OUTPUT_PROG_120427-06136.out
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
  /bin/mail vinodh.bhasker@rackspace.com -c bruce.martinez@rackspace.com,tim.cowen@rackspace.com -s "Installation log for Rackspace Buyer Metrics Report in ${TWO_TASK}" < $OUTFILE
}

#--------------------------------------------------------------------------
# Function to upload the responsibilities
#--------------------------------------------------------------------------
DbObjectsRegister()
{
cd $SQL_DIR
sqlplus -s apps/$apps_pwd << EOF
spool $OUTFILE
@XXRS_CHASE_OUTBOUND_PKG.pks;
@XXRS_CHASE_OUTBOUND_PKG.pkb;
exit;
/
EOF

}

#--------------------------------------------------------------------------
# Using the FNDLOAD to load AOL objects
#--------------------------------------------------------------------------
LoadAOLData()
{
  cd ${LDT_DIR}

  FNDLOAD $p_apps_usrn_pwd  O Y UPLOAD @FND:patch/115/import/afcpprog.lct $CUSTOM_TOP/install/ldt/XXRS_CHASE_OUTPUT_PROG_LDT.ldt CUSTOM_MODE='FORCE'>> $OUTFILE
  
  cat *.log >> $OUTFILE
  mv *.log ${LOG_DIR}
}

Psswd

echo -e "\nCompiling DB objects...\n" >> $OUTFILE
DbObjectsRegister

echo -e "\nLOADING AOL Data...\n" >> $OUTFILE
LoadAOLData

echo -e "\nDone.\n" >> $OUTFILE

echo -e "\nEmailing the outfile.\n"
MailOutFile

echo -e "\nOutput file is ${OUTFILE}"
