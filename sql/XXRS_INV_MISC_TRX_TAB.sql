/* ********************************************************************************************************************
*                                                                                                                     *
* NAME          : XXRS_INV_MISC_TRX_TAB.sql                                                                           *
*                                                                                                                     *
* DESCRIPTION   : Staging Table and sequence creation script                                                          *
*                                                                                                                     *
* AUTHOR        : Ravi                                                                                                *
* DATE WRITTEN  : 18-JAN-2012                                                                                         *
*                                                                                                                     *
* CHANGE CONTROL:                                                                                                     *
* SR#          |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                                     *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  111122-02448     | Ravi            |  18-JAN-2012   | Initial creation for R12 Upgradation          *
***********************************************************************************************************************/
/* $Header: xxrs_inv_misc_trx_tab.sql 1.0.0 18-JAN-2012 11:00:00 AM Ravi $ */

DROP TABLE xxrs.xxrs_inv_misc_trx_tab CASCADE CONSTRAINTS;

PROMPT Creating TABLE xxrs.xxrs_inv_misc_trx_tab

CREATE TABLE xxrs.xxrs_inv_misc_trx_tab
(
  transfer_id         NUMBER,
  inv_org             VARCHAR2(3 BYTE),
  transaction_type    VARCHAR2(80 BYTE),
  item_no             VARCHAR2(40 BYTE),
  serial_no           VARCHAR2(30 BYTE),
  qty                 NUMBER,
  uom                 VARCHAR2(3 BYTE),
  source_subinv       VARCHAR2(10 BYTE),
  source_locator      VARCHAR2(40 BYTE),
  transaction_source  VARCHAR2(40 BYTE),
  transfer_org        VARCHAR2(3 BYTE),
  shipment_no         VARCHAR2(30 BYTE),
  transfer_subinv     VARCHAR2(10 BYTE),
  transfer_locator    VARCHAR2(40 BYTE),
  reason_code         VARCHAR2(30 BYTE),
  status_flag         VARCHAR2(1 BYTE),
  error_msg           VARCHAR2(2000 BYTE),
  creation_date       DATE,
  created_by          NUMBER,
  last_updated_by     NUMBER,
  last_update_date    DATE,
  last_update_login   NUMBER,
  conc_request_id     NUMBER(15),
  source_reference    NUMBER PRIMARY KEY
);

DROP SYNONYM apps.xxrs_inv_misc_trx_tab;

CREATE SYNONYM apps.xxrs_inv_misc_trx_tab FOR xxrs.xxrs_inv_misc_trx_tab; 


DROP SEQUENCE xxrs.xxrs_inv_serial_ref_s;

PROMPT Creating SEQUENCE xxrs.xxrs_inv_serial_ref_s

CREATE SEQUENCE xxrs.xxrs_inv_serial_ref_s
START WITH 1
INCREMENT BY 1
MINVALUE 0
NOCACHE 
NOORDER;

DROP SYNONYM apps.xxrs_inv_serial_ref_s;

CREATE SYNONYM apps.xxrs_inv_serial_ref_s FOR xxrs.xxrs_inv_serial_ref_s; 


DROP SEQUENCE xxrs.xxrs_inv_misc_trx_hdr_s;
PROMPT Creating SEQUENCE xxrs.xxrs_inv_misc_trx_hdr_s

CREATE SEQUENCE xxrs.xxrs_inv_misc_trx_hdr_s
START WITH 1
INCREMENT BY 1
MINVALUE 0
NOCACHE 
NOORDER;

DROP SYNONYM apps.xxrs_inv_misc_trx_hdr_s;

CREATE SYNONYM apps.xxrs_inv_misc_trx_hdr_s FOR xxrs.xxrs_inv_misc_trx_hdr_s; 


DROP SEQUENCE xxrs.xxrs_inv_misc_trx_line_s;
PROMPT Creating SEQUENCE xxrs.xxrs_inv_misc_trx_line_s
CREATE SEQUENCE xxrs.xxrs_inv_misc_trx_line_s
START WITH 1
INCREMENT BY 1
MINVALUE 0
NOCACHE 
NOORDER;

DROP SYNONYM apps.xxrs_inv_misc_trx_line_s;

CREATE SYNONYM apps.xxrs_inv_misc_trx_line_s FOR xxrs.xxrs_inv_misc_trx_line_s; 
/