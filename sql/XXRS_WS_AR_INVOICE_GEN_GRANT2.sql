GRANT
  /*********************************************************************************************************
  *                                                                                                        *
  * NAME : XXRS_WS_AR_INVOICE_GEN_GRANT2.sql                                                               *
  *                                                                                                        *
  * DESCRIPTION :                                                                                          *
  * Script to Provide Grant on Package to report Invoice PDF.                                              *
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
EXECUTE       ON apps.xxrs_ws_ar_invoice_gen_pkg to xxrscore;
GRANT EXECUTE ON apps.fnd_run_function to xxrscore;
GRANT SELECT  ON ar.ra_customer_trx_all to xxrscore;
GRANT SELECT  ON ar.ra_cust_trx_types_all to xxrscore;
