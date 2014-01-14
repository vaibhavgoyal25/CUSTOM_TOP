#!/bin/bash

#************************************************************************************************************+
#--File Name          :       XXRSFNDUPLOAD_INSTALL_111122-02448.sh                                          |
#--Program Purpose    :       Script for upload AOL information for Responsibilities, Menu and Request Groups|
#--Author Name        :       Vinodh Bhasker                                                                 |
#--Initial Build Date :       09-APR-2012                                                                    |
#--                                                                                                          |
#--Version            :       1.0                                                                            |
#------------------------------------------------------------------------------------------------------------+
#--Modification History                                                                                      |
#   | Ver   | Ticket No.   | Author          | Date         | Description                                    |
#------------------------------------------------------------------------------------------------------------+
#-- | 1.0.0 | 111122-02448 | Vinodh Bhasker  | 09-APR-2012  | Initial Build                                  |
#------------------------------------------------------------------------------------------------------------+
#************************************************************************************************************/
#$Header: XXRSFNDUPLOAD_INSTALL_111122-02448.sh 1.0.0 09-APR-2012 10:07:00 AM vbhasker $
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
 OUTFILE=$OUTDIR/XXRSFNDUPLOAD_INSTALL_111122-02448.out
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
# Using the FNDLOAD to load AOL objects
#--------------------------------------------------------------------------
UploadRespData()
{
  cd ${LDT_DIR}

FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_ANSO_PURCHASING_INQUIRY.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_ANSO_LAB_PURCHASING_MANAGER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_ANSO_LABS_PURCHASING_STAFF.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_ANSOLABS_PURCHASE_SUPER_USE.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_ANSO_PURCHASING_APPROVER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_ANSO_PO_CLOSE_COORD.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_ANSO_AP_CLOSE_COORD.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_ANSO_PAYABLES_CLERK.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_ANSO_LABS_PAYABLES_INQUIRY.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_ANSO_LABS_PAYABLES_MANAGER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_ANSO_PURCHASING_ADMIN.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_ANSOLABS_PAYABLES_SUPERUSER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_BM_PURCHASING_APPROVER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_BM_PURCHASING_ADMIN.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_BM_PURCHASING_INQUIRY.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_BM_PURCHASING_MANAGER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_BM_PURCHASING_STAGF.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_BM_PURCHASING_SUPER_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_RM_PO_CLOSE_COORD.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_BM_PAYABLES_CLERK.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_BM_PAYABLES_INQUIRY.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_BM_PAYABLES_MANAGER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_BM_PAYABLES_SUPERUSER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_ANSO_GL_CONSOL_COORD.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_ANSO_GL_INQUIRY.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_ANSO_LABS_GL_MANAGER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_ANSO_LABS_GL_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_ANSO_FIXED_ASSETS_MANAGER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_ANSO_LABS_FIXED_ASSETS_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_BM_GL_CONSOL_COORDINATOR.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_BM_GL_INQUIRY.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_BM_GL_MANAGER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_BM_GL_MODULE_ADMINISTRATOR.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_BM_GL_SETUP.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_BM_GL_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_BM_FIXED_ASSETS_MANAGER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_BM_FIXED_ASSETS_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_GIBRALTAR_GL_CONSOL_COORD.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_GIBRALTAR_GL_INQUIRY.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_GIBRALTAR_GL_MANAGER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_GIBRALTAR_GL_SUPER_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_GIBRALTAR_GL_SETUP.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_GIBRALTAR_GL_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_INTERCOMPANY_MANAGER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_INTERCOMPANY_SUPER_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_INTERCOMPANY_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_NL_INTERCOMPANY_MANAGER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_NL_INTERCOMPANY_SUPER_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_NL_INTERCOMPANY_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_INTERCOMPANY_MANAGER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_INTERCOMPANY_SUPER_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_INTERCOMPANY_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_INTERCOMPANY_MANAGER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_INTERCOMPANY_SUPER_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_INTERCOMPANY_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct US_GENERAL_LEDGER_SUPER_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct UK_GENERAL_LEDGER_SUPER_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct HK_GENERAL_LEDGER_SUPER_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct NL_GENERAL_LEDGER_SUPER_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct XXRS_HK_TAX_MGR.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct XXRS_NL_TAX_MGR.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct XXRS_UK_TAX_MGR.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct XXRS_US_TAX_MGR.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct XXRS_HK_IBY_SETUP_COMPLETE.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct XXRS_NL_IBY_SETUP_COMPLETE.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct XXRS_UK_IBY_SETUP_COMPLETE.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct XXRS_US_IBY_SETUP_COMPLETE.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct XXRS_US_IEX_HTML_ADMIN_RESP.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct XXRS_UK_IEX_HTML_ADMIN_RESP.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct XXRS_NL_IEX_HTML_ADMIN_RESP.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct XXRS_HK_IEX_HTML_ADMIN_RESP.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_CYCLE_COUNT_MANAGER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_CYCLE_COUNT_SETUP.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_CYCLE_COUNT_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_NL_CYCLE_COUNT_MANAGER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_NL_CYCLE_COUNT_SETUP.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_NL_CYCLE_COUNT_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_CYCLE_COUNT_MANAGER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_CYCLE_COUNT_SETUP.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_CYCLE_COUNT_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_CYCLE_COUNT_MANAGER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_CYCLE_COUNT_SETUP.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_CYCLE_COUNT_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_INVENTORY_ACCOUNTANT.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_INVENTORY_ADMIN.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_INVENTORY_INQUIRY.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_INVENTORY_MANAGER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_INVENTORY_SHIP_RECG.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_NL_INVENTORY_ACCOUNTANT.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_NL_INVENTORY_ADMIN.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_NL_INVENTORY_MANAGER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_NL_INVENTORY_SHIP_RECG.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_INVENTORY_ACCOUNTANT.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_INVENTORY_ADMIN.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_INVENTORY_INQUIRY.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_INVENTORY_MANAGER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_INVENTORY_SHIP_RECG.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_INVENTORY_ACCOUNTANT.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_INVENTORY_ADMIN.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_INVENTORY_INQUIRY.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_INVENTORY_MANAGER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_INVENTORY_SHIP_RECG.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_SC_ADMIN.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_SC_BILL_LEAD.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_SC_BILL_PAY_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_SC_BILL_SPEC_I.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_SC_COLLECTIONS.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_SC_CONTRACT_PROC.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_SC_CONTRACT_PROC_LEAD.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_SC_INQUIRY.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_SC_BILL_SPEC_III.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_SC_SETUPS.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_SC_ADMIN.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_SC_BILL_LEAD.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_SC_BILL_PAY_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_SC_BILL_SPEC_I.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_SC_COLLECTIONS.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_SC_CONTRACT_PROC.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_SC_CONTRACT_PROC_LEAD.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_SC_INQUIRY.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_SC_BILL_SPEC_III.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_SC_SETUPS.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_NL_SC_ADMIN.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_NL_SC_BILL_LEAD.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_NL_SC_BILL_PAY_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_NL_SC_BILL_SPEC_I.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_NL_SC_COLLECTIONS.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_NL_SC_CONTRACT_PROC.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_NL_SC_CONTRACT_PROC_LEAD.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_NL_SC_INQUIRY.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_NL_SC_BILL_SPEC_III.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_NL_SC_SETUPS.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_SC_ADMIN.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_SC_BILL_LEAD.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_SC_BILL_PAY_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_SC_BILL_SPEC_I.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_SC_COLLECTIONS.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_SC_CONTRACT_PROC.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_SC_CONTRACT_PROC_LEAD.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_SC_INQUIRY.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_SC_BILL_SPEC_III.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_SC_SETUPS.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_RECEIVABLES_SUPERUSER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_RECEIVABLES_INQUIRY.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_AR_TAX_MAINT.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_AR_SETUPS.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_AR_CUSTOMER_MODIFY.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_AR_COLLECTION_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_AR_COLLECTION_TEAM_LEAD.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_AR_COLLECTION_ADMIN.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_AR_BILLING_PAYMENT_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_AR_BILLING_INVOICE_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_AR_BILLING_ADMIN.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_RECEIVABLES_SUPERUSER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_RECEIVABLES_INQUIRY.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_AR_SETUPS.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_AR_CUSTOMER_MODIFY.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_AR_COLLECTION_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_AR_COLLECTION_TEAM_LEAD.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_AR_COLLECTION_ADMIN.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_AR_BILLING_PAYMENT_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_AR_BILLING_INVOICE_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_AR_BILLING_ADMIN.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_NL_RECEIVABLES_SUPERUSER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_NL_RECEIVABLES_INQUIRY.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_NL_AR_SETUPS.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_NL_AR_CUSTOMER_MODIFY.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_NL_AR_COLLECTION_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_NL_AR_COLLECTION_TEAM_LEAD.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_NL_AR_COLLECTION_ADMIN.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_NL_AR_BILLING_PAYMENT_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_NL_AR_BILLING_INVOICE_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_NL_AR_BILLING_ADMIN.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_RECEIVABLES_SUPERUSER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_RECEIVABLES_INQUIRY.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_AR_SETUPS.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_AR_CUSTOMER_MODIFY.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_AR_COLLECTION_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_AR_COLLECTION_TEAM_LEAD.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_AR_COLLECTION_ADMIN.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_AR_BILLING_PAYMENT_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_AR_BILLING_INVOICE_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_AR_BILLING_ADMIN.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_AR_TAX_MAINT.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_NL_AR_TAX_MAINT.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_AR_TAX_MAINT.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_IEX_HTML_ADMIN_RES.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_NL_IEX_HTML_ADMIN_RES.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_IEX_OWN_CHANGE.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_IEX_FORMS_ADMIN.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_IEX_HTML_ADMIN_RESP.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_IEX_OWN_CHANGE.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_IEX_OWN_CHANGE.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_NL_IEX_OWN_CHANGE.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_IEX_FORMS_ADMIN.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_NL_IEX_FORMS_ADMIN.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_IEX_FORMS_ADMIN.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_IEX_HTML_ADMIN_RES.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_NL_CASH_MGMT_SUPER_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_CASH_MGMT_ADMIN.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_CASH_MGMT_ADMIN.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_NL_CASH_MGMT_ADMIN.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_CASH_MGMT_INQUIRY.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_CASH_MGMT_INQUIRY.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_NL_CASH_MGMT_INQUIRY.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_CASH_MGMT_MANAGER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_CASH_MGMT_MANAGER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_NL_CASH_MGMT_MANAGER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_CASH_MGMT_SUPER_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_CASH_MGMT_ADMIN.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_CASH_MGMT_INQUIRY.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_CASH_MGMT_MANAGER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_CASH_MGMT_SUPER_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_CASH_MGMT_SUPER_USER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_IEX_AGENT.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_IEX_MANAGER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_IEX_MANAGER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_UK_IEX_AGENT.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_NL_IEX_AGENT.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_HK_IEX_MANAGER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_NL_IEX_MANAGER.ldt >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afscursp.lct RS_US_IEX_AGENT.ldt >> $OUTFILE
  
  cat *.log >> $OUTFILE
  mv *.log ${LOG_DIR}

}
#--------------------------------------------------------------------------
# Using the FNDLOAD to load AOL objects
#--------------------------------------------------------------------------
UploadMenuData()
{
  cd ${LDT_DIR}

FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afsload.lct XXRS_AR_SETUP_GUI.ldt UPLOAD_MODE=REPLACE CUSTOM_MODE=FORCE  >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afsload.lct XXRS_AR_TRANSACTIONS_GUI.ldt UPLOAD_MODE=REPLACE CUSTOM_MODE=FORCE  >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afsload.lct XXRS_AR_INTERFACE_GUI.ldt UPLOAD_MODE=REPLACE CUSTOM_MODE=FORCE >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afsload.lct XXRS_INV_COUNTING.ldt UPLOAD_MODE=REPLACE CUSTOM_MODE=FORCE >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afsload.lct INV_NAVIGATE.ldt UPLOAD_MODE=REPLACE CUSTOM_MODE=FORCE >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afsload.lct XXRS_INV_NAVIGATE.ldt UPLOAD_MODE=REPLACE CUSTOM_MODE=FORCE >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afsload.lct GL_SUPERUSER.ldt UPLOAD_MODE=REPLACE CUSTOM_MODE=FORCE >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afsload.lct RS_GL_SUPERUSER.ldt UPLOAD_MODE=REPLACE CUSTOM_MODE=FORCE >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afsload.lct RS_GL_SU_SETUP.ldt UPLOAD_MODE=REPLACE CUSTOM_MODE=FORCE >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afsload.lct RS_GL_SU_S_FINANCIAL.ldt UPLOAD_MODE=REPLACE CUSTOM_MODE=FORCE >> $OUTFILE
FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afsload.lct RS_INTERCOMPANY_TRANSACTIONS.ldt UPLOAD_MODE=REPLACE CUSTOM_MODE=FORCE >> $OUTFILE
  
  cat *.log >> $OUTFILE
  mv *.log ${LOG_DIR}

}
#--------------------------------------------------------------------------
# Using the FNDLOAD to load AOL objects
#--------------------------------------------------------------------------
UploadRGData()
{
  cd ${LDT_DIR}

FNDLOAD apps/${apps_pwd} 0 Y UPLOAD $FND_TOP/patch/115/import/afcpreqg.lct RS_Intercompany_Reports.ldt >> $OUTFILE
  
  cat *.log >> $OUTFILE
  mv *.log ${LOG_DIR}

}
#--------------------------------------------------------------------------
# Calling Functions
#--------------------------------------------------------------------------
Psswd

echo -e "\nUPLOADING Request Group Data...\n" >> $OUTFILE
UploadRGData

echo -e "\nUPLOADING Menu Data...\n" >> $OUTFILE
UploadMenuData

echo -e "\nUPLOADING Responsibility Data...\n" >> $OUTFILE
UploadRespData

echo -e "\nUPLOAD of AOL Data completed.\n" >> $OUTFILE