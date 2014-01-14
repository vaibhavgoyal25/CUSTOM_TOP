/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_AR_DUN_CONT_TBL.sql                                                                                     *
*                                                                                                                     *
* DESCRIPTION :                                                                                                       *
* This file is used to Create table to Store Dunning contacts information                                             *
*                                                                                                                     *
* AUTHOR       : AneeshSingh                                                                                          *
* DATE WRITTEN : 23-DEC-11                                                                                            *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* Version#     |  TICKET          | WHO             |  DATE          |   REMARKS                                      *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  111122-02448    | AneeshSingh     |  23-DEC-11     |  Initial Build for R12 upgradation             *
**********************************************************************************************************************/

/* $Header: XXRS_AR_DUN_CONT_TBL.sql 1.0.0 23-DEC-11 03:31:52 PM Aneesh Singh $ */

DROP TABLE xxrs.xxrs_ar_contacts;

CREATE TABLE xxrs.xxrs_ar_contacts
(
  con_id             NUMBER(15),
  account_number     VARCHAR2(30)          NOT NULL,
  first_name         VARCHAR2(150),
  last_name          VARCHAR2(150),
  email_address      VARCHAR2(2000),
  role_resp_type     VARCHAR2(30)          NOT NULL,
  rr_primary_flag    VARCHAR2(1),
  error_msg          VARCHAR2(2000),
  process_flag       VARCHAR2(1),
  conc_request_id    NUMBER                NOT NULL,
  creation_date      DATE                  NOT NULL,
  created_by         NUMBER                NOT NULL,
  last_updated_by    NUMBER                NOT NULL,
  last_update_date   DATE                  NOT NULL,
  last_update_login  NUMBER                NOT NULL
);

GRANT ALL ON xxrs.xxrs_ar_contacts TO APPS; /*111122-02448*/

DROP SYNONYM apps.xxrs_ar_contacts;

CREATE SYNONYM apps.xxrs_ar_contacts FOR xxrs.xxrs_ar_contacts;

DROP SEQUENCE xxrs.xxrs_ar_contacts_s;

CREATE SEQUENCE xxrs.xxrs_ar_contacts_s
START WITH 1
INCREMENT BY 1
MINVALUE 0
NOCACHE 
NOORDER;

DROP SYNONYM apps.xxrs_ar_contacts_s;

CREATE SYNONYM apps.xxrs_ar_contacts_s FOR xxrs.xxrs_ar_contacts_s;
/