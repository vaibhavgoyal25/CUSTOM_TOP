GRANT
  /*********************************************************************************************************
  *                                                                                                        *
  * NAME : XXRS_WS_AR_CORE_TRX_DTL_GRANT2.sql                                                              *
  *                                                                                                        *
  * DESCRIPTION :                                                                                          *
  * Script to Provide Grant on Package to report Transaction Details.                                      *
  *                                                                                                        *
  * AUTHOR       : VAIBHAV GOYAL                                                                           *
  * DATE WRITTEN : 26-JAN-2012                                                                             *
  *                                                                                                        *
  * CHANGE CONTROL :                                                                                       *
  * VERSION#     |  RACKER TICKET #  | WHO             |  DATE          |   REMARKS                        *
  *--------------------------------------------------------------------------------------------------------*
  * 1.0.0        |  111122-02448     | VAIBHAV GOYAL   | 01/26/2012     | initial creation                 *
  **********************************************************************************************************/
  /* $Header: XXRS_WS_AR_TRX_DTL_GRANT2.sql 1.0.0 01/26/2012 10:00:00 AM Vaibhav Goyal $ */
EXECUTE ON  apps.xxrs_ws_ar_core_trx_dtl_pkg to xxrscore;
GRANT SELECT ON ar.hz_cust_accounts to xxrscore;
GRANT SELECT ON ar.ar_payment_schedules_all to xxrscore;
GRANT SELECT ON ar.ar_cash_receipt_history_all to xxrscore;

GRANT SELECT ON ar.hz_cust_site_uses_all to xxrscore;
GRANT SELECT ON ar.hz_cust_acct_sites_all to xxrscore;
GRANT SELECT ON ar.hz_party_sites to xxrscore;
GRANT SELECT ON ar.hz_locations to xxrscore;
GRANT SELECT ON ar.hz_parties to xxrscore;