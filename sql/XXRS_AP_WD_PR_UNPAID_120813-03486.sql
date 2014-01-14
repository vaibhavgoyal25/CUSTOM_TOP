/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_AP_WD_PR_UNPAID_120813-03486.sql                                                                       *
*                                                                                                                     *
* DESCRIPTION : Script to cancel unpaid suppliersinvoices because of orphan Banks and reprocess them.                 *
*                                                                                                                     *
* AUTHOR       : Vaibhav Goyal                                                                                        *
* DATE WRITTEN : 08/13/2012                                                                                           *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* Version#  | Ticket #      | WHO             |  DATE          |   REMARKS                                            *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0     | 120813-03486  | Vaibhav Goyal   | 08/13/2012     | Initial Creation                                     *
**********************************************************************************************************************/
/* $Header: XXRS_AP_WD_PR_UNPAID_120813-03486.sql 1.0.0 08/13/2012 15:00:00 Vaibhav Goyal$ */
SET SERVEROUTPUT ON SIZE 1000000;
DECLARE     
CURSOR cur_emp_conv 
IS  
SELECT sites.attribute1 wd_emp_id
     , TRIM(SUBSTR(sup.vendor_name, 0, INSTR(sup.vendor_name, ',')-1)) last_name
     , TRIM(SUBSTR(sup.vendor_name, INSTR(sup.vendor_name, ',')+1,LENGTH(vendor_name) )) first_name
     --, branch_number 
     --, bank_account_num_electronic  
     , iebbv.branch_number
     , iea.BANK_ACCOUNT_NUM  bank_account_num_electronic
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
     , apps.IBY_EFFECTED_ACCTS_11810646 iea/* apps.iby_ext_bank_accounts_v ieba*/
     , apps.IBY_EXT_BANK_BRANCHES_V iebbv
 WHERE sup.vendor_type_lookup_code = 'VENDOR'
   AND aia.vendor_id = sup.vendor_id 
   and sup.vendor_id = sites.vendor_id  
   AND aia.external_bank_account_id = iea.ext_bank_account_id 
   AND aia.creation_date >=  TO_DATE('04/23/2012', 'MM/DD/YYYY') 
   AND sites.attribute1 IS NOT NULL 
   AND aia.invoice_amount > 0 
   AND aia.org_id = 126
   AND iebbv.branch_party_id (+) = iea.branch_id 
  --AND sites.attribute1 = 'I01688'
   AND NOT EXISTS (SELECT 'X'
                     FROM ap.ap_payment_schedules_all ps 
                    WHERE ps.invoice_id = aia.invoice_id
                      AND amount_remaining = 0
                      AND ORG_ID = sites.org_id);
--                      
  x_cancel_inv BOOLEAN := NULL;

   v_BANK_BRANCH_NUMBER      VARCHAR2(100);
   v_ACCOUNT_NUMBER          VARCHAR2(100);
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

                       
BEGIN  
  fnd_global.apps_initialize(0,50593,201);  -- Executing the script as SYSADMIN
  mo_global.init('S');
  mo_global.set_policy_context('S','126');  
  dbms_output.put_line ('Supplier Number | WorkdayID | invoice_num | invoice amount | Cancelled Invoice ' );
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
--

BEGIN

BEGIN
DBMS_OUTPUT.PUT(CHR(10));
DBMS_OUTPUT.PUT_LINE('Before Update For Workday Emp ID : '||'I01688');
 SELECT DISTINCT BANK_BRANCH_NUMBER 
      , ACCOUNT_NUMBER 
   into v_BANK_BRANCH_NUMBER,v_ACCOUNT_NUMBER
   from XXRS.XXRS_AP_WKDY_EMP_EXPENSES
  where workday_employee_id = 'I01688'
    and UPPER(EMPLOYEE_FIRST_NAME) = 'RUSSELL';

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    dbms_output.put_line ('No Data Found For Workday Emp ID I01688' );
  WHEN OTHERS THEN
    dbms_output.put_line ('Error While finding Bank Details For Workday Emp ID I01688' );
  
END;

DBMS_OUTPUT.PUT_LINE('BANK_BRANCH_NUMBER|v_ACCOUNT_NUMBER');
DBMS_OUTPUT.PUT_LINE(v_BANK_BRANCH_NUMBER||'|'||v_ACCOUNT_NUMBER);
v_BANK_BRANCH_NUMBER := NULL;
v_ACCOUNT_NUMBER := NULL;

UPDATE XXRS.XXRS_AP_WKDY_EMP_EXPENSES
   SET BANK_BRANCH_NUMBER = '090128'
     , ACCOUNT_NUMBER     = '26102743'
  where workday_employee_id = 'I01688'
    and UPPER(EMPLOYEE_FIRST_NAME) = 'RUSSELL';

BEGIN
DBMS_OUTPUT.PUT_LINE('After Update For Workday Emp ID : '||'I01688');
 SELECT DISTINCT BANK_BRANCH_NUMBER 
      , ACCOUNT_NUMBER     
   into v_BANK_BRANCH_NUMBER,v_ACCOUNT_NUMBER
   from XXRS.XXRS_AP_WKDY_EMP_EXPENSES
  where workday_employee_id = 'I01688'
    and UPPER(EMPLOYEE_FIRST_NAME) = 'RUSSELL';
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    dbms_output.put_line ('No Data Found For Workday Emp ID I01688' );
  WHEN OTHERS THEN
    dbms_output.put_line ('Error While finding Bank Details For Workday Emp ID I01688' );
  
END;


DBMS_OUTPUT.PUT_LINE('BANK_BRANCH_NUMBER|v_ACCOUNT_NUMBER');
DBMS_OUTPUT.PUT_LINE(v_BANK_BRANCH_NUMBER||'|'||v_ACCOUNT_NUMBER);
v_BANK_BRANCH_NUMBER := NULL;
v_ACCOUNT_NUMBER := NULL;

EXCEPTION
  WHEN OTHERS THEN
        dbms_output.put_line ('Error While Updating Workday Record For workday_employee_id = I01688' );
END;    

BEGIN

BEGIN
DBMS_OUTPUT.PUT(CHR(10));
DBMS_OUTPUT.PUT_LINE('Before Update For Workday Emp ID : '||'13899');

 SELECT DISTINCT BANK_BRANCH_NUMBER 
      , ACCOUNT_NUMBER     
   into v_BANK_BRANCH_NUMBER,v_ACCOUNT_NUMBER
   from XXRS.XXRS_AP_WKDY_EMP_EXPENSES
  where workday_employee_id = '13899'
    and UPPER(EMPLOYEE_FIRST_NAME) = 'VIKKI';

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    dbms_output.put_line ('No Data Found For Workday Emp ID 13899' );
  WHEN OTHERS THEN
    dbms_output.put_line ('Error While finding Bank Details For Workday Emp ID 13899' );
  
END;

DBMS_OUTPUT.PUT_LINE('BANK_BRANCH_NUMBER|v_ACCOUNT_NUMBER');
DBMS_OUTPUT.PUT_LINE(v_BANK_BRANCH_NUMBER||'|'||v_ACCOUNT_NUMBER);
v_BANK_BRANCH_NUMBER := NULL;
v_ACCOUNT_NUMBER := NULL;

UPDATE XXRS.XXRS_AP_WKDY_EMP_EXPENSES
   SET BANK_BRANCH_NUMBER = '203590'
     , ACCOUNT_NUMBER     = '70683434'
  where workday_employee_id = '13899'
    and UPPER(EMPLOYEE_FIRST_NAME) = 'VIKKI';

BEGIN
DBMS_OUTPUT.PUT_LINE('After Update For Workday Emp ID : '||'13899');
 SELECT DISTINCT BANK_BRANCH_NUMBER 
      , ACCOUNT_NUMBER     
   into v_BANK_BRANCH_NUMBER,v_ACCOUNT_NUMBER
   from XXRS.XXRS_AP_WKDY_EMP_EXPENSES
  where workday_employee_id = '13899'
    and UPPER(EMPLOYEE_FIRST_NAME) = 'VIKKI';


EXCEPTION
  WHEN NO_DATA_FOUND THEN
    dbms_output.put_line ('No Data Found For Workday Emp ID 13899' );
  WHEN OTHERS THEN
    dbms_output.put_line ('Error While finding Bank Details For Workday Emp ID 13899' );
  
END;

DBMS_OUTPUT.PUT_LINE('BANK_BRANCH_NUMBER|v_ACCOUNT_NUMBER');
DBMS_OUTPUT.PUT_LINE(v_BANK_BRANCH_NUMBER||'|'||v_ACCOUNT_NUMBER);
v_BANK_BRANCH_NUMBER := NULL;
v_ACCOUNT_NUMBER := NULL;
 
EXCEPTION
  WHEN OTHERS THEN
        dbms_output.put_line ('Error While Updating Workday Record For workday_employee_id = 13899' );
END; 

BEGIN   

BEGIN
DBMS_OUTPUT.PUT(CHR(10));
DBMS_OUTPUT.PUT_LINE('Before Update For Workday Emp ID : '||'E00484');
 SELECT DISTINCT BANK_BRANCH_NUMBER 
      , ACCOUNT_NUMBER     
   into v_BANK_BRANCH_NUMBER,v_ACCOUNT_NUMBER
   from XXRS.XXRS_AP_WKDY_EMP_EXPENSES
  where workday_employee_id = 'E00484'
    and UPPER(EMPLOYEE_FIRST_NAME) = 'CHARLES';

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    dbms_output.put_line ('No Data Found For Workday Emp ID E00484' );
  WHEN OTHERS THEN
    dbms_output.put_line ('Error While finding Bank Details For Workday Emp ID E00484' );
  
END;

DBMS_OUTPUT.PUT_LINE('BANK_BRANCH_NUMBER|v_ACCOUNT_NUMBER');
DBMS_OUTPUT.PUT_LINE(v_BANK_BRANCH_NUMBER||'|'||v_ACCOUNT_NUMBER);
v_BANK_BRANCH_NUMBER := NULL;
v_ACCOUNT_NUMBER := NULL;

UPDATE XXRS.XXRS_AP_WKDY_EMP_EXPENSES
   SET BANK_BRANCH_NUMBER = '403545'
     , ACCOUNT_NUMBER     = '81482653'
  where workday_employee_id = 'E00484'
    and UPPER(EMPLOYEE_FIRST_NAME) = 'CHARLES'; 

BEGIN
DBMS_OUTPUT.PUT_LINE('After Update For Workday Emp ID : '||'E00484');
 SELECT DISTINCT BANK_BRANCH_NUMBER 
      , ACCOUNT_NUMBER     
   into v_BANK_BRANCH_NUMBER,v_ACCOUNT_NUMBER
   from XXRS.XXRS_AP_WKDY_EMP_EXPENSES
  where workday_employee_id = 'E00484'
    and UPPER(EMPLOYEE_FIRST_NAME) = 'CHARLES';

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    dbms_output.put_line ('No Data Found For Workday Emp ID E00484' );
  WHEN OTHERS THEN
    dbms_output.put_line ('Error While finding Bank Details For Workday Emp ID E00484' );
  
END;


DBMS_OUTPUT.PUT_LINE('BANK_BRANCH_NUMBER|v_ACCOUNT_NUMBER');
DBMS_OUTPUT.PUT_LINE(v_BANK_BRANCH_NUMBER||'|'||v_ACCOUNT_NUMBER);
v_BANK_BRANCH_NUMBER := NULL;
v_ACCOUNT_NUMBER := NULL;
  
EXCEPTION
  WHEN OTHERS THEN
        dbms_output.put_line ('Error While Updating Workday Record For workday_employee_id = E00484' );
END;

BEGIN  

BEGIN
DBMS_OUTPUT.PUT(CHR(10));
DBMS_OUTPUT.PUT_LINE('Before Update For Workday Emp ID : '||'14202');
 SELECT DISTINCT BANK_BRANCH_NUMBER 
      , ACCOUNT_NUMBER     
   into v_BANK_BRANCH_NUMBER,v_ACCOUNT_NUMBER
   from XXRS.XXRS_AP_WKDY_EMP_EXPENSES
  where workday_employee_id = '14202'
    and UPPER(EMPLOYEE_FIRST_NAME) = 'VLADIMIR';
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    dbms_output.put_line ('No Data Found For Workday Emp ID 14202' );
  WHEN OTHERS THEN
    dbms_output.put_line ('Error While finding Bank Details For Workday Emp ID 14202' );
  
END;


DBMS_OUTPUT.PUT_LINE('BANK_BRANCH_NUMBER|v_ACCOUNT_NUMBER');
DBMS_OUTPUT.PUT_LINE(v_BANK_BRANCH_NUMBER||'|'||v_ACCOUNT_NUMBER);
v_BANK_BRANCH_NUMBER := NULL;
v_ACCOUNT_NUMBER := NULL;

UPDATE XXRS.XXRS_AP_WKDY_EMP_EXPENSES
   SET BANK_BRANCH_NUMBER = '110001'
     , ACCOUNT_NUMBER     = '10555532'
  where workday_employee_id = '14202'
    and UPPER(EMPLOYEE_FIRST_NAME) = 'VLADIMIR'; 

BEGIN
DBMS_OUTPUT.PUT_LINE('After Update For Workday Emp ID : '||'14202');
 SELECT DISTINCT BANK_BRANCH_NUMBER 
      , ACCOUNT_NUMBER     
   into v_BANK_BRANCH_NUMBER,v_ACCOUNT_NUMBER
   from XXRS.XXRS_AP_WKDY_EMP_EXPENSES
  where workday_employee_id = '14202'
    and UPPER(EMPLOYEE_FIRST_NAME) = 'VLADIMIR';
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    dbms_output.put_line ('No Data Found For Workday Emp ID 14202' );
  WHEN OTHERS THEN
    dbms_output.put_line ('Error While finding Bank Details For Workday Emp ID 14202' );
  
END;

DBMS_OUTPUT.PUT_LINE('BANK_BRANCH_NUMBER|v_ACCOUNT_NUMBER');
DBMS_OUTPUT.PUT_LINE(v_BANK_BRANCH_NUMBER||'|'||v_ACCOUNT_NUMBER);
v_BANK_BRANCH_NUMBER := NULL;
v_ACCOUNT_NUMBER := NULL;
 
EXCEPTION
  WHEN OTHERS THEN
        dbms_output.put_line ('Error While Updating Workday Record For workday_employee_id = 14202' );
END;

BEGIN 

BEGIN
DBMS_OUTPUT.PUT(CHR(10));
DBMS_OUTPUT.PUT_LINE('Before Update For Workday Emp ID : '||'14472');
 SELECT DISTINCT BANK_BRANCH_NUMBER 
      , ACCOUNT_NUMBER     
   into v_BANK_BRANCH_NUMBER,v_ACCOUNT_NUMBER
   from XXRS.XXRS_AP_WKDY_EMP_EXPENSES
  where workday_employee_id =  '14472'
    and UPPER(EMPLOYEE_FIRST_NAME) = 'EMMA';

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    dbms_output.put_line ('No Data Found For Workday Emp ID 14472' );
  WHEN OTHERS THEN
    dbms_output.put_line ('Error While finding Bank Details For Workday Emp ID 14472' );
  
END;

DBMS_OUTPUT.PUT_LINE('BANK_BRANCH_NUMBER|v_ACCOUNT_NUMBER');
DBMS_OUTPUT.PUT_LINE(v_BANK_BRANCH_NUMBER||'|'||v_ACCOUNT_NUMBER);
v_BANK_BRANCH_NUMBER := NULL;
v_ACCOUNT_NUMBER := NULL;
  
UPDATE XXRS.XXRS_AP_WKDY_EMP_EXPENSES
   SET EMPLOYEE_LAST_NAME = 'STONE'
  where workday_employee_id = '14472'
    and UPPER(EMPLOYEE_FIRST_NAME) = 'EMMA';

BEGIN
DBMS_OUTPUT.PUT_LINE('After Update For Workday Emp ID : '||'14472');
 SELECT DISTINCT BANK_BRANCH_NUMBER 
      , ACCOUNT_NUMBER     
   into v_BANK_BRANCH_NUMBER,v_ACCOUNT_NUMBER
   from XXRS.XXRS_AP_WKDY_EMP_EXPENSES
  where workday_employee_id =  '14472'
    and UPPER(EMPLOYEE_FIRST_NAME) = 'EMMA';
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    dbms_output.put_line ('No Data Found For Workday Emp ID 14472' );
  WHEN OTHERS THEN
    dbms_output.put_line ('Error While finding Bank Details For Workday Emp ID 14472' );
  
END;
DBMS_OUTPUT.PUT_LINE('BANK_BRANCH_NUMBER|v_ACCOUNT_NUMBER');
DBMS_OUTPUT.PUT_LINE(v_BANK_BRANCH_NUMBER||'|'||v_ACCOUNT_NUMBER);
v_BANK_BRANCH_NUMBER := NULL;
v_ACCOUNT_NUMBER := NULL;

EXCEPTION
  WHEN OTHERS THEN
        dbms_output.put_line ('Error While Updating Workday Record' );
END;
COMMIT;

 END;
/
