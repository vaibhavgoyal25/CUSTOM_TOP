GRANT
  /*********************************************************************************************************
  *                                                                                                        *
  * NAME : XXRS_WS_AR_TRX_DTL_GRANT1.sql                                                                   *
  *                                                                                                        *
  * DESCRIPTION :                                                                                          *
  * Script to Provide Grant on Table Type Variable to report Transaction Details.                          *
  *                                                                                                        *
  * AUTHOR       : VAIBHAV GOYAL                                                                           *
  * DATE WRITTEN : 14-NOV-2011                                                                             *
  *                                                                                                        *
  * CHANGE CONTROL :                                                                                       *
  * VERSION#     |  RACKER TICKET #  | WHO             |  DATE          |   REMARKS                        *
  *--------------------------------------------------------------------------------------------------------*
  * 1.0.0        |  111122-02448     | VAIBHAV GOYAL   | 11/14/2011     | initial creation                 *
  **********************************************************************************************************/
  /* $Header: XXRS_WS_AR_TRX_DTL_GRANT1.sql 1.0.0 11/14/2011 10:00:00 AM Vaibhav Goyal $ */
EXECUTE ON xxrs.xxrs_ws_ar_trx_dtl_type TO xxrscore;
GRANT EXECUTE ON xxrs.xxrs_ws_ar_trx_dtl_tbl TO xxrscore;
GRANT ALL ON xxrs.xxrs_ws_ar_trx_dtl_type TO apps;
GRANT ALL ON xxrs.xxrs_ws_ar_trx_dtl_tbl TO apps;