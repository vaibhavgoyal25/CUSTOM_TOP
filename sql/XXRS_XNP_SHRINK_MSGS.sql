/**********************************************************************************************************************
* NAME : XXRS_XNP_SHRINK_MSGS.sql                                                                                     *
*                                                                                                                     *
* DESCRIPTION :                                                                                                       *
*                                                                                                                     *
*                                                                                                                     *
* AUTHOR       : Bruce Martinez                                                                                       *
* DATE WRITTEN : 12-JUL-2011                                                                                          *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* SR#           | Racker Ticket #  | WHO              | DATE            | REMARKS                                     *
*---------------------------------------------------------------------------------------------------------------------*
*  1.0.0        |  110630-03615    | Bruce Martinez  | 12-JUL-2011      | Initial Creation -                          *
*                                                                          Reclaim space via the shrink command       *
*  1.0.1        |  130426-12094    | Bruce Martinez  | 02-MAY-2013      | Initial Run in R12 -                        *
*                                                                       | added code to handle index xnp_msgs_n6      *
*                                                                       | removed reference to xx_xnp_msgs_n99        *
**********************************************************************************************************************/
col bytes        format 999,999,999,999
col owner        format a20
col segment_name format a33 
col segment_type format a20
col MBS          format 999,999,999,999
col wasted       format 999,999,999,999,999

set lines 130 
set pages  99
set time   on 
set timing on 
set echo   on 
-----------------------------------------------------------------------------------------------------------------------
--  Get the number of records and how much space is used by the table and indexes
-----------------------------------------------------------------------------------------------------------------------
  col file_name   new_value   spool_file_name    noprint
  select 'XXRS_XNP_SHRINK_MSGS_130426-12094_' ||to_char (sysdate, 'mmddyy_hhmiss')||'.log' file_name from dual ;
  spool &spool_file_name
 
SELECT count (*) FROM XNP.XNP_MSGS;   

SELECT segment_name, segment_type, bytes 
  FROM dba_segments 
 WHERE segment_name like 'XNP_MSGS%' 
    OR segment_name like 'XX_XNP_MSGS%' 
ORDER BY 1;
-----------------------------------------------------------------------------------------------------------------------
--  Get amount of wasted space  
-----------------------------------------------------------------------------------------------------------------------
  SELECT a.owner,
 	 a.segment_name,
         a.segment_type,
         round(a.bytes/1024/1024,0) MBS,
	 round((a.bytes-(b.num_rows*b.avg_row_len) )/1024/1024,0) WASTED
    FROM dba_segments a, dba_tables b
   WHERE a.owner=b.owner
     AND a.owner not like 'SYS%'
     AND a.segment_name = b.table_name
     AND a.segment_name like 'XNP%'
GROUP BY a.owner, a.segment_name, a.segment_type, round(a.bytes/1024/1024,0) ,round((a.bytes-(b.num_rows*b.avg_row_len) )/1024/1024,0)
  HAVING ROUND(bytes/1024/1024,0) > 100
ORDER BY ROUND(bytes/1024/1024,0) DESC ;
-----------------------------------------------------------------------------------------------------------------------
--  Enable row movment and shrink the table and indexes
--  The runtime for the table XNP.XNP_MSGS was 43 minutes in SPURS 
-----------------------------------------------------------------------------------------------------------------------

ALTER TABLE XNP.XNP_MSGS ENABLE ROW MOVEMENT;       
ALTER TABLE XNP.XNP_MSGS        SHRINK SPACE ;
ALTER INDEX XNP.xnp_msgs_n1     SHRINK SPACE ;
ALTER INDEX XNP.xnp_msgs_n2     SHRINK SPACE ;
ALTER INDEX XNP.xnp_msgs_n3     SHRINK SPACE ;
ALTER INDEX XNP.xnp_msgs_n5     SHRINK SPACE ;

--#130426-12094 added code to handle index xnp_msgs_n6
ALTER INDEX XNP.xnp_msgs_n6     SHRINK SPACE ;
ALTER INDEX XNP.xnp_msgs_u1     SHRINK SPACE ;
ALTER TABLE xnp.xnp_msgs DISABLE ROW MOVEMENT;
-----------------------------------------------------------------------------------------------------------------------
-- Now that we have reclaimed the space, let see how much we are using now.  
-----------------------------------------------------------------------------------------------------------------------

SELECT segment_name, segment_type, bytes 
  FROM dba_segments
 WHERE segment_name like 'XNP_MSGS%' 
    OR segment_name like 'XX_XNP_MSGS%'
ORDER BY 1;

SELECT a.owner,
       a.segment_name,
       a.segment_type,
       round(a.bytes/1024/1024,0) MBS,
       round((a.bytes-(b.num_rows*b.avg_row_len) )/1024/1024,0) WASTED
  FROM dba_segments a, dba_tables b
 WHERE a.owner=b.owner
   AND a.owner not like 'SYS%'
   AND a.segment_name = b.table_name
   AND a.segment_name like 'XNP_%'
GROUP BY a.owner, a.segment_name, a.segment_type, round(a.bytes/1024/1024,0) ,round((a.bytes-(b.num_rows*b.avg_row_len) )/1024/1024,0)
  HAVING ROUND(bytes/1024/1024,0) >100
ORDER BY ROUND(bytes/1024/1024,0) DESC ;

spool off 
EXIT;  

