/**************************************************************************************************************
*                                                                                                             *
* NAME : XXRS_SC_PA_PERIOD_DEL_120920-09626.sql                                                               *
*                                                                                                             *
* DESCRIPTION :                                                                                               *
*   Script to delete the PA Calendar periods for SEP-12                                                       *
*                                                                                                             *
* AUTHOR       : Pavan Amirineni                                                                              *
* DATE WRITTEN : 26-SEP-2012                                                                                  *
*                                                                                                             *
* CHANGE CONTROL :                                                                                            *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                             *
*-------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  120920-09626     | Pavan Amirineni |  26-SEP-2012   | Initial Creation.                     *
*              |                   |                 |                |                                       *
***************************************************************************************************************/
--
/* $Header: XXRS_SC_PA_PERIOD_DEL_120920-09626.sql 1.0.0 09/26/2012 11:06:24 AM Pavan Amirineni $ */
--
SET SERVEROUTPUT ON SIZE 1000000
SET LINES 1000
SET PAGESIZE 1000
SET COLSEP '|'
COL file_name NEW_VALUE spool_file_name NOPRINT
SELECT 'XXRS_SC_PA_PERIOD_DEL_120920-09626_'||TO_CHAR(SYSDATE,'YYYYMMDDHHMISS')||'.log' file_name
FROM DUAL;

SPOOL &spool_file_name

-- backup the pa period data


CREATE TABLE PA_PERIODS_14611254
    AS SELECT * FROM PA_PERIODS_ALL
        WHERE PERIOD_NAME In ('SEP-12' , 'SEP2-12');

PROMPT "data Before deleting two periods ('SEP-12', 'SEP2-12') "

   SELECT *
     FROM PA_PERIODS_ALL
    WHERE PERIOD_NAME IN ('SEP-12', 'SEP2-12');

-- delete data from PA_PERIODS_ALL:

PROMPT "Deleting records for PERIOD_NAME IN ('SEP-12', 'SEP2-12') "

 DELETE FROM PA_PERIODS_ALL
  WHERE PERIOD_NAME In ('SEP-12' , 'SEP2-12')
   AND  ORG_ID IN(126, 127);
/      