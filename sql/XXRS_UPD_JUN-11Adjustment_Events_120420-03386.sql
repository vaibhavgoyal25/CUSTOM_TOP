/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_UPD_JUN-11Adjustment_Events_120420-03386.sql                                                            *
*                                                                                                                     *
* DESCRIPTION :                                                                                                       *
* Script to Update Event Status Code in XLA_EVENTS from I to "N"                            			      *
*                                                                                                                     *
* AUTHOR       : Prathibha Emany                                                                                      *
* DATE WRITTEN : 02-JAN-2013                                                                                          *
*                                                                                                                     *
* CHANGE CONTROL : 1.0.0                                                                                              *
* SR#             	GENIE Ticket #    WHO                DATE                      REMARKS                        *
* 3-5970695421 		120420-03386      PRATHIBHA EMANY   2-JAN-2013    Script to Update Jun-11 Adjustment         *
**********************************************************************************************************************/
/* $Header: XXRS_UPD_JUN-11Adjustment_Events_120420-03386.sql 1.0 27-JUL-2012 10:14:00 AM Prathibha Emany$ */
SET SERVEROUTPUT ON SIZE 100000;
SET LINE 300;
SET PAGESIZE 2000;
SET COLSEP |;
col file_name   new_value   spool_file_name    noprint
select 'XXRS_UPD_JUN-11Adjustment_Events_120420-03386' ||to_char (sysdate, '_mmddyy_hhmiss')||'.log' file_name from dual ;
spool &spool_file_name
SELECT 'Before Updating xla_events table' comments from dual;
SELECT  event_id,EVENT_STATUS_CODE from xla_events 
where event_id IN (Select xe.event_id 
from xla.xla_events xe, ar.ar_adjustments_all adj, xla.xla_transaction_entities xte
where xe.entity_id = xte.entity_id
and xte.source_id_int_1 = adj.adjustment_id
and xe.event_status_code = 'I'
and adj.gl_date between to_date ('01-JUN-2011','DD-MON-YYYY')
and to_date('30-JUN-2011','DD-MON-YYYY'));


SELECT 'Updating xla_events' comments from dual;   
--  
update xla_events
set EVENT_STATUS_CODE='N'
where event_id IN (Select xe.event_id 
from xla.xla_events xe, ar.ar_adjustments_all adj, xla.xla_transaction_entities xte
where xe.entity_id = xte.entity_id
and xte.source_id_int_1 = adj.adjustment_id
and xe.event_status_code = 'I'
and adj.gl_date between to_date ('01-JUN-2011','DD-MON-YYYY')
and to_date('30-JUN-2011','DD-MON-YYYY'));

SELECT 'After Updating xla_events table' comments from dual;
--
SELECT  event_id,EVENT_STATUS_CODE from xla_events 
where event_id IN (Select xe.event_id 
from xla.xla_events xe, ar.ar_adjustments_all adj, xla.xla_transaction_entities xte
where xe.entity_id = xte.entity_id
and xte.source_id_int_1 = adj.adjustment_id
and xe.event_status_code = 'I'
and adj.gl_date between to_date ('01-JUN-2011','DD-MON-YYYY')
and to_date('30-JUN-2011','DD-MON-YYYY'));
-- COMMIT;
--SPOOL OFF;
