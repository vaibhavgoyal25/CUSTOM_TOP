/**************************************************************************************************************
* NAME : XXRS_AR_IMBALANCE_130516-02913.sql                                                                   *
*                                                                                                             *
* DESCRIPTION :                                                                                               *
*   Script to Correct AR Imbalance for an Adjustment.                                                         *
*                                                                                                             *
* AUTHOR       : Vaibhav Goyal                                                                                *
* DATE WRITTEN : 20-MAY-2013                                                                                  *
*                                                                                                             *
* CHANGE CONTROL :                                                                                            *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                             *
*-------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  130516-02913     | Vaibhav Goyal   |  20-MAY-2013   | Initial Creation.                     *
***************************************************************************************************************/
--
/* $Header: XXRS_AR_IMBALANCE_130516-02913.sql 1.0.0 05/20/2013 10:46:24 AM Vaibhav Goyal $ */
--
SET SERVEROUTPUT ON SIZE 1000000
SET LINES 1000
SET PAGESIZE 1000
SET COLSEP '|'
COL file_name NEW_VALUE spool_file_name NOPRINT
SELECT 'XXRS_AR_IMBALANCE_130516-02913_'||TO_CHAR(SYSDATE,'YYYYMMDDHHMISS')||'.log' file_name
FROM DUAL;

SPOOL &spool_file_name

PROMPT "Before Updating ar_adjustments_all for adjustment_id = 1615946"

SELECT adjustment_id,amount
  FROM ar_adjustments_all 
 WHERE adjustment_id = 1615946; 


PROMPT "Updating ar_adjustments_all for adjustment_id = 1615946"


update ar_adjustments_all
set amount = -231.51
where adjustment_id = 1615946;


PROMPT "After Updating ar_adjustments_all for adjustment_id = 1615946"   

SELECT adjustment_id,amount
  FROM ar_adjustments_all 
 WHERE adjustment_id = 1615946; 


PROMPT "Before Updating ar_distributions_all for source_id = 1615946 and line_id = 12742584"

SELECT source_id,line_id,amount_cr
  FROM ar_distributions_all
 WHERE source_id = 1615946
   AND line_id = 12742584;  


PROMPT "Updating ar_distributions_all for source_id = 1615946 and line_id = 12742584" 

update ar_distributions_all
set amount_cr = 231.51
where source_id = 1615946
and line_id = 12742584;

PROMPT "After Updating ar_distributions_all for source_id = 1615946 and line_id = 12742584"

SELECT source_id,line_id,amount_cr
  FROM ar_distributions_all
 WHERE source_id = 1615946
   AND line_id = 12742584;      
