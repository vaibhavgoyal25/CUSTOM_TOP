#!/bin/bash

#************************************************************************************************************+
#--File Name          :       XXRSGLHYPINT_INSTALL_111122-02448.sh                                           |
#--Program Purpose    :       Installation script for Hyperion Integration Views                             |
#--Author Name        :       Vinodh Bhasker                                                                 |
#--Initial Build Date :       23-DEC-2011                                                                    |
#--                                                                                                          |
#--Version            :       1.0.0                                                                          |
#--Modification History                                                                                      |
#   | Ver   | Ticket No.   | Author          | Date        | Description                                     |
#------------------------------------------------------------------------------------------------------------+
#-- | 1.0.0 | 111122-02448 | Vinodh Bhasker  | 23-DEC-2011 | Initial Build                                   |
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
 OUTFILE=$OUTDIR/XXRSGLHYPINT_INSTALL_111122-02448.out
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
    echo "Please enter JDBC TNSNAMES Connection, (hostname:port:SID, ddbs1.ord1.orapi.rackspace.com:1551:SCAR)=>"
    read jdbc
  fi
}
#--------------------------------------------------------------------------
# Create Database Objects
#--------------------------------------------------------------------------
CreateDBObjects()
{
cd $SQL_DIR
sqlplus ${p_apps_usrn_pwd} << EOF
spool $OUTFILE
@XXRS_FND_FLEX_VALUE_CHILDREN_V.sql
@XXRS_GL_ENTITIES_V.sql
@XXRS_GL_LOCATIONS_V.sql
@XXRS_GL_BU_DEPARTMENTS_V.sql
@XXRS_GL_ACCOUNTS_V.sql
@XXRS_GL_ACTUAL_BALANCES_V.sql
@XXRS_GL_ACTUAL_BALANCES_REC_V.sql
GRANT SELECT ON APPS.XXRS_GL_ENTITIES_V TO XXRS_HYPE_QUERY /* 111122-02448 */;
GRANT SELECT ON APPS.XXRS_FND_FLEX_VALUE_CHILDREN_V TO XXRS_HYPE_QUERY /* 111122-02448 */;
GRANT SELECT ON APPS.XXRS_GL_ACCOUNTS_V TO XXRS_HYPE_QUERY /* 111122-02448 */;
GRANT SELECT ON APPS.XXRS_GL_ACTUAL_BALANCES_REC_V TO XXRS_HYPE_QUERY /* 111122-02448 */;
GRANT SELECT ON APPS.XXRS_GL_ACTUAL_BALANCES_V TO XXRS_HYPE_QUERY /* 111122-02448 */;
GRANT SELECT ON APPS.XXRS_GL_BU_DEPARTMENTS_V TO XXRS_HYPE_QUERY /* 111122-02448 */;
GRANT SELECT ON APPS.XXRS_GL_LOCATIONS_V TO XXRS_HYPE_QUERY /* 111122-02448 */;
exit;
/
EOF
} 
#--------------------------------------------------------------------------
# Mailing output file
#--------------------------------------------------------------------------
MailOutFile()
{
  /bin/mail vinodh.bhasker@rackspace.com -c bruce.martinez@rackspace.com,tim.cowen@rackspace.com -s "Installation log for Hyperion Integration Views in ${TWO_TASK}" < $OUTFILE
}
#--------------------------------------------------------------------------
# Calling Functions
#--------------------------------------------------------------------------
Psswd

echo -e "\nCREATIONG Database Objects...\n" >> $OUTFILE
CreateDBObjects

echo -e "\nDone.\n" >> $OUTFILE

echo -e "\nEmailing the outfile.\n"
MailOutFile

echo -e "\nOutput file is ${OUTFILE}"
