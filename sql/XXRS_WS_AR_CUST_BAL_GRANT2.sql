GRANT
  /*********************************************************************************************************
  *                                                                                                        *
  * NAME : XXRS_WS_AR_CUST_BAL_GRANT2.sql                                                                  *
  *                                                                                                        *
  * DESCRIPTION :                                                                                          *
  * Script to Provide Grant on Package to report Customer Balance.                                         *
  *                                                                                                        *
  * AUTHOR       : VAIBHAV GOYAL                                                                           *
  * DATE WRITTEN : 21-NOV-2011                                                                             *
  *                                                                                                        *
  * CHANGE CONTROL :                                                                                       *
  * VERSION#     |  RACKER TICKET #  | WHO             |  DATE          |   REMARKS                        *
  *--------------------------------------------------------------------------------------------------------*
  * 1.0.0        |  111122-02448     | VAIBHAV GOYAL   | 11/21/2011     | initial creation                 *
  **********************************************************************************************************/
  /* $Header: XXRS_WS_AR_CUST_BAL_GRANT2.sql 1.0.0 11/21/2011 10:00:00 AM Vaibhav Goyal $ */
EXECUTE ON apps.xxrs_ws_ar_cust_bal_pkg to xxrscore;