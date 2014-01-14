GRANT
  /*********************************************************************************************************
  *                                                                                                        *
  * NAME : XXRS_WS_SC_PRD_RES_PRC_GRANT1.sql                                                               *
  *                                                                                                        *
  * DESCRIPTION :                                                                                          *
  * Script to Provide Grant on Table Type Variable to report product pricing details.                      *
  *                                                                                                        *
  * AUTHOR       : VAIBHAV GOYAL                                                                           *
  * DATE WRITTEN : 24-JAN-2012                                                                             *
  *                                                                                                        *
  * CHANGE CONTROL :                                                                                       *
  * VERSION#     |  RACKER TICKET #  | WHO             |  DATE          |   REMARKS                        *
  *--------------------------------------------------------------------------------------------------------*
  * 1.0.0        |  111122-02448     | VAIBHAV GOYAL   | 01/24/2012     | initial creation                 *
  **********************************************************************************************************/
  /* $Header: XXRS_WS_SC_PRD_RES_PRC_GRANT1.sql 1.0.0 01/24/2012 10:00:00 AM Vaibhav Goyal $ */
EXECUTE ON xxrs.xxrs_ws_sc_prd_res_prc_type TO xxrscore;
GRANT EXECUTE ON xxrs.xxrs_ws_sc_prd_res_prc_tbl TO xxrscore;
GRANT ALL ON xxrs.xxrs_ws_sc_prd_res_prc_type TO apps;
GRANT ALL ON xxrs.xxrs_ws_sc_prd_res_prc_tbl TO apps;