GRANT
  /*********************************************************************************************************
  *                                                                                                        *
  * NAME : XXRS_WS_AR_GET_REC_PAY_GRANT1.sql                                                               *
  *                                                                                                        *
  * DESCRIPTION :                                                                                          *
  * Script to Provide Grant on Table Type Variable to report Recurring Payment Details.                    *
  *                                                                                                        *
  * AUTHOR       : VAIBHAV GOYAL                                                                           *
  * DATE WRITTEN : 27-JAN-2012                                                                             *
  *                                                                                                        *
  * CHANGE CONTROL :                                                                                       *
  * VERSION#     |  RACKER TICKET #  | WHO             |  DATE          |   REMARKS                        *
  *--------------------------------------------------------------------------------------------------------*
  * 1.0.0        |  111122-02448     | VAIBHAV GOYAL   | 01/27/2012     | initial creation                 *
  **********************************************************************************************************/
  /* $Header: XXRS_WS_AR_GET_REC_PAY_GRANT1.sql 1.0.0 01/26/2012 10:00:00 AM Vaibhav Goyal $ */
EXECUTE ON xxrs.xxrs_ws_ar_get_rec_pay_type TO xxrscore;
GRANT EXECUTE ON xxrs.xxrs_ws_ar_get_rec_pay_tbl TO xxrscore;
GRANT ALL ON xxrs.xxrs_ws_ar_get_rec_pay_type TO apps;
GRANT ALL ON xxrs.xxrs_ws_ar_get_rec_pay_tbl TO apps;