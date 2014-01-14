/**************************************************************************************************************
* NAME : XXRS_COMPILE_INVALID_DB_OBJ.sql                                                                      *
*                                                                                                             *
* DESCRIPTION :                                                                                               *
*   Construct dynamic file that will compile all db objects with an INVALID status.                           *
*                                                                                                             *
* AUTHOR       : Pavan Amirineni                                                                              *
* DATE WRITTEN : 29-MAY-2013                                                                                  *
*                                                                                                             *
* CHANGE CONTROL :                                                                                            *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                             *
*-------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  130220-05014     | Pavan Amirineni |  29-MAY-2013   | Initial Creation.                     *
***************************************************************************************************************/
/* $Header: XXRS_COMPILE_INVALID_DB_OBJ.sql 1.0.0 29-MAY-2013 10:46:24 AM Pavan Amirineni $ */
set linesize 132
set pagesize 0
set echo on
col file_name   new_value   spool_file_name    noprint
select 'XXRS_COMPILE_INVALID_&1'||'_'||to_char (sysdate, '_mmddyy_hhmiss')||'.sql' file_name from dual ;

spool &spool_file_name

Select 'Alter '||decode(OBJECT_TYPE,'PACKAGE BODY','PACKAGE',OBJECT_TYPE)||
       ' '||OWNER||'.'||chr(34)||OBJECT_NAME||Chr(34)||' COMPILE '||
       decode(OBJECT_TYPE,'PACKAGE BODY','BODY;',';')
  From DBA_OBJECTS
 Where STATUS = 'INVALID'
   and owner != 'NOETIX_SYS'
   and object_type not in ('JAVA CLASS')
order by object_name
/
spool off
start &spool_file_name
start &spool_file_name