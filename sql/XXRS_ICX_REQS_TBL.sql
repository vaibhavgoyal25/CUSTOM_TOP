/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_ICX_REQS_TBL.sql                                                                                        *
*                                                                                                                     *
* DESCRIPTION :                                                                                                       *
* This file is used to create intermediate table 'xxrs.xxrs_icx_reqs_tbl'                                             *
*                                                                                                                     *
* AUTHOR       : SUDHEER GUNTU                                                                                        *
* DATE WRITTEN : 20-DEC-2011                                                                                          *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* Version#     |  TICKET      | WHO             |  DATE          |   REMARKS                                          *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0        | 111122-02448 | SUDHEER GUNTU   |  20-DEC-2011   | Initial Creation for R12 upgradation               *
**********************************************************************************************************************/

/* $Header: XXRS_ICX_REQS_TBL.sql 1.0.0 22/12/2011 03:24:29 PM SUDHEER GUNTU $ */

DROP TABLE xxrs.xxrs_icx_reqs_tbl;

CREATE TABLE xxrs.xxrs_icx_reqs_tbl
(
  suggested_vendor_name VARCHAR2(240),
  suggested_vendor_site VARCHAR2(15),
  item_description VARCHAR2(240),
  line_type VARCHAR2(25),
  category_segment1 VARCHAR2(40),
  unit_price NUMBER,
  amount NUMBER,
  currency_code VARCHAR2(15),
  quantity NUMBER,
  charge_account_segment1 VARCHAR2(30),
  charge_account_segment2 VARCHAR2(30),
  charge_account_segment3 VARCHAR2(30),
  charge_account_segment4 VARCHAR2(30),
  charge_account_segment5 VARCHAR2(30),
  charge_account_segment6 VARCHAR2(30),
  charge_account_segment7 VARCHAR2(30),
  charge_account_segment8 VARCHAR2(30),
  location_code VARCHAR2(60),
  inventory_org_code VARCHAR2(3),
  conc_request_id NUMBER,
  created_by NUMBER,
  reference_num NUMBER,
  employee_id NUMBER,
  creation_date DATE,
  last_update_login NUMBER,
  last_update_date DATE,
  last_updated_by NUMBER,
  org_id NUMBER,
  process_flag VARCHAR2(1),
  error_msg VARCHAR2(240),
  CONSTRAINT xxrs_icx_reqs_tbl_pk PRIMARY KEY (conc_request_id, reference_num)
);

DROP SYNONYM xxrs_icx_reqs_tbl;

CREATE SYNONYM apps.xxrs_icx_reqs_tbl FOR xxrs.xxrs_icx_reqs_tbl;
/
