DROP SYNONYM apps.xxrs_ws_sc_acctlvlprdprc_type;
DROP SYNONYM apps.xxrs_ws_sc_acctlvlprdprc_tbl;
CREATE 
/*********************************************************************************************************
*                                                                                                        *
* NAME : XXRS_WS_SC_ACCTLVLPRDPRC_SYNONYM.sql                                                            *
*                                                                                                        *
* DESCRIPTION : Script to create Synonym for types holding Account Level Product Pricing Data.           *
*                                                                                                        *
* AUTHOR       : Vaibhav Goyal                                                                           *
* DATE WRITTEN : 13-JAN-2012                                                                             *
*                                                                                                        *
* CHANGE CONTROL :                                                                                       *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                        *
*--------------------------------------------------------------------------------------------------------*
* 1.0.0        |   111122-02448    | Vaibhav Goyal   | 01/13/2012     | Initial Creation                 *
*                                                                                                        *
**********************************************************************************************************/
/* $Header: XXRS_WS_SC_ACCTLVLPRDPRC_SYNONYM.sql 1.0.0 01/13/2012 10:00:00 AM Vaibhav Goyal $ */
SYNONYM apps.xxrs_ws_sc_acctlvlprdprc_type FOR xxrs.xxrs_ws_sc_acctlvlprdprc_type;
CREATE SYNONYM apps.xxrs_ws_sc_acctlvlprdprc_tbl FOR xxrs.xxrs_ws_sc_acctlvlprdprc_tbl;


