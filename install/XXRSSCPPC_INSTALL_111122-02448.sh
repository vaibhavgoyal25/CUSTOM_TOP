#!/bin/bash
#************************************************************************************************************+
#--File Name          :       XXRSSCPPC_INSTALL_111122-02448.sh                                              | 
#--Program Purpose    :       Installation script for Rackspace Process Pending product Cancellations        |
#--Author Name        :       Pavan Amirineni                                                                |
#--Initial Build Date :       08-MAR-2012                                                                    |
#							                                                     |
#--Version            :       1.0.0                                                                          |
#--Modification History                                                                                      |
#   | Ver   | Ticket No.   | Author          | Date        | Description                                     |
#------------------------------------------------------------------------------------------------------------+
#-- | 1.0.0 | 111122-02448 | Pavan Amirineni | 08-MAR-2012 | R12 Upgradation                                 |
#------------------------------------------------------------------------------------------------------------+
#************************************************************************************************************/
#/* $Header: XXRSSCPPC_INSTALL_111122-02448.sh 1.0.0 08-MAR-2012 15:37:00 PM Pavan Amirineni $ */
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
 OUTFILE=$OUTDIR/XXRSSCPPC_INSTALL_111122-02448.out
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
}

#--------------------------------------------------------------------------
# Create Database Objects
#--------------------------------------------------------------------------
CreateDBObjects()
{
cd $SQL_DIR
sqlplus apps/$apps_pwd << EOF
spool ${OUTFILE}_TMP1
@XXRS_SC_PRODUCT_PKG.pks
@XXRS_SC_PRODUCT_PKG.pkb
exit;
/
EOF

cat ${OUTFILE}_TMP* >> $OUTFILE
rm ${OUTFILE}_TMP*
}
#--------------------------------------------------------------------------
# Mailing output file
#--------------------------------------------------------------------------
MailOutFile()
{
  /bin/mail pavan.amirineni@rackspace.com -c bruce.martinez@rackspace.com,tim.cowen@rackspace.com,vinodh.bhasker@rackspace.com -s "Installation log for Rackspace Buyer Metrics Report in ${TWO_TASK}" < $OUTFILE
}
#--------------------------------------------------------------------------
# Using the FNDLOAD to load AOL objects
#--------------------------------------------------------------------------
LoadAOLData()
{
  cd ${LDT_DIR}

   FNDLOAD $p_apps_usrn_pwd  O Y UPLOAD @FND:patch/115/import/afcpprog.lct $CUSTOM_TOP/install/ldt/XXRSSCPPC.ldt CUSTOM_MODE='FORCE'>> $OUTFILE
   FNDLOAD $p_apps_usrn_pwd  O Y UPLOAD @FND:patch/115/import/afcpreqg.lct $CUSTOM_TOP/install/ldt/XXRSSCPPC_REQ.ldt CUSTOM_MODE='FORCE'>> $OUTFILE
   FNDLOAD $p_apps_usrn_pwd  O Y UPLOAD @FND:patch/115/import/afcpreqg.lct $CUSTOM_TOP/install/ldt/XXRSSCPPC_ADREQ.ldt CUSTOM_MODE='FORCE'>> $OUTFILE

  cat *.log >> $OUTFILE
  mv *.log ${LOG_DIR}
}

Psswd

echo -e "\nLOADING AOL Data...\n" >> $OUTFILE
LoadAOLData

echo -e "\nDone.\n" >> $OUTFILE

echo -e "\nEmailing the outfile.\n"
MailOutFile

echo -e "\nOutput file is ${OUTFILE}"