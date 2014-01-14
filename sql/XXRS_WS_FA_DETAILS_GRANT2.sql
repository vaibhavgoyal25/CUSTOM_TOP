GRANT
  /*********************************************************************************************************
  *                                                                                                        *
  * NAME : XXRS_WS_FA_DETAILS_GRANT2.sql                                                                   *
  *                                                                                                        *
  * DESCRIPTION :                                                                                          *
  * Script to Provide Grant on Package to report FA Details.                                               *
  *                                                                                                        *
  * AUTHOR       : VAIBHAV GOYAL                                                                           *
  * DATE WRITTEN : 08-DEC-2011                                                                             *
  *                                                                                                        *
  * CHANGE CONTROL :                                                                                       *
  * VERSION#     |  RACKER TICKET #  | WHO             |  DATE          |   REMARKS                        *
  *--------------------------------------------------------------------------------------------------------*
  * 1.0.0        |  111122-02448     | VAIBHAV GOYAL   | 12/08/2011     | initial creation                 *
  **********************************************************************************************************/
  /* $Header: XXRS_WS_AR_CONTRACT_HIST_GRANT2.sql 1.0.0 12/08/2011 10:00:00 AM Vaibhav Goyal $ */
EXECUTE ON apps.xxrs_ws_fa_details_pkg to xxrscore;
GRANT SELECT ON inv.mtl_item_locations to xxrscore;
GRANT SELECT ON inv.mtl_serial_numbers to xxrscore;
GRANT SELECT ON inv.mtl_system_items_b to xxrscore;
GRANT SELECT ON inv.mtl_item_categories to xxrscore;
GRANT SELECT ON inv.mtl_categories_b to xxrscore;