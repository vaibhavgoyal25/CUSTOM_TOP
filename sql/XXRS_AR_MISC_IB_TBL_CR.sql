/**************************************************************************************************************
*                                                                                                             *
* NAME: XXRS_AR_MISC_IB_TBL_CR.sql                                                                            *
*                                                                                                             *
* DESCRIPTION :                                                                                               *
*   This file is used to create intermediate table 'xxrs_ar_misc_ib_tbl'                                      *
*                                                                                                             *
* AUTHOR       : Sunil Kumar Mallina                                                                          *
* DATE WRITTEN : 03-JAN-2012                                                                                  *
*                                                                                                             *
* CHANGE CONTROL :                                                                                            *
* Version#     |  Ticket Number    | WHO                    |  DATE             |   REMARKS                   *
*-------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  111122-02448     | Sunil Kumar Mallina    |  03-JAN-2012      | R12 Upgradation             *
***************************************************************************************************************/
/* $Header: XXRS_AR_MISC_IB_TBL_CR.sql 1.0.0 03-JAN-2012 16:14:00 PM Sunil Kumar M $ */

DROP TABLE xxrs.xxrs_ar_misc_ib_tbl;

CREATE TABLE xxrs.xxrs_ar_misc_ib_tbl
(
  org_id              NUMBER,
  customer_number     VARCHAR2(30),
  amount              NUMBER,
  payment_date        DATE,
  currency_code       VARCHAR2(15),
  payment_method      VARCHAR2(30),
  bank_account_num    VARCHAR2(30),
  payment_description VARCHAR2(30),
  status_code         VARCHAR2(1),
  message             VARCHAR2(2000),
  creation_date       DATE,
  created_by          NUMBER,
  last_update_login   NUMBER,
  last_update_date    DATE,
  last_updated_by     NUMBER,
  record_id           NUMBER  PRIMARY KEY
)
;

DROP SYNONYM apps.xxrs_ar_misc_ib_tbl;

CREATE SYNONYM apps.xxrs_ar_misc_ib_tbl  FOR xxrs.xxrs_ar_misc_ib_tbl;

DROP SEQUENCE xxrs.xxrs_inb_cc_receipt_num_seq;                                          

CREATE SEQUENCE xxrs.xxrs_inb_cc_receipt_num_seq
START WITH 1
INCREMENT BY 1
NOCACHE 
NOCYCLE ;

DROP  SYNONYM apps.xxrs_inb_cc_receipt_num_seq;

CREATE SYNONYM apps.xxrs_inb_cc_receipt_num_seq FOR xxrs.xxrs_inb_cc_receipt_num_seq;


DROP SEQUENCE xxrs.xxrs_ar_misc_ib_tbl_s;                                          

CREATE SEQUENCE xxrs.xxrs_ar_misc_ib_tbl_s
START WITH 1
INCREMENT BY 1
NOCACHE 
NOCYCLE ;

DROP  SYNONYM apps.xxrs_ar_misc_ib_tbl_s;

CREATE SYNONYM apps.xxrs_ar_misc_ib_tbl_s FOR xxrs.xxrs_ar_misc_ib_tbl_s;
/
