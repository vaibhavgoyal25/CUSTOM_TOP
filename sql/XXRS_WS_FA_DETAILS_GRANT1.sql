GRANT
  /*********************************************************************************************************
  *                                                                                                        *
  * NAME : XXRS_WS_FA_DETAILS_GRANT1.sql                                                                   *
  *                                                                                                        *
  * DESCRIPTION :                                                                                          *
  * Script to Provide Grant on Table Type Variable to Fixed Asset Details.                                 *
  *                                                                                                        *
  * AUTHOR       : VAIBHAV GOYAL                                                                           *
  * DATE WRITTEN : 08-DEC-2011                                                                             *
  *                                                                                                        *
  * CHANGE CONTROL :                                                                                       *
  * VERSION#     |  RACKER TICKET #  | WHO             |  DATE          |   REMARKS                        *
  *--------------------------------------------------------------------------------------------------------*
  * 1.0.0        |  111122-02448     | VAIBHAV GOYAL   | 12/08/2011     | initial creation                 *
  **********************************************************************************************************/
  /* $Header: XXRS_WS_FA_DETAILS_GRANT1.sql 1.0.0 12/08/2011 10:00:00 AM Vaibhav Goyal $ */
EXECUTE ON xxrs.xxrs_ws_fa_details_type TO xxrscore;
GRANT EXECUTE ON xxrs.xxrs_ws_fa_details_tbl TO xxrscore;
GRANT ALL ON xxrs.xxrs_ws_fa_details_type TO apps;
GRANT ALL ON xxrs.xxrs_ws_fa_details_tbl TO apps;