#!/bin/bash
#
#************************************************************************************************************+
#--File Name          : XXRS_NTF_DETAILS_130930-05478.sh                                                     |
#--Program Purpose    : Install script to compile Objects to Update Requisition Approval Notification.       |
#--Author Name        : Vaibhav Goyal                                                                        |
#--Initial Build Date : 29-OCT-2013                                                                          | 
#--Version            : 1.0.0                                                                                |  
#--Ticket Number      : 130930-05478                                                                         |
#------------------------------------------------------------------------------------------------------------+
#--Modification History                                                                                      |
#------------------------------------------------------------------------------------------------------------+
#   | Ver   | Ticket No.   | Author          | Date       | Description                                      |
#------------------------------------------------------------------------------------------------------------+
#   | 1.0.0 | 130930-05478 | Vaibhav Goyal   | 29-OCT-2013| Initial Build                                    |
#------------------------------------------------------------------------------------------------------------+
#************************************************************************************************************/
# $Header:XXRS_NTF_DETAILS_130930-05478.sh 1.0.0 29-OCT-2013 11:29:44 AM Vaibhav Goyal $ 
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
OUTFILE=$OUTDIR/XXRS_NTF_DETAILS_130930-05478_"$DATETIMESTAMP".out
apps_login=apps
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
# Set permissions on folders
#--------------------------------------------------------------------------
SetPermisssions()

{

  cd $JAVA_TOP/xxrs/oracle/apps
  chmod -R 775 $JAVA_TOP/xxrs/oracle/apps

  cd $XXRS_TOP/mds/webui/
  chmod -R 775 $XXRS_TOP/mds/webui
} 
#--------------------------------------------------------------------------
# Download OA Framework Files
#--------------------------------------------------------------------------
Createfwkfiles() 
{

echo -e "\n Untarring $JAVA_TOP/xxrs/install/xxrs_oaf_icx_130930-05478.tar.gz into $JAVA_TOP/xxrs/oracle/apps/ ...\n" >> $OUTFILE

  cd $JAVA_TOP/xxrs/oracle/apps/
  chmod -R 755 $JAVA_TOP/xxrs/oracle/apps/
  tar xvzf $JAVA_TOP/xxrs/install/xxrs_oaf_icx_130930-05478.tar.gz

echo -e "\n Compiling java files present at $JAVA_TOP/xxrs/oracle/apps/icx/lov/server/ ...\n" >> $OUTFILE

  javac $JAVA_TOP/xxrs/oracle/apps/icx/lov/server/*.java

echo -e "\n Compiling java files present at $JAVA_TOP/xxrs/oracle/apps/icx/por/wf/server/ ...\n" >> $OUTFILE

  javac $JAVA_TOP/xxrs/oracle/apps/icx/por/wf/server/*.java

echo -e "\n Running JPXImport to import substitutions...\n" >> $OUTFILE

  java oracle.jrad.tools.xml.importer.JPXImporter \
  $JAVA_TOP/xxrs/oracle/apps/icx/lov/server/ReqNotification.jpx \
  -username apps -password $apps_pwd -dbconnection $jdbc

echo -e "\n Untarring $JAVA_TOP/xxrs/install/xxrs_oaf_icx_ntf_130930-05478.tar.gz into $XXRS_TOP/mds/webui/ ...\n" >> $OUTFILE

  cd $XXRS_TOP/mds/webui/
  chmod -R 775 $XXRS_TOP/mds/webui/
  tar xvzf $JAVA_TOP/xxrs/install/xxrs_oaf_icx_ntf_130930-05478.tar.gz
 

echo -e "\n Importing page into MDS ...\n" >> $OUTFILE

  #importing the page into MDS  
  java oracle.jrad.tools.xml.importer.XMLImporter ./oracle/apps/icx/por/wf/webui/customizations/site/0/ReqLinesNotificationsRN.xml \
  -rootdir $XXRS_TOP/mds/webui \
  -username $apps_login \
  -password $apps_pwd \
  -dbconnection $jdbc >> $OUTFILE
}


#--------------------------------------------------------------------------
# Mailing output file
#--------------------------------------------------------------------------
MailOutFile()
{
  /bin/mail vaibhav.goyal@rackspace.com -c vinodh.bhasker@rackspace.com,bruce.martinez@rackspace.com,tim.cowen@rackspace.com, sachin.garg@rackspace.com -s "Installation log for Requisition Approval Notification in ${TWO_TASK}" < $OUTFILE
}
#---------------------------------------------------------------------
# Call the functions					      
#---------------------------------------------------------------------

Psswd

echo -e "\nCHANGING permissions recursively on $JAVA_TOP/xxrs/oracle/apps ...\n" >> $OUTFILE
echo -e "\nCHANGING permissions recursively on $XXRS_TOP/mds/webui/ ...\n" >> $OUTFILE
SetPermisssions

echo -e "\nUNZIPPING OA Framework Components for requisition approval notification changes to $JAVA_TOP/xxrs/oracle/apps ...\n" >> $OUTFILE
Createfwkfiles

echo -e "\nCHANGING permissions recursively on $JAVA_TOP/xxrs/oracle/apps ...\n" >> $OUTFILE
echo -e "\nCHANGING permissions recursively on $XXRS_TOP/mds/webui/ ...\n" >> $OUTFILE
SetPermisssions

echo -e "\nDone.\n" >> $OUTFILE

echo -e "\nEmailing the outfile.\n"
MailOutFile

echo -e "\nOutput file is ${OUTFILE}"
