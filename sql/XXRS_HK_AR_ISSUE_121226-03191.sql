/***************************************************************************************************
* NAME : XXRS_HK_AR_ISSUE_121226-03191.sql                                                         *
* DESCRIPTION :                                                                                    *
* Datafix for payment application SR 3-6516170931 : GLXFR: Unable to Close AR period for October.  *
*                                                                                                  *
* AUTHOR       : Vinodh Bhasker                                                                    *
* DATE WRITTEN : 27-DEC-2012                                                                       *
*                                                                                                  *
* CHANGE CONTROL :                                                                                 *
* Version# | Ticket #     |  WHO            | DATE        |   REMARKS                              *
*--------------------------------------------------------------------------------------------------*
* 1.0.0    | 121226-03191 | Vinodh Bhasker  | 27-DEC-2012 | Initial Creation - SR# SR 3-6516170931 *
****************************************************************************************************/
--  /* $Header: XXRS_HK_AR_ISSUE_121226-03191.sql 1.0.0 27-DEC-2012 14:15:00 Vinodh Bhasker $ */
SET SERVEROUTPUT ON SIZE 1000000;
SET PAGESIZE 300
col file_name   new_value   spool_file_name    noprint
SELECT 'XXRS_HK_AR_ISSUE_121226-03191'||to_char (sysdate, '_mmddyy_hhmiss')||'.log' file_name from dual ;
SPOOL &spool_file_name

PROMPT "Dropping old archive tables for this issue"
DROP TABLE xxrs.xxrs_ar_recv_appl_all_bkp;
DROP TABLE xxrs.xxrs_ar_dist_all_bkp_01;
--
PROMPT "Backing up ar_receivable_applications_all records"
--
CREATE TABLE xxrs.xxrs_ar_recv_appl_all_bkp
AS
SELECT *
  FROM ar.ar_receivable_applications_all
 WHERE cash_receipt_id IN (2710589, 2736592)
   AND receivable_application_id IN (5467235,
5467236,
5467247,
5467248,
5477868,
5477869,
5477872,
5477873,
5477876,
5477877
);
--
PROMPT "Backing up ar_distributions_all records"
--
CREATE TABLE xxrs.xxrs_ar_dist_all_bkp_01
AS
SELECT * 
  FROM ar.ar_distributions_all
 WHERE 1 = 1
   AND source_table = 'RA'
   AND source_id IN (5467235,
5467236,
5467247,
5467248,
5477868,
5477869,
5477872,
5477873,
5477876,
5477877
);
--
PROMPT "Updating records in ar_receivable_applications_all"
PROMPT "ONLY 10 records must be updated. If not please rollback."
--
UPDATE ar_receivable_applications_all
   SET acctd_amount_applied_from=0
     , last_updated_by = 0 
     , last_update_date = SYSDATE
 WHERE cash_receipt_id IN (2710589, 2736592)
   AND receivable_application_id IN (5467235,
5467236,
5467247,
5467248,
5477868,
5477869,
5477872,
5477873,
5477876,
5477877
);
--
PROMPT "Updating record in ar_distributions_all"
PROMPT "This should update 5 rows. If so, commit the changes; otherwise, roll them back"
--
UPDATE ar_distributions_all
   SET acctd_amount_cr = 0
     , last_updated_by = 0
     , last_update_date = SYSDATE
 WHERE 1 = 1
   AND line_id IN (9790861,9790896,9799835,9799845,9799854)
   AND source_id IN (5467235,5467247,5477868,5477872,5477876);
--
PROMPT "Deleting record in ar_distributions_all"
PROMPT "This should delete 5 rows. If so, commit the changes; otherwise, roll them back"
--
DELETE 
  FROM ar_distributions_all
 WHERE line_id IN (9790868,9790905,9799839,9799849,9799858)
   AND source_id IN (5467236,5467248,5477869,5477873,5477877);

/