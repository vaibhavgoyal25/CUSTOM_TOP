/**************************************************************************************************
* NAME :XXRS_CHASE_OB_PP_DATAFIX_120601-04276.sql                                                 *
* DESCRIPTION :                                                                                   *
* AP Processed Payments refresh                                                                   *
*                                                                                                 *
* AUTHOR       : Vaibhav Goyal                                                                    *
* DATE WRITTEN : 01-Jun-2012                                                                      *
*                                                                                                 *
* CHANGE CONTROL :                                                                                *
* Version# | Ticket #     |  WHO            | DATE       |   REMARKS                              *
*-------------------------------------------------------------------------------------------------*
* 1.0.0    | 120601-04276 | Vaibhav Goyal   | 01-Jun-2012 | Initial Creation                      *
***************************************************************************************************/
--  /* $Header: XXRS_CHASE_OB_PP_DATAFIX_120517-09156.sql 1.0.0 17-May-2012 10:54:39 AM Vaibhav Goyal $ */
SET SERVEROUTPUT ON SIZE 1000000;
SET PAGESIZE 300
col file_name   new_value   spool_file_name    noprint
select 'XXRS_CHASE_OB_PP_DATAFIX_120601-04276'||to_char (sysdate, '_mmddyy_hhmiss')||'.log' file_name from dual ;
spool &spool_file_name

PROMPT SQL1: Before Delete

select *
  from xxrs.xxrs_chase_processed_payments x
 where last_update_date between to_date('5/31/2012 1:20:00 PM','MM/DD/RRRR HH:MI:SS PM') AND  to_date('5/31/2012 1:22:00 PM','MM/DD/RRRR HH:MI:SS PM');
PROMPT Deleting records from xxrs.xxrs_chase_processed_payments

DELETE 
  from xxrs.xxrs_chase_processed_payments x
 where last_update_date between to_date('5/31/2012 1:20:00 PM','MM/DD/RRRR HH:MI:SS PM') AND  to_date('5/31/2012 1:22:00 PM','MM/DD/RRRR HH:MI:SS PM') ; 

PROMPT SQL2: After Delete

select *
  from xxrs.xxrs_chase_processed_payments x
 where last_update_date between to_date('5/31/2012 1:20:00 PM','MM/DD/RRRR HH:MI:SS PM') AND  to_date('5/31/2012 1:22:00 PM','MM/DD/RRRR HH:MI:SS PM') ;
