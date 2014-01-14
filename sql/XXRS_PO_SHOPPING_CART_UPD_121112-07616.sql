/**************************************************************************************************************
* NAME : XXRS_PO_SHOPPING_CART_UPD_121112-07616.sql                                                           *
*                                                                                                             *
* DESCRIPTION :                                                                                               *
*   Script to update PO Requisition Shopping Cart For User RAVI5255.                                          *
*                                                                                                             *
* AUTHOR       : Vaibhav Goyal                                                                                *
* DATE WRITTEN : 12-NOV-2012                                                                                  *
*                                                                                                             *
* CHANGE CONTROL :                                                                                            *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                             *
*-------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  121112-07616     | Vaibhav Goyal   |  12-NOV-2012   | Initial Creation.                     *
***************************************************************************************************************/
--
/* $Header: XXRS_PO_SHOPPING_CART_UPD_121112-07616.sql 1.0.0 11/12/2012 10:46:24 AM Vaibhav Goyal $ */
--
SET SERVEROUTPUT ON SIZE 1000000
SET LINES 1000
SET PAGESIZE 1000
SET COLSEP '|'
COL file_name NEW_VALUE spool_file_name NOPRINT
SELECT 'XXRS_PO_SHOPPING_CART_UPD_121112-07616_'||TO_CHAR(SYSDATE,'YYYYMMDDHHMISS')||'.log' file_name
FROM DUAL;

SPOOL &spool_file_name

PROMPT "Before Updating Shopping Cart For User RAVI5255"

SELECT requisition_header_id, active_shopping_cart_flag
  FROM po.po_requisition_headers_all
 WHERE requisition_header_id =
          (SELECT requisition_header_id
             FROM PO.po_requisition_headers_all
            WHERE     active_shopping_cart_flag = 'Y'
                  AND last_updated_by = (SELECT user_id
                                           FROM applsys.fnd_user
                                          WHERE user_name LIKE 'RAVI5255')
                  AND NVL (org_id, -1) = '126'); 

PROMPT "Updating Shopping Cart For User RAVI5255 to N"

UPDATE po.po_requisition_headers_all
   SET active_shopping_cart_flag = 'N',
       last_updated_by     = 0,
       last_update_date    = SYSDATE,
       last_update_login   = 0
 WHERE requisition_header_id =
          (SELECT requisition_header_id
             FROM PO.po_requisition_headers_all
            WHERE     active_shopping_cart_flag = 'Y'
                  AND last_updated_by = (SELECT user_id
                                           FROM applsys.fnd_user
                                          WHERE user_name LIKE 'RAVI5255')
                  AND NVL (org_id, -1) = '126');   


PROMPT "After Updating Shopping Cart For User RAVI5255 to N"
   
SELECT requisition_header_id, active_shopping_cart_flag
  FROM po.po_requisition_headers_all
 WHERE requisition_header_id =
          (SELECT requisition_header_id
             FROM PO.po_requisition_headers_all
            WHERE     active_shopping_cart_flag = 'N'
                  AND last_updated_by = 0
                  AND NVL (org_id, -1) = '126');        
/