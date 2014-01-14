DROP TABLE xxrs.xxrs_ar_invoice_documents CASCADE CONSTRAINTS;

CREATE TABLE xxrs.xxrs_ar_invoice_documents
/*********************************************************************************************************
*                                                                                                        *
* NAME : XXRS_AR_INVOICE_DOCUMENTS.sql                                                                   *
*                                                                                                        *
*DESCRIPTION : Script to create Table to Hold Invoice PDF Document.                                      *
*                                                                                                        *
* AUTHOR       : Vaibhav Goyal                                                                           *
* DATE WRITTEN : 27-JAN-2012                                                                             *
*                                                                                                        *
* CHANGE CONTROL :                                                                                       *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                        *
*--------------------------------------------------------------------------------------------------------*
* 1.0.0        |   111122-02448    | Vaibhav Goyal   | 01/27/2012     | Initial Creation                 *
*                                                                                                        *
**********************************************************************************************************
/* $Header: XXRS_AR_INVOICE_DOCUMENTS.sql 1.0.0 01/27/2012 10:00:00 AM Vaibhav Goyal $ */
( document_id         NUMBER ( 15 ),
  invoice_number      VARCHAR2 ( 20 BYTE ) NOT NULL,
  document            BLOB NOT NULL,
  org_id              NUMBER ( 15 ) NOT NULL,
  cust_trx_type       VARCHAR2 ( 20 BYTE ) NOT NULL,
  creation_date       DATE NOT NULL,
  created_by          NUMBER NOT NULL,
  last_updated_by     NUMBER NOT NULL,
  last_update_login   NUMBER NOT NULL,
  last_update_date    DATE NOT NULL );
