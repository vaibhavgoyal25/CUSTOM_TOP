GRANT
  /*********************************************************************************************************
  *                                                                                                        *
  * NAME : XXRS_WS_SC_ACCTLVLPRDPRC_GRANT1.sql                                                             *
  *                                                                                                        *
  * DESCRIPTION :                                                                                          *
  * Script to Provide Grant on Table Type Variable to report Account level product Pricing.                *
  *                                                                                                        *
  * AUTHOR       : VAIBHAV GOYAL                                                                           *
  * DATE WRITTEN : 13-JAN-2012                                                                             *
  *                                                                                                        *
  * CHANGE CONTROL :                                                                                       *
  * VERSION#     |  RACKER TICKET #  | WHO             |  DATE          |   REMARKS                        *
  *--------------------------------------------------------------------------------------------------------*
  * 1.0.0        |  111122-02448     | VAIBHAV GOYAL   | 01/13/2012     | initial creation                 *
  **********************************************************************************************************/
  /* $Header: XXRS_WS_SC_ACCTLVLPRDPRC_GRANT1.sql 1.0.0 12/08/2011 10:00:00 AM Vaibhav Goyal $ */
EXECUTE ON xxrs.xxrs_ws_sc_acctlvlprdprc_type TO xxrscore;
GRANT EXECUTE ON xxrs.xxrs_ws_sc_acctlvlprdprc_tbl TO xxrscore;
GRANT ALL ON xxrs.xxrs_ws_sc_acctlvlprdprc_type TO apps;
GRANT ALL ON xxrs.xxrs_ws_sc_acctlvlprdprc_tbl TO apps;
GRANT SELECT ON XXRS.XXRS_SC_SERVICE_DEF TO APPS WITH GRANT OPTION;