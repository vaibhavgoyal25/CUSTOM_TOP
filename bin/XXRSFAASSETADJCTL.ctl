 -- |================================================================================================+
 -- |                                                                                                |
 -- | FILENAME      : XXRSFAASSETADJCTL.ctl                                                          |
 -- |                                                                                                |
 -- | DESCRIPTION   : This Control file is used to upload Asset Adjustment Data to                   |
 -- |                 the table "XXRS.XXRS_FA_ADJ_ASSET_LIFE_TBL"                                    |
 -- |                                                                                                |
 -- | MODIFICATION HISTORY                                                                           |
 -- | CHANGE CONTROL :                                                                               |
 -- | Version#     |  TICKET           | WHO             |  DATE          |   REMARKS                |
 -- |------------------------------------------------------------------------------------------------|
 -- | 1.0.0        |  111122-02448     | SUDHEER GUNTU   |  20-DEC-11     |  Initial Build for R12   |
 -- |                                                                        upgradation             |
 -- =================================================================================================
OPTIONS (SKIP=1)
LOAD DATA
REPLACE
INTO TABLE xxrs.xxrs_fa_adj_asset_life_tbl
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  asset_number           "DECODE(:asset_number, NULL, NULL,LTRIM(RTRIM(:asset_number)))",
  book                   "DECODE(:asset_number, NULL, NULL,LTRIM(RTRIM(:book)))",
  life_yrs               "DECODE(:asset_number, NULL, NULL,LTRIM(RTRIM(:life_yrs)))",
  life_mnths             "DECODE(:asset_number, NULL, NULL,LTRIM(RTRIM(:life_mnths)))",
  asset_rec_id           "xxrs_fa_adj_asset_life_s.nextval",
  conc_request_id        "DECODE(:asset_number, NULL, NULL, :conc_request_id)",
  created_by             "DECODE(:asset_number, NULL, NULL, :created_by)",
  creation_date          "DECODE(:asset_number, NULL, NULL, SYSDATE)",
  last_update_login      "DECODE(:asset_number, NULL, NULL, -1)",
  last_update_date       "DECODE(:asset_number, NULL, NULL, SYSDATE)",
  last_updated_by        "DECODE(:asset_number, NULL, NULL, :created_by)"
)