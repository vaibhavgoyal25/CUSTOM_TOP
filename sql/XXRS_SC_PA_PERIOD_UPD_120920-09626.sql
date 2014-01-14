/**************************************************************************************************************
*                                                                                                             *
* NAME : XXRS_SC_PA_PERIOD_UPD_120920-09626.sql                                                               *
*                                                                                                             *
* DESCRIPTION :                                                                                               *
*   Script to update PA PERIOD entries in PA transactional tables                                             *
*                                                                                                             *
* AUTHOR       : Pavan Amirineni                                                                              *
* DATE WRITTEN : 26-SEP-2012                                                                                  *
*                                                                                                             *
* CHANGE CONTROL :                                                                                            *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                             *
*-------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  120920-09626     | Pavan Amirineni |  26-SEP-2012   | Initial Creation.                     *
***************************************************************************************************************/
--
/* $Header: XXRS_SC_PA_PERIOD_UPD_120920-09626.sql 1.0.0 09/26/2012 11:06:24 AM Pavan Amirineni $ */
--
SET SERVEROUTPUT ON SIZE 1000000
SET LINES 1000
SET PAGESIZE 1000
SET COLSEP '|'
COL file_name NEW_VALUE spool_file_name NOPRINT
SELECT 'XXRS_SC_PA_PERIOD_UPD_120920-09626_'||TO_CHAR(SYSDATE,'YYYYMMDDHHMISS')||'.log' file_name
FROM DUAL;
-- backup the pa period data

SPOOL &spool_file_name

PROMPT "Updating following records in PA_CC_DIST_LINES_ALL "

PROMPT "CC_DIST_LINE_ID"

SELECT CC_DIST_LINE_ID
  FROM PA_CC_DIST_LINES_ALL   
 WHERE PA_PERIOD_NAME = 'SEP2-12' 
   AND ORG_ID = 127;
  
--
UPDATE PA_CC_DIST_LINES_ALL
   SET pa_period_name = 'SEP-12'
     , last_update_date = SYSDATE
     , last_updated_by = 0
 WHERE PA_PERIOD_NAME = 'SEP2-12' 
   AND ORG_ID = 127;

PROMPT "Updating following records in PA_COST_DISTRIBUTION_LINES_ALL "

PROMPT "expenditure_item_id"

CREATE TABLE XXRS.XXRS_PA_COST_DIST_LINES_ALL AS 
   SELECT *
     FROM PA_COST_DISTRIBUTION_LINES_ALL
    WHERE PA_PERIOD_NAME = 'SEP2-12';  

SELECT expenditure_item_id
  FROM PA_COST_DISTRIBUTION_LINES_ALL
 WHERE PA_PERIOD_NAME = 'SEP2-12' 
   AND ORG_ID = 127;
      
--   
UPDATE PA_COST_DISTRIBUTION_LINES_ALL
   SET pa_period_name = 'SEP-12'
 WHERE pa_period_name = 'SEP2-12' 
   AND ORG_ID = 127;

PROMPT "Updating following records in PA_CC_DIST_LINES_AR "

PROMPT "purge_batch_id"

SELECT purge_batch_id
  FROM PA_CC_DIST_LINES_AR
 WHERE PA_PERIOD_NAME = 'SEP2-12' 
   AND ORG_ID = 127;   

--   
UPDATE PA_CC_DIST_LINES_AR
   SET PA_PERIOD_NAME = 'SEP-12'
     , last_update_date = SYSDATE
     , last_updated_by = 0
 WHERE PA_PERIOD_NAME = 'SEP2-12' 
   AND ORG_ID = 127;

PROMPT "Updating following records in PA_COMMITMENT_TXNS "

PROMPT "cmt_line_id"

SELECT cmt_line_id
  FROM PA_COMMITMENT_TXNS   
 WHERE pa_period = 'SEP2-12';

UPDATE PA_COMMITMENT_TXNS
   SET pa_period = 'SEP-12'
     , last_update_date = SYSDATE
     , last_updated_by = 0
 WHERE pa_period = 'SEP2-12';

PROMPT "Updating following records in PA_COMMITMENT_TXNS_TMP "

PROMPT "project_id,task_id"

SELECT project_id
     , task_id
  FROM PA_COMMITMENT_TXNS_TMP
 WHERE pa_period = 'SEP2-12';

UPDATE PA_COMMITMENT_TXNS_TMP
   SET pa_period = 'SEP-12'   
 WHERE pa_period = 'SEP2-12';


PROMPT "Updating following records in PA_COST_DIST_LINES_AR "

PROMPT "PURGE_BATCH_ID"

SELECT PURGE_BATCH_ID
  FROM PA_COST_DIST_LINES_AR;

UPDATE PA_COST_DIST_LINES_AR
   SET pa_period_name = 'SEP-12'
 WHERE pa_period_name = 'SEP2-12' 
   AND org_id = 127;
   
PROMPT "Updating following records in PA_DRAFT_INVOICES_ALL "

PROMPT "PROJECT_ID"   

SELECT PROJECT_ID
  FROM PA_DRAFT_INVOICES_ALL
 WHERE pa_period_name = 'SEP2-12'; 
   
UPDATE PA_DRAFT_INVOICES_ALL
   SET pa_period_name = 'SEP-12'
     , last_update_date = SYSDATE
     , last_updated_by = 0
 WHERE pa_period_name = 'SEP2-12' 
   AND org_id = 127;

PROMPT "Updating following records in PA_DRAFT_INVOICES_AR "

PROMPT "PURGE_BATCH_ID"   

SELECT PURGE_BATCH_ID
  FROM PA_DRAFT_INVOICES_AR
 WHERE pa_period_name = 'SEP2-12'; 

UPDATE PA_DRAFT_INVOICES_AR
   SET pa_period_name = 'SEP-12'
     , last_update_date = SYSDATE
     , last_updated_by = 0
 WHERE PA_PERIOD_NAME = 'SEP2-12' 
   AND ORG_ID = 127; 

PROMPT "Updating following records in PA_DRAFT_REVENUES_ALL "

PROMPT "PROJECT_ID"   

SELECT PROJECT_ID
  FROM PA_DRAFT_REVENUES_ALL
 WHERE pa_period_name = 'SEP2-12'; 

UPDATE PA_DRAFT_REVENUES_ALL
   SET PA_PERIOD_NAME = 'SEP-12'
     , last_update_date = SYSDATE
     , last_updated_by = 0
 WHERE PA_PERIOD_NAME = 'SEP2-12' 
   AND ORG_ID = 127;

PROMPT "Updating following records in PA_DRAFT_REVENUES_AR"

PROMPT "PURGE_BATCH_ID"

SELECT PURGE_BATCH_ID 
  FROM PA_DRAFT_REVENUES_AR  
 WHERE PA_PERIOD_NAME = 'SEP2-12'; 
  
UPDATE PA_DRAFT_REVENUES_AR
   SET PA_PERIOD_NAME = 'SEP-12'
     , last_update_date = SYSDATE
     , last_updated_by = 0
 WHERE PA_PERIOD_NAME = 'SEP2-12' 
   AND ORG_ID = 127;

PROMPT "Updating following records in PA_FP_CPY_PERIODS_TMP"

PROMPT "PA_PERIOD_NAME"

SELECT PA_PERIOD_NAME
  FROM PA_FP_CPY_PERIODS_TMP
 WHERE PA_PERIOD_NAME = 'SEP2-12';

UPDATE PA_FP_CPY_PERIODS_TMP
   SET PA_PERIOD_NAME = 'SEP-12'
 WHERE PA_PERIOD_NAME = 'SEP2-12';


PROMPT "Updating following records in PA_GL_PA_PERIODS_TMP"

UPDATE PA_GL_PA_PERIODS_TMP
   SET PA_PERIOD_NAME = 'SEP-12'
 WHERE PA_PERIOD_NAME = 'SEP2-12';


PROMPT "Updating following records in PA_PROJECT_EVENT_ACCUM"

UPDATE PA_PROJECT_EVENT_ACCUM
   SET PA_PERIOD = 'SEP-12'
 WHERE PA_PERIOD = 'SEP2-12';


PROMPT "Updating following records in PA_PROJECT_EXP_ITEM_ACCUM"

PROMPT "PROJECT_ID, TASK_ID"

SELECT project_id, task_id
  FROM PA_PROJECT_EXP_ITEM_ACCUM
 WHERE PA_PERIOD = 'SEP2-12';

UPDATE PA_PROJECT_EXP_ITEM_ACCUM
   SET PA_PERIOD = 'SEP-12'
 WHERE PA_PERIOD = 'SEP2-12';

PROMPT "Updating following records in PA_REP_UTIL_SUMM_TMP"

PROMPT "ROW_ID"

SELECT row_id
  FROM PA_REP_UTIL_SUMM00_TMP
 WHERE PA_PERIOD_NAME = 'SEP2-12';

UPDATE PA_REP_UTIL_SUMM00_TMP
   SET PA_PERIOD_NAME = 'SEP-12'
 WHERE PA_PERIOD_NAME = 'SEP2-12';
 
PROMPT "Updating following records in PA_REP_UTIL_SUMM_TMP"

PROMPT "OBJECT_ID,VERSION_ID"

SELECT object_id,version_id
  FROM PA_REP_UTIL_SUMM_TMP 
 WHERE PA_PERIOD_NAME = 'SEP2-12';
 
UPDATE PA_REP_UTIL_SUMM_TMP
   SET PA_PERIOD_NAME = 'SEP-12'
 WHERE PA_PERIOD_NAME = 'SEP2-12';

PROMPT "Updating following records in PA_TXN_ACCUM"

PROMPT "TXN_ACCUM_ID"

SELECT TXN_ACCUM_ID
  FROM PA_TXN_ACCUM
 WHERE PA_PERIOD = 'SEP2-12'; 

UPDATE PA_TXN_ACCUM
   SET PA_PERIOD = 'SEP-12'
 WHERE PA_PERIOD = 'SEP2-12';

PROMPT "Updating following records in PA_TXN_ACCUM_AR "

PROMPT "purge_batch_id"

SELECT purge_batch_id
  FROM PA_TXN_ACCUM_AR
 WHERE PA_PERIOD = 'SEP2-12'; 

UPDATE PA_TXN_ACCUM_AR
   SET PA_PERIOD = 'SEP-12'
     , last_update_date = SYSDATE
     , last_updated_by = 0
 WHERE PA_PERIOD = 'SEP2-12';

PROMPT "Updating following records in PA_BUDGET_LINES "

PROMPT "RESOURCE_ASSIGNMENT_ID"

SELECT RESOURCE_ASSIGNMENT_ID 
  FROM PA_BUDGET_LINES
 WHERE PERIOD_NAME = 'SEP2-12'; 

UPDATE PA_BUDGET_LINES
   SET PERIOD_NAME = 'SEP-12'
     , last_update_date = SYSDATE
     , last_updated_by = 0
 WHERE PERIOD_NAME = 'SEP2-12';

PROMPT "Updating following records in PJI_TIME_CAL_PERIOD "

PROMPT "CAL_PERIOD_ID, SEQUENCE"

SELECT CAL_PERIOD_ID
     , SEQUENCE 
 FROM PJI_TIME_CAL_PERIOD
WHERE NAME = 'SEP2-12';

UPDATE PJI_TIME_CAL_PERIOD
   SET NAME = 'SEP-12'
     , last_update_date = SYSDATE
     , last_updated_by = 0
 WHERE NAME = 'SEP2-12';
 
/