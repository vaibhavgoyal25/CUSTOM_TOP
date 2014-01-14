/**********************************************************************************************************************
* NAME : XXRS_FND_DROP_OBJECTS.sql                                                                                    *
* DESCRIPTION :                                                                                                       *
* Script to drop custom objects that are not important                                                                *
*                                                                                                                     *
* AUTHOR       : Vinodh Bhasker                                                                                       *
* DATE WRITTEN : 21-NOV-2011                                                                                          *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* SR#             Ticket#          WHO                DATE                        REMARKS                             *
* 1.0.0           111122-02448     Vinodh Bhasker     21-NOV-2011                 Initial build                       *
***********************************************************************************************************************/
SET SERVEROUTPUT ON SIZE 1000000;

-- Dropping Tables
DROP TABLE XXRS.XXRS_AP_SR_3_4186481901_AAEA;
DROP TABLE XXRS.XXRS_AP_SR_3_4186481901_AIDA;
DROP TABLE XXRS.XXRS_AP_SR_3_4186481901_UAAEA;
DROP TABLE XXRS.XXRS_AP_SR_3_4154347671_AIDA;
DROP TABLE XXRS.XXRS_AP_SR_3_4154347671_POD;
DROP TABLE XXRS.XXRS_AP_SR_3_4154347671_AIDA_1;
DROP TABLE XXRS.XX_TESTIMAGE;                  
DROP TABLE XXRS.XX_TEST;                       
DROP TABLE XXRS.STAGING_CUSTOMER_CONTACT;      
DROP TABLE XXRS.STAGING_CUSTOMER_BANK;         
DROP TABLE XXRS.STAGING_CUSTOMER;              
DROP TABLE XXRS.RACK_AP_PAID_INV_HDR_TAB;            
DROP TABLE XXRS.RACK_FA_BOOK_VALUE_TAB;                
DROP TABLE XXRS.RACK_JOURNAL_DETAILS_TAB;            
DROP TABLE XXRS.RACK_PAYABLES_INTERFACE_ARC;      
DROP TABLE XXRS.RACK_PAYABLES_INTERFACE_TAB;      
DROP TABLE XXRS.RACK_REP_ASSET_REINSTMNT_TAB;    
DROP TABLE XXRS.RACK_REP_CAPEX_DISB_HDR_TAB;      
DROP TABLE XXRS.RACK_REP_CAPEX_DISB_LKBK_TAB;    
DROP TABLE XXRS.RACK_REP_CASH_DIT_TAB;                  
DROP TABLE XXRS.RACK_REP_CASH_POSITIONING_TAB;  
DROP TABLE XXRS.RACK_REP_DEP_ANALYSIS_TAB;          
DROP TABLE XXRS.RACK_REP_FA_OPEN_INV_TAB;
DROP TABLE XXRS.RACK_REP_INV_ON_HOLD_TAB;            
DROP TABLE XXRS.RACK_RET_TYP_UPD_ASSETS_TAB;   

--CREATE TABLE XXRS.XXRS_AP_INVOICE_REQUESTS
--AS
--SELECT * FROM XXRS.RACK_REP_INV_CASH_REQ_TAB;  

DROP TABLE XXRS.RACK_REP_INV_CASH_REQ_TAB;   
DROP TABLE XXRS.MTL_TRANSACTIONS_INTERFACE_UK; 
DROP TABLE XXRS.MTL_TRANSACTIONS_IFACE_BOTH;   
DROP TABLE XXRS.MTL_TEST_ALL;                  
DROP TABLE XXRS.MTL_SERIAL_NUMBERS_IFACE_BOTH;

DROP TABLE XXRS.XXRS_7931_INV_OHQ_10604SUCCSS;             
DROP TABLE XXRS.XXRS_ADJ_ASSET_LIFE_TBL;                    
DROP TABLE XXRS.XXRS_AR_AUD_RESP_TBL;                               
DROP TABLE XXRS.XXRS_AR_CONTACTS;                                       
DROP TABLE XXRS.XXRS_AR_INVOICE_DOCUMENTS;          
DROP TABLE XXRS.XXRS_AR_MISC_IB_TBL; 
DROP TABLE XXRS.XXRS_BAD_ASSETS_TEMP_TBL;  
--  
DROP TABLE XXRS.XXRS_CHASE_UPLOAD;                          
DROP TABLE XXRS.XXRS_CONV_FA_ASSIGNED_TBL;          
DROP TABLE XXRS.XXRS_CONV_FA_ASSIGNED_TBL_MM;    

DROP TABLE XXRS.XXRS_CONV_INV_OHQ_10604ERR;        
DROP TABLE XXRS.XXRS_CONV_INV_OHQ_10604SUCCSS;  
DROP TABLE XXRS.XXRS_CONV_INV_OHQ_ERR;                  
DROP TABLE XXRS.XXRS_CONV_INV_OHQ_ERR_DUP;          
DROP TABLE XXRS.XXRS_CONV_INV_OHQ_TBL;                  
DROP TABLE XXRS.XXRS_CONV_INV_OHQ_TBL_AFTER_LD;
DROP TABLE XXRS.XXRS_CONV_INV_OHQ_TBL_BKUP;        
DROP TABLE XXRS.XXRS_CONV_INV_OHQ_TBL_MM;            
DROP TABLE XXRS.XXRS_CONV_INV_OHQ_TBL_OK;            
DROP TABLE XXRS.XXRS_CONV_INV_OHQ_TBL_RELOAD;    
DROP TABLE XXRS.XXRS_CONV_INV_OHQ_TBL_UK_ERR1;  
DROP TABLE XXRS.XXRS_CONV_IN_MASTER_TBL;              
DROP TABLE XXRS.XXRS_CONV_SC_ACCOUNT_PRODUCT;    
DROP TABLE XXRS.XXRS_CONV_SC_ACCOUNT_RESOURCE;  
DROP TABLE XXRS.XXRS_CONV_SC_CONTRACT;                  
DROP TABLE XXRS.XXRS_CONV_SC_DEVICE_PRODUCT;      
DROP TABLE XXRS.XXRS_CONV_SC_DEVICE_RESOURCE;    
DROP TABLE XXRS.XXRS_CUSTOMER_NOTES;                      
DROP TABLE XXRS.XXRS_CUST_MASS_TEAM_UPDATE;        
DROP TABLE XXRS.XXRS_FA_AMORTIZED_ADJ;                  
DROP TABLE XXRS.XXRS_FA_ASSET_DTL_GT;                    
DROP TABLE XXRS.XXRS_FA_ASSET_NBV_GT;                    
DROP TABLE XXRS.XXRS_FA_COST_TRANSFERS;                

DROP TABLE XXRS.XXRS_FA_INV_DTL_GT;                        
DROP TABLE XXRS.XXRS_FA_SERVER_BY_COMPANY;          
DROP TABLE XXRS.XXRS_FA_XFER_ASSETS_STG;              
DROP TABLE XXRS.XXRS_GL_BLACKLINE_GT;                    
DROP TABLE XXRS.XXRS_ICX_REQS_TBL;                          
DROP TABLE XXRS.XXRS_IEX_NO_AGING_CUSTOMERS;      
DROP TABLE XXRS.XXRS_INVENTORY_EXPORT_TAB;          
DROP TABLE XXRS.XXRS_INV_MSNT_BKUP_GENERIC;        
DROP TABLE XXRS.XXRS_INV_MSN_BKUP_GENERIC;          
DROP TABLE XXRS.XXRS_INV_MTLT_BKUP_GENERIC;        
DROP TABLE XXRS.XXRS_INV_SNAPSHOT_REP_GT;             
DROP TABLE XXRS.XXRS_JTF_NOTES;                                
DROP TABLE XXRS.XXRS_LOAD_MISC_TRANS_TBL;            
DROP TABLE XXRS.XXRS_MASS_COLLECTOR_UPDATE;        
DROP TABLE XXRS.XXRS_PAYABLES_INTERFACE_ARC;      
DROP TABLE XXRS.XXRS_PAYABLES_INTERFACE_TAB;      
DROP TABLE XXRS.XXRS_PO_NEED_BY_DATE_TAB;            
DROP TABLE XXRS.XXRS_REP_DUP_JE_DTLS_TAB;            
DROP TABLE XXRS.XXRS_TRACK_RS_EMP_JOB_TAB; 
DROP TABLE XXRS.XXRS_BANK_ACCOUNT_PAYMENT_TAB;
DROP TABLE XXRS.XXRS_AR_CREDIT_CARD_IB_EPDQ;


/* Not dropping the following transactional tables

SELECT count(*) XXRS_INV_STANDARD_CONFIGS FROM XXRS.XXRS_INV_STANDARD_CONFIGS; 
SELECT count(*) XXRS_INV_CONFIG_DETAILS FROM XXRS.XXRS_INV_CONFIG_DETAILS;                      
SELECT count(*) XXRS_AR_ORBITAL_GATEWAY_ARC FROM XXRS.XXRS_AR_ORBITAL_GATEWAY_ARC;      
SELECT count(*) XXRS_AR_ORBITAL_GATEWAY_DTLS FROM XXRS.XXRS_AR_ORBITAL_GATEWAY_DTLS;    
SELECT count(*) XXRS_AR_ORBITAL_GATEWAY_RANGE FROM XXRS.XXRS_AR_ORBITAL_GATEWAY_RANGE; 
SELECT count(*) XXRS_AR_LOCKBOX_RECEIPTS FROM XXRS.XXRS_AR_LOCKBOX_RECEIPTS;            
SELECT count(*) XXRS_AR_LOCKBOX_RECEIPTS_TRACK FROM XXRS.XXRS_AR_LOCKBOX_RECEIPTS_TRACK;
SELECT count(*) XXRS_AR_CREDIT_CARD_IB_AUTH FROM XXRS.XXRS_AR_CREDIT_CARD_IB_AUTH;     
SELECT count(*) XXRS_AR_CUSTOMER_NAME_H FROM XXRS.XXRS_AR_CUSTOMER_NAME_H;  
SELECT count(*) XXRS_ADJ_ASSET_LIFE_ARC FROM XXRS.XXRS_ADJ_ASSET_LIFE_ARC;   
SELECT count(*) XXRS_CHASE_PROCESSED_PAYMENTS FROM XXRS.XXRS_CHASE_PROCESSED_PAYMENTS;
SELECT count(*) XXRS_AR_CC_CHASE_IB_TBL FROM XXRS.XXRS_AR_CC_CHASE_IB_TBL;
SELECT count(*) XXRS_AP_WKDY_EMP_EXPENSES FROM XXRS.XXRS_AP_WKDY_EMP_EXPENSES;
*/

-- Dropping views

DROP VIEW APPS.IEX_F_XXRS_DELINQ_CUST_V;      
DROP VIEW APPS.IEX_F_XXRS_HK_EMG_V;           
DROP VIEW APPS.IEX_F_XXRS_HK_ENT_V;           
DROP VIEW APPS.IEX_F_XXRS_MULTI_ORG_V;        
DROP VIEW APPS.IEX_F_XXRS_NL_EMG_V;           
DROP VIEW APPS.IEX_F_XXRS_NL_ENT_V;           
DROP VIEW APPS.IEX_F_XXRS_NO_AGING_V;         
DROP VIEW APPS.IEX_F_XXRS_UK_ENT_V;           
DROP VIEW APPS.IEX_F_XXRS_UK_SMB_V;           
DROP VIEW APPS.IEX_F_XXRS_UNKNOWN_V;          
DROP VIEW APPS.IEX_F_XXRS_US_CRP_V;           
DROP VIEW APPS.IEX_F_XXRS_US_EMA_V;           
DROP VIEW APPS.IEX_F_XXRS_US_EMG_V;           
DROP VIEW APPS.IEX_F_XXRS_US_ENT_V;           
DROP VIEW APPS.XXRS_AR_CUST_MULTI_ORG_V;      
DROP VIEW APPS.XXRS_AR_PRODUCT_DFF_LOV_V;     
DROP VIEW APPS.XXRS_DWH_FA_ASSIGNMENT_VW;     
DROP VIEW APPS.XXRS_DWH_FA_DEPRN_VW;          
DROP VIEW APPS.XXRS_DWH_FA_VW;                
DROP VIEW APPS.XXRS_FND_FLEX_VALUE_CHILDREN_V;
DROP VIEW APPS.XXRS_GL_ACCOUNTS_V;            
DROP VIEW APPS.XXRS_GL_ACTUAL_BALANCES_REC_V; 
DROP VIEW APPS.XXRS_GL_ACTUAL_BALANCES_V;     

DROP VIEW APPS.XXRS_GL_BU_DEPARTMENTS_V;      
DROP VIEW APPS.XXRS_GL_ENTITIES_V;            
DROP VIEW APPS.XXRS_GL_LOCATIONS_V;           
DROP VIEW APPS.XXRS_IEX_TEAM_MAPPING_V;       
DROP VIEW APPS.XXRS_PO_COMPANY_SEGMENT_VW;    
DROP VIEW APPS.XXRS_RA_CUSTOMER_TRX_PARTIAL_V;
DROP VIEW XXRS.XXRS_AR_CUSTOMER_ACCOUNT;

-- Dropping sequences

DROP SEQUENCE XXRS.RACK_INVOICE_LINE_ID_SEQ;      
DROP SEQUENCE XXRS.RACK_INVOICE_ID_SEQ;           
DROP SEQUENCE XXRS.ONHAND_SRC_SEQ; 

-- Dropping Synonym

DROP PUBLIC SYNONYM XXRSAP_GET_CHECK_DATE_F;                                                                                                         
DROP PUBLIC SYNONYM XXRSAP_GET_PO_NUMBER_F;                                                                                                          
DROP PUBLIC SYNONYM XXRSAP_GET_PROJ_NUMBER_F;                                                                                                        
DROP PUBLIC SYNONYM XXRSAP_GET_RECEIPT_DATE_F;                                                                                                       
DROP PUBLIC SYNONYM XXRSAP_GET_RECEIPT_NUM_F;                                                                                                        
DROP PUBLIC SYNONYM XXRSPO_GET_CHECK_DATE_F;                                                                                                         
DROP PUBLIC SYNONYM XXRSPO_GET_PROJ_NUMBER_F;                                                                                                        
DROP PUBLIC SYNONYM XXRSPO_GET_RECEIPT_DATE_F;                                                                                                       
DROP PUBLIC SYNONYM XXRSPO_GET_RECEIPT_NUM_F;                                                                                                        
DROP PUBLIC SYNONYM XXRS_ACCOUNT_DTLS_TYPE;                                                                                                          
DROP PUBLIC SYNONYM XXRS_CUST_BAL_TYPE;                                                                                                              
DROP PUBLIC SYNONYM XXRS_CUST_NOTES_TYPE;                                                                                                            
DROP PUBLIC SYNONYM XXRS_DEVICE_DTLS_TYPE;                                                                                                           
DROP PUBLIC SYNONYM XXRS_INB_CC_RECEIPT_NUM_SEQ;                                                                                                     
DROP PUBLIC SYNONYM XXRS_INVOICE_HDR_TYPE;                                                                                                           
DROP PUBLIC SYNONYM XXRS_INV_CONFIG_DETAILS;                                                                                                         
DROP PUBLIC SYNONYM XXRS_INV_CONFIG_DETAILS_S;                                                                                                       
DROP PUBLIC SYNONYM XXRS_INV_STANDARD_CONFIGS;                                                                                                       
DROP PUBLIC SYNONYM XXRS_INV_STANDARD_CONFIGS_S;                                                                                                     
DROP PUBLIC SYNONYM XXRS_OBJECT_ACCOUNT_DTLS_TYPE;                                                                                                   
DROP PUBLIC SYNONYM XXRS_OBJECT_CUST_BAL_TYPE;                                                                                                       
DROP PUBLIC SYNONYM XXRS_OBJECT_CUST_NOTES_TYPE;                                                                                                     
DROP PUBLIC SYNONYM XXRS_OBJECT_DEVICE_DTLS_TYPE;                                                                                                    

DROP PUBLIC SYNONYM XXRS_OBJECT_INVOICE_HDR_TYPE;                                                                                                    
DROP PUBLIC SYNONYM XXRS_OBJECT_TRX_DTLS_TYPE;                                                                                                       
DROP PUBLIC SYNONYM XXRS_TRX_DTLS_TYPE; 

DROP SYNONYM APPS.XXRS_AP_FORCE_APRVL_S;                                                                                                           
DROP SYNONYM APPS.XXRS_AP_PRICE_HOLD_S;                                                                                                            
DROP SYNONYM APPS.XXRS_AP_WKDY_EMPID_LOAD;                                                                                                         
--DROP SYNONYM APPS.XXRS_AP_WKDY_EMP_EXPENSES;                                                                                                       
DROP SYNONYM APPS.XXRS_AR_AUD_RESP_TBL;                                                                                                            
--DROP SYNONYM APPS.XXRS_AR_CC_CHASE_IB_TBL;                                                                                                         
DROP SYNONYM APPS.XXRS_AR_CHASE_REFERENCE_SEQ;                                                                                                     
DROP SYNONYM APPS.XXRS_AR_CONTACTS;                                                                                                                
DROP SYNONYM APPS.XXRS_AR_CONTACTS_S;                                                                                                              
--DROP SYNONYM APPS.XXRS_AR_CREDIT_CARD_IB_AUTH;                                                                                                     
DROP SYNONYM APPS.XXRS_AR_CREDIT_CARD_IB_EPDQ;                                                                                                     
DROP SYNONYM APPS.XXRS_AR_CREDIT_CARD_IB_TBL_S;                                                                                                    
--DROP SYNONYM APPS.XXRS_AR_CUSTOMER_NAME_H;                                                                                                         
DROP SYNONYM APPS.XXRS_AR_CUSTOMER_NAME_S;                                                                                                         
DROP SYNONYM APPS.XXRS_AR_CUST_AGING_TBL;                                                                                                          
DROP SYNONYM APPS.XXRS_AR_CUST_AGING_TYPE;                                                                                                         
DROP SYNONYM APPS.XXRS_AR_CUST_SITE_DTLS_TBL;                                                                                                      
DROP SYNONYM APPS.XXRS_AR_CUST_SITE_DTLS_TYPE;                                                                                                     
DROP SYNONYM APPS.XXRS_AR_INVOICE_DOCUMENTS;                                                                                                       
DROP SYNONYM APPS.XXRS_AR_INVOICE_DOCUMENTS_S;                                                                                                     
DROP SYNONYM APPS.XXRS_AR_LBX_RECEIPT_ID_SEQ;                                                                                                      
--DROP SYNONYM APPS.XXRS_AR_LOCKBOX_RECEIPTS;                                                                                                        
--DROP SYNONYM APPS.XXRS_AR_LOCKBOX_RECEIPTS_TRACK;                                                                                                  

DROP SYNONYM APPS.XXRS_AR_MISC_IB_TBL;                                                                                                             
--DROP SYNONYM APPS.XXRS_AR_ORBITAL_GATEWAY_ARC;                                                                                                     
--DROP SYNONYM APPS.XXRS_AR_ORBITAL_GATEWAY_DTLS;                                                                                                    
--DROP SYNONYM APPS.XXRS_AR_ORBITAL_GATEWAY_RANGE;                                                                                                   
DROP SYNONYM APPS.XXRS_CONTR_HIST_TYPE;                                                                                                            
DROP SYNONYM APPS.XXRS_CONTR_MONTHLY_TYPE;                                                                                                         
DROP SYNONYM APPS.XXRS_CUST_REC_PYMNT_TYPE;                                                                                                        
DROP SYNONYM APPS.XXRS_FA_AMORT_ADJ_S;                                                                                                             
DROP SYNONYM APPS.XXRS_FA_ASSETS_XFER_S;                                                                                                           
DROP SYNONYM APPS.XXRS_FA_ASSET_DTL_GT;                                                                                                            
DROP SYNONYM APPS.XXRS_FA_ASSET_NBV_GT;                                                                                                            
DROP SYNONYM APPS.XXRS_FA_COST_TRANSFERS;                                                                                                          
DROP SYNONYM APPS.XXRS_FA_COST_TRANSFERS_S;                                                                                                        
DROP SYNONYM APPS.XXRS_FA_DTLS_TYPE;                                                                                                               
DROP SYNONYM APPS.XXRS_FA_INV_DTL_GT;                                                                                                              
DROP SYNONYM APPS.XXRS_FA_SERVER_BY_COMPANY;                                                                                                       
DROP SYNONYM APPS.XXRS_FA_SERVER_BY_COMPANY_S;                                                                                                     
DROP SYNONYM APPS.XXRS_FA_XFER_ASSETS_STG;                                                                                                         
DROP SYNONYM APPS.XXRS_INVOICE_DTL_TYPE;                                                                                                           
DROP SYNONYM APPS.XXRS_JTF_NOTES;                                                                                                                  
DROP SYNONYM APPS.XXRS_JTF_NOTES_S;                                                                                                                
DROP SYNONYM APPS.XXRS_LBX_CHANGE_REF_ID_SEQ;                                                                                                      
DROP SYNONYM APPS.XXRS_OBJECT_CONTR_HIST_TYPE;                                                                                                     

DROP SYNONYM APPS.XXRS_OBJECT_CONTR_MONTHLY_TYPE;                                                                                                  
DROP SYNONYM APPS.XXRS_OBJECT_FA_DTLS_TYPE;                                                                                                        
DROP SYNONYM APPS.XXRS_OBJECT_INVOICE_DTL_TYPE;                                                                                                    
DROP SYNONYM APPS.XXRS_OBJECT_TRX_TYPE;                                                                                                            
DROP SYNONYM APPS.XXRS_OBJ_REC_PYMNT_TYPE;                                                                                                         
DROP SYNONYM APPS.XXRS_TRX_TYPE;                                                                                                                   
DROP SYNONYM APPS.XXRS_WS_SC_PRD_RES_PRC_TBL;                                                                                                      
DROP SYNONYM APPS.XXRS_WS_SC_PRD_RES_PRC_TYPE; 
DROP SYNONYM APPS.XXRS_SC_ITEM_PROPERTY_TBL;

DROP SYNONYM XXRSCORE.XXRS_ACTLVLPRD_PRC_TYPE;                                                      
DROP SYNONYM XXRSCORE.XXRS_AR_CUST_SITE_DTLS_TBL;                                                   
DROP SYNONYM XXRSCORE.XXRS_AR_CUST_SITE_DTLS_TYPE;                                                  
DROP SYNONYM XXRSCORE.XXRS_INVOICE_DTL_TYPE;                                                        
DROP SYNONYM XXRSCORE.XXRS_OBJECT_ACTLVLPRD_PRC_TYPE;                                               
DROP SYNONYM XXRSCORE.XXRS_OBJECT_INVOICE_DTL_TYPE;                                                 
DROP SYNONYM XXRSCORE.XXRS_SC_DEVICES_TBL;                                                          
DROP SYNONYM XXRSCORE.XXRS_SC_DEVICES_TYPE;                                                         
DROP SYNONYM XXRSCORE.XXRS_SC_DEVICE_MRR_TBL;                                                       
DROP SYNONYM XXRSCORE.XXRS_SC_DEVICE_MRR_TYPE;

-- Dropping Triggers

DROP TRIGGER APPS.XXRS_AP_BANK_ACCOUNT_USES_BRU;                           
DROP TRIGGER APPS.XXRS_AP_BANK_ACCOUNT_USES_BRI;                           
DROP TRIGGER APPS.XXRS_HZ_PARTIES_BRU;                                     
DROP TRIGGER APPS.XXRS_HZ_CUST_ACCOUNTS_BRI;                               
DROP TRIGGER XXRS.XXRS_SC_INVOICE_WKST_INT_BRIU;                           
DROP TRIGGER APPS.XXRS_AR_LBX_RECEIPT_TRIGGER;

-- Dropping Functions

DROP FUNCTION APPS.XXRS_SC_CI_GET_FREETIME_0001;
DROP FUNCTION APPS.XXRS_SC_CI_GET_PRICE_0001;
DROP FUNCTION XXRS.XXRSAP_GET_CHECK_DATE_F;                                                                                                           
DROP FUNCTION XXRS.XXRSAP_GET_PO_NUMBER_F;                                                                                                            
DROP FUNCTION XXRS.XXRSAP_GET_PROJ_NUMBER_F;                                                                                                          
DROP FUNCTION XXRS.XXRSAP_GET_RECEIPT_DATE_F;                                                                                                         
DROP FUNCTION XXRS.XXRSAP_GET_RECEIPT_NUM_F;                                                                                                          
DROP FUNCTION XXRS.XXRSINV_GET_ITEM_NUMBER;                                                                                                           
DROP FUNCTION XXRS.XXRSPO_GET_CHECK_DATE_F;                                                                                                           
DROP FUNCTION XXRS.XXRSPO_GET_PROJ_NUMBER_F;                                                                                                          
DROP FUNCTION XXRS.XXRSPO_GET_RECEIPT_DATE_F;                                                                                                         
DROP FUNCTION XXRS.XXRSPO_GET_RECEIPT_NUM_F;                                                                                                          

-- Dropping Package

DROP PACKAGE APPS.XXRS_ACCT_LVL_PRDCT_PRC_PKG;                                                                                                        
DROP PACKAGE APPS.XXRS_AP_BANK_PAYMENTS_PKG;                                                                                                          
DROP PACKAGE APPS.XXRS_AP_FORCE_APP_WF;                                                                                                               
DROP PACKAGE APPS.XXRS_AP_INV_AGING;                                                                                                                  
DROP PACKAGE APPS.XXRS_AP_PAYMENT_EVENT_WF_PKG;                                                                                                       
DROP PACKAGE APPS.XXRS_AP_PRICE_HOLD_WF;                                                                                                              
DROP PACKAGE APPS.XXRS_AP_REJ_NOTI;                                                                                                                   
DROP PACKAGE APPS.XXRS_AP_WKDY_EMPEXP_PKG;                                                                                                            
DROP PACKAGE APPS.XXRS_AR_ACCOUNT_UPDATER_PKG;                                                                                                        
DROP PACKAGE APPS.XXRS_AR_ACH_OUTBOUND_US;                                                                                                            
DROP PACKAGE APPS.XXRS_AR_AGING_PKG;                                                                                                                  
DROP PACKAGE APPS.XXRS_AR_BANK_PKG;                                                                                                                   
DROP PACKAGE APPS.XXRS_AR_CC_CHASE_IB;                                                                                                                
DROP PACKAGE APPS.XXRS_AR_CC_CHASE_OB;                                                                                                                
DROP PACKAGE APPS.XXRS_AR_CONTACTS_PKG;                                                                                                               
DROP PACKAGE APPS.XXRS_AR_CREDIT_CARD_AUTH_OB;                                                                                                        
DROP PACKAGE APPS.XXRS_AR_CREDIT_CARD_EPDQ_IB;                                                                                                        
DROP PACKAGE APPS.XXRS_AR_CREDIT_CARD_EPDQ_OB;                                                                                                        
DROP PACKAGE APPS.XXRS_AR_CREDIT_CARD_IB;                                                                                                             
DROP PACKAGE APPS.XXRS_AR_CUSTOMER_NAME;                                                                                                              
DROP PACKAGE APPS.XXRS_AR_CUST_ACCT_PKG;                                                                                                              
DROP PACKAGE APPS.XXRS_AR_CUST_ACCT_SITE_PKG;                                                                                                         
DROP PACKAGE APPS.XXRS_AR_DD_PAYERS_OB;                                                                                                               

DROP PACKAGE APPS.XXRS_AR_LOCKBOX_RECEIPT_PKG;                                                                                                        
DROP PACKAGE APPS.XXRS_AR_MISC_IB_PKG;                                                                                                                
DROP PACKAGE APPS.XXRS_AR_ORBITAL_GATEWAY_PKG;                                                                                                        
DROP PACKAGE APPS.XXRS_AR_UK_DIRECT_DEBIT_OB;                                                                                                         
DROP PACKAGE APPS.XXRS_ASSET_ADD_PKG;                                                                                                                 
DROP PACKAGE APPS.XXRS_ASSET_COST_ADJ_PKG;                                                                                                            
DROP PACKAGE APPS.XXRS_ASSET_RET_PKG;                                                                                                                 
DROP PACKAGE APPS.XXRS_AUDIT_RPT_PKG;                                                                                                                 
DROP PACKAGE APPS.XXRS_CHASE_OUTBOUND_PKG;                                                                                                            
DROP PACKAGE APPS.XXRS_CONP_PKG;                                                                                                                      
DROP PACKAGE APPS.XXRS_CONTRACT_DTLS_PKG;                                                                                                             
DROP PACKAGE APPS.XXRS_CONTRACT_HIST_PKG;                                                                                                             
DROP PACKAGE APPS.XXRS_CONTR_MONTHLY_DTLS_PKG;                                                                                                        
DROP PACKAGE APPS.XXRS_CONV_ITEM_MASTER;                                                                                                              
DROP PACKAGE APPS.XXRS_CUSTOMER_BANK_PKG;                                                                                                             
DROP PACKAGE APPS.XXRS_CUSTOMER_NOTES_PKG;                                                                                                            
DROP PACKAGE APPS.XXRS_CUST_BAL_PKG;                                                                                                                  
DROP PACKAGE APPS.XXRS_CUST_CC_EXP_PKG;                                                                                                               
DROP PACKAGE APPS.XXRS_CUST_NOTES_PKG;                                                                                                                
DROP PACKAGE APPS.XXRS_CUST_PYMNT_TRACK_PKG;                                                                                                          
DROP PACKAGE APPS.XXRS_CUST_RECPAY_INS_UPD_PKG;                                                                                                       
DROP PACKAGE APPS.XXRS_CUST_REC_PYMNT_PKG;                                                                                                            
DROP PACKAGE APPS.XXRS_DYNAMIC_CCID_PKG;                                                                                                              

DROP PACKAGE APPS.XXRS_DYN_GL_ACC_UPDT_PKG;                                                                                                           
DROP PACKAGE APPS.XXRS_FA_ADD_ADJ_PKG;                                                                                                                
DROP PACKAGE APPS.XXRS_FA_AMORTIZED_ADJ_PKG;                                                                                                          
DROP PACKAGE APPS.XXRS_FA_ASSET_LIFE_ADJ_PKG;                                                                                                         
DROP PACKAGE APPS.XXRS_FA_COST_TRANSFER_PKG;                                                                                                          
DROP PACKAGE APPS.XXRS_FA_DTLS_PKG;                                                                                                                   
DROP PACKAGE APPS.XXRS_FA_EXPORT_PKG;                                                                                                                 
DROP PACKAGE APPS.XXRS_FA_SISIC_PKG;                                                                                                                  
DROP PACKAGE APPS.XXRS_FA_SUBASSEMBLY_PKG;                                                                                                            
DROP PACKAGE APPS.XXRS_GL_ACC_UPDT_PKG;                                                                                                               
DROP PACKAGE APPS.XXRS_GL_BLACK_LINE_PKG;                                                                                                             
DROP PACKAGE APPS.XXRS_GL_INTERFACE_PKG;                                                                                                              
DROP PACKAGE APPS.XXRS_ICX_REQS_PKG;                                                                                                                  
DROP PACKAGE APPS.XXRS_IEX_NOTES_PKG;                                                                                                                 
DROP PACKAGE APPS.XXRS_IEX_SCORING_PKG;                                                                                                               
DROP PACKAGE APPS.XXRS_IEX_STRATEGY_PKG;                                                                                                              
DROP PACKAGE APPS.XXRS_INVENTORY_EXPORT_PKG;                                                                                                          
DROP PACKAGE APPS.XXRS_INVOHQQC_PKG;                                                                                                                  
DROP PACKAGE APPS.XXRS_INVOICE_DTL_PKG;                                                                                                               
DROP PACKAGE APPS.XXRS_INVOICE_HDR_PKG;                                                                                                               
DROP PACKAGE APPS.XXRS_INVTXN_PKG;                                                                                                                    
DROP PACKAGE APPS.XXRS_INV_MAN_APR_PKG;                                                                                                               
DROP PACKAGE APPS.XXRS_INV_SNAPSHOT_REP_PKG;                                                                                                          

DROP PACKAGE APPS.XXRS_INV_STRUCK_TRX_PKG;                                                                                                            
DROP PACKAGE APPS.XXRS_ITEM_STA_PKG;                                                                                                                  
DROP PACKAGE APPS.XXRS_LOAD_MISC_TRANS_PKG;                                                                                                           
DROP PACKAGE APPS.XXRS_LOCKBOX_ERR_PKG;                                                                                                               
DROP PACKAGE APPS.XXRS_MASS_COLL_UPDATE_PKG;                                                                                                          
DROP PACKAGE APPS.XXRS_MASS_TEAM_BU_AM_PKG;                                                                                                           
DROP PACKAGE APPS.XXRS_NORMAL_TO_DEPR_PKG;                                                                                                            
DROP PACKAGE APPS.XXRS_OKS_TRANS_PKG;                                                                                                                 
DROP PACKAGE APPS.XXRS_ONHAND_QTY_CONV_PKG;                                                                                                           
DROP PACKAGE APPS.XXRS_OPEN_INV_PKG;                                                                                                                  
DROP PACKAGE APPS.XXRS_PAYABLES_INTERFACE_PKG;                                                                                                        
DROP PACKAGE APPS.XXRS_PLAN_ASL_PKG;                                                                                                                  
DROP PACKAGE APPS.XXRS_PO_AGE_PKG;                                                                                                                    
DROP PACKAGE APPS.XXRS_PO_NBD_PKG;                                                                                                                    
DROP PACKAGE APPS.XXRS_PO_NEED_BYDT;                                                                                                                  
DROP PACKAGE APPS.XXRS_PREPAY_PKG;                                                                                                                    
DROP PACKAGE APPS.XXRS_PROPERTY_TAX_PKG;                                                                                                              
DROP PACKAGE APPS.XXRS_RAXINV;                                                                                                                        
DROP PACKAGE APPS.XXRS_REP_DUPLICATE_ENTRY_PKG;                                                                                                       
DROP PACKAGE APPS.XXRS_SALE_COMM_PKG;                                                                                                                 
DROP PACKAGE APPS.XXRS_TCA_CUST_CONV_PKG;                                                                                                             
DROP PACKAGE APPS.XXRS_TCA_CUST_ERR_PKG;                                                                                                              
DROP PACKAGE APPS.XXRS_TRACK_RS_EMP_JOB_PKG;                                                                                                          

DROP PACKAGE APPS.XXRS_TRX_DTLS_PKG;                                                                                                                  
DROP PACKAGE APPS.XXRS_TRX_TYPE_PKG;                                                                                                                  
DROP PACKAGE APPS.XXRS_UK_IB_ASSET_LINK;                                                                                                              
DROP PACKAGE APPS.XXRS_UNINV_RCPT_PKG;                                                                                                                
DROP PACKAGE APPS.XXRS_UNPLAN_ASL_PKG;                                                                                                                
DROP PACKAGE APPS.XXRS_US_IB_ASSET_LINK;                                                                                                              
DROP PACKAGE APPS.XXRS_UTILITY_PKG;                                                                                                                   
DROP PACKAGE APPS.XXRS_VENDOR_INACT_UTL_PKG;                                                                                                          
DROP PACKAGE APPS.XXRS_WS_AR_CUST_AGING_PKG;                                                                                                          
DROP PACKAGE APPS.XXRS_WS_AR_CUST_DETAILS_PKG;                                                                                                        
DROP PACKAGE APPS.XXRS_WS_AR_INVOICE_GEN_PKG;                                                                                                         
DROP PACKAGE APPS.XXRS_WS_AR_ONLINE_PAYMENTS_PKG;                                                                                                     
DROP PACKAGE APPS.XXRS_WS_AR_PAPERLESS_PKG;                                                                                                           
DROP PACKAGE APPS.XXRS_WS_GL_DETAILS_PKG;                                                                                                             
DROP PACKAGE APPS.XXRS_WS_SC_DEVICE_PKG;                                                                                                              
DROP PACKAGE APPS.XXRS_WS_SC_PRD_RES_PRC_PKG;

DROP PACKAGE APPS.RACK_STOCK_DEPRN_PKG;
DROP PACKAGE APPS.RACK_RETIREMENT_TYPE_UPD_PKG;
DROP PACKAGE APPS.RACK_REP_INV_ON_HOLD_PKG;
DROP PACKAGE APPS.RACK_REP_INV_CASH_REQ_PKG;
DROP PACKAGE APPS.RACK_REP_FA_OPEN_INV_PKG;
DROP PACKAGE APPS.RACK_REP_DEP_ANALYSIS_PKG;
DROP PACKAGE APPS.RACK_REP_CASH_POSITIONING_PKG;
DROP PACKAGE APPS.RACK_REP_CAPEX_DISB_LKBK_PKG;
DROP PACKAGE APPS.RACK_REP_ASSET_REINSTMNT_PKG;
DROP PACKAGE APPS.RACK_PAYABLES_INTERFACE_PKG;
DROP PACKAGE APPS.RACK_INSTALL_BASE_UPDATE;
DROP PACKAGE APPS.RACK_FA_EXPORT_PKG;
DROP PACKAGE APPS.RACK_FA_BOOK_VALUE_PKG;

-- Dropping Types
DROP TYPE APPS.XXRS_OBJECT_ACCOUNT_DTLS_TYPE;                                                                                                         
DROP TYPE APPS.XXRS_OBJECT_ACTLVLPRD_PRC_TYPE;                                                                                                        
DROP TYPE APPS.XXRS_OBJECT_CUST_BAL_TYPE;                                                                                                             
DROP TYPE APPS.XXRS_OBJECT_CUST_NOTES_TYPE;                                                                                                           
DROP TYPE APPS.XXRS_OBJECT_DEVICE_DTLS_TYPE;                                                                                                          
DROP TYPE APPS.XXRS_OBJECT_INVOICE_HDR_TYPE;                                                                                                          
DROP TYPE APPS.XXRS_OBJECT_TRX_DTLS_TYPE;   
DROP TYPE XXRS.XXRS_OBJECT_CONTR_HIST_TYPE;                                                                                                           
DROP TYPE XXRS.XXRS_OBJECT_CONTR_MONTHLY_TYPE;                                                                                                        
DROP TYPE XXRS.XXRS_OBJECT_FA_DTLS_TYPE;                                                                                                              
DROP TYPE XXRS.XXRS_OBJECT_INVOICE_DTL_TYPE;                                                                                                          
DROP TYPE XXRS.XXRS_OBJECT_TRX_TYPE;                                                                                                                  
DROP TYPE XXRS.XXRS_OBJ_REC_PYMNT_TYPE;
DROP TYPE XXRS.XXRS_AR_CUST_AGING_TBL; 
DROP TYPE XXRS.XXRS_SC_DEVICE_MRR_TBL;
DROP TYPE XXRS.XXRS_WS_SC_PRD_RES_PRC_TBL;  
DROP TYPE XXRS.XXRS_SC_DEVICES_TBL; 

DROP TYPE APPS.XXRS_ACCOUNT_DTLS_TYPE;                                                                                                                
DROP TYPE APPS.XXRS_ACTLVLPRD_PRC_TYPE;                                                                                                               
DROP TYPE APPS.XXRS_CUST_BAL_TYPE;                                                                                                                    
DROP TYPE APPS.XXRS_CUST_NOTES_TYPE;                                                                                                                  
DROP TYPE APPS.XXRS_DEVICE_DTLS_TYPE;                                                                                                                 
DROP TYPE APPS.XXRS_INVOICE_HDR_TYPE;                                                                                                          
DROP TYPE APPS.XXRS_TRX_DTLS_TYPE;                                                                                                                
DROP TYPE XXRS.XXRS_AR_CUST_AGING_TYPE;                                                                                                               
DROP TYPE XXRS.XXRS_AR_CUST_SITE_DTLS_TBL;                                                                                                            
DROP TYPE XXRS.XXRS_AR_CUST_SITE_DTLS_TYPE;                                                                                                           
DROP TYPE XXRS.XXRS_CONTR_HIST_TYPE;                                                                                                                  
DROP TYPE XXRS.XXRS_CONTR_MONTHLY_TYPE;                                                                                                               
DROP TYPE XXRS.XXRS_CUST_REC_PYMNT_TYPE;                                                                                                              
DROP TYPE XXRS.XXRS_FA_DTLS_TYPE;                                                                                                                     
DROP TYPE XXRS.XXRS_INVOICE_DTL_TYPE;                                                                                                                 
                                                                                                                                                                                                                                
DROP TYPE XXRS.XXRS_SC_DEVICES_TYPE;                                                                                 
DROP TYPE XXRS.XXRS_SC_DEVICE_MRR_TYPE;                                                                                                               
DROP TYPE XXRS.XXRS_TRX_TYPE;                                                                               
DROP TYPE XXRS.XXRS_WS_SC_PRD_RES_PRC_TYPE; 

-- Dropping Procedures
                                                                                                   
DROP PROCEDURE APPS.XXRS_EMAIL_ALERT;                                                                                                                 
DROP PROCEDURE APPS.XXRS_MAIL;                                                                                                                        
DROP PROCEDURE APPS.XXRS_MONITOR_WF_MAILER;                                                                                                           

-- Dropping Indexes

DROP INDEX APPS.XX_XNP_MSGS_N99;                                                                                                                      
--DROP INDEX XXRS.XXRS_ADJ_ASSET_LIFE_ARC_INDX;                                                                                                         
--DROP INDEX XXRS.XXRS_AR_CUSTOMER_NAME_H_PK;                                                                                                           
--DROP INDEX XXRS.XXRS_AR_LBX_RCPT_TRK_PK;                                                                                                              
--DROP INDEX XXRS.XXRS_AR_LOCKBOX_RECEIPTS_N01;                                                                                                         
--DROP INDEX XXRS.XXRS_AR_LOCKBOX_RECEIPTS_N02;                                                                                                         
--DROP INDEX XXRS.XXRS_AR_LOCKBOX_RECEIPTS_N03;                                                                                                         
--DROP INDEX XXRS.XXRS_AR_LOCKBOX_RECEIPTS_N04;                                                                                                         
--DROP INDEX XXRS.XXRS_AR_LOCKBOX_RECEIPTS_PK;                                                                                                          
--DROP INDEX XXRS.XXRS_BAD_ASSETS_TEMP_TBL_N1;                                                                                                          
--DROP INDEX XXRS.XXRS_BAD_ASSETS_TEMP_TBL_N2;                                                                                                          
DROP INDEX XXRS.XXRS_CONV_IN_MASTER_TBL_PK;                                                                                                           
DROP INDEX XXRS.XXRS_CONV_SC_ACCT_PROD_N1;                                                                                                            
DROP INDEX XXRS.XXRS_CONV_SC_ACCT_PROD_N2;                                                                                                            
DROP INDEX XXRS.XXRS_CONV_SC_ACCT_PROD_N3;                                                                                                            
DROP INDEX XXRS.XXRS_CONV_SC_ACCT_RES_N1;                                                                                                             
DROP INDEX XXRS.XXRS_CONV_SC_ACCT_RES_N2;                                                                                                             
DROP INDEX XXRS.XXRS_CONV_SC_ACCT_RES_N3;                                                                                                             
DROP INDEX XXRS.XXRS_CONV_SC_CONTRACT_N1;                                                                                                             
DROP INDEX XXRS.XXRS_CONV_SC_CONTRACT_N2;                                                                                                             
DROP INDEX XXRS.XXRS_CONV_SC_DEVICE_PROD_N1;                                                                                                          
DROP INDEX XXRS.XXRS_CONV_SC_DEVICE_PROD_N2;                                                                                                          
DROP INDEX XXRS.XXRS_CONV_SC_DEVICE_PROD_N3;                                                                                                          

DROP INDEX XXRS.XXRS_CONV_SC_DEVICE_RES_N1;                                                                                                           
DROP INDEX XXRS.XXRS_CONV_SC_DEVICE_RES_N2;                                                                                                           
--DROP INDEX XXRS.XXRS_FA_AMORTIZED_ADJ_N01;                                                                                                            
--DROP INDEX XXRS.XXRS_FA_AMORTIZED_ADJ_U01;                                                                                                            
--DROP INDEX XXRS.XXRS_FA_ASSET_DTL_GT_N01;                                                                                                             
--DROP INDEX XXRS.XXRS_FA_ASSET_NBV_GT_N01;                                                                                                             
DROP INDEX XXRS.XXRS_FA_BAL_REP_ITF_IDX001;                                                                                                           
--DROP INDEX XXRS.XXRS_FA_COST_TRANSFERS_N01;                                                                                                           
--DROP INDEX XXRS.XXRS_FA_COST_TRANSFERS_N02;                                                                                                           
--DROP INDEX XXRS.XXRS_FA_INV_DTL_GT_N01;                                                                                                               
--DROP INDEX XXRS.XXRS_FA_SERVER_BY_COMPANY_N1;                                                                                                         
--DROP INDEX XXRS.XXRS_FA_SERVER_BY_COMPANY_N2;                                                                                                         
DROP INDEX XXRS.XXRS_HST_PRODUCT_SNID_N02;                                                                                                            
--DROP INDEX XXRS.XXRS_ICX_REQS_TBL_PK;                                                                                                                 
--DROP INDEX XXRS.XXRS_IEX_NO_AGING_CUSTOMERS_PK;                                                                                                       
--DROP INDEX XXRS.XXRS_INV_CONFIG_DETAILS_U01;                                                                                                          
--DROP INDEX XXRS.XXRS_INV_SNAPSHOT_REP_GT_N01;                                                                                                         
--DROP INDEX XXRS.XXRS_INV_SNAPSHOT_REP_GT_N02;                                                                                                         
--DROP INDEX XXRS.XXRS_INV_STANDARD_CONFIGS_U01;                                                                                                        
DROP INDEX XXRS.XXRS_RA_CUSTOMER_TRX_N24;                                                                                                             
DROP INDEX XXRS.XXRS_RESOURCE_SNID_N01;                                                                                                               
/*DROP INDEX XXRS.XXRS_STAGE_CUST_CONTACT_N1;                                                                                                           
DROP INDEX XXRS.XXRS_STAGE_CUST_CONTACT_N2;                                                                                                           

DROP INDEX XXRS.XXRS_STAGE_CUST_CONTACT_N3;                                                                                                           
DROP INDEX XXRS.XXRS_STAGE_CUST_CONTACT_N4;                                                                                                           
DROP INDEX XXRS.XXRS_STAGE_CUST_CONTACT_N5;                                                                                                           
DROP INDEX XXRS.XXRS_STAGING_CUSTOMER_N1;                                                                                                             
DROP INDEX XXRS.XXRS_STAGING_CUSTOMER_N10;                                                                                                            
DROP INDEX XXRS.XXRS_STAGING_CUSTOMER_N2;                                                                                                             
DROP INDEX XXRS.XXRS_STAGING_CUSTOMER_N3;                                                                                                             
DROP INDEX XXRS.XXRS_STAGING_CUSTOMER_N4;                                                                                                             
DROP INDEX XXRS.XXRS_STAGING_CUSTOMER_N5;                                                                                                             
DROP INDEX XXRS.XXRS_STAGING_CUSTOMER_N6;                                                                                                             
DROP INDEX XXRS.XXRS_STAGING_CUSTOMER_N7;                                                                                                             
DROP INDEX XXRS.XXRS_STAGING_CUSTOMER_N8;                                                                                                             
DROP INDEX XXRS.XXRS_STAGING_CUSTOMER_N9;                                                                                                             
DROP INDEX XXRS.XXRS_STAGING_CUST_BANK_N101;                                                                                                          
DROP INDEX XXRS.XXRS_STAGING_CUST_N101;
*/
/