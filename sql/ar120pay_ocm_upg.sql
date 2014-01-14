REM +=====================================================================+
REM |                Copyright (c) 1999 Oracle Corporation                |
REM |                   Redwood Shores, California, USA                   |
REM |                        All rights reserved.                         |
REM +=====================================================================+
REM |  Name                                                               |
REM |    ar120pay.sql                                                     |
REM |                                                                     |
REM |  Description                                                        |
REM |  Script to populate column payment_trxn_extension_id  in            |
REM |  table ar_cash_receipts_all table.                                  |
REM |                                                                     |
REM |  Notes                                                              |
REM |                                                                     |
REM |  History                                                            |
REM |   30-AUG-2005      Ramakant Alat    Created for 12.0 Upgrade.       |
REM |   31-MAR-2006      GyanaJyothiG     Modified to nullify the customer
REM |                                     Bank Details for CM. Bug4931161  
REM |   04-Aug-2006      Surendra Rajan   Bug 5438415: Added full set of  |
REM |                                     hints to avoid statistics gather| 
REM |                                     -ing for the new tables.        |
REM +=====================================================================+
REM
REM *********************************************************************
REM :__SCM_FILE_METADATA__:<METADATA >
REM :__SCM_FILE_METADATA__: <DEPENDENCIES >
REM :__SCM_FILE_METADATA__:  <DEPENDENCY PRODUCT_FAMILY="FINANCIALS" >
REM :__SCM_FILE_METADATA__:   <MODIFIES TYPE="UPG" >
REM :__SCM_FILE_METADATA__:    <MODIFY NAME="AR_EXT_BNK_CC" />
REM :__SCM_FILE_METADATA__:   </MODIFIES>
REM :__SCM_FILE_METADATA__:  </DEPENDENCY>
REM :__SCM_FILE_METADATA__: </DEPENDENCIES>
REM :__SCM_FILE_METADATA__:</METADATA>
REM *********************************************************************
REM $Header: ar120pay.sql 120.8.12010000.2 2012/03/07 09:37:24 bcyadav ship $
REM dbdrv: sql ~PROD ~PATH ~FILE none none none sqlplus_repeat &phase=upg+78 \
REM dbdrv: checkfile(120.8.12000000.2=120.8.12010000.2):~PROD:~PATH:~FILE &un_ar &batchsize


SET VERIFY OFF;
WHENEVER SQLERROR EXIT FAILURE ROLLBACK;
WHENEVER OSERROR EXIT FAILURE ROLLBACK;
DECLARE

 
  l_rows_processed            NUMBER:= 0;
  l_user_id                   NUMBER;

------------------------------------------------------
-- Types
------------------------------------------------------
  TYPE  Num15Tab   IS TABLE OF NUMBER(15) INDEX BY BINARY_INTEGER;
  TYPE  Char1Tab   IS TABLE OF VARCHAR2(1) INDEX BY BINARY_INTEGER;
  TYPE  Char100Tab IS TABLE OF VARCHAR2(100) INDEX BY BINARY_INTEGER;
  TYPE  Char150Tab IS TABLE OF VARCHAR2(150) INDEX BY BINARY_INTEGER;
  TYPE  Char255Tab IS TABLE OF VARCHAR2(255) INDEX BY BINARY_INTEGER;
  TYPE  RowIDTab   IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
-----------------------------------------------------
-- Processing variables
-----------------------------------------------------

  c_ba_trxn_id               Num15Tab; -- modified to rowid values
  c_bank_account_id          Num15Tab;
  c_order_id                 Char100Tab;
  c_po_number                Char100Tab;
  c_trxn_ref1                Char100Tab;
  c_trxn_ref2                Char100Tab;
  c_customer_id              Num15Tab;
  c_cust_account_id          Num15Tab;
  c_cust_site_use_id         Num15Tab;
  c_org_id                   Num15Tab;
  c_additional_info          Char255Tab;
  c_trxn_entity_id           Num15Tab;
  c_instr_assignment_id      Num15Tab;
  c_pay_channel_code         Char100Tab;
  c_ext_payer_id             Num15Tab;
  c_tangible_id              Char100Tab;
  c_ba_trxn_id2              RowIDTab;
------------------------------------------------------
-- Local variables 
------------------------------------------------------
  l_debug_flag               VARCHAR2(1) := 'N';
--------------------------------------
-- Main cursor for receipt header
--------------------------------------  

CURSOR c01 IS
    select 
       temp.ba_trxn_id,
       temp.bank_account_id,
       temp.order_id,
       temp.po_number,
       temp.trxn_ref1,
       temp.trxn_ref2,
       temp.cust_account_id,
       temp.cust_site_use_id,
       temp.org_id,
       null additional_info,
       iby_fndcpt_tx_extensions_s.NEXTVAL trxn_entity_id,
       DECODE(temp.creation_method_code, 'AUTOMATIC', arrm.payment_channel_code, 'BILLS_RECEIVABLE'),
       temp.tangible_id
    from 
    temp_13735383 temp,
    ar_receipt_methods arrm
    where arrm.receipt_method_id = temp.receipt_method_id
    and decode(temp.creation_method_code, 'AUTOMATIC', arrm.payment_channel_code, 'BILLS_RECEIVABLE') IS NOT NULL;

PROCEDURE debug (p_text IN VARCHAR2) AS
BEGIN
--  dbms_output.put_line(p_text);
   null;
END debug;

BEGIN

  l_user_id := NVL(fnd_global.user_id, -1);

 
    l_rows_processed := 0;
    c_trxn_entity_id.DELETE;
    c_ba_trxn_id.DELETE;
    c_ba_trxn_id2.DELETE;

    -- Fetch the transactions
    OPEN c01 ;

    IF l_debug_flag = 'Y' THEN
       debug( 'after open.....');
    END IF;
    

    FETCH c01 BULK COLLECT INTO
       c_ba_trxn_id, 
       c_bank_account_id, 
       c_order_id, 
       c_po_number,
       c_trxn_ref1, 
       c_trxn_ref2, 
       c_cust_account_id,
       c_cust_site_use_id, 
       c_org_id, 
       c_additional_info, 
       c_trxn_entity_id, 
       c_pay_channel_code,
       c_tangible_id;
    
    IF l_debug_flag = 'Y' THEN
       debug( 'after fetch.....[' || SQL%ROWCOUNT || ']');
    END IF;

    -- insert the transactions into IBY transaction extension table
    FORALL i IN  c_ba_trxn_id.FIRST..c_ba_trxn_id.LAST
    INSERT INTO  IBY_FNDCPT_TX_EXTENSIONS
       (TRXN_EXTENSION_ID,
        PAYMENT_CHANNEL_CODE,
        ORDER_ID,
        PO_NUMBER,
        TRXN_REF_NUMBER1,
        TRXN_REF_NUMBER2,
        ADDITIONAL_INFO,
        CREATED_BY,
        CREATION_DATE,
        LAST_UPDATED_BY,
        LAST_UPDATE_DATE,
        LAST_UPDATE_LOGIN,
        OBJECT_VERSION_NUMBER,
        encrypted,
        origin_application_id,
        tangibleid)
    VALUES 
       (
        iby_fndcpt_tx_extensions_s.NEXTVAL, 
        c_pay_channel_code(i),
        c_order_id(i),
        c_po_number(i),
        c_trxn_ref1(i),
        c_trxn_ref2(i),        
        c_additional_info(i),
        l_user_id,
        sysdate,
        l_user_id,
        sysdate,
        l_user_id,
        1,
        'N',     --- 
        222,     --- Receivables
        c_tangible_id(i)
        )
        RETURNING 
           TRXN_EXTENSION_ID 
        BULK COLLECT INTO c_trxn_entity_id;
        

    IF l_debug_flag = 'Y' THEN
       debug( 'After insert.....[' || SQL%ROWCOUNT || ']');
    END IF;
 -- update the foreign key relationship 
  
    FORALL i in c_ba_trxn_id.FIRST..c_ba_trxn_id.LAST
    UPDATE ra_customer_trx_all
    SET    payment_trxn_extension_id = c_trxn_entity_id(i),
           paying_customer_id = c_cust_account_id(i),
           paying_site_use_id = c_cust_site_use_id(i),
           customer_bank_account_id = null
    WHERE  customer_trx_id  = c_ba_trxn_id(i);

    l_rows_processed := SQL%ROWCOUNT;

    
    IF l_debug_flag = 'Y' THEN
       debug( 'After update.....[' ||l_rows_processed ||']' );
    END IF;

    CLOSE c01;


EXCEPTION
WHEN OTHERS THEN 
   RAISE;

END;
/
commit;
