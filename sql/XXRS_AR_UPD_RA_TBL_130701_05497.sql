-- /***********************************************************************************************************
-- *                                                                                                          *
-- * NAME : XXRS_AR_UPD_RA_TBL_130701_05497.sql                                                               *
-- *                                                                                                          *
-- * DESCRIPTION :                                                                                            *
-- * Script to update ar_receivable_applications_all                                                          *
-- *                                                                                                          *
-- * AUTHOR       : Pavan Amirineni                                                                           *
-- * DATE WRITTEN : 07/02/2013                                                                                *
-- *                                                                                                          *
-- * CHANGE CONTROL :                                                                                         *
-- * Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                          *
-- *----------------------------------------------------------------------------------------------------------*
-- * 1.0.0        |  130701_05497     | Pavan Amirineni |  07/02/2013    | SR # 3-7462710981                  *
-- ***********************************************************************************************************/
-- /* $Header XXRS_AR_UPD_RA_TBL_130701_05497.sql 1.0.0 07/02/2013 15:00:00 Pavan Amirineni $*/
SET SERVEROUTPUT ON SIZE 1000000
SET LINES 1000
SET PAGESIZE 1000
SET COLSEP '|'
COL file_name NEW_VALUE spool_file_name NOPRINT
SELECT 'XXRS_AR_UPD_RA_TBL_130701_05497_'||TO_CHAR(SYSDATE,'YYYYMMDDHHMISS')||'.log' file_name
FROM DUAL;

SPOOL &spool_file_name

PROMPT "Before Updating ar_receivable_applications_all"

SELECT event_id 
  FROM ar_receivable_applications_all    
 WHERE receivable_application_id IN (SELECT ar.receivable_application_id 
                                       FROM ar_receivable_applications_all ar
									      , xla_events xe 
								      WHERE ar.event_id=xe.event_id 
                                        AND xe.event_status_code='P' 
										AND xe.process_status_code='P' 
										AND ar.posting_control_id=-3
									);

UPDATE ar_receivable_applications_all
   SET event_id = null
 WHERE receivable_application_id IN (SELECT ar.receivable_application_id 
                                       FROM ar_receivable_applications_all ar
									      , xla_events xe 
								      WHERE ar.event_id=xe.event_id 
                                        AND xe.event_status_code='P' 
										AND xe.process_status_code='P' 
										AND ar.posting_control_id=-3
									);									
									
PROMPT "After Updating ar_receivable_applications_all"									
SELECT event_id 
  FROM ar_receivable_applications_all    
 WHERE receivable_application_id IN (SELECT ar.receivable_application_id 
                                       FROM ar_receivable_applications_all ar
									      , xla_events xe 
								      WHERE ar.event_id=xe.event_id 
                                        AND xe.event_status_code='P' 
										AND xe.process_status_code='P' 
										AND ar.posting_control_id=-3
									);	
/