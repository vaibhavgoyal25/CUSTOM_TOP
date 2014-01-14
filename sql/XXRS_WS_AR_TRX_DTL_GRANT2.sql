GRANT
  /*********************************************************************************************************
  *                                                                                                        *
  * NAME : XXRS_WS_AR_TRX_DTL_GRANT2.sql                                                                   *
  *                                                                                                        *
  * DESCRIPTION :                                                                                          *
  * Script to Provide Grant on Package to report Transaction Details.                                      *
  *                                                                                                        *
  * AUTHOR       : VAIBHAV GOYAL                                                                           *
  * DATE WRITTEN : 14-NOV-2011                                                                             *
  *                                                                                                        *
  * CHANGE CONTROL :                                                                                       *
  * VERSION#     |  RACKER TICKET #  | WHO             |  DATE          |   REMARKS                        *
  *--------------------------------------------------------------------------------------------------------*
  * 1.0.0        |  111122-02448     | VAIBHAV GOYAL   | 11/14/2011     | initial creation                 *
  **********************************************************************************************************/
  /* $Header: XXRS_WS_AR_TRX_DTL_GRANT2.sql 1.0.0 11/14/2011 10:00:00 AM Vaibhav Goyal $ */
EXECUTE ON apps.xxrs_ws_ar_trx_dtl_pkg to xxrscore;
GRANT SELECT ON ar.ar_payment_schedules_all to xxrscore;
GRANT SELECT ON ar.hz_cust_accounts to xxrscore;
GRANT SELECT ON ar.ar_receivable_applications_all to xxrscore;
GRANT SELECT ON ar.ar_adjustments_all to xxrscore;
GRANT SELECT ON ar.ar_approval_action_history to xxrscore;
GRANT SELECT ON ar.ar_cash_receipt_history_all to xxrscore;
GRANT SELECT ON ar.ra_customer_trx_lines_all to xxrscore;
GRANT SELECT ON applsys.fnd_lookup_values to xxrscore;
GRANT SELECT ON ar.ar_vat_tax_all_b to xxrscore;
GRANT SELECT ON ar.ar_receivables_trx_all to xxrscore;
