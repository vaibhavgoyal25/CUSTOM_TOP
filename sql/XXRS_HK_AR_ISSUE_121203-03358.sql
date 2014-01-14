/***************************************************************************************************
* NAME : XXRS_HK_AR_ISSUE_121203-03358.sql                                                         *
* DESCRIPTION :                                                                                    *
* Datafix for payment application SR 3-6516170931 : GLXFR: Unable to Close AR period for October.  *
*                                                                                                  *
* AUTHOR       : Vinodh Bhasker                                                                    *
* DATE WRITTEN : 03-DEC-2012                                                                       *
*                                                                                                  *
* CHANGE CONTROL :                                                                                 *
* Version# | Ticket #     |  WHO            | DATE        |   REMARKS                              *
*--------------------------------------------------------------------------------------------------*
* 1.0.0    | 121203-03358 | Vinodh Bhasker  | 03-DEC-2012 | Initial Creation - SR# SR 3-6393005941 *
****************************************************************************************************/
--  /* $Header: XXRS_HK_AR_ISSUE_121203-03358.sql 1.0.0 03-DEC-2012 13:23:00 Vinodh Bhasker $ */
SET SERVEROUTPUT ON SIZE 1000000;
SET PAGESIZE 300
col file_name   new_value   spool_file_name    noprint
SELECT 'XXRS_HK_AR_ISSUE_121203-03358'||to_char (sysdate, '_mmddyy_hhmiss')||'.log' file_name from dual ;
SPOOL &spool_file_name

PROMPT "Dropping old archive tables for this issue"
DROP TABLE xxrs.xxrs_ar_recv_appl_all_bkp;
DROP TABLE xxrs.xxrs_ar_dist_all_bkp_01;
DROP TABLE xxrs.xxrs_ar_dist_all_bkp_02;
--
PROMPT "Backing up ar_receivable_applications_all records"
--
CREATE TABLE xxrs.xxrs_ar_recv_appl_all_bkp
AS
SELECT *
  FROM ar_receivable_applications_all
 WHERE receivable_application_id IN (5226012, 5226013)
   AND cash_receipt_id = 2560583;
--
PROMPT "Backing up ar_distributions_all records"
--
CREATE TABLE xxrs.xxrs_ar_dist_all_bkp_01
AS
SELECT * 
  FROM ar_distributions_all
 WHERE source_id in (5226012, 5226013)
   AND source_table = 'RA';
--
PROMPT "Updating records in ar_receivable_applications_all"
PROMPT "ONLY 2 records must be updated. If not please rollback."
--
UPDATE ar_receivable_applications_all
   SET acctd_amount_applied_from=0
     , last_updated_by = 0 
     , last_update_date = SYSDATE
 WHERE receivable_application_id IN (5226012, 5226013)
   AND cash_receipt_id = 2560583;
--
PROMPT "Updating record in ar_distributions_all"
PROMPT "This should update one row. If so, commit the changes; otherwise, roll them back"
--
UPDATE ar_distributions_all
   SET acctd_amount_cr = 0
     , last_updated_by = 0
     , last_update_date = SYSDATE
 WHERE 1 = 1
   AND line_id = 9277691
   AND source_id = 5226012;
--
PROMPT "Deleting record in ar_distributions_all"
PROMPT "This should delete one row. If so, commit the changes; otherwise, roll them back"
--
DELETE 
  FROM ar_distributions_all
 WHERE line_id = 9277698
   AND source_id = 5226013;

/