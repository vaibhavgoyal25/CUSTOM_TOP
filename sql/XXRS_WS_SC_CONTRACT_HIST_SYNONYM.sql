DROP SYNONYM apps.xxrs_ws_sc_contract_hist_type;
DROP SYNONYM apps.xxrs_ws_sc_contract_hist_tbl;
CREATE 
/*********************************************************************************************************
*                                                                                                        *
* NAME : XXRS_WS_SC_CONTRACT_HIST_SYNONYM.sql                                                            *
*                                                                                                        *
* DESCRIPTION : Script to create Synonym for types holding Customer Contract History Details.            *
*                                                                                                        *
* AUTHOR       : Vaibhav Goyal                                                                           *
* DATE WRITTEN : 08-DEC-2011                                                                             *
*                                                                                                        *
* CHANGE CONTROL :                                                                                       *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                        *
*--------------------------------------------------------------------------------------------------------*
* 1.0.0        |   111122-02448    | Vaibhav Goyal   | 12/08/2011     | Initial Creation                 *
*                                                                                                        *
**********************************************************************************************************/
/* $Header: XXRS_WS_SC_CONTRACT_HIST_SYNONYM.sql 1.0.0 12/08/2011 10:00:00 AM Vaibhav Goyal $ */
SYNONYM apps.xxrs_ws_sc_contract_hist_type FOR xxrs.xxrs_ws_sc_contract_hist_type;
CREATE SYNONYM apps.xxrs_ws_sc_contract_hist_tbl FOR xxrs.xxrs_ws_sc_contract_hist_tbl;


