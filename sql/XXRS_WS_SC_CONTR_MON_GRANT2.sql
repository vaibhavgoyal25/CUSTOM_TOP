GRANT
  /*********************************************************************************************************
  *                                                                                                        *
  * NAME : XXRS_WS_SC_CONTR_MON_GRANT2.sql                                                                 *
  *                                                                                                        *
  * DESCRIPTION :                                                                                          *
  * Script to Provide Grant on Package to report Contract Monthly Details.                                 *
  *                                                                                                        *
  * AUTHOR       : VAIBHAV GOYAL                                                                           *
  * DATE WRITTEN : 07-DEC-2011                                                                             *
  *                                                                                                        *
  * CHANGE CONTROL :                                                                                       *
  * VERSION#     |  RACKER TICKET #  | WHO             |  DATE          |   REMARKS                        *
  *--------------------------------------------------------------------------------------------------------*
  * 1.0.0        |  111122-02448     | VAIBHAV GOYAL   | 12/07/2011     | initial creation                 *
  **********************************************************************************************************/
  /* $Header: XXRS_WS_SC_CONTR_MON_GRANT2.sql 1.0.0 12/07/2011 10:00:00 AM Vaibhav Goyal $ */
EXECUTE ON xxrs_ws_SC_contr_mon_pkg to xxrscore;
GRANT SELECT ON XXRS.XXRS_SC_DEVICE_PRODUCT_TBL to xxrscore;
GRANT SELECT ON xxrs.xxrs_sc_device_resource_tbl to xxrscore;
GRANT SELECT ON xxrs.xxrs_sc_product_rsrc_def_tbl to xxrscore;
GRANT SELECT ON xxrs.xxrs_sc_resource_def_tbl to xxrscore;
GRANT SELECT ON XXRS.XXRS_SC_CONTRACT_TBL to xxrscore;
GRANT SELECT ON APPLSYS.FND_LOOKUP_VALUES to xxrscore;