GRANT
  /*********************************************************************************************************
  *                                                                                                        *
  * NAME : XXRS_WS_AR_CUST_AGING_GRANT2.sql                                                                *
  *                                                                                                        *
  * DESCRIPTION :                                                                                          *
  * Script to Provide Grant on Package to report Customer Aging Details.                                   *
  *                                                                                                        *
  * AUTHOR       : VAIBHAV GOYAL                                                                           *
  * DATE WRITTEN : 14-NOV-2011                                                                             *
  *                                                                                                        *
  * CHANGE CONTROL :                                                                                       *
  * VERSION#     |  RACKER TICKET #  | WHO             |  DATE          |   REMARKS                        *
  *--------------------------------------------------------------------------------------------------------*
  * 1.0.0        |  111122-02448     | VAIBHAV GOYAL   | 11/14/2011     | initial creation                 *
  **********************************************************************************************************/
/* $Header: XXRS_WS_AR_CUST_AGING_GRANT2.sql 1.0.0 11/14/2011 2:07:10 PM Vaibhav Goyal $ */
EXECUTE ON apps.xxrs_ws_ar_cust_aging_pkg to xxrscore;