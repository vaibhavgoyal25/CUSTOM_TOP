GRANT
  /*********************************************************************************************************
  *                                                                                                        *
  * NAME : XXRS_WS_SC_ACCTLVLPRDPRC_GRANT2.sql                                                           *
  *                                                                                                        *
  * DESCRIPTION :                                                                                          *
  * Script to Provide Grant on Package to report Account Level Product Pricing.                            *
  *                                                                                                        *
  * AUTHOR       : VAIBHAV GOYAL                                                                           *
  * DATE WRITTEN : 13-JAN-2012                                                                             *
  *                                                                                                        *
  * CHANGE CONTROL :                                                                                       *
  * VERSION#     |  RACKER TICKET #  | WHO             |  DATE          |   REMARKS                        *
  *--------------------------------------------------------------------------------------------------------*
  * 1.0.0        |  111122-02448     | VAIBHAV GOYAL   | 01/13/2012     | initial creation                 *
  **********************************************************************************************************/
  /* $Header: XXRS_WS_SC_ACCTLVLPRDCTPRC_GRANT2.sql 1.0.0 12/08/2011 10:00:00 AM Vaibhav Goyal $ */
EXECUTE ON apps.xxrs_ws_sc_acctlvlprdprc_pkg to xxrscore;
GRANT SELECT ON XXRS.XXRS_SC_SERVICE_DEF to xxrscore;
GRANT SELECT ON apps.XXRS_SC_SPCL_PRICE_EFFECT_TBL to xxrscore;
GRANT SELECT ON apps.xxrs_sc_spcl_price_tier_vw to xxrscore;
GRANT SELECT ON APPS.XXRS_SC_ACCOUNT_RESOURCE_VW to xxrscore;
GRANT SELECT ON APPS.XXRS_SC_PRICE_RULE_VW to xxrscore;
GRANT SELECT ON apps.xxrs_sc_price_effectivity_tbl to xxrscore;
GRANT SELECT ON apps.xxrs_sc_price_tier_vw to xxrscore;
GRANT SELECT ON ar.hz_cust_accounts to xxrscore;
GRANT SELECT ON xxrs.xxrs_sc_account_product_tbl to xxrscore;
GRANT SELECT ON xxrs.xxrs_sc_product_def_tbl to xxrscore;
GRANT SELECT ON xxrs.xxrs_sc_contract_tbl to xxrscore;
GRANT SELECT ON applsys.fnd_lookup_values to xxrscore;
GRANT SELECT ON apps.xxrs_sc_cust_bill_to_sites_vw to xxrscore;
GRANT SELECT ON AR.HZ_CUST_ACCT_SITES_ALL to xxrscore;
GRANT SELECT ON APPS.AR_LOOKUPS to xxrscore;
GRANT SELECT ON APPS.XXRS_SC_ACCOUNT_RESOURCE_VW to xxrscore;