GRANT
  /*********************************************************************************************************
  *                                                                                                        *
  * NAME : XXRS_WS_AR_CUST_NOTES_GRANT1.sql                                                                *
  *                                                                                                        *
  * DESCRIPTION :                                                                                          *
  * Script to Provide Grant on Table Type Variable to report Customer Notes.                               *
  *                                                                                                        *
  * AUTHOR       : VAIBHAV GOYAL                                                                           *
  * DATE WRITTEN : 05-DEC-2011                                                                             *
  *                                                                                                        *
  * CHANGE CONTROL :                                                                                       *
  * VERSION#     |  RACKER TICKET #  | WHO             |  DATE          |   REMARKS                        *
  *--------------------------------------------------------------------------------------------------------*
  * 1.0.0        |  111122-02448     | VAIBHAV GOYAL   | 12/05/2011     | initial creation                 *
  * 1.0.1        |  120911-08923     | VAIBHAV GOYAL   | 11/27/2012     | Grants on Updated Type           *
  **********************************************************************************************************/
  /* $Header: XXRS_WS_AR_CUST_NOTES_GRANT1.sql 1.0.1 11/27/2012 10:00:00 AM Vaibhav Goyal $ */
EXECUTE ON xxrs.xxrs_ws_ar_cust_notes_type TO xxrscore;
GRANT EXECUTE ON xxrs.xxrs_ws_ar_cust_notes_tbl TO xxrscore;
GRANT ALL ON xxrs.xxrs_ws_ar_cust_notes_type TO apps;
GRANT ALL ON xxrs.xxrs_ws_ar_cust_notes_tbl TO apps;