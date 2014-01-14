#!/bin/bash
#************************************************************************************************************+
#--File Name          :       XXRS_MASS_CREDIT_MEMO_130617-06898.sh                                          | 
#--Program Purpose    :       Installation script for Rackspace Mass credit memo process .                   |
#--Author Name        :       Mahesh Guddeti                                                                 |
#--Initial Build Date :       29-AUG-2013                                                                    |
#							                                                     |
#--Version            :       1.0.0                                                                          |
#--Modification History                                                                                      |
#   | Ver   | Ticket No.   | Author          | Date        | Description                                     |
#------------------------------------------------------------------------------------------------------------+
#-- | 1.0.0 | 130617-06898 | Mahesh Guddeti   | 29-AUG-2013 | Initial Creation                               |
#------------------------------------------------------------------------------------------------------------+
#************************************************************************************************************/
#/* $Header: XXRS_MASS_CREDIT_MEMO_130617-06898.sh 1.0.0 29-AUG-2013 17:00:00 PM Mahesh Guddeti $ */
#
#--------------------------------------------------------------------------
# Set the environmental variables and other administrative requirements.
#--------------------------------------------------------------------------
 DATETIMESTAMP=`date +%Y%m%d%H%M%S`
 p_apps_usrn_pwd=$1
 jdbc=`echo $AD_APPS_JDBC_URL`
 CUSTOM_TOP=$XXRS_TOP
 SQL_DIR=$CUSTOM_TOP/install/sql
 LDT_DIR=$CUSTOM_TOP/install/ldt
 XML_DIR=$CUSTOM_TOP/xml
 LOG_DIR=$CUSTOM_TOP/log
 INSTALL_DIR=$CUSTOM_TOP/install
 OUTDIR=$CUSTOM_TOP/out
 OUTFILE=$OUTDIR/XXRS_MASS_CREDIT_MEMO_130617-06898.out
 apps_login=apps
 FRM_DIR=$CUSTOM_TOP/forms/US

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
# Create Database Objects
#--------------------------------------------------------------------------
CreateDBObjects()
{
cd $SQL_DIR
sqlplus $p_apps_usrn_pwd << EOF
spool $OUTFILE
@XXRS_SC_INVOICE_WKST_INT_TBL.sql
@XXRS_SC_INVOICE_WKST_VW.sql
@XXRS_SC_INVOICE_WKST_ARCH_VW.sql
@XXRS_SC_INVOICE_WKST_INT_VW.sql
@XXRS_MASS_CREDIT_MEMO_TEMP.sql
@XXRS_SC_INVOICE_WKST_PKG.pkb
@XXRS_SC_MCM_PKG.pks
@XXRS_SC_MCM_PKG.pkb
@XXRS_SC_BILLING_ERR_PU_0001.pkb
exit;
/
EOF
}

#--------------------------------------------------------------------------
# Compiling invalid data base objects
#--------------------------------------------------------------------------
InvalidObjects()
{
cd $SQL_DIR
sqlplus -s $p_apps_usrn_pwd @XXRS_COMPILE_INVALID_DB_OBJ.sql 130617-06898<< EOF
exit;
/
EOF
echo ""
echo "**********************************************************************"
cat XXRS_COMPILE_INVALID_130617-06898*.sql >> $OUTFILE
echo " "
echo "**********************************************************************"
rm -f XXRS_COMPILE_INVALID_130617-06898*.sql
}

#--------------------------------------------------------------------------
# Mailing output file
#--------------------------------------------------------------------------
MailOutFile()
{
  /bin/mail mahesh.guddeti@rackspace.com -c pavan.amirineni@rackspace.com,sachin.garg@rackspace.com,vinodh.bhasker@rackspace.com,bruce.martinez@rackspace.com,tim.cowen@rackspace.com -s "Installation log for Rackspace Uninvoiced Receipts Report in ${TWO_TASK}" < $OUTFILE
}
#--------------------------------------------------------------------------
# Function to create 
#--------------------------------------------------------------------------
UploadAolObjects()
{
cd $CUSTOM_TOP/install/ldt

#concurrent prg
#$FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscprof.lct ${CUSTOM_TOP}/install/ldt/XXRS_SC_DEBUG_ON.ldt CUSTOM_MODE='FORCE' 
$FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afcpprog.lct ${CUSTOM_TOP}/install/ldt/XXRSSCMCM.ldt CUSTOM_MODE='FORCE'
$FND_TOP/bin/FNDLOAD ${p_apps_usrn_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afcpreqg.lct ${CUSTOM_TOP}/install/ldt/XXRSSCMCMRG.ldt CUSTOM_MODE='FORCE'
cat *.log >> $OUTFILE
mv *.log ${LOG_DIR}
}

CompileForms()
{
   cd ${FRM_DIR} 

   echo "Compiling form XXRS_SC_INVOICE_WKST.fmb under ${FRM_DIR}" >> $OUTFILE
   frmcmp_batch.sh userid=${p_apps_usrn_pwd} batch=yes module=XXRS_SC_INVOICE_WKST.fmb module_type=FORM compile_all=yes window_state=minimize
   # Output the log files to the out file
     mv XXRS_SC_INVOICE_WKST.err XXRS_SC_INVOICE_WKST.log
     cat XXRS_SC_INVOICE_WKST.log >> $OUTFILE
   # Clear the log files from the forms directory
     mv XXRS_SC_INVOICE_WKST.log  $CUSTOM_TOP/LOG
     
   echo "Compiling form XXRS_SC_INVOICE_WKST_ARCH.fmb under ${FRM_DIR}" >> $OUTFILE
   frmcmp_batch.sh userid=${p_apps_usrn_pwd} batch=yes module=XXRS_SC_INVOICE_WKST_ARCH.fmb module_type=FORM compile_all=yes window_state=minimize
   # Output the log files to the out file
     mv XXRS_SC_INVOICE_WKST_ARCH.err XXRS_SC_INVOICE_WKST_ARCH.log
     cat XXRS_SC_INVOICE_WKST_ARCH.log >> $OUTFILE
   # Clear the log files from the forms directory
     mv XXRS_SC_INVOICE_WKST_ARCH.log  $CUSTOM_TOP/log

}

#--------------------------------------------------------------------------
# Calling Functions
#--------------------------------------------------------------------------
Psswd
echo -e "\nCompiling DB Objects...\n" >> $OUTFILE
CreateDBObjects

echo -e "\nUploading AOL Objects...\n" >> $OUTFILE
UploadAolObjects >> $OUTFILE

echo -e "\nCompiling Invablid DB Objects...\n" >> $OUTFILE
InvalidObjects >> $OUTFILE

echo -e "\nCompiling Forms...\n" >> $OUTFILE
CompileForms >> $OUTFILE

echo -e "\nDone.\n" >> $OUTFILE
echo -e "\nInstallation output file: ${OUTFILE}" 
echo -e "\nEmailing the outfile.\n"
MailOutFile
