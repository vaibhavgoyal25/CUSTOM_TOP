GRANT
  /*********************************************************************************************************
  *                                                                                                        *
  * NAME : XXRS_WS_AR_CREATE_CUST_GRANT.sql                                                                *
  *                                                                                                        *
  * DESCRIPTION :                                                                                          *
  * Script to Provide Grant on Package to set recurring payment details.                                   *
  *                                                                                                        *
  * AUTHOR       : VAIBHAV GOYAL                                                                           *
  * DATE WRITTEN : 27-JAN-2012                                                                             *
  *                                                                                                        *
  * CHANGE CONTROL :                                                                                       *
  * VERSION#     |  RACKER TICKET #  | WHO             |  DATE          |   REMARKS                        *
  *--------------------------------------------------------------------------------------------------------*
  * 1.0.0        |  130226-06484     | VAIBHAV GOYAL   | 03/15/2013     | initial creation                 *
  **********************************************************************************************************/
  /* $Header: XXRS_WS_AR_CREATE_CUST_GRANT.sql 1.0.0 03/15/2013 10:00:00 AM Vaibhav Goyal $ */
EXECUTE ON apps.xxrs_ws_ar_create_cust_pkg to xxrscore;