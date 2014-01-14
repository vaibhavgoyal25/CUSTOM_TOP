/*********************************************************************************************************************
*                                                                                                                    *
* NAME : XXRS_AP_CREATE_INVOICE_ARCH.sql                                                                             *
*                                                                                                                    *
* DESCRIPTION :                                                                                                      *
* Staging table  creation  script for Solution Partner Invoices  archive table                                       *
*                                                                                                                    *
* AUTHOR       :  Padmaja                                                                                            *
* DATE WRITTEN :  02-JAN-2012                                                                                        *
*                                                                                                                    *
* CHANGE CONTROL :                                                                                                   *
* Version#     |  Racker Ticket #  | WHO                |  DATE             |   REMARKS                              *
*--------------------------------------------------------------------------------------------------------------------*
* 1.0.0        |   111122-02448    | Padmaja            |  02-JAN-2012      | Initial Creation                       *
**********************************************************************************************************************/
/* $Header:  XXRS_AP_CREATE_INVOICE_ARCH.sql 1.0.0 02-JAN-2012  10:00:00 AM Padmaja  $ */ 


DROP TABLE xxrs.xxrs_ap_create_invoice_arch CASCADE CONSTRAINTS;

CREATE TABLE xxrs.xxrs_ap_create_invoice_arch
(
  VENDOR_NUMBER               VARCHAR2(60 BYTE),
  INVOICE_NUMBER              VARCHAR2(60 BYTE),
  INVOICE_DATE                VARCHAR2(60 BYTE),
  DESCRIPTION                 VARCHAR2(240 BYTE),
  AMOUNT                      VARCHAR2(60 BYTE),
  RS_COMPANY                  VARCHAR2(60 BYTE),
  RS_LOCATION                 VARCHAR2(60 BYTE),
  RS_ACCOUNT                  VARCHAR2(60 BYTE),
  RS_TEAM                     VARCHAR2(60 BYTE),
  RS_BUSINESS_UNITS           VARCHAR2(60 BYTE),
  RS_DEPARTMENTS              VARCHAR2(60 BYTE),
  RS_PRODUCT                  VARCHAR2(60 BYTE),
  RS_FUTURE1                  VARCHAR2(60 BYTE),
  TERMS                       VARCHAR2(60 BYTE),
  H_INVOICE_ID                VARCHAR2(60 BYTE),
  H_INVOICE_NUMBER            VARCHAR2(60 BYTE),
  H_INVOICE_DATE              VARCHAR2(60 BYTE),
  H_VENDOR_NUMBER             VARCHAR2(60 BYTE),
  H_INVOICE_AMOUNT            VARCHAR2(60 BYTE),
  H_INVOICE_CURRENCY_CODE     VARCHAR2(60 BYTE),
  H_TERMS_ID                  VARCHAR2(60 BYTE),
  H_SOURCE                    VARCHAR2(60 BYTE),
  L_INVOICE_ID                VARCHAR2(60 BYTE),
  L_INVOICE_LINE_ID           VARCHAR2(60 BYTE),
  L_LINE_NUMBER               VARCHAR2(60 BYTE),
  L_LINE_TYPE_LOOKUP_CODE     VARCHAR2(60 BYTE),
  L_ITEM_DESCRIPTION          VARCHAR2(60 BYTE),
  L_AMOUNT                    VARCHAR2(60 BYTE),
  L_DIST_CODE_COMBINATION_ID  VARCHAR2(60 BYTE),
  PROCESS_STATUS              VARCHAR2(60 BYTE),
  ERROR_MESSAGE               VARCHAR2(1000 BYTE),
  ARCHIVE_DATE                DATE,
  CONC_REQUEST_ID             NUMBER(15),
  CREATION_DATE               DATE,
  CREATED_BY                  NUMBER(15),
  LAST_UPDATED_BY             NUMBER(15),
  LAST_UPDATE_DATE            DATE,
  LAST_UPDATE_LOGIN           NUMBER
)  ;
DROP SYNONYM apps.xxrs_ap_create_invoice_arch;

CREATE SYNONYM apps.xxrs_ap_create_invoice_arch FOR xxrs.xxrs_ap_create_invoice_arch;




