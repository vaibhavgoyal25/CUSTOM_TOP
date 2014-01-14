/**************************************************************************************************************
*                                                                                                             *
* NAME : XXRS_SC_SALES_PERSON_UPD_121101-07727.sql                                                            *
*                                                                                                             *
* DESCRIPTION :                                                                                               *
*   Script to update person_id in sales_person_table                                                          *
*                                                                                                             *
* AUTHOR       : Pavan Amirineni                                                                              *
* DATE WRITTEN : 01-NOV-2012                                                                                  *
*                                                                                                             *
* CHANGE CONTROL :                                                                                            *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                             *
*-------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  121101-07727     | Pavan Amirineni |  01-NOV-2012   | Initial Creation.                     *
***************************************************************************************************************/
--
/* $Header: XXRS_SC_SALES_PERSON_UPD_121101-07727.sql 1.0.0 11/01/2012 10:46:24 AM Pavan Amirineni $ */
--

SET SERVEROUTPUT ON SIZE 1000000
SET LINES 1000
SET PAGESIZE 1000
SET COLSEP '|'
COL file_name NEW_VALUE spool_file_name NOPRINT
SELECT 'XXRS_SC_SALES_PERSON_UPD_121101-07727_'||TO_CHAR(SYSDATE,'YYYYMMDDHHMISS')||'.html' file_name
FROM DUAL;
-- backup the pa period data

spool &spool_file_name

PROMPT "Before updating XXRS_SC_SALES_PERSON_TBL "

SELECT con.contract_snid, person_snid, org_id
  FROM XXRS.XXRS_SC_SALES_PERSON_TBL sc
     , xxrs.xxrs_sc_contract_tbl  con
 WHERE person_snid = 887
   AND con.contract_snid = sc.contract_snid
   AND con.contract_snid != 610005; 

PROMPT "Update sales person in XXRS_SC_SALES_PERSON_TBL " 
 
UPDATE XXRS.XXRS_SC_SALES_PERSON_TBL
   SET person_snid = 891 -- JUSTIN LEONOR id 
     , last_update_date = SYSDATE
     , last_updated_by = 0 
 WHERE person_snid = 887
   AND contract_snid != 610005;   

PROMPT "after update sales person in XXRS_SC_SALES_PERSON_TBL " 
 
SELECT contract_snid, person_snid
  FROM XXRS.XXRS_SC_SALES_PERSON_TBL
 WHERE person_snid = 887
  AND contract_snid != 610005;
/