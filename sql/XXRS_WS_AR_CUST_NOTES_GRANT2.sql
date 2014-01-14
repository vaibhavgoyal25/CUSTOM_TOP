GRANT
  /*********************************************************************************************************
  *                                                                                                        *
  * NAME : XXRS_WS_AR_CUST_NOTES_GRANT2.sql                                                                *
  *                                                                                                        *
  * DESCRIPTION :                                                                                          *
  * Script to Provide Grant on Package to report Customer Notes.                                           *
  *                                                                                                        *
  * AUTHOR       : VAIBHAV GOYAL                                                                           *
  * DATE WRITTEN : 05-DEC-2011                                                                             *
  *                                                                                                        *
  * CHANGE CONTROL :                                                                                       *
  * VERSION#     |  RACKER TICKET #  | WHO             |  DATE          |   REMARKS                        *
  *--------------------------------------------------------------------------------------------------------*
  * 1.0.0        |  111122-02448     | VAIBHAV GOYAL   | 12/05/2011     | initial creation                 *
  **********************************************************************************************************/
  /* $Header: XXRS_WS_AR_CUST_NOTES_GRANT2.sql 1.0.0 12/05/2011 10:00:00 AM Vaibhav Goyal $ */
EXECUTE ON  apps.xxrs_ws_ar_cust_notes_pkg to xxrscore;
GRANT SELECT ON jtf.jtf_notes_b to xxrscore;
GRANT SELECT ON jtf.jtf_notes_tl to xxrscore;
GRANT SELECT ON jtf.jtf_rs_resource_extns to xxrscore;
GRANT SELECT ON ar.hz_cust_accounts to xxrscore;