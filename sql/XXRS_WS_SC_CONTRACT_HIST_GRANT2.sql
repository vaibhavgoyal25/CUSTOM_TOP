GRANT
  /*********************************************************************************************************
  *                                                                                                        *
  * NAME : XXRS_WS_SC_CONTRACT_HIST_GRANT2.sql                                                             *
  *                                                                                                        *
  * DESCRIPTION :                                                                                          *
  * Script to Provide Grant on Package to report Contract History.                                         *
  *                                                                                                        *
  * AUTHOR       : VAIBHAV GOYAL                                                                           *
  * DATE WRITTEN : 08-DEC-2011                                                                             *
  *                                                                                                        *
  * CHANGE CONTROL :                                                                                       *
  * VERSION#     |  RACKER TICKET #  | WHO             |  DATE          |   REMARKS                        *
  *--------------------------------------------------------------------------------------------------------*
  * 1.0.0        |  111122-02448     | VAIBHAV GOYAL   | 12/08/2011     | initial creation                 *
  **********************************************************************************************************/
  /* $Header: XXRS_WS_SC_CONTRACT_HIST_GRANT2.sql 1.0.0 12/08/2011 10:00:00 AM Vaibhav Goyal $ */
EXECUTE ON apps.xxrs_ws_sc_contract_hist_pkg to xxrscore;
