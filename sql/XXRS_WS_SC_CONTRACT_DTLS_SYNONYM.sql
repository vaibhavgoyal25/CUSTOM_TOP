DROP SYNONYM xxrs_ws_sc_con_dev_dtls_type;
DROP SYNONYM xxrs_ws_sc_con_dev_dtls_tbl;
DROP SYNONYM xxrs_ws_sc_con_acc_dtls_type;
DROP SYNONYM xxrs_ws_sc_con_acc_dtls_tbl;
CREATE 
/*********************************************************************************************************
*                                                                                                        *
* NAME : XXRS_WS_SC_CONTRACT_DTLS_SYNONYM.sql                                                            *
*                                                                                                        *
*DESCRIPTION : Script to create Synonym for types holding Customer Contract Details.                     *
*                                                                                                        *
* AUTHOR       : Vaibhav Goyal                                                                           *
* DATE WRITTEN : 06-DEC-2011                                                                             *
*                                                                                                        *
* CHANGE CONTROL :                                                                                       *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                        *
*--------------------------------------------------------------------------------------------------------*
* 1.0.0        |   111122-02448    | Vaibhav Goyal   | 12/06/2011     | Initial Creation                 *
*                                                                                                        *
**********************************************************************************************************/
/* $Header: XXRS_WS_SC_CONTRACT_DTLS_SYNONYM.sql 1.0.0 12/06/2011 10:00:00 AM Vaibhav Goyal $ */
SYNONYM xxrs_ws_sc_con_dev_dtls_type FOR xxrs.xxrs_ws_sc_con_dev_dtls_type;
CREATE SYNONYM xxrs_ws_sc_con_dev_dtls_tbl FOR xxrs.xxrs_ws_sc_con_dev_dtls_tbl;
CREATE SYNONYM xxrs_ws_sc_con_acc_dtls_type FOR xxrs.xxrs_ws_sc_con_acc_dtls_type;
CREATE SYNONYM xxrs_ws_sc_con_acc_dtls_tbl FOR xxrs.xxrs_ws_sc_con_acc_dtls_tbl;


