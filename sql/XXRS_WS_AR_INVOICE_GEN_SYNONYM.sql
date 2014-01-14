DROP SYNONYM apps.xxrs_ar_invoice_documents;
CREATE 
/*********************************************************************************************************
*                                                                                                        *
* NAME : XXRS_WS_AR_INVOICE_GEN_SYNONYM.sql                                                              *
*                                                                                                        *
*DESCRIPTION : Script to create Synonym for table holding Invoice PDF.                                   *
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
/* $Header: XXRS_WS_AR_INVOICE_GEN_SYNONYM.sql 1.0.0 01/27/2012 10:00:00 AM Vaibhav Goyal $ */
SYNONYM apps.xxrs_ar_invoice_documents FOR xxrs.xxrs_ar_invoice_documents;
CREATE OR REPLACE SYNONYM apps.xxrs_ar_invoice_documents_s for xxrs.xxrs_ar_invoice_documents_s;


