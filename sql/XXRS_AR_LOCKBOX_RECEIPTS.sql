/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_AR_LOCKBOX_RECEIPTS.sql                                                                                 *
*                                                                                                                     *
* DESCRIPTION :                                                                                                       *
* Table Creation script to Hold and Process the Lockbox Data                                                          *
*                                                                                                                     *
* AUTHOR       : Sai Manohar                                                                                          *
* DATE WRITTEN : 29-DEC-2011                                                                                          *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* VER #  |  TICKET #    | WHO             |  DATE       |  REMARKS                                                    *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0  | 111122-02448 | Sai Manohar     |  29-DEC-2011  | Initial built for R12 upgrade                             *
***********************************************************************************************************************/
/* $Header: XXRS_AR_LOCKBOX_RECEIPTS.sql 1.0.0 29-DEC-2011 10:00:00 AM Sai Manohar $ */
ALTER TABLE xxrs.xxrs_ar_lockbox_receipts
 DROP PRIMARY KEY CASCADE;
DROP TABLE xxrs.xxrs_ar_lockbox_receipts CASCADE CONSTRAINTS;

CREATE TABLE xxrs.xxrs_ar_lockbox_receipts
(
  lbx_receipt_id         NUMBER(15),
  credit_date            DATE,
  process_date           DATE,
  site                   VARCHAR2(60 BYTE),
  lockbox                NUMBER(15),
  batch                  NUMBER(15),
  item                   NUMBER(15),
  seq                    NUMBER(15),
  deposit_dda            VARCHAR2(30 BYTE),
  remitter               VARCHAR2(240 BYTE),
  rt_number              VARCHAR2(60 BYTE),
  dda                    VARCHAR2(30 BYTE),
  payment_number         NUMBER(15),
  remit_date             DATE,
  type                   VARCHAR2(15 BYTE),
  currency               VARCHAR2(15 BYTE),
  amount                 NUMBER(15,2),
  invoice_number         VARCHAR2(50 BYTE),
  invoice_amount         NUMBER(15,2)           NOT NULL,
  customer_number        VARCHAR2(30 BYTE),
  process_status         VARCHAR2(10 BYTE),
  error_message          VARCHAR2(1000 BYTE),
  conc_request_id        NUMBER(15)             NOT NULL,
  creation_date          DATE                   NOT NULL,
  created_by             NUMBER(15)             NOT NULL,
  last_updated_by        NUMBER(15)             NOT NULL,
  last_update_date       DATE                   NOT NULL,
  last_update_login      NUMBER(15)             NOT NULL,
  batch_number           VARCHAR2(30 BYTE),
  cash_receipt_id        NUMBER(15),
  distribution_amount    NUMBER(15,2),
  parent_lbx_receipt_id  NUMBER(15),
  gl_date                DATE
)
TABLESPACE xxrs
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE INDEX xxrs.xxrs_ar_lockbox_receipts_n01 ON xxrs.xxrs_ar_lockbox_receipts
(customer_number)
LOGGING
TABLESPACE XXRS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE INDEX xxrs.xxrs_ar_lockbox_receipts_n02 ON xxrs.xxrs_ar_lockbox_receipts
(invoice_number)
LOGGING
TABLESPACE xxrs
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE INDEX xxrs.xxrs_ar_lockbox_receipts_n03 ON xxrs.xxrs_ar_lockbox_receipts
(batch_number, process_status)
LOGGING
TABLESPACE xxrs
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE INDEX xxrs.xxrs_ar_lockbox_receipts_n04 ON xxrs.xxrs_ar_lockbox_receipts
(parent_lbx_receipt_id)
LOGGING
TABLESPACE xxrs
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE UNIQUE INDEX xxrs.xxrs_ar_lockbox_receipts_pk ON xxrs.xxrs_ar_lockbox_receipts
(lbx_receipt_id)
LOGGING
TABLESPACE XXRS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


DROP SYNONYM apps.xxrs_ar_lockbox_receipts;

CREATE SYNONYM apps.xxrs_ar_lockbox_receipts FOR xxrs.xxrs_ar_lockbox_receipts;


ALTER TABLE xxrs.xxrs_ar_lockbox_receipts ADD (
  CONSTRAINT xxrs_ar_lockbox_receipts_pk
 PRIMARY KEY
 (lbx_receipt_id)
    USING INDEX 
    TABLESPACE xxrs
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
               ));
