GRANT
  /*********************************************************************************************************
  *                                                                                                        *
  * NAME : XXRS_WS_SC_CONTRACT_DTLS_GRANT2.sql                                                             *
  *                                                                                                        *
  * DESCRIPTION :                                                                                          *
  * Script to Provide Grant on Package to report Customer Contract Details.                                *
  *                                                                                                        *
  * AUTHOR       : VAIBHAV GOYAL                                                                           *
  * DATE WRITTEN : 07-DEC-2011                                                                             *
  *                                                                                                        *
  * CHANGE CONTROL :                                                                                       *
  * VERSION#     |  RACKER TICKET #  | WHO             |  DATE          |   REMARKS                        *
  *--------------------------------------------------------------------------------------------------------*
  * 1.0.0        |  111122-02448     | VAIBHAV GOYAL   | 12/07/2011     | initial creation                 *
  **********************************************************************************************************/
  /* $Header: XXRS_WS_SC_CONTRACT_DTLS_GRANT2.sql 1.0.0 12/07/2011 10:00:00 AM Vaibhav Goyal $ */
EXECUTE ON xxrs_ws_sc_contract_dtls_pkg to xxrscore;
GRANT SELECT ON xxrs.xxrs_sc_device_product_tbl to xxrscore;
GRANT SELECT ON xxrs.xxrs_sc_contract_tbl to xxrscore;
GRANT SELECT ON applsys.fnd_lookup_values to xxrscore;
GRANT SELECT ON ar.hz_cust_acct_sites_all to xxrscore;
GRANT SELECT ON ar.hz_party_sites to xxrscore;
GRANT SELECT ON xxrs.xxrs_sc_account_product_tbl to xxrscore;
GRANT SELECT ON xxrs.xxrs_sc_contract_tbl to xxrscore; 
GRANT SELECT ON xxrs.xxrs_sc_product_def_tbl to xxrscore;