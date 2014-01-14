  /**************************************************************************************************
  *                                                                                                 *
  * NAME : XXRS_DWH_GRANTS_AR_CUST_H_130122-10283.sql                                               *
  *                                                                                                 *
  * DESCRIPTION :  Script to grant permissions on select tables to XXRSDW role                      *
  *                                                                                                 *
  *                                                                                                 *
  * AUTHOR       : Vaibhav Goyal                                                                    *
  * DATE WRITTEN : 02/22/2013                                                                       *
  *                                                                                                 *
  * CHANGE CONTROL :                                                                                *
  * Version#     | Genie Ticket #      | WHO             |  DATE        |   REMARKS                 *
  *-------------------------------------------------------------------------------------------------*
  * 1.0.0        | 130122-10283        | Vaibhav Goyal   | 02/22/2013   | Initial Creation          *
  ***************************************************************************************************/
  SET SERVEROUTPUT ON SIZE 100000;
  SET LINE 300;
  SET PAGESIZE 2000;
  SET COLSEP |;
  col file_name   new_value   spool_file_name    noprint
  select 'XXRS_DWH_GRANTS_AR_CUST_H_130122-10283' ||to_char (sysdate, 'mmddyy_hhmiss')||'.log' file_name from dual ;
  spool &spool_file_name

Grant Select ON XXRS.XXRS_AR_CUSTOMER_ADDR_H TO XXRS_DW_QUERY /*130122-10283*/;

  SPOOL OFF;
