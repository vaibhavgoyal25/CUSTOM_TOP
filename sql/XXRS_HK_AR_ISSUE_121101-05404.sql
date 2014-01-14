/**************************************************************************************************
* NAME : XXRS_HK_AR_ISSUE_121101-05404.sql                                                        *
* DESCRIPTION :                                                                                   *
* Datafix for payment application SR 3-6393005941 : GLXFR: Unable to Close AR period for October. *
*                                                                                                 *
* AUTHOR       : Pavan Amirineni                                                                  *
* DATE WRITTEN : 01-NOV-2012                                                                      *
*                                                                                                 *
* CHANGE CONTROL :                                                                                *
* Version# | Ticket #     |  WHO            | DATE       |   REMARKS                              *
*-------------------------------------------------------------------------------------------------*
* 1.0.0    | 121101-05404 | Pavan Amirineni | 26-APR-2012 | Initial Creation - SR# SR 3-6393005941*
***************************************************************************************************/
--  /* $Header: XXRS_HK_AR_ISSUE_120410-04126.sql 1.0.0 01-NOV-2012 10:54:39 AM Pavan AMirineni $ */
SET SERVEROUTPUT ON SIZE 1000000;
SET PAGESIZE 300
col file_name   new_value   spool_file_name    noprint
SELECT 'XXRS_HK_AR_ISSUE_121101-05404'||to_char (sysdate, '_mmddyy_hhmiss')||'.log' file_name from dual ;
SPOOL &spool_file_name

CREATE TABLE xxrs.xxrs_ar_recv_appl_all_bkp
AS
SELECT *
  FROM ar_receivable_applications_all
 WHERE receivable_application_id IN (
5079074,
5079075,
5079078,
5079079,
5079011,
5079012,
5079015,
5079016,
5079031,
5079032,
5079035,
5079036,
5079047,
5079048)
AND cash_receipt_id IN (2228600,2228601)
AND posting_control_id=-3;

UPDATE ar_receivable_applications_all
   SET acctd_amount_applied_from=0
     , last_updated_by = 0 
     , last_update_date = SYSDATE
 WHERE receivable_application_id IN (
5079074,
5079075,
5079078,
5079079,
5079011,
5079012,
5079015,
5079016,
5079031,
5079032,
5079035,
5079036,
5079047,
5079048)
AND cash_receipt_id IN (2228600,2228601)
AND posting_control_id=-3;
--
CREATE TABLE xxrs.xxrs_ar_dist_all_bkp_01
AS
SELECT *
  FROM ar_distributions_all
 WHERE source_type IN ('EXCH_LOSS','EXCH_GAIN')
   AND source_id IN (5079012, 5079016, 5079032, 5079036, 5079048, 5079075, 5079079);
--
DELETE 
  FROM ar_distributions_all
 WHERE source_type IN ('EXCH_LOSS','EXCH_GAIN')
   AND source_id IN (5079012, 5079016, 5079032, 5079036, 5079048, 5079075, 5079079);
--

CREATE TABLE xxrs.xxrs_ar_dist_all_bkp_02
AS
SELECT *
  FROM ar_distributions_all
 WHERE source_type IN ('UNAPP')
   AND source_id IN (5079011, 5079015,5079031, 5079035, 5079047, 5079074, 5079078);


UPDATE ar_distributions_all
   SET acctd_amount_cr = 0
     , last_updated_by = 0
     , last_update_date = SYSDATE
 WHERE source_type IN ('UNAPP')
   AND source_id IN
              (5079011, 5079015, 5079031, 5079035, 5079047, 5079074, 5079078);
/