set serveroutput on size 1000000
/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_ASSETS_NOT_CREATED_IN_IB_131007-11166.sql                                                               *
*                                                                                                                     *
* DESCRIPTION :                                                                                                       *
* Script provided by Oracle per SR 3-7901387051 : Install Base records not created for Inventory receipts.            *
*                                                                                                                     *
* AUTHOR       : Vaibhav Goyal                                                                                        *
* DATE WRITTEN : 10-OCT-2013                                                                                          *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* Version#     |  TICKET          | WHO             |  DATE          |   REMARKS                                      *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  131007-11166    | VAIBHAV GOYAL   |  10-OCT-2013   |  Initial Creation.                             *
**********************************************************************************************************************/
/* $Header: XXRS_ASSETS_NOT_CREATED_IN_IB_131007-11166.sql 1.0.0 10-OCT-2013 10:21:52 AM VAIBHAV GOYAL $ */
SET LINES 1000
SET PAGESIZE 1000
SET COLSEP '|'
COL file_name NEW_VALUE spool_file_name NOPRINT
SELECT 'XXRS_ASSETS_NOT_CREATED_IN_IB_131007-11166_'||TO_CHAR(SYSDATE,'YYYYMMDDHHMISS')||'.log' file_name
FROM DUAL;

SPOOL &spool_file_name

PROMPT "Before Updating xnp_msgs where msg_status is FAILED"
SELECT msg_id,msg_status
FROM xnp_msgs
WHERE msg_status = 'FAILED';

PROMPT "Updating xnp_msgs where msg_status is FAILED"
DECLARE
CURSOR stuck_cur IS
SELECT msg_id
FROM xnp_msgs
WHERE msg_status = 'FAILED';
v_msg_id  xnp_msgs.msg_id%TYPE;
v_msg_status xnp_msgs.msg_status%TYPE;
BEGIN
FOR stuck_rec in stuck_cur
LOOP
BEGIN
-- dbms_output.put_line('Inside '||stuck_rec.msg_id);
xnp_message.fix(
p_msg_id => stuck_rec.msg_id);
EXCEPTION
WHEN others THEN
dbms_output.put_line('Error '||stuck_rec.msg_id);
END;


SELECT msg_id,msg_status
INTO v_msg_id,v_msg_status
FROM xnp_msgs
WHERE msg_id = stuck_rec.msg_id;
dbms_output.put_line(v_msg_id||'|'||v_msg_status);
END LOOP;
END;
/
PROMPT "After Updating xnp_msgs where msg_status was FAILED"
SELECT msg_id,msg_status
FROM xnp_msgs
WHERE msg_status = 'FAILED';