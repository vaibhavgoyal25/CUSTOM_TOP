#!/bin/bash
#
#************************************************************************************************************+
#--File Name          : XXRS_WS_AR_INVOICE_DTL_INSTALL_111122-02448.sh                                       |
#--Program Purpose    : Install script to compile Objects to report Invoice Details.                         |
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
OUTFILE=$OUTDIR/XXRS_WS_AR_INVOICE_DTL_INSTALL_111122-02448.out
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
}
#--------------------------------------------------------------------------
# Function to upload the responsibilities
#--------------------------------------------------------------------------
DbObjectsRegister()
{
cd $SQL_DIR
sqlplus -s xxrs/$xxrs_pwd << EOF
spool $OUTFILE
@XXRS_WS_AR_INVOICE_DTL_TYPE.sql
@XXRS_WS_AR_INVOICE_DTL_GRANT1.sql
conn apps/$apps_pwd
@XXRS_WS_AR_INVOICE_DTL_SYNONYM.sql
@XXRS_AR_CUST_ACCT_PKG.pks
@XXRS_AR_CUST_ACCT_PKG.pkb
@XXRS_WS_AR_INVOICE_DTL_PKG.pks
@XXRS_WS_AR_INVOICE_DTL_PKG.pkb
@XXRS_WS_AR_INVOICE_DTL_GRANT2.sql
exit;
/
EOF

}
#--------------------------------------------------------------------------
# Mailing output file
#--------------------------------------------------------------------------
MailOutFile()
{
  /bin/mail vaibhav.goyal@rackspace.com -c bruce.martinez@rackspace.com,tim.cowen@rackspace.com -s "Installation log for Rackspace Invoice Details SOA Service in ${TWO_TASK}" < $OUTFILE
}
#---------------------------------------------------------------------
# Call the functions					      
#---------------------------------------------------------------------

Psswd

echo -e "\nCREATING Database Objects...\n" >> $OUTFILE

DbObjectsRegister

echo -e "\nOutput file is ${OUTFILE}">> $OUTFILE
echo -e "\nEmailing the outfile.\n">> $OUTFILE
MailOutFile


