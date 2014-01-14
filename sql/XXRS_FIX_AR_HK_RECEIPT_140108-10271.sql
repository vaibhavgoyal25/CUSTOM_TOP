/**********************************************************************************************************************
* NAME : XXRS_FIX_AR_HK_RECEIPT_140108-10271.sql                                                                      *
*                                                                                                                     *
* DESCRIPTION :                                                                                                       *
* One-off script to fix the receipt number 'WIRE_16-DEC-2013_1_123713' and 'WIRE_08-JAN-2014_1_128962'                *
* which have special character in the customer_receipt_reference field  in AR_CASH_RECEIPTS_ALL table   		      *
*                                                                                                                     *
* AUTHOR       : Rahul Boddireddy                                                                                     *
* DATE WRITTEN : 10-JAN-2014                                                                                          *
* SR#          : 3-8329485131                                                                                         *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* Version#     |  TICKET          | WHO             |  DATE          |   REMARKS                                      *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  140108-10271    | RAHUL B         |  10-JAN-2013   |  Initial Build                                 *
**********************************************************************************************************************/
--
/* $Header: XXRS_FIX_AR_HK_RECEIPT_140108-10271.sql 1.0.0 10-JAN-2014 02:00:00 PM RAHUL B $ */
--
SET SERVEROUTPUT ON SIZE 1000000
SET LINES 1000
SET PAGESIZE 1000
SET COLSEP '|'
COL file_name NEW_VALUE spool_file_name NOPRINT
SELECT 'XXRS_FIX_AR_HK_RECEIPT_140108-10271_'||TO_CHAR(SYSDATE,'YYYYMMDDHHMISS')||'.log' file_name
FROM DUAL;

SPOOL &spool_file_name   

PROMPT "Count of rows being updated"
SELECT COUNT(*) 
  FROM ar.ar_cash_receipts_all
 WHERE cash_receipt_id IN (5457629,5596649);

PROMPT "cash_receipt_id,customer_receipt_reference before update"
SELECT cash_receipt_id,customer_receipt_reference
  FROM ar_cash_receipts_all
 WHERE cash_receipt_id IN (5457629,5596649);
 
PROMPT "Updating ar_cash_receipts_all table"
UPDATE ar.ar_cash_receipts_all
   SET customer_receipt_reference = SUBSTR(customer_receipt_reference,1,6)
 WHERE cash_receipt_id IN (5457629,5596649);
 
PROMPT "cash_receipt_id,customer_receipt_reference after update"
SELECT cash_receipt_id,customer_receipt_reference
  FROM ar_cash_receipts_all
 WHERE cash_receipt_id IN (5457629,5596649);

PROMPT "Count of rows after update"
SELECT COUNT(*) 
  FROM ar.ar_cash_receipts_all
 WHERE cash_receipt_id IN (5457629,5596649);

 SPOOL OFF