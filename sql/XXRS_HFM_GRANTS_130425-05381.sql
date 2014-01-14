  /**************************************************************************************************
  *                                                                                                 *
  * NAME : XXRS_HFM_GRANTS_130425-05381.sql                                                         *
  *                                                                                                 *
  * DESCRIPTION :  Script to grant permissions on select tables to XXRS_HFM.                        *
  *                                                                                                 *
  * AUTHOR       : VAIBHAV GOYAL                                                                    *
  * DATE WRITTEN : 04/25/2013                                                                       *
  *                                                                                                 *
  * CHANGE CONTROL :                                                                                *
  * Version#     | Genie Ticket #      | WHO             |  DATE        |   REMARKS                 *
  *-------------------------------------------------------------------------------------------------*
  * 1.0.0        | 130425-05381        | Vaibhav Goyal   | 04/25/2013   | Initial Creation          *
  ***************************************************************************************************/
  SET SERVEROUTPUT ON SIZE 100000;
  SET LINE 300;
  SET PAGESIZE 2000;
  SET COLSEP |;
  col file_name   new_value   spool_file_name    noprint
  select 'XXRS_HFM_GRANTS_130425-05381' ||to_char (sysdate, 'mmddyy_hhmiss')||'.log' file_name from dual ;
  spool &spool_file_name
grant select on gl.GL_PERIOD_STATUSES to XXRS_HFM /*130425-05381*/ ;
Create synonym XXRS_HFM.GL_PERIOD_STATUSES for GL.GL_PERIOD_STATUSES;
SPOOL OFF;
