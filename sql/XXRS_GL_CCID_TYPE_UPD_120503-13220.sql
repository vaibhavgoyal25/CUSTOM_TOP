/**************************************************************************************************
* NAME : XXRS_GL_CCID_TYPE_UPD_120503-13220.sql                                                   *
* DESCRIPTION :                                                                                   *
* Update GL CCID Account Type                                                                     *
*                                                                                                 *
* AUTHOR       : Pavan Amirineni                                                                  *
* DATE WRITTEN : 14-MAY-2012                                                                      *
*                                                                                                 *
* CHANGE CONTROL :                                                                                *
* Version# | Ticket #     |  WHO            | DATE       |   REMARKS                              *
*-------------------------------------------------------------------------------------------------*
* 1.0.0    | 120503-13220 | Pavan Amirineni | 14-MAY-2012 | Initial Creation                      *
***************************************************************************************************/
/* $Header: XXRS_GL_CCID_TYPE_UPD_120503-13220.sql 1.0.0 14-MAY-2012 10:54:39 AM Pavan AMirineni $ */
SET SERVEROUTPUT ON SIZE 1000000;
SET LINESIZE 600
SET PAGESIZE 300
col file_name   new_value   spool_file_name    noprint
select 'XXRS_GL_CCID_TYPE_UPD_120503-13220'||to_char (sysdate, '_mmddyy_hhmiss')||'.log' file_name from dual ;
spool &spool_file_name


PROMPT before updating account type

SELECT code_combination_id   
     , account_type
     , chart_of_accounts_id   
     , last_updated_by 
     , last_update_date       
  FROM gl_code_combinations   
 WHERE segment3 IN ( '430000','440500', '449500','460100','460250','460750')  
   AND chart_of_accounts_id = 101
   AND account_type = 'E' ;
   
PROMPT updating account type

UPDATE gl_code_combinations
   SET account_type = 'R'
     , last_updated_by = 0 
     , last_update_date = SYSDATE
 WHERE segment3 IN ( '430000','440500', '449500','460100','460250','460750')  
   AND chart_of_accounts_id = 101
   AND account_type = 'E';
   
PROMPT after updating account type
   
SELECT code_combination_id
     , account_type
     , chart_of_accounts_id
  FROM gl_code_combinations   
 WHERE segment3 IN ( '430000','440500', '449500','460100','460250','460750')  
   AND chart_of_accounts_id = 101
   AND account_type = 'E';   