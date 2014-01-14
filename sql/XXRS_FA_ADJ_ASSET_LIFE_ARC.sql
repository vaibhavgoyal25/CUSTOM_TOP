/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_FA_ADJ_ASSET_LIFE_ARC.sql                                                                               *
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

/* $Header: XXRS_FA_ADJ_ASSET_LIFE_ARC.sql 1.0.0 22/12/2011 10:13:23 AM SUDHEER GUNTU $ */

DROP TABLE xxrs.xxrs_fa_adj_asset_life_arc;

CREATE TABLE xxrs.xxrs_fa_adj_asset_life_arc
(
  asset_number       VARCHAR2(15),
  book               VARCHAR2(15),
  life_yrs           NUMBER(4),
  life_mnths         NUMBER(4),
  last_updated_by    NUMBER(15),
  last_update_date   DATE,
  process_status     VARCHAR2(1),
  error_message      VARCHAR2(1000),
  archive_date       DATE,
  conc_request_id    NUMBER(15),
  creation_date      DATE,
  created_by         NUMBER(15),
  last_update_login  NUMBER(15)
);

CREATE INDEX xxrs.xxrs_fa_asset_life_arc_indx
ON xxrs.xxrs_fa_adj_asset_life_arc ( archive_date )
LOGGING
NOPARALLEL;

DROP SYNONYM apps.xxrs_fa_adj_asset_life_arc;

CREATE SYNONYM apps.xxrs_fa_adj_asset_life_arc FOR xxrs.xxrs_fa_adj_asset_life_arc;
/