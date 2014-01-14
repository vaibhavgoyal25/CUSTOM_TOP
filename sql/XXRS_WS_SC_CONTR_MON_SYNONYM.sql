DROP SYNONYM xxrs_ws_sc_contr_mon_type;
DROP SYNONYM xxrs_ws_sc_contr_mon_tbl;
CREATE 
/*********************************************************************************************************
*                                                                                                        *
* NAME : XXRS_WS_SC_CONTR_MON_SYNONYM.sql                                                                *
*                                                                                                        *
*DESCRIPTION : Script to create Synonym for types holding Contract Monthly Details.                      *
*                                                                                                        *
* AUTHOR       : Vaibhav Goyal                                                                           *
* DATE WRITTEN : 07-DEC-2011                                                                             *
*                                                                                                        *
* CHANGE CONTROL :                                                                                       *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                        *
*--------------------------------------------------------------------------------------------------------*
* 1.0.0        |   111122-02448    | Vaibhav Goyal   | 12/07/2011     | Initial Creation                 *
*                                                                                                        *
**********************************************************************************************************/
/* $Header: XXRS_WS_SC_CONTR_MON_SYNONYM.sql 1.0.0 12/07/2011 10:00:00 AM Vaibhav Goyal $ */
SYNONYM xxrs_ws_sc_contr_mon_type FOR xxrs.xxrs_ws_sc_contr_mon_type;
CREATE SYNONYM xxrs_ws_sc_contr_mon_tbl FOR xxrs.xxrs_ws_sc_contr_mon_tbl;


