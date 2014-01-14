DROP SYNONYM apps.xxrs_ws_ar_invoice_dtl_type;
DROP SYNONYM apps.xxrs_ws_ar_invoice_dtl_tbl;
CREATE 
/*********************************************************************************************************
*                                                                                                        *
* NAME : XXRS_WS_AR_INVOICE_DTL_SYNONYM.sql                                                              *
*                                                                                                        *
*DESCRIPTION : Script to create Synonym for types holding Invoice Details.                               *
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
/* $Header: XXRS_WS_AR_INVOICE_DTL_SYNONYM.sql 1.0.0 01/27/2012 10:00:00 AM Vaibhav Goyal $ */
SYNONYM apps.xxrs_ws_ar_invoice_dtl_type FOR xxrs.xxrs_ws_ar_invoice_dtl_type;
CREATE SYNONYM apps.xxrs_ws_ar_invoice_dtl_tbl FOR xxrs.xxrs_ws_ar_invoice_dtl_tbl;


