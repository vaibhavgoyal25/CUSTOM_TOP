GRANT
  /*********************************************************************************************************
  *                                                                                                        *
  * NAME : XXRS_WS_AR_CUST_AGING_GRANT1.sql                                                                *
  *                                                                                                        *
  * DESCRIPTION :                                                                                          *
  * Script to Provide Grant on Table Type Variable to report Customer Aging Details.                       *
  *                                                                                                        *
  * AUTHOR       : VAIBHAV GOYAL                                                                           *
  * DATE WRITTEN : 14-NOV-2011                                                                             *
  *                                                                                                        *
  * CHANGE CONTROL :                                                                                       *
  * VERSION#     |  RACKER TICKET #  | WHO             |  DATE          |   REMARKS                        *
  *--------------------------------------------------------------------------------------------------------*
  * 1.0.0        |  111122-02448      | VAIBHAV GOYAL   | 11/14/2011     | initial creation                *
  **********************************************************************************************************/
/* $Header: XXRS_WS_AR_CUST_AGING_GRANT1.sql 1.0.0 11/14/2011 2:07:10 PM Vaibhav Goyal $ */
EXECUTE ON xxrs.xxrs_ws_ar_cust_aging_type TO xxrscore;
GRANT EXECUTE ON xxrs.xxrs_ws_ar_cust_aging_tbl TO xxrscore;
GRANT ALL ON xxrs.xxrs_ws_ar_cust_aging_type TO apps;
GRANT ALL ON xxrs.xxrs_ws_ar_cust_aging_tbl TO apps;