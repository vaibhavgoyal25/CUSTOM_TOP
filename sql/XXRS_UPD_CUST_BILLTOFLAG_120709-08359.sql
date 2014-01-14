/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_UPD_CUST_BILLTOFLAG_120709-08359.sql                                                                    *
*                                                                                                                     *
* DESCRIPTION :                                                                                                       *
* Script to Update Bill to Flag in HZ_CUST_ACCT_SITES_ALL from Null to "P" (Primary Flag).                            *
*                                                                                                                     *
* AUTHOR       : Prathibha Emany                                                                                      *
* DATE WRITTEN : 09-JUL-2012                                                                                          *
*                                                                                                                     *
* CHANGE CONTROL : 1.0.0                                                                                              *
* SR#             		GENIE Ticket #    WHO                DATE                      REMARKS                *
* 3-5910337531 			120709-08359      PRATHIBHA EMANY   09-JUL-2012    Script to Update bill to flag      *
**********************************************************************************************************************/
/* $Header: XXRS_UPD_CUST_BILLTOFLAG_120709-08359.sql 1.0 09-JUL-2012 04:44:00 PM Prathibha Emany$ */
SET SERVEROUTPUT ON SIZE 100000;
SET LINE 300;
SET PAGESIZE 2000;
SET COLSEP |;
col file_name   new_value   spool_file_name    noprint
select 'XXRS_UPD_CUST_BILLTOFLAG_120709-08359' ||to_char (sysdate, '_mmddyy_hhmiss')||'.log' file_name from dual ;
spool &spool_file_name
SELECT 'Before Updating hz_cust_acct_sites_all table' comments from dual;
select cust_acct_site_id,cust_account_id, bill_to_flag
from apps.hz_cust_acct_sites_all
WHERE CUST_ACCT_SITE_ID = 90574
AND CUST_ACCOUNT_ID = 22389
AND PARTY_SITE_ID = 3429035;

SELECT 'Updating hz_cust_acct_sites_all' comments from dual;   
--  
UPDATE HZ_CUST_ACCT_SITES_ALL
SET BILL_TO_FLAG = 'P',
last_update_date = SYSDATE,
last_updated_by = 0
WHERE CUST_ACCT_SITE_ID = 90574
AND CUST_ACCOUNT_ID = 22389
AND PARTY_SITE_ID = 3429035;
--
select cust_acct_site_id,cust_account_id, bill_to_flag
from apps.hz_cust_acct_sites_all
WHERE CUST_ACCT_SITE_ID = 90574
AND CUST_ACCOUNT_ID = 22389
AND PARTY_SITE_ID = 3429035;
-- COMMIT;
--SPOOL OFF;