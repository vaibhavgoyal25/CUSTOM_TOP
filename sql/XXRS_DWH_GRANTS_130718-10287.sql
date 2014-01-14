  /**************************************************************************************************
  *                                                                                                 *
  * NAME : XXRS_DWH_GRANTS_130718-10287.sql                                                         *
  *                                                                                                 *
  * DESCRIPTION :                                                                                   *
  * Script to grant permissions on select tables to XXRSDW role                                     *
  *                                                                                                 *
  * AUTHOR       : Pavan Amirineni                                                                  *
  * DATE WRITTEN : 07-19-2013                                                                       *
  *                                                                                                 *
  * CHANGE CONTROL :                                                                                *
  * Version#     | Genie Ticket #      | WHO             |  DATE        |   REMARKS                 *
  *-------------------------------------------------------------------------------------------------*
  * 1.0.0        | 130718-10287        | Pavan Amirineni | 07-19-2013   | Initial Creation          *
  ***************************************************************************************************/
--
/* $Header: XXRS_DWH_GRANTS_130718-10287.sql 1.0.0 07-19-2013 10:46:24 AM Pavan Amirineni$ */
--
  SET SERVEROUTPUT ON SIZE 100000;
  SET LINE 300;
  SET PAGESIZE 2000;
  SET COLSEP |;
  col file_name   new_value   spool_file_name    noprint
  select 'XXRS_DWH_GRANTS_130718-10287' ||to_char (sysdate, 'mmddyy_hhmiss')||'.log' file_name from dual ;
  spool &spool_file_name

  GRANT SELECT ON hr.hr_locations_all to XXRS_DW_QUERY /*130718-10287*/ ;    
  GRANT SELECT ON apps.mtl_cross_references_v to XXRS_DW_QUERY /*130718-10287*/; 
  
  SPOOL OFF;
/