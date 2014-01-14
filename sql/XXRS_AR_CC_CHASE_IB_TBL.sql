/* *******************************************************************************************************************
*                                                                                                                    *
* NAME : xxrs_ar_cc_chase_ib_tbl.sql                                                                                 *
*                                                                                                                    *
* DESCRIPTION :                                                                                                      *
* Staging table creation script for xxrs_ar_cc_chase_ib_pkg                                                          *
*                                                                                                                    *
* AUTHOR       : Ravi Gadwala                                                                                        *
* DATE WRITTEN : 11-JAN-2012                                                                                         *
*                                                                                                                    *
* CHANGE CONTROL :                                                                                                   *
* Version#     |   Ticket #        | WHO             |  DATE          |   REMARKS                                    *
*--------------------------------------------------------------------------------------------------------------------*
* 1.0.0        |   111122-02448    | Ravi Gadwala    |  11-JAN-2012   | Initial Creation for R12 Upgradation         *
*********************************************************************************************************************/
/* $Header: xxrs_ar_cc_chase_ib_tbl.sql 1.0.0 11-JAN-2012 10:41:56 AM Ravi $ */
DROP TABLE xxrs.xxrs_ar_cc_chase_ib_tbl CASCADE CONSTRAINTS;

CREATE TABLE xxrs.xxrs_ar_cc_chase_ib_tbl
(
  RECORD_ID           NUMBER  PRIMARY KEY,
  ORG_ID              NUMBER,
  AMOUNT              NUMBER,
  CARD_TYPE           VARCHAR2(30 BYTE),
  AUTHORIZATION_CODE  VARCHAR2(30 BYTE),
  CUSTOMER_NUMBER     VARCHAR2(30 BYTE),
  STATUS_CODE         VARCHAR2(1 BYTE),
  MESSAGE             VARCHAR2(2000 BYTE),
  CREATION_DATE       DATE,
  CREATED_BY          NUMBER,
  LAST_UPDATE_LOGIN   NUMBER,
  LAST_UPDATE_DATE    DATE,
  LAST_UPDATED_BY     NUMBER,
  CURRENCY_CODE       VARCHAR2(15 BYTE)
);

DROP SYNONYM apps.xxrs_ar_cc_chase_ib_tbl;

CREATE SYNONYM apps.xxrs_ar_cc_chase_ib_tbl FOR xxrs.xxrs_ar_cc_chase_ib_tbl;

DROP SEQUENCE xxrs.xxrs_ar_credit_card_ib_tbl_s;

CREATE SEQUENCE xxrs.xxrs_ar_credit_card_ib_tbl_s
START WITH 1
INCREMENT BY 1
MINVALUE 0
NOCACHE 
NOORDER;

DROP SYNONYM apps.xxrs_ar_credit_card_ib_tbl_s;

CREATE SYNONYM apps.xxrs_ar_credit_card_ib_tbl_s FOR xxrs.xxrs_ar_credit_card_ib_tbl_s;

CREATE SEQUENCE xxrs.xxrs_inb_cc_receipt_num_seq
START WITH 1
INCREMENT BY 1
MINVALUE 0
NOCACHE 
NOORDER;

DROP SYNONYM apps.xxrs_inb_cc_receipt_num_seq;

CREATE SYNONYM apps.xxrs_inb_cc_receipt_num_seq FOR xxrs.xxrs_inb_cc_receipt_num_seq;

/
