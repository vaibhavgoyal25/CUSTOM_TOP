/**************************************************************************************************************
* NAME : XXRS_PA_PROJ_UPD_121105-05626.sql                                                                    *
*                                                                                                             *
* DESCRIPTION :                                                                                               *
*   Script to update projects tables for booking double exp because of sep2-12 period                         *
*                                                                                                             *
* AUTHOR       : Pavan Amirineni                                                                              *
* DATE WRITTEN : 06-NOV-2012                                                                                  *
*                                                                                                             *
* CHANGE CONTROL :                                                                                            *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                             *
*-------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  121105-05626     | Pavan Amirineni |  06-NOV-2012   | Initial Creation.                     *
***************************************************************************************************************/
--
/* $Header: XXRS_PA_PROJ_UPD_121105-05626.sql 1.0.0 11/06/2012 10:46:24 AM Pavan Amirineni $ */
--
SET SERVEROUTPUT ON SIZE 1000000
SET LINES 1000
SET PAGESIZE 1000
SET COLSEP '|'
COL file_name NEW_VALUE spool_file_name NOPRINT
SELECT 'XXRS_PA_PROJ_UPD_121105-05626_'||TO_CHAR(SYSDATE,'YYYYMMDDHHMISS')||'.log' file_name
FROM DUAL;

SPOOL &spool_file_name

PROMPT "Selecting records in PA_COST_DISTRIBUTION_LINES_ALL with GL period as SEP2-12"

SELECT expenditure_item_id
     , line_num 
     , recvr_GL_PERIOD_NAME
     , amount
     , quantity
  FROM PA_COST_DISTRIBUTION_LINES_ALL
 WHERE RECVR_GL_PERIOD_NAME = 'SEP2-12' 
   AND org_id = 127;   

PROMPT "Updating records in PA_COST_DISTRIBUTION_LINES_ALL with GL period as SEP-12"

UPDATE PA_COST_DISTRIBUTION_LINES_ALL
   SET RECVR_GL_PERIOD_NAME = 'SEP-12'
 WHERE RECVR_GL_PERIOD_NAME = 'SEP2-12' 
   AND org_id = 127;   

PROMPT "Selecting records in PA_COST_DISTRIBUTION_LINES_ALL with PA period as SEP2-12"
   
SELECT expenditure_item_id
     , line_num 
     , RECVR_PA_PERIOD_NAME
     , amount
     , quantity
  FROM PA_COST_DISTRIBUTION_LINES_ALL
 WHERE RECVR_PA_PERIOD_NAME = 'SEP2-12' 
   AND org_id = 127;      

PROMPT "Updating records in PA_COST_DISTRIBUTION_LINES_ALL with PA period as SEP-12"
   
UPDATE PA_COST_DISTRIBUTION_LINES_ALL
   SET RECVR_PA_PERIOD_NAME = 'SEP-12'
 WHERE RECVR_PA_PERIOD_NAME = 'SEP2-12' 
   AND org_id = 127;   

PROMPT "Backing up records in PA_TXN_ACCUM and PA_TXN_ACCUM_DETAILS"

CREATE TABLE xxrs.xxrs_pa_txn_accum_bkp AS (SELECT * FROM PA_TXN_ACCUM);

CREATE TABLE xxrs.xxrs_pa_txn_accum_dtls_bkp AS (SELECT * FROM PA_TXN_ACCUM_DETAILS);

PROMPT "Truncating records in PA_TXN_ACCUM and PA_TXN_ACCUM_DETAILS"

TRUNCATE TABLE PA.PA_TXN_ACCUM;

TRUNCATE TABLE PA.PA_TXN_ACCUM_DETAILS;
