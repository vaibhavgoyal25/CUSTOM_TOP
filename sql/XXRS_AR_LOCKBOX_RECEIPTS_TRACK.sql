/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_AR_LOCKBOX_RECEIPTS_TRACK.sql                                                                           *
*                                                                                                                     *
* DESCRIPTION :                                                                                                       *
* Table Creation script to keep track of Changes to the Lockbox Data                                                  *
*                                                                                                                     *
* AUTHOR       : Sai Manohar                                                                                          *
* DATE WRITTEN : 29-DEC-2011                                                                                          *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* VER #  |  TICKET #    | WHO             |  DATE       |  REMARKS                                                    *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0  | 111122-02448 | Sai Manohar     |  29-DEC-2011  | Initial built for R12 upgrade                             *
***********************************************************************************************************************/
/* $Header: XXRS_AR_LOCKBOX_RECEIPTS_TRACK.sql 1.0.0 29-DEC-2011 10:00:00 AM Sai Manohar $ */
ALTER TABLE xxrs.xxrs_ar_lockbox_receipts_track
 DROP PRIMARY KEY CASCADE;
DROP TABLE xxrs.xxrs_ar_lockbox_receipts_track CASCADE CONSTRAINTS;

CREATE TABLE xxrs.xxrs_ar_lockbox_receipts_track
(
  lbx_change_ref_id        NUMBER(15),
  lbx_receipt_id           NUMBER(15),
  old_payment_number       NUMBER(15),
  new_payment_number       NUMBER(15),
  old_invoice_number       VARCHAR2(30 BYTE),
  new_invoice_number       VARCHAR2(30 BYTE),
  old_customer_number      VARCHAR2(30 BYTE),
  new_customer_number      VARCHAR2(30 BYTE),
  old_distribution_amount  NUMBER(15,2),
  new_distribution_amount  NUMBER(15,2),
  change_description       VARCHAR2(1000 BYTE),
  creation_date            DATE                 NOT NULL,
  created_by               NUMBER(15)           NOT NULL,
  last_update_date         DATE                 NOT NULL,
  last_updated_by          NUMBER(15)           NOT NULL,
  last_update_login        NUMBER(15)           NOT NULL,
  batch_number             VARCHAR2(30 BYTE)
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


CREATE UNIQUE INDEX xxrs.xxrs_ar_lbx_rcpt_trk_pk ON xxrs.xxrs_ar_lockbox_receipts_track
(lbx_change_ref_id)
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


DROP SYNONYM apps.xxrs_ar_lockbox_receipts_track;

CREATE SYNONYM apps.xxrs_ar_lockbox_receipts_track FOR xxrs.xxrs_ar_lockbox_receipts_track;


ALTER TABLE xxrs.xxrs_ar_lockbox_receipts_track ADD (
  CONSTRAINT xxrs_ar_lbx_rcpt_trk_pk
 PRIMARY KEY
 (lbx_change_ref_id)
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
