GRANT
  /*********************************************************************************************************
  *                                                                                                        *
  * NAME : XXRS_WS_AR_INVOICE_DTL_GRANT2.sql                                                               *
  *                                                                                                        *
  * DESCRIPTION :                                                                                          *
  * Script to Provide Grant on Package to report Invoice Details.                                          *
  *                                                                                                        *
  * AUTHOR       : VAIBHAV GOYAL                                                                           *
  * DATE WRITTEN : 27-JAN-2012                                                                             *
  *                                                                                                        *
  * CHANGE CONTROL :                                                                                       *
  * VERSION#     |  RACKER TICKET #  | WHO             |  DATE          |   REMARKS                        *
  *--------------------------------------------------------------------------------------------------------*
  * 1.0.0        |  111122-02448     | VAIBHAV GOYAL   | 01/27/2012     | initial creation                 *
  **********************************************************************************************************/
  /* $Header: XXRS_WS_AR_INVOICE_DTL_GRANT2.sql 1.0.0 01/27/2012 10:00:00 AM Vaibhav Goyal $ */
EXECUTE ON apps.xxrs_ws_ar_invoice_dtl_pkg to xxrscore;
GRANT EXECUTE ON apps.xxrs_ar_cust_acct_pkg to xxrscore;
GRANT EXECUTE ON apps.fnd_client_info to xxrscore;
GRANT EXECUTE ON apps.fnd_profile to xxrscore;
GRANT SELECT ON xxrs.xxrs_ar_customer_name_h to xxrscore;
GRANT SELECT ON ar.ra_customer_trx_all to xxrscore;
GRANT SELECT ON ar.ra_cust_trx_types_all to xxrscore;
GRANT SELECT ON ar.ra_tax_exemptions_all to xxrscore;
GRANT SELECT ON apps.ra_terms to xxrscore;
GRANT SELECT ON hr.hr_all_organization_units to xxrscore;
GRANT SELECT ON ar.ar_payment_schedules_all to xxrscore;
GRANT SELECT ON ar.hz_cust_site_uses_all to xxrscore;
GRANT SELECT ON ar.hz_cust_acct_sites_all to xxrscore;
GRANT SELECT ON ar.hz_party_sites  to xxrscore;
GRANT SELECT ON ar.hz_locations to xxrscore;
GRANT SELECT ON ar.hz_parties to xxrscore; 
GRANT SELECT ON ar.hz_cust_accounts to xxrscore;
GRANT SELECT ON ar.hz_cust_account_roles to xxrscore;
GRANT SELECT ON ar.hz_parties to xxrscore; 
GRANT SELECT ON ar.hz_relationships to xxrscore; 
GRANT SELECT ON ar.hz_org_contacts to xxrscore;
GRANT SELECT ON ap.ap_bank_accounts_all to xxrscore;
GRANT SELECT ON ar.ar_receipt_methods to xxrscore;
GRANT SELECT ON ar.ra_customer_trx_lines_all to xxrscore;
GRANT SELECT ON apps.ra_customer_trx_lines to xxrscore;
GRANT SELECT ON apps.ar_lookups to xxrscore;
GRANT SELECT ON apps.ar_vat_tax_vl to xxrscore;
GRANT SELECT ON apps.ra_customer_trx_lines to xxrscore;
GRANT SELECT ON gl.gl_daily_rates to xxrscore;
GRANT SELECT ON gl.gl_daily_conversion_types to xxrscore;
GRANT SELECT ON ar.ra_customer_trx_lines_all to xxrscore;
GRANT SELECT ON inv.mtl_units_of_measure_tl to xxrscore;
