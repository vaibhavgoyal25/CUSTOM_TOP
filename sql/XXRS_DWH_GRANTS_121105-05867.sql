  /**************************************************************************************************
  *                                                                                                 *
  * NAME : XXRS_DWH_GRANTS_121105-05867.sql                                                         *
  *                                                                                                 *
  * DESCRIPTION :                                                                                   *
  * Script to grant permissions on select tables to XXRS_DW_QUERY role                              *
  *                                                                                                 *
  * AUTHOR       : Vaibhav Goyal                                                                    *
  * DATE WRITTEN : 03/22/2012                                                                       *
  *                                                                                                 *
  * CHANGE CONTROL :                                                                                *
  * Version#     | Genie Ticket #      | WHO             |  DATE        |   REMARKS                 *
  *-------------------------------------------------------------------------------------------------*
  * 1.0.0        | 121105-05867        | Vaibhav Goyal   | 11/06/2012   | Initial Creation          *
  ***************************************************************************************************/
  SET SERVEROUTPUT ON SIZE 100000;
  SET LINE 300;
  SET PAGESIZE 2000;
  set echo on ;
  SET COLSEP |;
  col file_name   new_value   spool_file_name    noprint
  select 'XXRS_DWH_GRANTS_121105-05867_' ||to_char (sysdate, 'mmddyy_hhmiss')||'.log' file_name from dual ;
  spool &spool_file_name

  GRANT SELECT ON APPS.GL_LEDGERS TO XXRS_DW_QUERY /*121105-05867*/;
  GRANT SELECT ON APPS.GL_JE_LINES TO XXRS_DW_QUERY /*121105-05867*/;
  GRANT SELECT ON APPS.GL_JE_HEADERS TO XXRS_DW_QUERY /*121105-05867*/;
  GRANT SELECT ON APPS.GL_CODE_COMBINATIONS TO XXRS_DW_QUERY /*121105-05867*/;
  GRANT SELECT ON APPS.FND_FLEX_VALUES_VL TO XXRS_DW_QUERY /*121105-05867*/;
  GRANT SELECT ON GL.GL_IMPORT_REFERENCES TO XXRS_DW_QUERY /*121105-05867*/;
  GRANT SELECT ON AP.AP_SUPPLIERS TO XXRS_DW_QUERY /*121105-05867*/;
  GRANT SELECT ON XLA.XLA_AE_HEADERS TO XXRS_DW_QUERY /*121105-05867*/;
  GRANT SELECT ON XLA.XLA_AE_LINES TO XXRS_DW_QUERY /*121105-05867*/;
  GRANT SELECT ON XXRS.XXRS_SC_BILLING_DATA_HST TO XXRS_DW_QUERY /*121105-05867*/;
  SPOOL OFF;
/
