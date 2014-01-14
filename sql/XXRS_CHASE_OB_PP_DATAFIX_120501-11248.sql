/**************************************************************************************************
* NAME :XXRS_CHASE_OB_PP_DATAFIX_120501-11248.sql                                                 *
* DESCRIPTION :                                                                                   *
* AP Processed Payments refresh                                                                   *
*                                                                                                 *
* AUTHOR       : Vaibhav Goyal                                                                    *
* DATE WRITTEN : 01-May-2012                                                                      *
*                                                                                                 *
* CHANGE CONTROL :                                                                                *
* Version# | Ticket #     |  WHO            | DATE       |   REMARKS                              *
*-------------------------------------------------------------------------------------------------*
* 1.0.0    | 120501-11248 | Vaibhav Goyal   | 01-May-2012 | Initial Creation                      *
***************************************************************************************************/
--  /* $Header: XXRS_CHASE_OB_PP_DATAFIX_120501-11248.sql 1.0.0 30-APR-2012 10:54:39 AM Vaibhav Goyal $ */
SET SERVEROUTPUT ON SIZE 1000000;
SET PAGESIZE 300
col file_name   new_value   spool_file_name    noprint
select 'XXRS_CHASE_OB_PP_DATAFIX_120501-11248'||to_char (sysdate, '_mmddyy_hhmiss')||'.log' file_name from dual ;
spool &spool_file_name

PROMPT SQL1: Before Delete

SELECT * FROM xxrs.xxrs_chase_processed_payments
 WHERE TRUNC (creation_date) = TO_DATE ('04/26/2012', 'MM/DD/YYYY');

PROMPT Deleting records from xxrs.xxrs_chase_processed_payments

DELETE FROM xxrs.xxrs_chase_processed_payments
 WHERE TRUNC (creation_date) = TO_DATE ('04/26/2012', 'MM/DD/YYYY'); 

PROMPT SQL2: After Delete

SELECT * FROM xxrs.xxrs_chase_processed_payments
 WHERE TRUNC (creation_date) = TO_DATE ('04/26/2012', 'MM/DD/YYYY');
