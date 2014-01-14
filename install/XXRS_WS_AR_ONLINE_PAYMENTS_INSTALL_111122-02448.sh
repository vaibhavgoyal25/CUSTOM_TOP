#!/bin/bash
#
#************************************************************************************************************+
#--File Name          : XXRS_WS_AR_ONLINE_PAYMENTS_INSTALL_111122-02448.sh                                   |
#--Program Purpose    : Install script to compile Objects to set Online Payment Details.                     |
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
CUSTOM_TOP=$XXRS_TOP
SQL_DIR=$CUSTOM_TOP/install/sql
LDT_DIR=$CUSTOM_TOP/install/ldt
XML_DIR=$CUSTOM_TOP/xml
LOG_DIR=$CUSTOM_TOP/log
INSTALL_DIR=$CUSTOM_TOP/install
OUTDIR=$CUSTOM_TOP/out
OUTFILE=$OUTDIR/XXRS_WS_AR_ONLINE_PAYMENTS_INSTALL_111122-02448.out
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
# Function to upload the responsibilities
#--------------------------------------------------------------------------
DbObjectsRegister()
{
cd $SQL_DIR
sqlplus -s apps/$apps_pwd << EOF
spool $OUTFILE
@XXRS_WS_AR_ONLINE_PAYMENTS_PKG.pks;
@XXRS_WS_AR_ONLINE_PAYMENTS_PKG.pkb;
@XXRS_WS_AR_ONLINE_PAYMENTS_GRANT2.sql;
exit;
/
EOF

}

#---------------------------------------------------------------------
# Call the functions					      
#---------------------------------------------------------------------

Psswd

DbObjectsRegister

echo -e "\nDone.\n" >> $OUTFILE
