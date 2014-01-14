/**************************************************************************************************************
* NAME : XXRS_AR_CB_PO_NUM_FIX_131105-10593.sql                                                              *
*                                                                                                             *
* DESCRIPTION :                                                                                               *
*   Script to recreate invoices with po number                                                                *
*                                                                                                             *
* AUTHOR       : Pavan Amirineni                                                                              *
* DATE WRITTEN : 06-NOV-2013                                                                                  *
*                                                                                                             *
* CHANGE CONTROL :                                                                                            *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                             *
*-------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  131105-10593     | Pavan Amirineni |  06-NOV-2013   | Initial Creation.                     *
***************************************************************************************************************/
--
/* $Header: XXRS_AR_CB_PO_NUM_FIX_131105-10593.sql 1.0.0 11/06/2013 10:46:24 AM Pavan Amirineni $ */
--
SET SERVEROUTPUT ON SIZE 1000000
SET LINES 1000
SET PAGESIZE 1000
SET COLSEP '|'
COL file_name NEW_VALUE spool_file_name NOPRINT
SELECT 'XXRS_AR_CB_PO_NUM_FIX_131105-10593_'||TO_CHAR(SYSDATE,'YYYYMMDDHHMISS')||'.log' file_name
FROM DUAL;

SPOOL &spool_file_name   

PROMPT "RILA Table Count"
SELECT COUNT(*) 
  FROM AR.RA_INTERFACE_LINES_ALL; 

PROMPT "Inserting data into RILA Table"

INSERT INTO AR.RA_INTERFACE_LINES_ALL
SELECT INTERFACE_LINE_ID,
       INTERFACE_LINE_CONTEXT,
       INTERFACE_LINE_ATTRIBUTE1,
       INTERFACE_LINE_ATTRIBUTE2,                    
       CASE WHEN DESCRIPTION = 'CLOUD ACCOUNT'
       THEN 
         (SELECT NVL (( SELECT cpo.po_number
                          FROM xxrs.xxrs_sc_cloud_account_po cpo 
                         WHERE 1 = 1
                           AND TRIM(cpo.cloud_account_number) = TRIM(SUBSTR(rila.attribute7, INSTR(rila.attribute7,':', 1, 1)+1,INSTR(rila.attribute7,':',1,2)-INSTR(rila.attribute7,':',1,1)-5))
                           AND cpo.rackspace_account_number = rila.interface_line_attribute1
                      )
                     , rila.interface_line_attribute3)
                FROM DUAL
          ) 
       ELSE 
         rila.interface_line_attribute3
       END interface_line_attribute3,
       INTERFACE_LINE_ATTRIBUTE4,
       INTERFACE_LINE_ATTRIBUTE5,
       INTERFACE_LINE_ATTRIBUTE6,
       INTERFACE_LINE_ATTRIBUTE7,
       INTERFACE_LINE_ATTRIBUTE8,
       BATCH_SOURCE_NAME,
       SET_OF_BOOKS_ID,
       LINE_TYPE,
       DESCRIPTION,
       CURRENCY_CODE,
       AMOUNT,
       CUST_TRX_TYPE_NAME,
       CUST_TRX_TYPE_ID,
       TERM_NAME,
       TERM_ID,
       ORIG_SYSTEM_BATCH_NAME,
       ORIG_SYSTEM_BILL_CUSTOMER_REF,
       ORIG_SYSTEM_BILL_CUSTOMER_ID,
       ORIG_SYSTEM_BILL_ADDRESS_REF,
       ORIG_SYSTEM_BILL_ADDRESS_ID,
       ORIG_SYSTEM_BILL_CONTACT_REF,
       ORIG_SYSTEM_BILL_CONTACT_ID,
       ORIG_SYSTEM_SHIP_CUSTOMER_REF,
       ORIG_SYSTEM_SHIP_CUSTOMER_ID,
       ORIG_SYSTEM_SHIP_ADDRESS_REF,
       ORIG_SYSTEM_SHIP_ADDRESS_ID,
       ORIG_SYSTEM_SHIP_CONTACT_REF,
       ORIG_SYSTEM_SHIP_CONTACT_ID,
       ORIG_SYSTEM_SOLD_CUSTOMER_REF,
       ORIG_SYSTEM_SOLD_CUSTOMER_ID,
       LINK_TO_LINE_ID,
       LINK_TO_LINE_CONTEXT,
       LINK_TO_LINE_ATTRIBUTE1,
       LINK_TO_LINE_ATTRIBUTE2,
       LINK_TO_LINE_ATTRIBUTE3,
       LINK_TO_LINE_ATTRIBUTE4,
       LINK_TO_LINE_ATTRIBUTE5,
       LINK_TO_LINE_ATTRIBUTE6,
       LINK_TO_LINE_ATTRIBUTE7,
       RECEIPT_METHOD_NAME,
       RECEIPT_METHOD_ID,
       CONVERSION_TYPE,
       CONVERSION_DATE,
       CONVERSION_RATE,
       CUSTOMER_TRX_ID,
       TRX_DATE,
       GL_DATE,
       DOCUMENT_NUMBER,
       TRX_NUMBER,
       LINE_NUMBER,
       QUANTITY,
       QUANTITY_ORDERED,
       UNIT_SELLING_PRICE,
       UNIT_STANDARD_PRICE,
       PRINTING_OPTION,
       INTERFACE_STATUS,
       REQUEST_ID,
       RELATED_BATCH_SOURCE_NAME,
       RELATED_TRX_NUMBER,
       RELATED_CUSTOMER_TRX_ID,
       PREVIOUS_CUSTOMER_TRX_ID,
       CREDIT_METHOD_FOR_ACCT_RULE,
       CREDIT_METHOD_FOR_INSTALLMENTS,
       REASON_CODE,
       TAX_RATE,
       TAX_CODE,
       TAX_PRECEDENCE,
       EXCEPTION_ID,
       EXEMPTION_ID,
       SHIP_DATE_ACTUAL,
       FOB_POINT,
       SHIP_VIA,
       WAYBILL_NUMBER,
       INVOICING_RULE_NAME,
       INVOICING_RULE_ID,
       ACCOUNTING_RULE_NAME,
       ACCOUNTING_RULE_ID,
       ACCOUNTING_RULE_DURATION,
       RULE_START_DATE,
       PRIMARY_SALESREP_NUMBER,
       PRIMARY_SALESREP_ID,
       SALES_ORDER,
       SALES_ORDER_LINE,
       SALES_ORDER_DATE,
       SALES_ORDER_SOURCE,
       SALES_ORDER_REVISION,
       CASE WHEN DESCRIPTION = 'CLOUD ACCOUNT'
       THEN 
         (SELECT NVL (( SELECT cpo.po_number
                          FROM xxrs.xxrs_sc_cloud_account_po cpo 
                         WHERE 1 = 1
                           AND TRIM(cpo.cloud_account_number) = TRIM(SUBSTR(rila.attribute7, INSTR(rila.attribute7,':', 1, 1)+1,INSTR(rila.attribute7,':',1,2)-INSTR(rila.attribute7,':',1,1)-5))
                           AND cpo.rackspace_account_number = rila.interface_line_attribute1),rila.purchase_order)
                           FROM DUAL
                       ) 
       ELSE 
         rila.purchase_order
       END PURCHASE_ORDER,              
       PURCHASE_ORDER_REVISION,
       PURCHASE_ORDER_DATE,
       AGREEMENT_NAME,
       AGREEMENT_ID,
       MEMO_LINE_NAME,
       MEMO_LINE_ID,
       INVENTORY_ITEM_ID,
       MTL_SYSTEM_ITEMS_SEG1,
       MTL_SYSTEM_ITEMS_SEG2,
       MTL_SYSTEM_ITEMS_SEG3,
       MTL_SYSTEM_ITEMS_SEG4,
       MTL_SYSTEM_ITEMS_SEG5,
       MTL_SYSTEM_ITEMS_SEG6,
       MTL_SYSTEM_ITEMS_SEG7,
       MTL_SYSTEM_ITEMS_SEG8,
       MTL_SYSTEM_ITEMS_SEG9,
       MTL_SYSTEM_ITEMS_SEG10,
       MTL_SYSTEM_ITEMS_SEG11,
       MTL_SYSTEM_ITEMS_SEG12,
       MTL_SYSTEM_ITEMS_SEG13,
       MTL_SYSTEM_ITEMS_SEG14,
       MTL_SYSTEM_ITEMS_SEG15,
       MTL_SYSTEM_ITEMS_SEG16,
       MTL_SYSTEM_ITEMS_SEG17,
       MTL_SYSTEM_ITEMS_SEG18,
       MTL_SYSTEM_ITEMS_SEG19,
       MTL_SYSTEM_ITEMS_SEG20,
       REFERENCE_LINE_ID,
       REFERENCE_LINE_CONTEXT,
       REFERENCE_LINE_ATTRIBUTE1,
       REFERENCE_LINE_ATTRIBUTE2,
       REFERENCE_LINE_ATTRIBUTE3,
       REFERENCE_LINE_ATTRIBUTE4,
       REFERENCE_LINE_ATTRIBUTE5,
       REFERENCE_LINE_ATTRIBUTE6,
       REFERENCE_LINE_ATTRIBUTE7,
       TERRITORY_ID,
       TERRITORY_SEGMENT1,
       TERRITORY_SEGMENT2,
       TERRITORY_SEGMENT3,
       TERRITORY_SEGMENT4,
       TERRITORY_SEGMENT5,
       TERRITORY_SEGMENT6,
       TERRITORY_SEGMENT7,
       TERRITORY_SEGMENT8,
       TERRITORY_SEGMENT9,
       TERRITORY_SEGMENT10,
       TERRITORY_SEGMENT11,
       TERRITORY_SEGMENT12,
       TERRITORY_SEGMENT13,
       TERRITORY_SEGMENT14,
       TERRITORY_SEGMENT15,
       TERRITORY_SEGMENT16,
       TERRITORY_SEGMENT17,
       TERRITORY_SEGMENT18,
       TERRITORY_SEGMENT19,
       TERRITORY_SEGMENT20,
       ATTRIBUTE_CATEGORY,
       ATTRIBUTE1,
       ATTRIBUTE2,
       ATTRIBUTE3,
       ATTRIBUTE4,
       ATTRIBUTE5,
       ATTRIBUTE6,
       ATTRIBUTE7,
       ATTRIBUTE8,
       ATTRIBUTE9,
       ATTRIBUTE10,
       ATTRIBUTE11,
       ATTRIBUTE12,
       ATTRIBUTE13,
       ATTRIBUTE14,
       ATTRIBUTE15,
       HEADER_ATTRIBUTE_CATEGORY,
       HEADER_ATTRIBUTE1,
       HEADER_ATTRIBUTE2,
       HEADER_ATTRIBUTE3,
       HEADER_ATTRIBUTE4,
       HEADER_ATTRIBUTE5,
       HEADER_ATTRIBUTE6,
       HEADER_ATTRIBUTE7,
       HEADER_ATTRIBUTE8,
       HEADER_ATTRIBUTE9,
       HEADER_ATTRIBUTE10,
       HEADER_ATTRIBUTE11,
       HEADER_ATTRIBUTE12,
       HEADER_ATTRIBUTE13,
       HEADER_ATTRIBUTE14,
       HEADER_ATTRIBUTE15,
       COMMENTS,
       INTERNAL_NOTES,
       INITIAL_CUSTOMER_TRX_ID,
       USSGL_TRANSACTION_CODE_CONTEXT,
       USSGL_TRANSACTION_CODE,
       ACCTD_AMOUNT,
       CUSTOMER_BANK_ACCOUNT_ID,
       CUSTOMER_BANK_ACCOUNT_NAME,
       UOM_CODE,
       UOM_NAME,
       DOCUMENT_NUMBER_SEQUENCE_ID,
       LINK_TO_LINE_ATTRIBUTE10,
       LINK_TO_LINE_ATTRIBUTE11,
       LINK_TO_LINE_ATTRIBUTE12,
       LINK_TO_LINE_ATTRIBUTE13,
       LINK_TO_LINE_ATTRIBUTE14,
       LINK_TO_LINE_ATTRIBUTE15,
              LINK_TO_LINE_ATTRIBUTE8,
              LINK_TO_LINE_ATTRIBUTE9,
              REFERENCE_LINE_ATTRIBUTE10,
              REFERENCE_LINE_ATTRIBUTE11,
              REFERENCE_LINE_ATTRIBUTE12,
              REFERENCE_LINE_ATTRIBUTE13,
              REFERENCE_LINE_ATTRIBUTE14,
              REFERENCE_LINE_ATTRIBUTE15,
              REFERENCE_LINE_ATTRIBUTE8,
              REFERENCE_LINE_ATTRIBUTE9,
              INTERFACE_LINE_ATTRIBUTE10,
              INTERFACE_LINE_ATTRIBUTE11,
              INTERFACE_LINE_ATTRIBUTE12,
                            - 1 INTERFACE_LINE_ATTRIBUTE13, -- Pass negative value for conc request id ,
              INTERFACE_LINE_ATTRIBUTE14,
              INTERFACE_LINE_ATTRIBUTE15,
              INTERFACE_LINE_ATTRIBUTE9,
              VAT_TAX_ID,
              REASON_CODE_MEANING,
              LAST_PERIOD_TO_CREDIT,
              PAYING_CUSTOMER_ID,
              PAYING_SITE_USE_ID,
              TAX_EXEMPT_FLAG,
              TAX_EXEMPT_REASON_CODE,
              TAX_EXEMPT_REASON_CODE_MEANING,
              TAX_EXEMPT_NUMBER,
              SALES_TAX_ID,
              CREATED_BY,
              CREATION_DATE,
              LAST_UPDATED_BY,
              LAST_UPDATE_DATE,
              LAST_UPDATE_LOGIN,
              LOCATION_SEGMENT_ID,
              MOVEMENT_ID,
              ORG_ID,
              AMOUNT_INCLUDES_TAX_FLAG,
              HEADER_GDF_ATTR_CATEGORY,
              HEADER_GDF_ATTRIBUTE1,
              HEADER_GDF_ATTRIBUTE2,
              HEADER_GDF_ATTRIBUTE3,
              HEADER_GDF_ATTRIBUTE4,
              HEADER_GDF_ATTRIBUTE5,
              HEADER_GDF_ATTRIBUTE6,
              HEADER_GDF_ATTRIBUTE7,
              HEADER_GDF_ATTRIBUTE8,
              HEADER_GDF_ATTRIBUTE9,
              HEADER_GDF_ATTRIBUTE10,
              HEADER_GDF_ATTRIBUTE11,
              HEADER_GDF_ATTRIBUTE12,
              HEADER_GDF_ATTRIBUTE13,
              HEADER_GDF_ATTRIBUTE14,
              HEADER_GDF_ATTRIBUTE15,
              HEADER_GDF_ATTRIBUTE16,
              HEADER_GDF_ATTRIBUTE17,
              HEADER_GDF_ATTRIBUTE18,
              HEADER_GDF_ATTRIBUTE19,
              HEADER_GDF_ATTRIBUTE20,
              HEADER_GDF_ATTRIBUTE21,
              HEADER_GDF_ATTRIBUTE22,
              HEADER_GDF_ATTRIBUTE23,
              HEADER_GDF_ATTRIBUTE24,
              HEADER_GDF_ATTRIBUTE25,
              HEADER_GDF_ATTRIBUTE26,
              HEADER_GDF_ATTRIBUTE27,
              HEADER_GDF_ATTRIBUTE28,
              HEADER_GDF_ATTRIBUTE29,
              HEADER_GDF_ATTRIBUTE30,
              LINE_GDF_ATTR_CATEGORY,
              LINE_GDF_ATTRIBUTE1,
              LINE_GDF_ATTRIBUTE2,
              LINE_GDF_ATTRIBUTE3,
              LINE_GDF_ATTRIBUTE4,
              LINE_GDF_ATTRIBUTE5,
              LINE_GDF_ATTRIBUTE6,
              LINE_GDF_ATTRIBUTE7,
              LINE_GDF_ATTRIBUTE8,
              LINE_GDF_ATTRIBUTE9,
              LINE_GDF_ATTRIBUTE10,
              LINE_GDF_ATTRIBUTE11,
              LINE_GDF_ATTRIBUTE12,
              LINE_GDF_ATTRIBUTE13,
              LINE_GDF_ATTRIBUTE14,
              LINE_GDF_ATTRIBUTE15,
              LINE_GDF_ATTRIBUTE16,
              LINE_GDF_ATTRIBUTE17,
              LINE_GDF_ATTRIBUTE18,
              LINE_GDF_ATTRIBUTE19,
              LINE_GDF_ATTRIBUTE20,
              RESET_TRX_DATE_FLAG,
              PAYMENT_SERVER_ORDER_NUM,
              APPROVAL_CODE,
              ADDRESS_VERIFICATION_CODE,
              WAREHOUSE_ID,
              TRANSLATED_DESCRIPTION,
              CONS_BILLING_NUMBER,
              PROMISED_COMMITMENT_AMOUNT,
              PAYMENT_SET_ID,
              ORIGINAL_GL_DATE,
              CONTRACT_LINE_ID,
              CONTRACT_ID,
              SOURCE_DATA_KEY1,
              SOURCE_DATA_KEY2,
              SOURCE_DATA_KEY3,
              SOURCE_DATA_KEY4,
              SOURCE_DATA_KEY5,
              INVOICED_LINE_ACCTG_LEVEL,
              OVERRIDE_AUTO_ACCOUNTING_FLAG,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL
   FROM xxrs.xxrs_sc_rila_arch_sc_data_tbl rila 
  WHERE 1 = 1
    AND INTERFACE_LINE_ATTRIBUTE6 = 'MONTHLY BILLING'
    AND trx_date =  TO_DATE('05-NOV-2013', 'DD-MON-YYYY')
    AND conc_req_id = 8521591
    AND rila.INTERFACE_LINE_ATTRIBUTE1 IN ('1549862',
                                           '1816790','1085359',
                                           '1087943','1087943',
                                           '1096085','1484472',
                                           '1484474','1498200',
                                           '1501707','1523322',
                                           '1530086','1543716',
                                           '1592410','823669',
                                           '823669','946112',
                                           '946112','848894',
                                           '27484','847277',
                                           '847277','847277',
                                           '575474','679297',
                                           '679297'
                                           )
    AND rila.interface_line_attribute4 = 'NOV-13'
    AND NOT EXISTS ( SELECT 'x'
                       FROM apps.ra_customer_trx_all rcta     
                          , apps.hz_cust_accounts hca     
                      WHERE 1 = 1       
                        AND rcta.bill_to_customer_id = hca.cust_account_id 
                        AND rcta.trx_date = TO_DATE('05-NOV-2013', 'DD-MON-YYYY')
                        AND rcta.purchase_order IS NOT NULL
                        AND rila.orig_system_bill_customer_id = hca.cust_account_id
                        AND rila.PURCHASE_ORDER = rcta.purchase_order
                        AND NOT EXISTS (SELECT 'X'
                                          FROM xxrs.xxrs_sc_cloud_account_po cpo    
                                         WHERE 1 = 1 
                                           AND cpo.rackspace_account_number = hca.account_number
                                           AND cpo.po_number = rcta.purchase_order
                                           AND rackspace_account_number IN ( SELECT  rackspace_account_number
                                                                               FROM xxrs.xxrs_sc_cloud_account_po cpo
                                                                              WHERE EXISTS (SELECT 'X'
                                                                                              FROM xxrs.xxrs_sc_usage_data_arch usd
                                                                                             WHERE billing_period = 'NOV-13'
                                                                                               AND customer_num = rackspace_account_number
                                                                                               AND trim(cpo.cloud_account_number)  = TRIM(SUBSTR(usd.ticket_num, INSTR(usd.ticket_num,':', 1, 1)+1,INSTR(usd.ticket_num,':',1,2)-INSTR(usd.ticket_num,':',1,1)-5))
                                                                                               AND data_type = 'CB'
                                                                                            )
                                                                               GROUP BY rackspace_account_number 
                                                                             )
                                      )
                         AND hca.account_number IN ('1549862','1816790',
                                                   '1085359','1087943',
                                                   '1087943','1096085',
                                                   '1484472','1484474',
                                                   '1498200','1501707',
                                                   '1523322','1530086',
                                                   '1543716','1592410',
                                                   '823669','823669',
                                                   '946112','946112',
                                                   '848894','27484',
                                                   '847277','847277',
                                                   '847277','575474',
                                                   '679297','679297'
                                                  )
                   ) 
    ORDER BY  rila.interface_line_attribute1,rila.interface_line_attribute2;   

PROMPT "RIDA Table Count"

SELECT COUNT(*) 
  FROM AR.RA_INTERFACE_DISTRIBUTIONS_ALL;  
  
-- RIDA DATA   
-- interface_attribute3 and purchase_order fields need to be populated where description = cloud accounts 
   INSERT INTO AR.RA_INTERFACE_DISTRIBUTIONS_ALL
          SELECT rida.INTERFACE_DISTRIBUTION_ID,
                 rida.INTERFACE_LINE_ID,
                 rida.INTERFACE_LINE_CONTEXT,
                 rida.INTERFACE_LINE_ATTRIBUTE1,
                 rida.INTERFACE_LINE_ATTRIBUTE2,
                 CASE WHEN DESCRIPTION = 'CLOUD ACCOUNT'
                 THEN 
                  (SELECT NVL (
                  ( SELECT cpo.po_number
                              FROM xxrs.xxrs_sc_cloud_account_po cpo 
                             WHERE 1 = 1
                               AND TRIM(cpo.cloud_account_number) = TRIM(SUBSTR(rila.attribute7, INSTR(rila.attribute7,':', 1, 1)+1,INSTR(rila.attribute7,':',1,2)-INSTR(rila.attribute7,':',1,1)-5))
                               AND cpo.rackspace_account_number = rila.interface_line_attribute1),rida.INTERFACE_LINE_ATTRIBUTE3)
                               FROM DUAL) 
                 ELSE 
                   rida.INTERFACE_LINE_ATTRIBUTE3
                 END interface_line_attribute3,                 
                 rida.INTERFACE_LINE_ATTRIBUTE4,
                 rida.INTERFACE_LINE_ATTRIBUTE5,
                 rida.INTERFACE_LINE_ATTRIBUTE6,
                 rida.INTERFACE_LINE_ATTRIBUTE7,
                 rida.INTERFACE_LINE_ATTRIBUTE8,
                 rida.ACCOUNT_CLASS,
                 rida.AMOUNT,
                 rida.PERCENT,
                 rida.INTERFACE_STATUS,
                 rida.REQUEST_ID,
                 rida.CODE_COMBINATION_ID,
                 rida.SEGMENT1,
                 rida.SEGMENT2,
                 rida.SEGMENT3,
                 rida.SEGMENT4,
                 rida.SEGMENT5,
                 rida.SEGMENT6,
                 rida.SEGMENT7,
                 rida.SEGMENT8,
                 rida.SEGMENT9,
                 rida.SEGMENT10,
                 rida.SEGMENT11,
                 rida.SEGMENT12,
                 rida.SEGMENT13,
                 rida.SEGMENT14,
                 rida.SEGMENT15,
                 rida.SEGMENT16,
                 rida.SEGMENT17,
                 rida.SEGMENT18,
                 rida.SEGMENT19,
                 rida.SEGMENT20,
                 rida.SEGMENT21,
                 rida.SEGMENT22,
                 rida.SEGMENT23,
                 rida.SEGMENT24,
                 rida.SEGMENT25,
                 rida.SEGMENT26,
                 rida.SEGMENT27,
                 rida.SEGMENT28,
                 rida.SEGMENT29,
                 rida.SEGMENT30,
                 rida.COMMENTS,
                 rida.ATTRIBUTE_CATEGORY,
                 rida.ATTRIBUTE1,
                 rida.ATTRIBUTE2,
                 rida.ATTRIBUTE3,
                 rida.ATTRIBUTE4,
                 rida.ATTRIBUTE5,
                 rida.ATTRIBUTE6,
                 rida.ATTRIBUTE7,
                 rida.ATTRIBUTE8,
                 rida.ATTRIBUTE9,
                 rida.ATTRIBUTE10,
                 rida.ATTRIBUTE11,
                 rida.ATTRIBUTE12,
                 rida.ATTRIBUTE13,
                 rida.ATTRIBUTE14,
                 rida.ATTRIBUTE15,
                 rida.ACCTD_AMOUNT,
                 rida.INTERFACE_LINE_ATTRIBUTE10,
                 rida.INTERFACE_LINE_ATTRIBUTE11,
                 rida.INTERFACE_LINE_ATTRIBUTE12,
                 - 1 INTERFACE_LINE_ATTRIBUTE13, -- Pass negative value for conc request id ,
                 rida.INTERFACE_LINE_ATTRIBUTE14,
                 rida.INTERFACE_LINE_ATTRIBUTE15,
                 rida.INTERFACE_LINE_ATTRIBUTE9,
                 rida.CREATED_BY,
                 rida.CREATION_DATE,
                 rida.LAST_UPDATED_BY,
                 rida.LAST_UPDATE_DATE,
                 rida.LAST_UPDATE_LOGIN,
                 rida.ORG_ID,
                 rida.INTERIM_TAX_CCID,
                 rida.INTERIM_TAX_SEGMENT1,
                 rida.INTERIM_TAX_SEGMENT2,
                 rida.INTERIM_TAX_SEGMENT3,
                 rida.INTERIM_TAX_SEGMENT4,
                 rida.INTERIM_TAX_SEGMENT5,
                 rida.INTERIM_TAX_SEGMENT6,
                 rida.INTERIM_TAX_SEGMENT7,
                 rida.INTERIM_TAX_SEGMENT8,
                 rida.INTERIM_TAX_SEGMENT9,
                 rida.INTERIM_TAX_SEGMENT10,
                 rida.INTERIM_TAX_SEGMENT11,
                 rida.INTERIM_TAX_SEGMENT12,
                 rida.INTERIM_TAX_SEGMENT13,
                 rida.INTERIM_TAX_SEGMENT14,
                 rida.INTERIM_TAX_SEGMENT15,
                 rida.INTERIM_TAX_SEGMENT16,
                 rida.INTERIM_TAX_SEGMENT17,
                 rida.INTERIM_TAX_SEGMENT18,
                 rida.INTERIM_TAX_SEGMENT19,
                 rida.INTERIM_TAX_SEGMENT20,
                 rida.INTERIM_TAX_SEGMENT21,
                 rida.INTERIM_TAX_SEGMENT22,
                 rida.INTERIM_TAX_SEGMENT23,
                 rida.INTERIM_TAX_SEGMENT24,
                 rida.INTERIM_TAX_SEGMENT25,
                 rida.INTERIM_TAX_SEGMENT26,
                 rida.INTERIM_TAX_SEGMENT27,
                 rida.INTERIM_TAX_SEGMENT28,
                 rida.INTERIM_TAX_SEGMENT29,
                 rida.INTERIM_TAX_SEGMENT30                      
       FROM xxrs.xxrs_sc_rila_arch_sc_data_tbl rila 
          , xxrs.xxrs_sc_rida_arch_sc_data_tbl rida
      WHERE 1 = 1
        AND rila.conc_req_id = rida.conc_req_id
        AND rila.interface_line_attribute1 = rida.interface_line_attribute1
        AND rila.interface_line_attribute2 = rida.interface_line_attribute2
        AND rila.interface_line_attribute3 = rida.interface_line_attribute3 
        AND rila.interface_line_attribute4 = rida.interface_line_attribute4
        AND rila.interface_line_attribute5 = rida.interface_line_attribute5
        AND rila.interface_line_attribute6 = rida.interface_line_attribute6
        AND rila.interface_line_attribute7 = rida.interface_line_attribute7
        AND rila.interface_line_attribute8 = rida.interface_line_attribute8
        AND rila.interface_line_attribute9 = rida.interface_line_attribute9
        AND rila.interface_line_attribute10 = rida.interface_line_attribute10
        AND rila.interface_line_attribute11 = rida.interface_line_attribute11
        AND rila.interface_line_attribute12 = rida.interface_line_attribute12
        AND rila.interface_line_attribute13 = rida.interface_line_attribute13
        AND NVL(rila.interface_line_attribute14,'X243') = NVL(rida.interface_line_attribute14,'X243')
        AND NVL(rila.interface_line_attribute15,'X243') = NVL(rida.interface_line_attribute15,'X243')  
        AND rila.INTERFACE_LINE_ATTRIBUTE6 = 'MONTHLY BILLING'
        AND rila.trx_date =  TO_DATE('05-NOV-2013', 'DD-MON-YYYY')
        AND rila.conc_req_id = 8521591
        AND rila.INTERFACE_LINE_ATTRIBUTE1 IN ('1549862','1816790',
                                               '1085359','1087943',
                                               '1087943','1096085',
                                               '1484472','1484474',
                                               '1498200','1501707',
                                               '1523322','1530086',
                                               '1543716','1592410',
                                               '823669','823669',
                                               '946112','946112',
                                               '848894','27484',
                                               '847277','847277',
                                               '847277','575474',
                                               '679297','679297'
                                               )
       AND rila.interface_line_attribute4 = 'NOV-13'
       AND NOT EXISTS ( SELECT 'x'
                          FROM apps.ra_customer_trx_all rcta     
                             , apps.hz_cust_accounts hca     
                         WHERE 1 = 1       
                           AND rcta.bill_to_customer_id = hca.cust_account_id 
                           AND rcta.trx_date = TO_DATE('05-NOV-2013', 'DD-MON-YYYY')
                           AND rcta.purchase_order IS NOT NULL
                           AND rila.orig_system_bill_customer_id = hca.cust_account_id
                           AND rila.PURCHASE_ORDER = rcta.purchase_order
                           AND NOT EXISTS (SELECT 'X'
                                             FROM xxrs.xxrs_sc_cloud_account_po cpo                                                
                                            WHERE 1 = 1 
                                              AND cpo.rackspace_account_number = hca.account_number
                                              AND cpo.po_number = rcta.purchase_order
                                              AND rackspace_account_number IN ( SELECT  rackspace_account_number
                                                                                  FROM xxrs.xxrs_sc_cloud_account_po cpo
                                                                                 WHERE EXISTS (SELECT 'X'
                                                                                                 FROM xxrs.xxrs_sc_usage_data_arch usd
                                                                                                WHERE billing_period = 'NOV-13'
                                                                                                  AND customer_num = rackspace_account_number
                                                                                                  AND trim(cpo.cloud_account_number)  = TRIM(SUBSTR(usd.ticket_num, INSTR(usd.ticket_num,':', 1, 1)+1,INSTR(usd.ticket_num,':',1,2)-INSTR(usd.ticket_num,':',1,1)-5))
                                                                                                  AND data_type = 'CB'
                                                                                               )
                                                                                 GROUP BY rackspace_account_number 
                                                                                 )
                                           )
                         AND hca.account_number IN ('1549862','1816790',
                                                    '1085359','1087943',
                                                    '1087943','1096085',
                                                    '1484472','1484474',
                                                    '1498200','1501707',
                                                    '1523322','1530086',
                                                    '1543716','1592410',
                                                    '823669','823669',
                                                    '946112','946112',
                                                    '848894','27484',
                                                    '847277','847277',
                                                    '847277','575474',
                                                    '679297','679297'
                                                    )
                 ) 
        ORDER BY rila.interface_line_attribute1,rila.interface_line_attribute2;
Commit;

