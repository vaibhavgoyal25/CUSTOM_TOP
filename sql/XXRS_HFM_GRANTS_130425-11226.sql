  /**************************************************************************************************
  *                                                                                                 *
  * NAME : XXRS_HFM_GRANTS_130425-11226.sql                                                         *
  *                                                                                                 *
  * DESCRIPTION :  Script to grant permissions on select tables to XXRS_HFM.                        *
  *                                                                                                 *
  * AUTHOR       : Tim cowen                                                                    *
  * DATE WRITTEN : 04/25/2013                                                                       *
  *                                                                                                 *
  * CHANGE CONTROL :                                                                                *
  * Version#     | Genie Ticket #      | WHO             |  DATE        |   REMARKS                 *
  *-------------------------------------------------------------------------------------------------*
  * 1.0.0        | 130425-11226       | Tim Cowen   | 04/25/2013   | Initial Creation          *
  ***************************************************************************************************/
  SET SERVEROUTPUT ON SIZE 100000;
  SET LINE 300;
  SET PAGESIZE 2000;
  SET COLSEP |;
  col file_name   new_value   spool_file_name    noprint
  select 'XXRS_HFM_GRANTS_130425-11226' ||to_char (sysdate, 'mmddyy_hhmiss')||'.log' file_name from dual ;
  spool &spool_file_name
grant select, insert, update, delete on gl.GL_TRACK_DELTA_BALANCES /*130425-11226*/ to XXRS_HFM;
SPOOL OFF;
