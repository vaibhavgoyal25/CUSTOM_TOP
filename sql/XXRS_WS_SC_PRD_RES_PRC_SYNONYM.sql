DROP SYNONYM apps.xxrs_ws_sc_prd_res_prc_type;
DROP SYNONYM apps.xxrs_ws_sc_prd_res_prc_tbl;
CREATE 
/*********************************************************************************************************
*                                                                                                        *
* NAME : XXRS_WS_SC_PRD_RES_PRC_SYNONYM.sql                                                              *
*                                                                                                        *
* DESCRIPTION : Script to create Synonym for types holding Product Pricing Details.                      *
*                                                                                                        *
* AUTHOR       : Vaibhav Goyal                                                                           *
* DATE WRITTEN : 24-JAN-2012                                                                             *
*                                                                                                        *
* CHANGE CONTROL :                                                                                       *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                        *
*--------------------------------------------------------------------------------------------------------*
* 1.0.0        |   111122-02448    | Vaibhav Goyal   | 01/24/2012     | Initial Creation                 *
*                                                                                                        *
**********************************************************************************************************/
/* $Header: XXRS_WS_SC_PRD_RES_PRC_SYNONYM.sql 1.0.0 01/24/2012 10:00:00 AM Vaibhav Goyal $ */
SYNONYM apps.xxrs_ws_sc_prd_res_prc_type FOR xxrs.xxrs_ws_sc_prd_res_prc_type;
CREATE SYNONYM apps.xxrs_ws_sc_prd_res_prc_tbl FOR xxrs.xxrs_ws_sc_prd_res_prc_tbl;


