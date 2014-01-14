  /**************************************************************************************************
  *                                                                                                 *
  * NAME : XXRS_DWH_GRANTS_CHURN_TR_130725-08079.sql                                                *
  *                                                                                                 *
  * DESCRIPTION :  Script To Grant access to requested SC And AR Objects To DWH for their Churn and *
  *                Treasury Report.                                                                 *
  *                                                                                                 *
  * AUTHOR       : Vaibhav Goyal                                                                    *
  * DATE WRITTEN : 07/25/2013                                                                       *
  *                                                                                                 *
  * CHANGE CONTROL :                                                                                *
  * Version#     | Genie Ticket #      | WHO             |  DATE        |   REMARKS                 *
  *-------------------------------------------------------------------------------------------------*
  * 1.0.0        | 130725-08079        | Vaibhav Goyal   | 07/25/2013   | Initial Creation          *
  ***************************************************************************************************/
  /*$Header: XXRS_DWH_GRANTS_CHURN_TR_130725-08079.sql 1.0.0 07/25/2013 Vaibhav Goyal $*/
  SET SERVEROUTPUT ON SIZE 100000;
  SET LINE 300;
  SET PAGESIZE 2000;
  SET COLSEP |;
  col file_name   new_value   spool_file_name    noprint
  select 'XXRS_DWH_GRANTS_CHURN_TR_130725-08079' ||to_char (sysdate, 'mmddyy_hhmiss')||'.log' file_name from dual ;
  spool &spool_file_name
 PROMPT "GRANTING SELECT ACCESS TO XXRS_DW_QUERY ON apps.xxrs_sc_price_rule_vw";
 Grant Select ON apps.xxrs_sc_price_rule_vw TO XXRS_DW_QUERY /*130725-08079*/;
 PROMPT "GRANTING SELECT ACCESS TO XXRS_DW_QUERY ON apps.xxrs_sc_price_tier_vw";
 Grant Select ON apps.xxrs_sc_price_tier_vw TO XXRS_DW_QUERY /*130725-08079*/;
 PROMPT "GRANTING SELECT ACCESS TO XXRS_DW_QUERY ON apps.ar_lookups";
 Grant Select ON apps.ar_lookups TO XXRS_DW_QUERY /*130725-08079*/;
 PROMPT "GRANTING SELECT ACCESS TO XXRS_DW_QUERY ON apps.xxrs_sc_spcl_price_tier_vw";
 Grant Select ON apps.xxrs_sc_spcl_price_tier_vw TO XXRS_DW_QUERY /*130725-08079*/;
 PROMPT "GRANTING SELECT ACCESS TO XXRS_DW_QUERY ON apps.xxrs_sc_lookup_vw";
 Grant Select ON apps.xxrs_sc_lookup_vw TO XXRS_DW_QUERY /*130725-08079*/;
 PROMPT "GRANTING SELECT ACCESS TO XXRS_DW_QUERY ON ar.ar_receipt_methods";
 Grant Select ON ar.ar_receipt_methods TO XXRS_DW_QUERY /*130725-08079*/;
 PROMPT "GRANTING SELECT ACCESS TO XXRS_DW_QUERY ON ar.ra_cust_receipt_methods";
 Grant Select ON ar.ra_cust_receipt_methods TO XXRS_DW_QUERY /*130725-08079*/;
 SPOOL OFF;
