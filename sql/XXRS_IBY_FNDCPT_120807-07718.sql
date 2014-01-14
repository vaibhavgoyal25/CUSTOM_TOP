/**************************************************************************************************************
*                                                                                                             *
* NAME: XXRS_IBY_FNDCPT_120807-07718.sql                                                                      *
*                                                                                                             *
* DESCRIPTION :                                                                                               *
* Script to report the error records in the system.                                                           *
*                                                                                                             *
*                                                                                                             *
* AUTHOR       : Vinodh Bhasker                                                                               *
* DATE WRITTEN : 08/07/2012                                                                                   *
*                                                                                                             *
* CHANGE CONTROL :                                                                                            *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                             *
*-------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  120807-07718     | Vinodh Bhasker |  08/07/2012    | Initial Creation                       *
***************************************************************************************************************/
--
--
SET SERVEROUTPUT ON SIZE 1000000;
SET LINE 300;
SET PAGESIZE 2000;
SET COLSEP |;
col file_name   new_value   spool_file_name    noprint
select 'XXRS_IBY_FNDCPT_120807-07718_' ||to_char (sysdate, '_mmddyy_hhmiss')||'.log' file_name from dual ;
spool &spool_file_name

/************** SQL 1 *****************/
PROMPT SQL1:  

SELECT trx.trx_number
     , trx.customer_trx_id
     , trx.org_id
  FROM ra_customer_trx_all trx
     , ar_receipt_methods arm
     , ar_receipt_classes arc
     , ar_payment_schedules_all ps
 WHERE trx.receipt_method_id = arm.receipt_method_id
   AND arc.receipt_class_id = arm.receipt_class_id
   AND trx.customer_trx_id = ps.customer_trx_id
   AND ps.class = 'CM'
   AND arc.creation_method_code = 'AUTOMATIC'
   AND arm.payment_channel_code = 'BANK_ACCT_XFER'
   AND trx.receipt_method_id IS NOT NULL
   AND trx.paying_customer_id IS NULL
   AND trx.previous_customer_trx_id IS NULL
   AND trx.payment_trxn_extension_id IS NULL;     
             

PROMPT SQL2:

SELECT *
  FROM ra_customer_trx_all
 WHERE customer_trx_id IN
         ( ( SELECT temp.ba_trxn_id
               FROM temp_13735383 temp
                  , ar_receipt_methods arrm
              WHERE arrm.receipt_method_id = temp.receipt_method_id
                AND DECODE ( temp.creation_method_code, 'AUTOMATIC', arrm.payment_channel_code, 'BILLS_RECEIVABLE' ) IS NOT NULL ) )
   AND paying_customer_id IS NULL;