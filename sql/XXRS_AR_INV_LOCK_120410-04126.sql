/**************************************************************************************************
* NAME : XXRS_AR_INV_LOCK_120410-04126.sql                                                        *
* DESCRIPTION :                                                                                   *
* AR payment schedules review                                                                     *
*                                                                                                 *
* AUTHOR       : Pavan Amirineni                                                                  *
* DATE WRITTEN : 26-APR-2012                                                                      *
*                                                                                                 *
* CHANGE CONTROL :                                                                                *
* Version# | Ticket #     |  WHO            | DATE       |   REMARKS                              *
*-------------------------------------------------------------------------------------------------*
* 1.0.0    | 120410-04126 | Pavan Amirineni | 26-APR-2012 | Initial Creation                      *
***************************************************************************************************/
--  /* $Header: XXRS_AR_INV_LOCK_120410-04126.sql 1.0.0 26-APR-2012 10:54:39 AM Pavan AMirineni $ */
SET SERVEROUTPUT ON SIZE 1000000;
SET PAGESIZE 300
col file_name   new_value   spool_file_name    noprint
select 'XXRS_AR_INV_LOCK_120410-04126'||to_char (sysdate, '_mmddyy_hhmiss')||'.log' file_name from dual ;
spool &spool_file_name
PROMPT SQL1:Before Update

SELECT payment_schedule_id
     , selected_for_receipt_batch_id
     , ORG_ID  
  FROM ar_payment_schedules_all
 where selected_for_receipt_batch_id in ( 49529,51309 ) and org_id = 127 ;  

PROMPT SQL1:Updating records

UPDATE ar_payment_schedules_all
   SET selected_for_receipt_batch_id = null 
 WHERE selected_for_receipt_batch_id in ( 49529,51309 ) 
   AND org_id = 127 ;

PROMPT SQL1:after Update

SELECT payment_schedule_id
     , selected_for_receipt_batch_id
     , ORG_ID  
  FROM ar_payment_schedules_all
 where selected_for_receipt_batch_id in ( 49529,51309 ) and org_id = 127 ;
