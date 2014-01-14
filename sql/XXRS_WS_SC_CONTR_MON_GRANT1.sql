GRANT
  /*********************************************************************************************************
  *                                                                                                        *
  * NAME : XXRS_WS_SC_CONTR_MON_GRANT1.sql                                                                 *
  *                                                                                                        *
  * DESCRIPTION :                                                                                          *
  * Script to Provide Grant on Table Type Variable to report Contract Monthly charges.                     *
  *                                                                                                        *
  * AUTHOR       : VAIBHAV GOYAL                                                                           *
  * DATE WRITTEN : 07-DEC-2011                                                                             *
  *                                                                                                        *
  * CHANGE CONTROL :                                                                                       *
  * VERSION#     |  RACKER TICKET #  | WHO             |  DATE          |   REMARKS                        *
  *--------------------------------------------------------------------------------------------------------*
  * 1.0.0        |  111122-02448     | VAIBHAV GOYAL   | 12/07/2011     | initial creation                 *
  **********************************************************************************************************/
  /* $Header: XXRS_WS_SC_CONTR_MON_GRANT1.sql 1.0.0 12/05/2011 10:00:00 AM Vaibhav Goyal $ */
EXECUTE ON xxrs.xxrs_ws_sc_contr_mon_type TO xxrscore;
GRANT EXECUTE ON xxrs.xxrs_ws_sc_contr_mon_tbl TO xxrscore;
GRANT ALL ON xxrs.xxrs_ws_sc_contr_mon_type TO apps;
GRANT ALL ON xxrs.xxrs_ws_sc_contr_mon_tbl TO apps;