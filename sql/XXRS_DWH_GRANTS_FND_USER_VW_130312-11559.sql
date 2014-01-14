  /**************************************************************************************************
  *                                                                                                 *
  * NAME : XXRS_DWH_GRANTS_FND_USER_VW_130312-11559.sql                                             *
  *                                                                                                 *
  * DESCRIPTION :  Script to grant permissions on FND_USER_VIEW to XXRS_DW_QUERY role               *
  *                                                                                                 *
  *                                                                                                 *
  * AUTHOR       : Vaibhav Goyal                                                                    *
  * DATE WRITTEN : 04/03/2013                                                                       *
  *                                                                                                 *
  * CHANGE CONTROL :                                                                                *
  * Version#     | Genie Ticket #      | WHO             |  DATE        |   REMARKS                 *
  *-------------------------------------------------------------------------------------------------*
  * 1.0.0        | 130312-11559        | Vaibhav Goyal   | 04/03/2013   | Initial Creation          *
  ***************************************************************************************************/
  SET SERVEROUTPUT ON SIZE 100000;
  SET LINE 300;
  SET PAGESIZE 2000;
  SET COLSEP |;
  col file_name   new_value   spool_file_name    noprint
  select 'XXRS_DWH_GRANTS_FND_USER_VW_130312-11559' ||to_char (sysdate, 'mmddyy_hhmiss')||'.log' file_name from dual ;
  spool &spool_file_name

Grant Select ON apps.FND_USER_VIEW TO XXRS_DW_QUERY /*130312-11559*/;

  SPOOL OFF;
