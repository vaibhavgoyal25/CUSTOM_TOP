DROP SYNONYM apps.xxrs_ws_ar_get_rec_pay_type;
DROP SYNONYM apps.xxrs_ws_ar_get_rec_pay_tbl;
CREATE 
/*********************************************************************************************************
*                                                                                                        *
* NAME : XXRS_WS_AR_GET_REC_PAY_SYNONYM.sql                                                              *
*                                                                                                        *
*DESCRIPTION : Script to create Synonym for types holding Recurring Payment Details.                     *
*                                                                                                        *
* AUTHOR       : Vaibhav Goyal                                                                           *
* DATE WRITTEN : 27-JAN-2012                                                                             *
*                                                                                                        *
* CHANGE CONTROL :                                                                                       *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                        *
*--------------------------------------------------------------------------------------------------------*
* 1.0.0        |   111122-02448    | Vaibhav Goyal   | 01/27/2012     | Initial Creation                 *
*                                                                                                        *
**********************************************************************************************************/
/* $Header: XXRS_WS_AR_GET_REC_PAY_SYNONYM.sql 1.0.0 01/27/2012 10:00:00 AM Vaibhav Goyal $ */
SYNONYM apps.xxrs_ws_ar_get_rec_pay_type FOR xxrs.xxrs_ws_ar_get_rec_pay_type;
CREATE SYNONYM apps.xxrs_ws_ar_get_rec_pay_tbl FOR xxrs.xxrs_ws_ar_get_rec_pay_tbl;


