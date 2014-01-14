GRANT
  /*********************************************************************************************************
  *                                                                                                        *
  * NAME : XXRS_WS_SC_DEVICE_GRANT1.sql                                                                    *
  *                                                                                                        *
  * DESCRIPTION :                                                                                          *
  * Script to Provide Grant on Table Type Variable to report Device MRR.                                   *
  *                                                                                                        *
  * AUTHOR       : VAIBHAV GOYAL                                                                           *
  * DATE WRITTEN : 08-DEC-2011                                                                             *
  *                                                                                                        *
  * CHANGE CONTROL :                                                                                       *
  * VERSION#     |  RACKER TICKET #  | WHO             |  DATE          |   REMARKS                        *
  *--------------------------------------------------------------------------------------------------------*
  * 1.0.0        |  111122-02448     | VAIBHAV GOYAL   | 12/08/2011     | initial creation                 *
  **********************************************************************************************************/
  /* $Header: XXRS_WS_SC_DEVICE_GRANT1.sql 1.0.0 12/08/2011 10:00:00 AM Vaibhav Goyal $ */
EXECUTE ON xxrs.xxrs_ws_sc_device_mrr_type TO xxrscore;
GRANT EXECUTE ON xxrs.xxrs_ws_sc_device_mrr_tbl TO xxrscore;
GRANT ALL ON xxrs.xxrs_ws_sc_device_mrr_type TO apps;
GRANT ALL ON xxrs.xxrs_ws_sc_device_mrr_tbl TO apps;
GRANT EXECUTE ON xxrs.xxrs_ws_sc_devices_type TO xxrscore;
GRANT EXECUTE ON xxrs.xxrs_ws_sc_devices_tbl TO xxrscore;
GRANT ALL ON xxrs.xxrs_ws_sc_devices_type TO apps;
GRANT ALL ON xxrs.xxrs_ws_sc_devices_tbl TO apps;