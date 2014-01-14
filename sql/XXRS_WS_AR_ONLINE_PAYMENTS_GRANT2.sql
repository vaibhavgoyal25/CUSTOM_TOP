GRANT
  /*********************************************************************************************************
  *                                                                                                        *
  * NAME : XXRS_WS_AR_ONLINE_PAYMENTS_GRANT2.sql                                                           *
  *                                                                                                        *
  * DESCRIPTION :                                                                                          *
  * Script to Provide Grant on Package to set online payment details.                                      *
  *                                                                                                        *
  * AUTHOR       : VAIBHAV GOYAL                                                                           *
  * DATE WRITTEN : 27-JAN-2012                                                                             *
  *                                                                                                        *
  * CHANGE CONTROL :                                                                                       *
  * VERSION#     |  RACKER TICKET #  | WHO             |  DATE          |   REMARKS                        *
  *--------------------------------------------------------------------------------------------------------*
  * 1.0.0        |  111122-02448     | VAIBHAV GOYAL   | 01/27/2012     | initial creation                 *
  **********************************************************************************************************/
  /* $Header: XXRS_WS_AR_ONLINE_PAYMENTS_GRANT2.sql 1.0.0 01/27/2012 10:00:00 AM Vaibhav Goyal $ */
EXECUTE ON apps.XXRS_WS_AR_ONLINE_PAYMENTS_PKG to xxrscore;         
grant select on ce.ce_bank_acct_uses_all to xxrscore;
grant select on ce.ce_bank_accounts to xxrscore;
grant select on ar.ar_receipt_method_accounts_all to xxrscore;
grant select on apps.fnd_lookup_values_vl to xxrscore;
grant select on ar.hz_cust_acct_sites_all to xxrscore;
grant execute on apps.ar_receipt_api_pub to xxrscore;