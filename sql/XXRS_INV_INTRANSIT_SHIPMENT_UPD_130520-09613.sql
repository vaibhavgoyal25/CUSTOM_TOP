/**************************************************************************************************************
* NAME : XXRS_INV_INTRANSIT_SHIPMENT_UPD_130520-09613.sql                                                     *
*                                                                                                             *
* DESCRIPTION :                                                                                               *
*   Script to update serial numbers for items intransit receipt is not able to received.                      *
*                                                                                                             *
* AUTHOR       : Vaibhav Goyal                                                                                *
* DATE WRITTEN : 20-MAY-2013                                                                                  *
*                                                                                                             *
* CHANGE CONTROL :                                                                                            *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                             *
*-------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  130520-09613     | Vaibhav Goyal   |  20-MAY-2013   | Initial Creation.                     *
***************************************************************************************************************/
--
/* $Header: XXRS_INV_INTRANSIT_SHIPMENT_UPD_130520-09613.sql 1.0.0 05/17/2013 11:30:00 AM Vaibhav Goyal $ */
--
SET SERVEROUTPUT ON SIZE 1000000
SET LINES 1000
SET PAGESIZE 1000
SET COLSEP '|'
COL file_name NEW_VALUE spool_file_name NOPRINT
SELECT 'XXRS_INV_INTRANSIT_SHIPMENT_UPD_130520-09613_'||TO_CHAR(SYSDATE,'YYYYMMDDHHMISS')||'.log' file_name
FROM DUAL;

SPOOL &spool_file_name

PROMPT "Before Updating Serial Numbers for items intransit receipt is not able to received"

SELECT serial_number
     , inventory_item_id
     , group_mark_id
     , line_mark_id
     , lot_line_mark_id 
FROM mtl_serial_numbers
where INVENTORY_ITEM_ID = 688009
and SERIAL_NUMBER in
('1980831', '1980833', '1980834', '1980836')
and CURRENT_ORGANIZATION_ID = 132
and GROUP_MARK_ID is not null
and LINE_MARK_ID is not null
and LOT_LINE_MARK_ID is not null;

PROMPT "Updating Serial Numbers for items intransit receipt is not able to received"

update mtl_serial_numbers
set GROUP_MARK_ID = null,
LINE_MARK_ID = null, LOT_LINE_MARK_ID = null
where INVENTORY_ITEM_ID = 688009
and SERIAL_NUMBER in
('1980831', '1980833', '1980834', '1980836')
and CURRENT_ORGANIZATION_ID = 132
and GROUP_MARK_ID is not null
and LINE_MARK_ID is not null
and LOT_LINE_MARK_ID is not null; 

PROMPT "After Updating Serial Number information for items intransit receipt in not able to received"   

SELECT serial_number
     , inventory_item_id
     , group_mark_id
     , line_mark_id
     , lot_line_mark_id 
FROM mtl_serial_numbers
where INVENTORY_ITEM_ID = 688009
and SERIAL_NUMBER in
('1980831', '1980833', '1980834', '1980836')
and CURRENT_ORGANIZATION_ID = 132;  
