  /**************************************************************************************************
  *                                                                                                 *
  * NAME : XXRS_DWH_GRANTS_111122-02448.sql                                                         *
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
  * 1.0.0        | 111122-02448        | Vaibhav Goyal   | 03/22/2012   | Initial Creation          *
  ***************************************************************************************************/
  SET SERVEROUTPUT ON SIZE 100000;
  SET LINE 300;
  SET PAGESIZE 2000;
  SET COLSEP |;
  col file_name   new_value   spool_file_name    noprint
  select 'XXRS_DWH_GRANTS_111122-02448_' ||to_char (sysdate, 'mmddyy_hhmiss')||'.log' file_name from dual ;
  spool &spool_file_name

  GRANT SELECT ON APPS.GL_SETS_OF_BOOKS TO XXRS_DW_QUERY /*111122-02448*/;
  GRANT SELECT ON APPS.GL_TRANSLATION_RATES TO XXRS_DW_QUERY /*111122-02448*/;
  GRANT SELECT ON APPS.PO_VENDORS TO XXRS_DW_QUERY /*111122-02448*/;
  GRANT SELECT ON APPS.PO_VENDOR_SITES_ALL TO XXRS_DW_QUERY /*111122-02448*/;
  REVOKE SELECT ON GL.GL_SETS_OF_BOOKS_11I FROM XXRS_DW_QUERY /*111122-02448*/;
  REVOKE SELECT ON GL.GL_TRANSLATION_RATES_11I FROM XXRS_DW_QUERY /*111122-02448*/;
  REVOKE SELECT ON PO.PO_VENDORS_OBS FROM XXRS_DW_QUERY /*111122-02448*/;
  REVOKE SELECT ON PO.PO_VENDOR_SITES_OBS FROM XXRS_DW_QUERY /*111122-02448*/;
  SPOOL OFF;
/