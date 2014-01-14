/**********************************************************************************************************************
* NAME : XXRS_FIX_UNAPPLIED_MONEY_RECEIPT_131213-10090.sql                                                            *
*                                                                                                                     *
* DESCRIPTION :                                                                                                       *
* One-off script to fix the receipt number 'WIRE_23-OCT-2013_1_115094' which has unapplied money with -1 as           *
* customer id for UK.                                          	                                                      *
*                                                                                                                     *
* AUTHOR       : Rahul Boddireddy                                                                                     *
* DATE WRITTEN : 16-DEC-2013                                                                                          *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* Version#     |  TICKET          | WHO             |  DATE          |   REMARKS                                      *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  131213-10090    | RAHUL B         |  16-DEC-2013   |  Initial Build                                 *
**********************************************************************************************************************/
--
/* $Header: XXRS_FIX_UNAPPLIED_MONEY_RECEIPT_131213-10090.sql 1.0.0 16-DEC-2013 02:00:00 PM RAHUL B $ */
--
SET SERVEROUTPUT ON SIZE 1000000
SET LINES 1000
SET PAGESIZE 1000
SET COLSEP '|'
COL file_name NEW_VALUE spool_file_name NOPRINT
SELECT 'XXRS_FIX_UNAPPLIED_MONEY_RECEIPT_131213-10090_'||TO_CHAR(SYSDATE,'YYYYMMDDHHMISS')||'.log' file_name
FROM DUAL;

SPOOL &spool_file_name   

PROMPT "Count of rows being updated"
SELECT COUNT(*) 
  FROM AR.ar_receivable_applications_all
 WHERE receivable_application_id = 8328405;

PROMPT "receivable_application_id,on_acct_cust_id before update"
SELECT receivable_application_id,on_acct_cust_id
  FROM ar_receivable_applications_all
 WHERE receivable_application_id = 8328405;
 
PROMPT "Updating ar_receivable_applications table"
UPDATE ar.ar_receivable_applications_all
   SET on_acct_cust_id = NULL
 WHERE receivable_application_id = 8328405;
 
PROMPT "receivable_application_id,on_acct_cust_id after update"
SELECT receivable_application_id,on_acct_cust_id
  FROM ar_receivable_applications_all
 WHERE receivable_application_id = 8328405; 

PROMPT "Count of rows after update"
SELECT COUNT(*) 
  FROM AR.ar_receivable_applications_all
 WHERE receivable_application_id = 8328405; 

SPOOL OFF
