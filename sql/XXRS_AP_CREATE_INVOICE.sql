/*********************************************************************************************************************
*                                                                                                                    *
* NAME : XXRS_AP_CREATE_INVOICE.sql                                                                                  *
*                                                                                                                    *
* DESCRIPTION :                                                                                                      *
* Staging table and sequence creation  script for Solution Partner Invoices                                          *
*                                                                                                                    *
* AUTHOR       :  Padmaja                                                                                            *
* DATE WRITTEN :  02-JAN-2012                                                                                        *
*                                                                                                                    *
* CHANGE CONTROL :                                                                                                   *
* Version#     |  Racker Ticket #  | WHO                |  DATE             |   REMARKS                              *
*--------------------------------------------------------------------------------------------------------------------*
* 1.0.0        |   111122-02448    | Padmaja            |  02-JAN-2012      | Initial Creation                       *
**********************************************************************************************************************/
/* $Header:  XXRS_AP_CREATE_INVOICE.sql 1.0.0 02-JAN-2012  10:00:00 AM Padmaja  $ */ 

DROP TABLE xxrs.xxrs_ap_create_invoice CASCADE CONSTRAINTS;

CREATE TABLE xxrs.xxrs_ap_create_invoice
(
 vendor_number               VARCHAR2(30 BYTE),
 invoice_number              VARCHAR2(50 BYTE),
 invoice_date                DATE,
 description                 VARCHAR2(240 BYTE),
 amount                      NUMBER ,
 rs_company                  VARCHAR2(25 BYTE) ,
 rs_location                 VARCHAR2(25 BYTE) ,
 rs_account                  VARCHAR2(25 BYTE) ,
 rs_team                     VARCHAR2(25 BYTE) ,
 rs_business_units           VARCHAR2(25 BYTE) ,
 rs_departments              VARCHAR2(25 BYTE) ,
 rs_product                  VARCHAR2(25 BYTE) ,
 rs_future1                  VARCHAR2(25 BYTE) ,
 terms                       VARCHAR2(50 BYTE) ,
 h_invoice_id                NUMBER(15) ,
 h_invoice_number            VARCHAR2(50 BYTE) ,
 h_invoice_date              DATE ,
 h_vendor_number             VARCHAR2(30 BYTE) ,
 h_invoice_amount            NUMBER ,
 h_invoice_currency_code     VARCHAR2(15 BYTE) ,
 h_terms_id                  VARCHAR2(15 BYTE) ,
 h_source                    VARCHAR2(25 BYTE) ,
 l_invoice_id                NUMBER(15) ,
 l_invoice_line_id           NUMBER ,
 l_line_number               NUMBER ,
 l_line_type_lookup_code     VARCHAR2(25 BYTE) ,
 l_item_description          VARCHAR2(240 BYTE) ,
 l_amount                    NUMBER ,
 l_dist_code_combination_id  NUMBER(15) ,
 process_status              VARCHAR2(25 BYTE) ,
 error_message               VARCHAR2(1000 BYTE)   ,
 conc_request_id             NUMBER(15)            ,
 creation_date               DATE                  ,
 created_by                  NUMBER(15)            ,
 last_updated_by             NUMBER(15)            ,
 last_update_date            DATE                  ,
 last_update_login           NUMBER                ,
 record_id                   NUMBER  PRIMARY KEY   
);





DROP SYNONYM apps.xxrs_ap_create_invoice;

CREATE SYNONYM apps.xxrs_ap_create_invoice FOR xxrs.xxrs_ap_create_invoice;

DROP SEQUENCE xxrs.xxrs_ap_invoice_rec_id_s ;                                          

CREATE SEQUENCE xxrs.xxrs_ap_invoice_rec_id_s 
START WITH 1
INCREMENT BY 1
NOCACHE 
NOCYCLE ;

DROP  SYNONYM apps.xxrs_ap_invoice_rec_id_s ;

CREATE SYNONYM apps.xxrs_ap_invoice_rec_id_s  FOR xxrs.xxrs_ap_invoice_rec_id_s ;




