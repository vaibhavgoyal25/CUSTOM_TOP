/**************************************************************************************************************
* NAME : XXRS_ACCT_PRG_ERR_130529-01372.sql                                                                   *
*                                                                                                             *
* DESCRIPTION :                                                                                               *
*   Datafix For Accounting Program Error.                                                                     *
*                                                                                                             *
* AUTHOR       : Vaibhav Goyal                                                                                *
* DATE WRITTEN : 20-MAY-2013                                                                                  *
*                                                                                                             *
* CHANGE CONTROL :                                                                                            *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                             *
*-------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  130529-01372     | Vaibhav Goyal   |  30-MAY-2013   | Initial Creation.                     *
***************************************************************************************************************/
--
/* $Header: XXRS_ACCT_PRG_ERR_130529-01372.sql 1.0.0 05/30/2013 10:46:24 AM Vaibhav Goyal $ */
--
SET SERVEROUTPUT ON SIZE 1000000
SET LINES 1000
SET PAGESIZE 1000
SET COLSEP '|'
COL file_name NEW_VALUE spool_file_name NOPRINT
SELECT 'XXRS_ACCT_PRG_ERR_130529-01372_'||TO_CHAR(SYSDATE,'YYYYMMDDHHMISS')||'.log' file_name
FROM DUAL;

SPOOL &spool_file_name

PROMPT "Creating tmp_ra_37287522791 to take Backup of Table ar_receivable_applications_all for the records being updated:"
Create table tmp_ra_37287522791
as (select * from ar_receivable_applications_all
where receivable_application_id in (7365025, 7365026, 
7365029, 7365030)
and cash_receipt_id = 4042644);


PROMPT "Creating tmp_ard_37287522791 to take Backup of Table ar_distributions_all for the records being updated:"
create table tmp_ard_37287522791
as (select * from ar_distributions_all
where source_id in (7365025, 7365026, 
7365029, 7365030)
and source_table = 'RA');

PROMPT "Run the following to fix the data:"

update ar_receivable_applications_all
set acctd_amount_applied_from = 0
where receivable_application_id in (7365025, 7365026, 
7365029, 7365030)
and cash_receipt_id = 4042644;

PROMPT "This should update 4 rows. If so, commit the changes; otherwise, roll them back."

update ar_distributions_all
set acctd_amount_cr = 0
where line_id = 12872205
and source_id = 7365025;

PROMPT "This should update 1 row. If so, commit the changes; otherwise, roll them back."

update ar_distributions_all
set acctd_amount_cr = 0
where line_id = 12872218
and source_id = 7365029;

PROMPT "This should update 1 row. If so, commit the changes; otherwise, roll them back."

delete from ar_distributions_all
where line_id in (12872212, 12872225)
and source_id in (7365026, 7365030);

PROMPT "This should delete 2 rows. If so, commit the changes; otherwise, roll them back."
 
