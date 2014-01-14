#!/bin/bash
#
#************************************************************************************************************+
#--File Name          : XXRS_WS_AR_INVOICE_GEN_INSTALL_111122-02448.sh                                       |
#--Program Purpose    : Install script to compile Objects to report Invoice PDF.                             |
#--Author Name        : Vaibhav Goyal                                                                        |
#--Initial Build Date : 27-JAN-2012                                                                          | 
#--Version            : 1.0.0                                                                                |  
#--Ticket Number      : 111122-02448                                                                         |
#------------------------------------------------------------------------------------------------------------+
#--Modification History                                                                                      |
#------------------------------------------------------------------------------------------------------------+
#-- | 27-JAN-2012     | 1.0.0   | Vaibhav Goyal | Initial Build                                              |
#------------------------------------------------------------------------------------------------------------+
#************************************************************************************************************/
#
#--------------------------------------------------------------------------
# Set the environmental variables and other administrative requirements.
#--------------------------------------------------------------------------
DATETIMESTAMP=`date +%Y%m%d%H%M%S`
p_apps_usrn_pwd=$1
jdbc=$2
xxrs_pwd=$3
CUSTOM_TOP=$XXRS_TOP
SQL_DIR=$CUSTOM_TOP/install/sql
LDT_DIR=$CUSTOM_TOP/install/ldt
XML_DIR=$CUSTOM_TOP/xml
LOG_DIR=$CUSTOM_TOP/log
INSTALL_DIR=$CUSTOM_TOP/install
OUTDIR=$CUSTOM_TOP/out
OUTFILE=$OUTDIR/XXRS_WS_AR_INVOICE_GEN_INSTALL_111122-02448.out
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
  if [ -n "$xxrs_pwd" ];then
    echo ""
  else
    echo "Please enter XXRS Password=>"
    stty -echo
    read xxrs_pwd
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
# Function to upload the responsibilities
#--------------------------------------------------------------------------
DbObjectsRegister()
{
cd $SQL_DIR
sqlplus -s xxrs/$xxrs_pwd << EOF
spool $OUTFILE
@XXRS_AR_INVOICE_DOCUMENTS.sql;
@XXRS_WS_AR_INVOICE_GEN_GRANT1.sql;
conn apps/$apps_pwd
@XXRS_WS_AR_INVOICE_GEN_SYNONYM.sql;
@XXRS_WS_AR_INVOICE_GEN_PKG.pks;
@XXRS_WS_AR_INVOICE_GEN_PKG.pkb;
@XXRS_WS_AR_INVOICE_GEN_GRANT2.sql;
exit;
/
EOF

}
#--------------------------------------------------------------------------
# Set permissions on folders
#--------------------------------------------------------------------------
SetPermisssions()
{
  cd $JAVA_TOP/xxrs/oracle/apps/ar

  chmod -R 750 $JAVA_TOP/xxrs/oracle/apps/ar
} 
#--------------------------------------------------------------------------
# Download OA Framework Files
#--------------------------------------------------------------------------
Createfwkfiles() 
{
  cd $JAVA_TOP/xxrs/oracle/apps/ar

  chmod -R 750 $JAVA_TOP/xxrs/oracle/apps/ar

  tar xvzf $JAVA_TOP/xxrs/install/xxrs_oaf_ar_invoice_111122-02448.tar.gz
}

#---------------------------------------------------------------------
# Importing OAF pages
#---------------------------------------------------------------------
ImportOAFPages()
{
  cd $JAVA_TOP

#importing the page into MDS  
java oracle.jrad.tools.xml.importer.XMLImporter ./xxrs/oracle/apps/ar/invoice/webui/InvoiceGeneratorPG.xml \
-rootdir $JAVA_TOP \
-username $apps_login \
-password $apps_pwd \
-dbconnection $jdbc >> $OUTFILE
  
}
#--------------------------------------------------------------------------
# Mailing output file
#--------------------------------------------------------------------------
MailOutFile()
{
  /bin/mail vaibhav.goyal@rackspace.com -c vinodh.bhasker@rackspace.com,bruce.martinez@rackspace.com,tim.cowen@rackspace.com -s "Installation log for Rackspace Invoice Generation Webservice in ${TWO_TASK}" < $OUTFILE
}
#---------------------------------------------------------------------
# Call the functions					      
#---------------------------------------------------------------------

Psswd

echo -e "\nCREATIONG Database Objects...\n" >> $OUTFILE
DbObjectsRegister

echo -e "\nCHANGING permissions recursively on $JAVA_TOP/xxrs/oracle/apps/inv ...\n" >> $OUTFILE
SetPermisssions

echo -e "\nUNZIPPING OA Framework Components for inventory project to $JAVA_TOP/xxrs/oracle/apps/inv ...\n" >> $OUTFILE
Createfwkfiles

echo -e "\nCHANGING permissions recursively on $JAVA_TOP/xxrs/oracle/apps/inv ...\n" >> $OUTFILE
SetPermisssions

echo -e "\nIMPORTING OAF pages ...\n" >> $OUTFILE
ImportOAFPages

echo -e "\nDone.\n" >> $OUTFILE

echo -e "\nEmailing the outfile.\n"
MailOutFile

echo -e "\nOutput file is ${OUTFILE}"
