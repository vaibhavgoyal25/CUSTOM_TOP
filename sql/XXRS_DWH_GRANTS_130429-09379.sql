GRANT 
/**************************************************************************************************
*                                                                                                 *
* NAME : XXRS_DWH_GRANTS_130429-09379.sql                                                         *
*                                                                                                 *
* DESCRIPTION : Grants For Data Mapping for Metrics Dashboard.                                    *
*                                                                                                 *
* AUTHOR       : Vaibhav Goyal                                                                    *
* DATE WRITTEN : 05/04/2013                                                                       *
*                                                                                                 *
* CHANGE CONTROL :                                                                                *
* Version#     | Genie Ticket #      | WHO             |  DATE        |   REMARKS                 *
*-------------------------------------------------------------------------------------------------*
* 1.0.0        | 130429-09379        | Vaibhav Goyal   | 05/04/2013   | Initial Creation          *
***************************************************************************************************/
/* $Header: XXRS_DWH_GRANTS_130429-09379.sql 1.0.0 05-MAY-13 11:19:00 AM Vaibhav Goyal $ */
  SELECT ON AP.AP_INVOICE_LINES_ALL TO XXRS_DW_QUERY/*130429-09379*/;
  GRANT SELECT ON AP.AP_INVOICES_ALL TO XXRS_DW_QUERY/*130429-09379*/;
  GRANT SELECT ON AP.AP_INV_APRVL_HIST_ALL TO XXRS_DW_QUERY/*130429-09379*/;
  GRANT SELECT ON APPS.XXRS_PER_ALL_PEOPLE_F_VW TO XXRS_DW_QUERY/*130429-09379*/;
  SPOOL OFF;
/