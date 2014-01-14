#!/bin/bash

#************************************************************************************************************+
#--File Name          :       XXRS_FND_PREP_INSTANCE_111122-02448.sh                                         |
#--Program Purpose    :       Installation script R12 instance technical prep                                |
#--Author Name        :       Vinodh Bhasker                                                                 |
#--Initial Build Date :       15-SEP-2010                                                                    |
#--                                                                                                          |
#--Version            :       1.0.0                                                                          |
#--Modification History                                                                                      |
#   | Ver   | Ticket No.   | Author          | Date        | Description                                     |
#------------------------------------------------------------------------------------------------------------+
#-- | 1.0.0 | 111122-02448 | Vinodh Bhasker  | 15-SEP-2011 | Initial Build                                   |
#------------------------------------------------------------------------------------------------------------+
#************************************************************************************************************/
#
#--------------------------------------------------------------------------
# Set the environmental variables and other administrative requirements.
#--------------------------------------------------------------------------
 DATETIMESTAMP=`date +%Y%m%d%H%M%S`
 CUSTOM_TOP=$XXRS_TOP
 FRM_DIR=$CUSTOM_TOP/forms/US
 SQL_DIR=$CUSTOM_TOP/install/sql
 LDT_DIR=$CUSTOM_TOP/install/ldt
 XML_DIR=$CUSTOM_TOP/xml
 LOG_DIR=$CUSTOM_TOP/log
 O_JDK_HOME=$ORACLE_HOME/jdk
 JAVA_DIR=$JAVA_TOP
 INSTALL_DIR=$CUSTOM_TOP/install
 OUTDIR=$CUSTOM_TOP/out
 OUTFILE=$OUTDIR/XXRS_FND_PREP_INSTANCE_111122-02448.out
 FILE_LIST=XXRS_FND_PREP_INSTANCE_111122-02448.lst
 apps_login=apps
#
 export CLASSPATH=$CLASSPATH:$JAVA_TOP/xxrs/jar/xmlrpc-2.0.1.jar:$JAVA_TOP/xxrs/jar/commons-codec-1.2.jar
# 
 echo `date` > $OUTFILE

#--------------------------------------------------------------------------
# Define the function to get the APPS and XXRS password.
#--------------------------------------------------------------------------
Psswd()
{
  echo "Please enter APPS password =>"
  stty -echo
  read apps_pwd
  stty echo
  
}
#--------------------------------------------------------------------------
# Mailing output file
#--------------------------------------------------------------------------
MailOutFile()
{
  /bin/mail vinodh.bhasker@rackspace.com -c bruce.martinez@rackspace.com,tim.cowen@rackspace.com -s "recompiling forms in ${TWO_TASK}" < $OUTFILE
}
#--------------------------------------------------------------------------
# submitting Generate Messages concurrent program
#--------------------------------------------------------------------------
Submitconcprg()
{
  #submitting Generate Messages concurrent program
  cd $INSTALL_DIR
  CONCSUB apps/$apps_pwd SYSADMIN "System Administrator" SYSADMIN WAIT=N CONCURRENT FND FNDMDGEN '"US" "XXRS" "DB_TO_RUNTIME" "" ""'>> $OUTFILE
}
#--------------------------------------------------------------------------
# Database Changes
#--------------------------------------------------------------------------
DatabaseChanges()
{
   cd $SQL_DIR

   echo "Dropping all custom objects" >> $OUTFILE
   echo "Dropping all custom objects"

sqlplus -s apps/$apps_pwd << EOF
spool $OUTFILE
@XXRS_FND_REQ_SET_DELETE.sql;
@XXRS_FND_CONC_REQ_DELETE.sql;
@XXRS_FND_EXE_DELETE.sql;
@XXRS_FND_DROP_OBJECTS.sql;
exit;
/
EOF

}
#--------------------------------------------------------------------------
# Compile Forms
#--------------------------------------------------------------------------
CompileForms()
{
   cd $FRM_DIR 

   echo "Compiling all forms under ${FRM_DIR}" >> $OUTFILE
   echo "Compiling all forms under ${FRM_DIR}"


# Compile the library
   frmcmp_batch.sh userid=apps/${apps_pwd} batch=yes module=XXRSSCACPRD.pll module_type=LIBRARY compile_all=yes window_state=minimize

   for form in `ls *.fmb`
   do
     echo Compiling Form ${form} ....
     frmcmp_batch.sh userid=apps/${apps_pwd} batch=yes module=${form} module_type=form compile_all=yes
     
     form_name=`echo ${form} | sed s/.fmb\$//`
# Output the log files to the out file
#     mv ${form_name}.err ${form_name}.log >> $OUTFILE
     cat ${form_name}.err >> $OUTFILE
# Clear the log files from the forms directory
     mv ${form_name}.err  $CUSTOM_TOP/log
 
   done
}

#--------------------------------------------------------------------------
# Create OAF Directory Structure
#--------------------------------------------------------------------------
 CreateOAFdir()
 {
  echo -e "\nCreated Directory Structure for OAF under $JAVA_TOP\n" >> $OUTFILE
#
  mkdir -p $JAVA_TOP/xxrs/install
  mkdir -p $JAVA_TOP/xxrs/oracle/apps
  mkdir -p $JAVA_TOP/xxrs/oracle/apps/ar/cp
  mkdir -p $JAVA_TOP/xxrs/oracle/apps/ar/iface
  mkdir -p $JAVA_TOP/xxrs/oracle/apps/ar/invoice
  mkdir -p $JAVA_TOP/xxrs/oracle/apps/ar/lov
  mkdir -p $JAVA_TOP/xxrs/oracle/apps/ar/poplist
  mkdir -p $JAVA_TOP/xxrs/oracle/apps/icx
  mkdir -p $JAVA_TOP/xxrs/oracle/apps/iex
  mkdir -p $JAVA_TOP/xxrs/oracle/apps/inv
  mkdir -p $JAVA_TOP/xxrs/oracle/apps/ofa
  mkdir -p $JAVA_TOP/xxrs/oracle/apps/xxrs
  mkdir -p $JAVA_TOP/xxrs/jar
  cp /mnt/shared/R12_Patches/R12_INSTANCE_TECH_PREP/*.jar $JAVA_TOP/xxrs/jar
  cp /mnt/shared/R12_Patches/R12_INSTANCE_TECH_PREP/RS.GIF  $OA_MEDIA
#  
  chmod -R 755 $JAVA_TOP/xxrs
}
#--------------------------------------------------------------------------
# Calling Functions
#--------------------------------------------------------------------------
Psswd


echo -e "COMPILE Forms ..."
echo -e "COMPILE Forms ..." >> $OUTFILE
CompileForms

echo -e "\nDone.\n" >> $OUTFILE

echo -e "\nEmailing the outfile.\n"
MailOutFile

echo -e "\nOutput file is ${OUTFILE}"
