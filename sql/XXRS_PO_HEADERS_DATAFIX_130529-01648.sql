/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_PO_HEADERS_DATAFIX_130529-01648.sql                                                                     *
*                                                                                                                     *
* DESCRIPTION :                                                                                                       *
* Script to Update po_headers_all for given po_header_id.                                                             *
*                                                                                                                     *
* AUTHOR       : VAIBHAV GOYAL                                                                                        *
* DATE WRITTEN : 11-JUN-2013                                                                                          *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* Version#     |  TICKET          | WHO             |  DATE          |   REMARKS                                      *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  130529-01648    | VAIBHAV GOYAL   |  11-JUN-2013   |  Initial Build                                 *
**********************************************************************************************************************/
/* $Header: XXRS_PO_HEADERS_DATAFIX_130529-01648.sql 1.0.0 11-JUN-2013 02:00:00 PM VAIBHAV GOYAL $ */
--
SET SERVEROUTPUT ON SIZE 1000000
SET LINES 1000
SET PAGESIZE 1000
SET COLSEP '|'
COL file_name NEW_VALUE spool_file_name NOPRINT
SELECT 'XXRS_PO_HEADERS_DATAFIX_130529-01648_'||TO_CHAR(SYSDATE,'YYYYMMDDHHMISS')||'.log' file_name
FROM DUAL;

SPOOL &spool_file_name

PROMPT "Before Updating po_headers_all for po_header_id = 2954997 and revision_num = 1"

SELECT po_header_id,revision_num
  FROM po_headers_all
 WHERE po_header_id = 2954997 
   and revision_num=1;


PROMPT "Updating ar_adjustments_all for po_header_id = 2954997 and revision_num = 1"


update po_headers_all 
   set revision_num = 4 
 where po_header_id = 2954997 
   and revision_num=1;


PROMPT "After Updating ar_adjustments_all for po_header_id = 2954997 "

SELECT po_header_id,revision_num
  FROM po_headers_all
 WHERE po_header_id = 2954997 
   and revision_num=4;


