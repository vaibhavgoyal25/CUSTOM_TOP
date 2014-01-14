#!/bin/bash
#************************************************************************************************************+
#--File Name          :       XXRSFNDMIGUTL_INSTALL_111122-02448.sh                                          | 
#--Program Purpose    :       Installation script for Rackspace Migration Utility.                           |
#--Author Name        :       Vaibhav Goyal                                                                  |
#--Initial Build Date :       11-SEP-2012                                                                    |
#							                                                     |
#--Version            :       1.0.0                                                                          |
#--Modification History                                                                                      |
#   | Ver   | Ticket No.   | Author          | Date        | Description                                     |
#------------------------------------------------------------------------------------------------------------+
#-- | 1.0.0 | 111122-02448 | Vaibhav Goyal   | 11-SEP-2012 | R12 Upgradation                                 |
#------------------------------------------------------------------------------------------------------------+
#************************************************************************************************************/
#/* $Header: XXRSFNDMIGUTL_INSTALL_111122-02448.sh 1.0.0 11-SEP-2012 17:00:00 PM Vaibhav Goyal $ */
#
#--------------------------------------------------------------------------
# Set the environmental variables and other administrative requirements.
#--------------------------------------------------------------------------
 DATETIMESTAMP=`date +%Y%m%d%H%M%S`
 p_apps_usrn_pwd=$1
 jdbc=$2
 jdbc=`echo $AD_APPS_JDBC_URL`
 CUSTOM_TOP=$XXRS_TOP
 SQL_DIR=$CUSTOM_TOP/install/sql
 LDT_DIR=$CUSTOM_TOP/install/ldt
 XML_DIR=$CUSTOM_TOP/xml
 LOG_DIR=$CUSTOM_TOP/log
 INSTALL_DIR=$CUSTOM_TOP/install
 OUTDIR=$CUSTOM_TOP/out
 OUTFILE=$OUTDIR/XXRSFNDMIGUTL_INSTALL_111122-02448.out
 apps_login=apps

#echo ${p_apps_usrn_pwd##*/}
#echo ${p_apps_usrn_pwd}
#echo ${jdbc}

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
#  if [ -n "$jdbc" ];then
#    echo ""
#  else
#    echo "Please enter JDBC TNSNAMES Connection, (hostname:port:SID, dfw1svdevdbs02.ora.rackspace.com:1551:DEV)=>"
#    read jdbc
#  fi
} 
#--------------------------------------------------------------------------
# Mailing output file
#--------------------------------------------------------------------------
MailOutFile()
{
  /bin/mail vaibhav.goyal@rackspace.com -c sachin.garg@rackspace.com,vinodh.bhasker@rackspace.com,bruce.martinez@rackspace.com,tim.cowen@rackspace.com -s "Installation log for Rackspace Migration Utility in ${TWO_TASK}" < $OUTFILE
}
#--------------------------------------------------------------------------
# Function to create 
#--------------------------------------------------------------------------
UploadAolObjects()
{
cd $CUSTOM_TOP/install/ldt

#concurrent prg
$FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afcpprog.lct ${CUSTOM_TOP}/install/ldt/XXRSFNDMIGUTL.ldt CUSTOM_MODE='FORCE' 
$FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afcpreqg.lct ${CUSTOM_TOP}/install/ldt/XXRSFNDMIGUTL_RG.ldt CUSTOM_MODE='FORCE'
cat *.log >> $OUTFILE
mv *.log ${LOG_DIR}
}


#--------------------------------------------------------------------------
# Calling Functions
#--------------------------------------------------------------------------
Psswd

echo -e "\nUploading AOL Objects...\n" >> $OUTFILE
UploadAolObjects >> $OUTFILE

echo -e "\nDone.\n" >> $OUTFILE
echo -e "\nInstallation output file: ${OUTFILE}" 
echo -e "\nEmailing the outfile.\n"
MailOutFile
