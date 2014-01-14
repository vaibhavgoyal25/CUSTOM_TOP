GRANT
  /*********************************************************************************************************
  *                                                                                                        *
  * NAME : XXRS_WS_SC_DEVICE_GRANT2.sql                                                                    *
  *                                                                                                        *
  * DESCRIPTION :                                                                                          *
  * Script to Provide Grant on Package to report Device MRR.                                               *
  *                                                                                                        *
  * AUTHOR       : VAIBHAV GOYAL                                                                           *
  * DATE WRITTEN : 08-DEC-2011                                                                             *
  *                                                                                                        *
  * CHANGE CONTROL :                                                                                       *
  * VERSION#     |  RACKER TICKET #  | WHO             |  DATE          |   REMARKS                        *
  *--------------------------------------------------------------------------------------------------------*
  * 1.0.0        |  111122-02448     | VAIBHAV GOYAL   | 12/08/2011     | initial creation                 *
  **********************************************************************************************************/
  /* $Header: XXRS_WS_SC_DEVICE_GRANT2.sql 1.0.0 12/08/2011 10:00:00 AM Vaibhav Goyal $ */
EXECUTE ON apps.xxrs_ws_sc_device_pkg to xxrscore;
GRANT SELECT ON ar.hz_cust_accounts  to xxrscore;
GRANT SELECT ON ar.ra_customer_trx_all  to xxrscore;
GRANT SELECT ON ar.ra_customer_trx_lines_all  to xxrscore;
GRANT SELECT ON ar.ra_cust_trx_types_all  to xxrscore;
GRANT SELECT ON inv.mtl_units_of_measure_tl  to xxrscore;
GRANT SELECT ON xxrs.xxrs_sc_device_product_tbl to xxrscore;
GRANT SELECT ON xxrs.xxrs_sc_device_resource_tbl to xxrscore;
GRANT SELECT ON xxrs.xxrs_sc_product_rsrc_def_tbl to xxrscore;
GRANT SELECT ON xxrs.xxrs_sc_resource_def_tbl to xxrscore;
GRANT SELECT ON inv.mtl_units_of_measure_tl to xxrscore;
GRANT SELECT ON ar.hz_cust_accounts  to xxrscore;
GRANT SELECT ON ar.hz_cust_acct_sites_all to xxrscore;
GRANT SELECT ON applsys.fnd_lookup_values to xxrscore;
GRANT SELECT ON applsys.fnd_application to xxrscore;