/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_AR_CUSTOMER_ADDR_H.sql                                                                                  *
*                                                                                                                     *
* DESCRIPTION :                                                                                                       *
* This file is used to Create table to Store Old and new Address of customer                                          *
*                                                                                                                     *
* AUTHOR       : SUDHEER GUNTU                                                                                        *
* DATE WRITTEN : 17-FEB-12                                                                                            *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* Version#     |  TICKET          | WHO             |  DATE          |   REMARKS                                      *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  111122-02448    | SUDHEER GUNTU   |  17-FEB-12     |  Initial Build for R12 upgradation             *
**********************************************************************************************************************/

/* $Header: XXRS_AR_CUSTOMER_ADDR_H.sql 1.0.0 17/02/2012 03:13:52 PM SUDHEER GUNTU $ */

DROP TABLE xxrs.xxrs_ar_customer_addr_h;

CREATE TABLE xxrs.xxrs_ar_customer_addr_h
(
  cust_history_id    NUMBER(15)                 NOT NULL,
  location_id        NUMBER(15)                 NOT NULL,
  party_site_id      NUMBER(15),
  site_use_id        NUMBER(15),
  old_country        VARCHAR2(60 BYTE),
  new_country        VARCHAR2(60 BYTE),
  old_address1       VARCHAR2(240 BYTE),
  new_address1       VARCHAR2(240 BYTE),
  old_address2       VARCHAR2(240 BYTE),
  new_address2       VARCHAR2(240 BYTE),
  old_address3       VARCHAR2(240 BYTE),
  new_address3       VARCHAR2(240 BYTE),
  old_address4       VARCHAR2(240 BYTE),
  new_address4       VARCHAR2(240 BYTE),
  old_city           VARCHAR2(60 BYTE),
  new_city           VARCHAR2(60 BYTE),
  old_postal_code    VARCHAR2(60 BYTE),
  new_postal_code    VARCHAR2(60 BYTE),
  old_state          VARCHAR2(60 BYTE),
  new_state          VARCHAR2(60 BYTE),
  creation_date      DATE                       NOT NULL,
  created_by         NUMBER                     NOT NULL,
  last_updated_by    NUMBER                     NOT NULL,
  last_update_login  NUMBER                     NOT NULL,
  last_update_date   DATE                       NOT NULL
);

DROP SYNONYM apps.xxrs_ar_customer_addr_h;

CREATE SYNONYM apps.xxrs_ar_customer_addr_h FOR xxrs.xxrs_ar_customer_addr_h;

DROP SEQUENCE xxrs.xxrs_ar_customer_addr_s;

CREATE SEQUENCE xxrs.xxrs_ar_customer_addr_s
START WITH 1
INCREMENT BY 1
MINVALUE 0
NOCYCLE
NOCACHE
ORDER;

DROP SYNONYM apps.xxrs_ar_customer_addr_s;

CREATE SYNONYM xxrs_ar_customer_addr_s FOR xxrs.xxrs_ar_customer_addr_s;