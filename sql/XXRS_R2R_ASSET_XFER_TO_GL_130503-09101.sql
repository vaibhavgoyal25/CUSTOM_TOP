/**************************************************************************************************************
* NAME : XXRS_R2R_ASSET_XFER_TO_GL_130503-09101.sql                                                           *
*                                                                                                             *
* DESCRIPTION :                                                                                               *
*   Script to update GL_TRANSFER_STATUS_CODE of given Assets.                                                 *
*                                                                                                             *
* AUTHOR       : Vaibhav Goyal                                                                                *
* DATE WRITTEN : 28-MAY-2013                                                                                  *
*                                                                                                             *
* CHANGE CONTROL :                                                                                            *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                             *
*-------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  130503-09101     | Vaibhav Goyal   |  28-MAY-2013   | Initial Creation.                     *
***************************************************************************************************************/
--
/* $Header: XXRS_R2R_ASSET_XFER_TO_GL_130503-09101.sql 1.0.0 05/28/2013 11:30:00 AM Vaibhav Goyal $ */
--
SET SERVEROUTPUT ON SIZE 1000000
SET LINES 1000
SET PAGESIZE 1000
SET COLSEP '|'
set timing on
set time on 
set echo on 

COL file_name NEW_VALUE spool_file_name NOPRINT
SELECT 'XXRS_R2R_ASSET_XFER_TO_GL_130503-09101_'||TO_CHAR(SYSDATE,'YYYYMMDDHHMISS')||'.log' file_name
FROM DUAL;

SPOOL &spool_file_name

PROMPT "Creating Table XLA_AE_HEADERS_CURBU to take backup of XLA_AE_HEADERS before update"

create table XLA_AE_HEADERS_CURBU 
as 
select AE_HEADER_ID, 
       ENTITY_ID, 
       EVENT_ID, 
       APPLICATION_ID, 
       LEDGER_ID, 
       GL_TRANSFER_STATUS_CODE 
from XLA_AE_HEADERS;

PROMPT "Creating Table XLA_AE_HEADERS_CUROP to store effected rows of XLA_AE_HEADERS"

create table XLA_AE_HEADERS_CUROP as 
select AE_HEADER_ID, 
       ENTITY_ID,
       EVENT_ID, 
       APPLICATION_ID, 
       LEDGER_ID,
       GL_TRANSFER_STATUS_CODE
from XLA_AE_HEADERS XAH 
WHERE 
XAH.APPLICATION_ID = 140 
AND XAH.LEDGER_ID = 1001
AND XAH.GL_TRANSFER_STATUS_CODE = 'N' 
AND XAH.ACCOUNTING_ENTRY_STATUS_CODE = 'F' 
AND XAH.ACCOUNTING_DATE BETWEEN TO_DATE('01-09-2007','DD-MM-YYYY') AND TO_DATE('31-03-2012','DD-MM-YYYY') 
AND EXISTS (SELECT 1 
FROM XLA_EVENTS XE 
WHERE XE.APPLICATION_ID = 140
AND XE.EVENT_ID = XAH.EVENT_ID 
AND XE.EVENT_ID = XAH.EVENT_ID 
AND XE.EVENT_STATUS_CODE = 'P' 
AND XE.PROCESS_STATUS_CODE = 'P'); 

PROMPT "Get The count of Rows that will be Updated"

select count(*)
from XLA_AE_HEADERS_CUROP;


PROMPT "Updating GL_TRANSFER_STATUS_CODE of XLA_AE_HEADERS"   

declare

CURSOR c_needed_xla_updates is

select xah.AE_HEADER_ID, xah.ENTITY_ID, xah.EVENT_ID
from XLA_AE_HEADERS_CUROP xahc,
XLA_AE_HEADERS xah
where xah.AE_HEADER_ID = xahc.AE_HEADER_ID
and xah.ENTITY_ID = xahc.ENTITY_ID
and xah.EVENT_ID = xahc. EVENT_ID;

v_counter NUMBER(10) := 0;

begin

for c_rec in c_needed_xla_updates 
loop

v_counter := v_counter+1;

update XLA_AE_HEADERS
set GL_TRANSFER_STATUS_CODE = 'NT' 
where AE_HEADER_ID = c_rec.AE_HEADER_ID
and ENTITY_ID = c_rec.ENTITY_ID
and EVENT_ID = c_rec.EVENT_ID
and APPLICATION_ID = 140
AND LEDGER_ID = 1001;

IF mod(v_counter,1000) = 0 THEN
COMMIT;
END IF;

end loop;

COMMIT;

end;
 
/
