GRANT
  /*********************************************************************************************************
  *                                                                                                        *
  * NAME : XXRS_WS_AR_CORE_TRX_DTL_GRANT1.sql                                                              *
  *                                                                                                        *
  * DESCRIPTION :                                                                                          *
  * Script to Provide Grant on Table Type Variable to report Transaction Details.                          *
  *                                                                                                        *
  * AUTHOR       : VAIBHAV GOYAL                                                                           *
  * DATE WRITTEN : 26-JAN-2012                                                                             *
  *                                                                                                        *
  * CHANGE CONTROL :                                                                                       *
  * VERSION#     |  RACKER TICKET #  | WHO             |  DATE          |   REMARKS                        *
  *--------------------------------------------------------------------------------------------------------*
  * 1.0.0        |  111122-02448     | VAIBHAV GOYAL   | 01/26/2012     | initial creation                 *
  **********************************************************************************************************/
  /* $Header: XXRS_WS_AR_CORE_TRX_DTL_GRANT1.sql 1.0.0 01/26/2012 10:00:00 AM Vaibhav Goyal $ */
EXECUTE ON xxrs.xxrs_ws_ar_core_trx_dtl_type TO xxrscore;
GRANT EXECUTE ON xxrs.xxrs_ws_ar_core_trx_dtl_tbl TO xxrscore;
GRANT ALL ON xxrs.xxrs_ws_ar_core_trx_dtl_type TO apps;
GRANT ALL ON xxrs.xxrs_ws_ar_core_trx_dtl_tbl TO apps;