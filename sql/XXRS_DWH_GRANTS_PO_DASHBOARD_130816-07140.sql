  /**************************************************************************************************
  *                                                                                                 *
  * NAME : XXRS_DWH_GRANTS_PO_DASHBOARD_130816-07140.sql                                            *
  *                                                                                                 *
  * DESCRIPTION :  Script To Grant access to requested Objects for PO Dashboard.                    *
  *                                                                                                 *
  * AUTHOR       : Vaibhav Goyal                                                                    *
  * DATE WRITTEN : 08/19/2013                                                                       *
  *                                                                                                 *
  * CHANGE CONTROL :                                                                                *
  * Version#     | Genie Ticket #      | WHO             |  DATE        |   REMARKS                 *
  *-------------------------------------------------------------------------------------------------*
  * 1.0.0        | 130816-07140        | Vaibhav Goyal   | 08/19/2013   | Initial Creation          *
  ***************************************************************************************************/
  /*$Header: XXRS_DWH_GRANTS_PO_DASHBOARD_130816-07140.sql 1.0.0 08/19/2013 Vaibhav Goyal $*/
  SET SERVEROUTPUT ON SIZE 100000;
  SET LINE 300;
  SET PAGESIZE 2000;
  SET COLSEP |;
  col file_name   new_value   spool_file_name    noprint
  select 'XXRS_DWH_GRANTS_PO_DASHBOARD_130816-07140' ||to_char (sysdate, 'mmddyy_hhmiss')||'.log' file_name from dual ;
  spool &spool_file_name
 PROMPT "GRANTING SELECT ACCESS TO XXRS_DW_QUERY ON HR.HR_LOCATIONS_ALL_TL";
 Grant Select ON HR.HR_LOCATIONS_ALL_TL TO XXRS_DW_QUERY /*130816-07140*/;
 PROMPT "GRANTING SELECT ACCESS TO XXRS_DW_QUERY ON PO.PO_ACTION_HISTORY";
 Grant Select ON PO.PO_ACTION_HISTORY TO XXRS_DW_QUERY /*130816-07140*/;
 SPOOL OFF;
