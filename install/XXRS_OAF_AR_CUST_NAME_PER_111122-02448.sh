#!/bin/bash

#************************************************************************************************************+
#--File Name          :       XXRS_OAF_AR_CUST_NAME_PER_111122-02448.sh                                      |
#--Program Purpose    :       Installation script for Customer Page personalization                          |
#--Author Name        :       Pavan Amirineni                                                                |
#--Initial Build Date :       19-FEB-2012                                                                    |
#--                                                                                                          |
#--Version            :       1.0.0                                                                          |
#--Modification History                                                                                      |
#   | Ver   | Ticket No.   | Author          | Date        | Description                                     |
#------------------------------------------------------------------------------------------------------------+
#-- | 1.0.0 | 111122-02448 | Pavan Amirineni | 19-FEB-2012 | Initial Build                                   |
#------------------------------------------------------------------------------------------------------------+
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
 OUTFILE=$OUTDIR/XXRS_OAF_AR_CUST_NAME_PER_111122-02448.out
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

AOLLOAD()
{
cd $XXRS_TOP/install/ldt
$FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} O Y UPLOAD $FND_TOP/patch/115/import/afsload.lct XXRS_AR_CUST_NUM_FUN.ldt >> $OUTFILE
$FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} O Y UPLOAD $FND_TOP/patch/115/import/afmdmsg.lct XXRS_AR_CUST_UNSUB_CONF.ldt >> $OUTFILE

cat *.log >> $OUTFILE
mv *.log $XXRS_TOP/log

}
#--------------------------------------------------------------------------
# Download OA Framework Files
#--------------------------------------------------------------------------
CreateJavafiles() 
{
  cd $XXRS_TOP/
  tar xvzf $JAVA_TOP/xxrs/install/xxrs_oaf_cusstd_mds_111122-02448.tar.gz

  # untar it under apps  
  cd $XXRS_TOP/mds/webui/oracle/apps/
  tar xvzf $JAVA_TOP/xxrs/install/xxrs_oaf_iby_cc_dff_111122-02448.tar.gz

  # untar it under JAVA_TOP   
  cd $JAVA_TOP/xxrs/oracle/apps/ar/
  tar xvzf $JAVA_TOP/xxrs/install/xxrs_oaf_ar_cust_prof_vo_111122-02448.tar.gz

  # untar it under apps  
  cd $JAVA_TOP/xxrs/oracle/apps/ar
  tar xvzf $JAVA_TOP/xxrs/install/xxrs_oaf_cusstd_co_111122-02448.tar.gz

  # untar it under apps  
  cd $JAVA_TOP/xxrs/oracle/apps
  tar xvzf $JAVA_TOP/xxrs/install/xxrs_oaf_iby_bank_name_lov_111122-02448.tar.gz

  chmod -R 750 $XXRS_TOP/mds/

#  importing substitution  

java oracle.jrad.tools.xml.importer.JPXImporter $JAVA_TOP/xxrs/oracle/apps/ar/hz/components/account/customer/server/Receivables.jpx \
-username $apps_login \
-password $apps_pwd \
-dbconnection $jdbc >>$OUTFILE

java oracle.jrad.tools.xml.importer.JPXImporter $JAVA_TOP/xxrs/oracle/apps/iby/lov/server/ExtBankNameLov.jpx \
-username $apps_login \
-password $apps_pwd \
-dbconnection $jdbc >>$OUTFILE
}
#--------------------------------------------------------------------------
# Mailing output file
#--------------------------------------------------------------------------
MailOutFile()
{
  /bin/mail pavan.amirineni@rackspace.com,vinodh.bhasker@rackspace.com -c bruce.martinez@rackspace.com,tim.cowen@rackspace.com -s "Installation log for Customer Page Personalizations in ${TWO_TASK}" < $OUTFILE
}
#--------------------------------------------------------------------------
# Calling Functions
#--------------------------------------------------------------------------
Psswd

echo -e "\nUpload fnd files ...\n" >> $OUTFILE
AOLLOAD

echo -e "\nUNZIPPING OA Framework Components for ar to $JAVA_TOP/xxrs/oracle/apps/ar ...\n" >> $OUTFILE
CreateJavafiles


echo -e "\nDone.\n" >> $OUTFILE

echo -e "\nEmailing the outfile.\n"
MailOutFile

echo -e "\nOutput file is ${OUTFILE}"
