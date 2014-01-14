/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_HK_RCPT_BATCH_STUCK_130114-01022.sql                                                                    *
*                                                                                                                     *
* DESCRIPTION :                                                                                                       *
* Script to update the receipt batch status to PROCESSED                           			                          *
*                                                                                                                     *
* AUTHOR       : Prathibha Emany                                                                                      *
* DATE WRITTEN : 18-JAN-2013                                                                                          *
*                                                                                                                     *
* CHANGE CONTROL : 1.0.0                                                                                              *
* SR#             	GENIE Ticket #    WHO                DATE                          REMARKS                        *
* 3-6673814691 		130114-01022      PRATHIBHA EMANY   18-JAN-2013     Script to Update HK Rcpt Batch Status         *
**********************************************************************************************************************/
/* $Header: XXRS_HK_RCPT_BATCH_STUCK_130114-01022.sql 1.0 18-JAN-2013 10:14:00 AM Prathibha Emany$ */
SET SERVEROUTPUT ON SIZE 100000;
SET LINE 300;
SET PAGESIZE 2000;
SET COLSEP |;
col file_name   new_value   spool_file_name    noprint
select 'XXRS_HK_RCPT_BATCH_STUCK_130114-01022' ||to_char (sysdate, '_mmddyy_hhmiss')||'.log' file_name from dual ;
spool &spool_file_name

PROMPT 'Create Backup table'
create table XXRS.XXRS_AR_INTERIM_392991_TMP
as SELECT * FROM AR_INTERIM_CASH_RECEIPTS_ALL WHERE batch_id = 392991;

create table XXRS.XXRS_AR_INTRM_LINES_392991_TMP
as SELECT * FROM AR_INTERIM_CASH_RCPT_LINES_ALL WHERE batch_id = 392991;

create table XXRS.XXRS_AR_BATCHES_392991_TMP
as SELECT * FROM AR_BATCHES_ALL WHERE batch_id = 392991;

PROMPT 'Delete records from Interface table for stuck batch'
delete FROM AR_INTERIM_CASH_RECEIPTS_ALL WHERE batch_id = 392991;

delete FROM AR_INTERIM_CASH_RCPT_LINES_ALL WHERE batch_id = 392991;

PROMPT 'Before updating the batch status'
SELECT b.batch_id, b.batch_applied_status,b.status,
b.control_amount,b.control_count 
from ar_batches_all b
where b.batch_id = 392991;

PROMPT 'Updating the batch status'
UPDATE ar_batches_all b
SET b.batch_applied_status = 'PROCESSED',
b.status = 'CL',
b.control_amount = (SELECT SUM(crh.amount)
FROM AR_CASH_RECEIPT_HISTORY_ALL crh
WHERE crh.batch_id = b.batch_id),
b.control_count = (SELECT COUNT(crh2.batch_id)
FROM AR_CASH_RECEIPT_HISTORY_ALL crh2
WHERE crh2.batch_id = b.batch_id )
where  batch_id = 392991;

PROMPT 'After updating the batch status'
SELECT b.batch_id, b.batch_applied_status,b.status,
b.control_amount,b.control_count 
from ar_batches_all b
where b.batch_id = 392991;
--COMMIT;
--SPOOL OFF;

