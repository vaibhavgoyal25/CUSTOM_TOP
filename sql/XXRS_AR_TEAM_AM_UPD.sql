/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_AR_TEAM_AM_UPD.sql                                                                               *
*                                                                                                                     *
* DESCRIPTION : Staging table for 'Rackspace Mass Team BU AM Update' program                                          *
*                                                                                                                     *
* AUTHOR       : Kalyan                                                                                               *
* DATE WRITTEN : 29-DEC-2011                                                                                          *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* VER #  |  TICKET #    | WHO        |  DATE       |  REMARKS                                                         *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0  | 111122-02448 | Kalyan     |  29-DEC-2011  | Initial built for R12 upgrade                                  * 
***********************************************************************************************************************/
/* $Header: XXRS_AR_TEAM_AM_UPD.sql 1.0.0 29-DEC-2011 15:00:00 Kalyan$ */

DROP TABLE xxrs.xxrs_ar_team_am_upd;

CREATE TABLE xxrs.xxrs_ar_team_am_upd
( team_am_upd_id     NUMBER PRIMARY KEY ,
  customer_number    VARCHAR2(30),
  location_id        NUMBER,
  cust_acct_site_id  NUMBER,
  site_use_id        NUMBER,   
  business_unit      VARCHAR2(150),
  support_team       VARCHAR2(150),
  account_manager    VARCHAR2(150),
  error_msg          VARCHAR2(2000),
  status_flag        VARCHAR2(1),
  conc_request_id    NUMBER,
  creation_date      DATE,
  created_by         NUMBER,
  last_update_date   DATE,
  last_updated_by    NUMBER,
  last_update_login  NUMBER
);

DROP SYNONYM apps.xxrs_ar_team_am_upd;

CREATE SYNONYM apps.xxrs_ar_team_am_upd FOR xxrs.xxrs_ar_team_am_upd;

DROP SEQUENCE xxrs.xxrs_ar_team_am_upd_s;

CREATE SEQUENCE xxrs.xxrs_ar_team_am_upd_s
START WITH 1
INCREMENT BY 1
MINVALUE 0
NOCACHE
NOORDER;

DROP SYNONYM apps.xxrs_ar_team_am_upd_s;

CREATE SYNONYM apps.xxrs_ar_team_am_upd_s FOR xxrs.xxrs_ar_team_am_upd_s;

CREATE INDEX xxrs.xxrs_ar_team_am_upd_n01 ON xxrs.xxrs_ar_team_am_upd (status_flag);

/