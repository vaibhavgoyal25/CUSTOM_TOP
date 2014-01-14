/**************************************************************************************************************
*                                                                                                             *
* NAME : XXRS_SC_SUPPORT_TEAM_DATAFIX_120716-04393.sql                                                        *
*                                                                                                             *
* DESCRIPTION :                                                                                               *
*   Script to update support team code in service contracts table                                             *
*                                                                                                             *
* AUTHOR       : Vaibhav Goyal                                                                                *
* DATE WRITTEN : 23-JUL-2012                                                                                  *
*                                                                                                             *
* CHANGE CONTROL :                                                                                            *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                             *
*-------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  120716-04393     | Vaibhav Goyal   |  23-JUL-2012   | Initial Creation.                     *
*              |                   |                 |                |                                       *
***************************************************************************************************************/
--
/* $Header: XXRS_SC_SUPPORT_TEAM_DATAFIX_120716-04393.sql 1.0.0 07/23/2011 11:06:24 AM Vaibhav Goyal $ */
--
-- -----------------------------------------------------------------------------
--    ARGUMENTS:
--
--
--    RETURNS:
--
--
-- -----------------------------------------------------------------------------
--

SET SERVEROUTPUT ON SIZE 1000000
SET LINES 100
SET PAGES 10000
SET COLSEP '|'

COL file_name NEW_VALUE spool_file_name NOPRINT

SELECT 'XXRS_SC_SUPPORT_TEAM_DATAFIX_120716-04393_'||TO_CHAR(SYSDATE,'YYYYMMDDHHMISS')||'.log' file_name
FROM DUAL
;

COL org_id FORMAT 9999
COL contract_snid FORMAT 99999999999
COL customer_number FORMAT A15 TRUNC
COL contract_status FORMAT A15 TRUNC
COL support_team FORMAT A15 TRUNC

SET TERM ON

SPOOL &spool_file_name

PROMPT
PROMPT 'BEFORE UPDATE'
PROMPT

select contract_snid,cust_account_id,xsct.support_team 
  from xxrs.xxrs_sc_contract_tbl xsct
 where cust_account_id = '4200043'
   and contract_snid = '441492'
;

PROMPT
PROMPT 'UPDATE FOR SUPPORT TEAM'
PROMPT

UPDATE xxrs.xxrs_sc_contract_tbl xsct
   SET xsct.support_team = '601'
     , last_update_date = SYSDATE
     , last_updated_by = 0 
     , last_update_login = -1
 WHERE 1 = 1 
   AND cust_account_id = '4200043'
   and contract_snid = '441492'
;

PROMPT
PROMPT 'AFTER UPDATE'
PROMPT

select contract_snid,cust_account_id,xsct.support_team 
  from xxrs.xxrs_sc_contract_tbl xsct
 where cust_account_id = '4200043'
   and contract_snid = '441492'
;
SPOOL OFF
