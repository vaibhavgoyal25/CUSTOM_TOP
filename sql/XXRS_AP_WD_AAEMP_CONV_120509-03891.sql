/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_AP_WD_AAEMP_CONV_120509-03891.sql                                                                          *
*                                                                                                                     *
* DESCRIPTION : Script to load workday staging table to convert AAEMP to suppliers                                    *
*                                                                                                                     *
* AUTHOR       : Pavan Amirineni                                                                                      *
* DATE WRITTEN : 07/20/2012                                                                                           *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* Version#  | Ticket #      | WHO             |  DATE          |   REMARKS                                            *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0     | 120509-03891  | Pavan Amirineni | 07/20/2012     | Initial Creation                                     *
**********************************************************************************************************************/
/* $Header: XXRS_AP_WD_AAEMP_CONV_120509-03891.sql 1.0.0 07/20/2012 15:00:00 Pavan Amirineni$ */
SET SERVEROUTPUT ON;
DECLARE     
CURSOR cur_emp_conv 
IS  
SELECT sites.attribute1 wd_emp_id
     , TRIM(SUBSTR(sup.vendor_name, 0, INSTR(sup.vendor_name, ',')-1)) last_name
     , TRIM(SUBSTR(sup.vendor_name, INSTR(sup.vendor_name, ',')+1,LENGTH(vendor_name) )) first_name
     , branch_number 
     , bank_account_num_electronic          
     , aia.invoice_amount
     , aia.invoice_currency_code currency_code
     , sites.remittance_email
     , aia.invoice_date     
     , aia.invoice_num  
     , sup.segment1          
     , aia.amount_paid   
     , aia.description
     , sup.vendor_name   
     , aia.invoice_id
     , aia.external_bank_account_id       
  FROM ap.ap_suppliers sup
     , ap.ap_invoices_all aia
     , ap.ap_supplier_sites_all sites
     , apps.iby_ext_bank_accounts_v ieba
 WHERE sup.vendor_type_lookup_code = 'AAEMPLOYEE'
   AND aia.vendor_id = sup.vendor_id 
   and sup.vendor_id = sites.vendor_id  
   AND aia.external_bank_account_id = ieba.ext_bank_account_id (+) 
   AND aia.creation_date >=  TO_DATE('04/23/2012', 'MM/DD/YYYY')  
   AND sites.attribute1 IS NOT NULL 
   AND aia.invoice_amount > 0 
   AND aia.org_id = 126
--   and sites.org_id != aia.org_id  
   AND NOT EXISTS (SELECT 'X'
                     FROM ap.ap_payment_schedules_all ps 
                    WHERE ps.invoice_id = aia.invoice_id
                      AND amount_remaining = 0
                      AND ORG_ID = sites.org_id)
   ;
--                      
  x_cancel_inv BOOLEAN := NULL;
--      
  FUNCTION cancel_invoice (p_invoice_id IN NUMBER)
  RETURN BOOLEAN  
  IS      
   v_invoice_id              NUMBER ;
   v_boolean                 BOOLEAN;
   v_error_code              VARCHAR2 (100);
   v_debug_info              VARCHAR2 (1000);
   v_message_name            VARCHAR2 (1000);
   v_invoice_amount          NUMBER;
   v_base_amount             NUMBER;
   v_tax_amount              NUMBER;
   v_temp_cancelled_amount   NUMBER;
   v_cancelled_by            VARCHAR2 (1000);
   v_cancelled_amount        NUMBER;
   v_cancelled_date          DATE;
   v_last_update_date        DATE;
   v_token                   VARCHAR2 (100);
   v_orig_prepay_amt         NUMBER;
   v_pay_cur_inv_amt         NUMBER;
   BEGIN                            
      v_boolean                 := NULL;
      v_error_code              := NULL;
      v_debug_info              := NULL;
      v_message_name            := NULL;
      v_invoice_amount          := NULL;
      v_base_amount             := NULL;
      v_tax_amount              := NULL;
      v_temp_cancelled_amount   := NULL;
      v_cancelled_by            := NULL;
      v_cancelled_amount        := NULL; 
      v_cancelled_date          := NULL;
      v_last_update_date        := NULL;
      v_token                   := NULL;
      v_orig_prepay_amt         := NULL;
      v_pay_cur_inv_amt         := NULL;   
        --- context done ------------     
     v_boolean := AP_CANCEL_PKG.IS_INVOICE_CANCELLABLE (P_invoice_id         => p_invoice_id,
                                                        p_error_code         => v_error_code,
                                                        P_debug_info         => v_debug_info,
                                                        p_calling_sequence   => NULL
                                                       );
     IF (v_boolean= FALSE) THEN 
       dbms_output.put_line ('Invoice ID => '|| v_invoice_id|| ' is not cancellable :'|| v_error_code);
       v_boolean    := NULL; 
       v_error_code := NULL; 
       v_debug_info := NULL; 
       RETURN FALSE; 
     END IF;     
     v_boolean := AP_CANCEL_PKG.AP_CANCEL_SINGLE_INVOICE ( p_invoice_id                   => p_invoice_id,
                                                           p_last_updated_by              => 0,
                                                           p_last_update_login            => -1,
                                                           p_accounting_date              => SYSDATE,
                                                           p_message_name                 => v_message_name,
                                                           p_invoice_amount               => v_invoice_amount,
                                                           p_base_amount                  => v_base_amount,
                                                           p_temp_cancelled_amount        => v_temp_cancelled_amount,
                                                           p_cancelled_by                 => v_cancelled_by,
                                                           p_cancelled_amount             => v_cancelled_amount,
                                                           p_cancelled_date               => v_cancelled_date,
                                                           p_last_update_date             => v_last_update_date,
                                                           p_original_prepayment_amount   => v_orig_prepay_amt,
                                                           p_pay_curr_invoice_amount      => v_pay_cur_inv_amt,
                                                           p_Token                        => v_token,
                                                           p_calling_sequence             => NULL);
     IF v_boolean
     THEN      
        COMMIT;        
        RETURN TRUE;            
     ELSE        
        dbms_output.put_line ('Invoice ID => '|| v_invoice_id|| ' is not cancellable :'|| v_error_code);
        ROLLBACK;
        RETURN FALSE; 
     END IF;
          
   END cancel_invoice;        

PROCEDURE DISABLE_AAEMP 
IS 
  CURSOR cur_aaemp 
  IS         
  SELECT sup.segment1  
       , sup.party_id           
       , sup.vendor_name
       , sup.vendor_id
       , sites.vendor_site_code
       , sites.attribute1
       , sites.vendor_site_id         
       , sites.org_id
    FROM ap.ap_suppliers sup     
       , ap.ap_supplier_sites_all sites     
   WHERE sup.vendor_type_lookup_code = 'AAEMPLOYEE'   
     AND sup.vendor_name NOT LIKE 'Do Not Use%' 
     AND sup.vendor_id = sites.vendor_id
     AND sites.attribute1 IS NOT NULL
     ;
  lv_msg_count            NUMBER;
  lv_msg_data             VARCHAR2(4000);   
  lv_new_vendor_name      VARCHAR2(240);
  lv_return_status        VARCHAR2(1);     
  lv_vendor_rec      ap_vendor_pub_pkg.r_vendor_rec_type;  
  v_attribute1        VARCHAR2(100);
  v_last_updated_by   VARCHAR2(100);
  v_last_update_date  VARCHAR2(100);
  v_last_update_login VARCHAR2(100);
BEGIN
-- 
  dbms_output.put_line(' Disable all AA Employees');
  dbms_output.put_line(' ');
  dbms_output.put_line(' Supplier Number | Supplier Name | Disabled | Error reason ');
--             
  FOR rec_aaemp IN cur_aaemp 
  LOOP
--    
    lv_new_vendor_name := NULL; 
    lv_return_status   := NULL;
    lv_msg_count       := NULL; 
    lv_return_status   := NULL;   
--    
--  end date the vendor
    lv_vendor_rec.end_date_active:= SYSDATE;   
    lv_vendor_rec.vendor_id      := rec_aaemp.vendor_id;
--
    ap_vendor_pub_pkg.update_vendor ( p_api_version      => 1.0
                                    , p_init_msg_list    => fnd_api.g_true 
                                    , p_commit           => fnd_api.g_true
                                    , p_validation_level => fnd_api.g_valid_level_full
                                    , x_return_status    => lv_return_status
                                    , x_msg_count        => lv_msg_count
                                    , x_msg_data         => lv_msg_data
                                    , p_vendor_rec       => lv_vendor_rec
                                    , p_vendor_id        => rec_aaemp.vendor_id
                                    );    
--     
    IF (lv_return_status = fnd_api.g_ret_sts_success ) THEN 
      COMMIT;        
      dbms_output.put_line(rec_aaemp.segment1||' | '||rec_aaemp.vendor_name||' | '||'Y'||' | '||' ');
    ELSE 
      ROLLBACK; 
      dbms_output.put_line(rec_aaemp.segment1||' | '||rec_aaemp.vendor_name||' | '||'N'||' | '||lv_msg_data);
    END IF;    
-- Update attribute1 at site level 

DBMS_OUTPUT.PUT_LINE('Before Update Values for Vendor Site ID : '||rec_aaemp.vendor_site_id);
DBMS_OUTPUT.PUT_LINE('attribute1|last_updated_by|last_update_date|last_update_login');
   SELECT attribute1 
        , last_updated_by  
        , last_update_date  
        , last_update_login
     INTO v_attribute1 
        , v_last_updated_by  
        , v_last_update_date  
        , v_last_update_login
     FROM ap_supplier_sites_all
    WHERE vendor_site_id = rec_aaemp.vendor_site_id;

DBMS_OUTPUT.PUT_LINE(v_attribute1||'|'||v_last_updated_by||'|'||v_last_update_date||'|'||v_last_update_login);

   UPDATE ap_supplier_sites_all 
      SET attribute1 = NULL
        , last_updated_by   = 0 
        , last_update_date  = SYSDATE
        , last_update_login = -1 
    WHERE 1 = 1
      AND vendor_site_id = rec_aaemp.vendor_site_id;  
    
   COMMIT;
-- 
  END LOOP; 
--     
EXCEPTION 
  WHEN OTHERS THEN 
    ROLLBACK; 
    dbms_output.put_line('Encountered Unexpected Error => '||SQLERRM);
END DISABLE_AAEMP; 
                       
BEGIN  
  fnd_global.apps_initialize(0,50593,201);  -- Executing the script as SYSADMIN
  mo_global.init('S');
  mo_global.set_policy_context('S','126');  
  dbms_output.put_line ('Supplier Number(AAEMP) | WorkdayID | invoice_num | invoice amount | Cancelled Inoice? ' );
  FOR rec_emp_conv IN cur_emp_conv 
  LOOP 
    x_cancel_inv := NULL;
    INSERT INTO  XXRS.XXRS_AP_WKDY_EMP_EXPENSES( WORKDAY_EMP_EXP_REC_ID
                                               , WORKDAY_EMPLOYEE_ID
                                               , ORGANIZATION
                                               , EMPLOYEE_FIRST_NAME                                               
                                               , EMPLOYEE_LAST_NAME
                                               , EMPLOYEE_EMAIL
                                               , BANK_BRANCH_NUMBER
                                               , ACCOUNT_NUMBER
                                               , TOTAL_AMOUNT
                                               , CURRENCY
                                               , TRANSACTION_DATE
                                               , PROCESS_STATUS
                                               , ERROR_MESSAGE
                                               , CONC_REQUEST_ID
                                               , CREATION_DATE
                                               , CREATED_BY
                                               , LAST_UPDATE_LOGIN
                                               , LAST_UPDATE_DATE
                                               , LAST_UPDATED_BY
                                               )
                                       VALUES ( xxrs.xxrs_ap_wkdy_emp_exp_s.NEXTVAL
                                              , rec_emp_conv.wd_emp_id 
                                              , '200'
                                              , rec_emp_conv.first_name
                                              , rec_emp_conv.last_name
                                              , rec_emp_conv.remittance_email
                                              , rec_emp_conv.branch_number
                                              , rec_emp_conv.bank_account_num_electronic
                                              , rec_emp_conv.invoice_amount
                                              , rec_emp_conv.currency_code
                                              , rec_emp_conv.invoice_date                                              
                                              , 'P'
                                              , NULL
                                              , -1
                                              , SYSDATE
                                              , 0
                                              , -1
                                              , SYSDATE
                                              , 0
                                       );
     COMMIT;                                                                            
     x_cancel_inv := cancel_invoice(rec_emp_conv.INVOICE_ID);                                                
     IF x_cancel_inv
     THEN      
        dbms_output.put_line (rec_emp_conv.segment1||' | '||rec_emp_conv.wd_emp_id||' | '||rec_emp_conv.invoice_num||' | '||rec_emp_conv.invoice_amount||' | '||'Y' );
        COMMIT;
     ELSE
        dbms_output.put_line (rec_emp_conv.segment1||' | '||rec_emp_conv.wd_emp_id||' | '||rec_emp_conv.invoice_num||' | '||rec_emp_conv.invoice_amount||' | '||'N' );
        ROLLBACK;
     END IF;  
--
   END LOOP;                      
--
-- Now call disable aaemp to disable all employees
--
   DISABLE_AAEMP;
--

 END;
/