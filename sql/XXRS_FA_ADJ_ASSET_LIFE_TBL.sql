/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_FA_ADJ_ASSET_LIFE_TBL.sql                                                                               *
*                                                                                                                     *
* DESCRIPTION :                                                                                                       *
* This file is used to Create table to Store Asset Life Adjustment Data                                               *
*                                                                                                                     *
* AUTHOR       : SUDHEER GUNTU                                                                                        *
* DATE WRITTEN : 20-DEC-11                                                                                            *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* Version#     |  TICKET          | WHO             |  DATE          |   REMARKS                                      *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  111122-02448    | SUDHEER GUNTU   |  20-DEC-11     |  Initial Build for R12 upgradation             *
**********************************************************************************************************************/

/* $Header: XXRS_FA_ADJ_ASSET_LIFE_TBL.sql 1.0.0 22/12/2011 10:11:52 AM SUDHEER GUNTU $ */

DROP TABLE xxrs.xxrs_fa_adj_asset_life_tbl;

CREATE TABLE xxrs.xxrs_fa_adj_asset_life_tbl
(
  asset_number       VARCHAR2(15) NOT NULL,
  book               VARCHAR2(15),
  life_yrs           NUMBER(4),
  life_mnths         NUMBER(4),
  last_updated_by    NUMBER(15),
  last_update_date   DATE,
  process_status     VARCHAR2(1),
  error_message      VARCHAR2(1000),
  conc_request_id    NUMBER(15),
  creation_date      DATE,
  created_by         NUMBER(15),
  last_update_login  NUMBER(15),
  asset_rec_id       NUMBER       PRIMARY KEY
);

DROP SYNONYM apps.xxrs_fa_adj_asset_life_tbl;

CREATE SYNONYM apps.xxrs_fa_adj_asset_life_tbl FOR xxrs.xxrs_fa_adj_asset_life_tbl;

DROP SEQUENCE xxrs.xxrs_fa_adj_asset_life_s;

CREATE SEQUENCE xxrs.xxrs_fa_adj_asset_life_s
START WITH 1
INCREMENT BY 1
MINVALUE 0
NOCACHE 
NOORDER;

DROP SYNONYM apps.xxrs_fa_adj_asset_life_s;

CREATE SYNONYM apps.xxrs_fa_adj_asset_life_s FOR xxrs.xxrs_fa_adj_asset_life_s;
/