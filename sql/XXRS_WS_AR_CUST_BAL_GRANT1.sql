GRANT
  /*********************************************************************************************************
  *                                                                                                        *
  * NAME : XXRS_WS_AR_CUST_BAL_GRANT1.sql                                                                  *
  *                                                                                                        *
  * DESCRIPTION :                                                                                          *
  * Script to Provide Grant on Table Type Variable to report Customer Balance.                             *
  *                                                                                                        *
  * AUTHOR       : VAIBHAV GOYAL                                                                           *
  * DATE WRITTEN : 21-NOV-2011                                                                             *
  *                                                                                                        *
  * CHANGE CONTROL :                                                                                       *
  * VERSION#     |  RACKER TICKET #  | WHO             |  DATE          |   REMARKS                        *
  *--------------------------------------------------------------------------------------------------------*
  * 1.0.0        |  111122-02448     | VAIBHAV GOYAL   | 11/21/2011     | initial creation                 *
  **********************************************************************************************************/
  /* $Header: XXRS_WS_AR_CUST_BAL_GRANT1.sql 1.0.0 11/21/2011 10:00:00 AM Vaibhav Goyal $ */
EXECUTE ON xxrs.xxrs_ws_ar_cust_bal_type TO xxrscore;
GRANT EXECUTE ON xxrs.xxrs_ws_ar_cust_bal_tbl TO xxrscore;
GRANT ALL ON xxrs.xxrs_ws_ar_cust_bal_type TO apps;
GRANT ALL ON xxrs.xxrs_ws_ar_cust_bal_tbl TO apps;