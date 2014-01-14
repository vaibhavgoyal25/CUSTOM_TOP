/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_SC_PO_NUM_UPD.sql                                                                                       *
*                                                                                                                     *
* DESCRIPTION :                                                                                                       *
* Table to hold SC Po Number Update data.                                                                             *
*                                                                                                                     *
* AUTHOR       : Vaibhav Goyal                                                                                        *
* DATE WRITTEN : 03-SEP-2013                                                                                          *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* Version#     |  TICKET          | WHO             |  DATE          |   REMARKS                                      *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  130621-07223    | VAIBHAV GOYAL   |  03-SEP-2013   |  Initial Creation.                             *
**********************************************************************************************************************/

/* $Header: XXRS_SC_PO_NUM_UPD.sql 1.0.0 03-SEP-2013 10:21:52 AM VAIBHAV GOYAL $ */

DROP TABLE XXRS.XXRS_SC_PO_NUM_UPD;

CREATE TABLE XXRS.XXRS_SC_PO_NUM_UPD
( cust_po_num_upd_id         NUMBER(10) PRIMARY KEY,
  customer_number            VARCHAR2(30) NOT NULL,
  cloud_account              VARCHAR2(50),
  product_name               VARCHAR2(40),
  resource_name              VARCHAR2(30),
  device_num                 VARCHAR2(40),
  existing_po_number         VARCHAR2(50),
  new_po_number              VARCHAR2(50) NOT NULL,
  process_status             VARCHAR2(10),
  error_message              VARCHAR2(1000),
  conc_request_id            NUMBER,
  creation_date              DATE   NOT NULL,
  created_by                 NUMBER NOT NULL,
  last_update_login          NUMBER NOT NULL,
  last_update_date           DATE   NOT NULL,
  last_updated_by            NUMBER NOT NULL);

DROP SYNONYM apps.XXRS_SC_PO_NUM_UPD;

CREATE SYNONYM apps.XXRS_SC_PO_NUM_UPD FOR xxrs.XXRS_SC_PO_NUM_UPD;
 
