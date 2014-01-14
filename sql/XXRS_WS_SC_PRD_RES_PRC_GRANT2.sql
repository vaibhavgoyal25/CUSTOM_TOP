GRANT
  /*********************************************************************************************************
  *                                                                                                        *
  * NAME : XXRS_WS_SC_PRD_RES_PRC_GRANT2.sql                                                               *
  *                                                                                                        *
  * DESCRIPTION :                                                                                          *
  * Script to Provide Grant on Package to report product pricing Details.                                  *
  *                                                                                                        *
  * AUTHOR       : VAIBHAV GOYAL                                                                           *
  * DATE WRITTEN : 24-JAN-2012                                                                             *
  *                                                                                                        *
  * CHANGE CONTROL :                                                                                       *
  * VERSION#     |  RACKER TICKET #  | WHO             |  DATE          |   REMARKS                        *
  *--------------------------------------------------------------------------------------------------------*
  * 1.0.0        |  111122-02448     | VAIBHAV GOYAL   | 01/24/2012     | initial creation                 *
  **********************************************************************************************************/
  /* $Header: XXRS_WS_SC_PRD_RES_PRC_GRANT2.sql 1.0.0 01/24/2012 10:00:00 AM Vaibhav Goyal $ */
EXECUTE ON apps.xxrs_ws_sc_prd_res_prc_pkg to xxrscore;
GRANT SELECT ON xxrs.xxrs_sc_account_resource_tbl to xxrscore;
GRANT SELECT ON apps.xxrs_sc_price_rule_tbl to xxrscore;
GRANT SELECT ON apps.xxrs_sc_spcl_price_effect_tblto xxrscore;
GRANT SELECT ON apps.xxrs_sc_spcl_price_tier_tbl to xxrscore;
GRANT SELECT ON apps.xxrs_sc_price_rule_tbl to xxrscore;
GRANT SELECT ON apps.xxrs_sc_price_effectivity_tbl to xxrscore;
GRANT SELECT ON apps.xxrs_sc_price_tier_tbl to xxrscore;
GRANT SELECT ON ar.hz_cust_accounts to xxrscore;
GRANT SELECT ON xxrs.xxrs_sc_product_def_tbl to xxrscore;
GRANT SELECT ON xxrs.xxrs_sc_resource_def_tbl to xxrscore;
GRANT SELECT ON xxrs.xxrs_sc_product_rsrc_def_tbl to xxrscore;
GRANT SELECT ON xxrs.xxrs_sc_account_product_tbl to xxrscore;
GRANT SELECT ON applsys.fnd_lookup_values to xxrscore;
GRANT SELECT ON xxrs.xxrs_sc_resource_def_tbl to xxrscore;
GRANT SELECT ON xxrs.xxrs_sc_product_rsrc_def_tbl to xxrscore;
GRANT SELECT ON xxrs.xxrs_sc_account_product_tbl to xxrscore;
GRANT SELECT ON ar.hz_cust_acct_sites_all to xxrscore;
GRANT SELECT ON ar.hz_party_sites to xxrscore;
GRANT SELECT ON applsys.fnd_flex_value_sets to xxrscore;
GRANT SELECT ON applsys.fnd_flex_values to xxrscore;
GRANT SELECT ON applsys.fnd_flex_values_tl to xxrscore;
GRANT SELECT ON inv.mtl_units_of_measure_tl to xxrscore;