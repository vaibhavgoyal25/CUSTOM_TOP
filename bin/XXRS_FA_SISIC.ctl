-- /**********************************************************************************************************************
-- *                                                                                                                     *
-- * NAME : XXRS_FA_SISIC.ctl                                                                                *
-- *                                                                                                                     *
-- * DESCRIPTION :                                                                                                       *
-- * Load data into xxrs_fa_server_by_company table.                                                                     *
-- *                                                                                                                     *
-- * AUTHOR       : Sunil Kumar Mallina                                                                                  *
-- * DATE WRITTEN : 31-Dec-2011                                                                                          *
-- *                                                                                                                     *
-- * CHANGE CONTROL :                                                                                                    *
-- * Version#  | Ticket Number    | WHO                 |  DATE       |   REMARKS                                        *
-- *---------------------------------------------------------------------------------------------------------------------*
-- * 1.0.0     | 111122-02448     | Sunil Kumar Mallina | 31-Dec-2011 | R12 Upgradation                                  *
-- ***********************************************************************************************************************/
OPTIONS (SKIP=1)
LOAD DATA
REPLACE
INTO TABLE xxrs.xxrs_fa_server_by_company
FIELDS TERMINATED BY "|" OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(  
  locator         	"TRIM(:locator)",  
  xfer_company         	"TRIM(:xfer_company)",
  dc_name         	"TRIM(:dc_name)",
  customer_num          "TRIM(:customer_num)",
  sku_num               "TRIM(:sku_num)",
  sku_desc              "TRIM(:sku_desc)",
  process_flag    	CONSTANT 1 ,
  conc_request_id       ":conc_request_id",
  created_by            ":created_by",
  transfer_id "xxrs_fa_server_by_company_s.nextval",
  creation_date         SYSDATE,
  last_update_login     CONSTANT "-1",
  last_update_date      SYSDATE,
  last_updated_by       ":created_by"
)

