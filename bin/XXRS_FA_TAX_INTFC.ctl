-- /**********************************************************************************************************************
-- *                                                                                                                     *
-- * NAME : XXRS_FA_TAX_INTFC.ctl                                                                                        *
-- *                                                                                                                     *
-- * DESCRIPTION :                                                                                                       *
-- * Load data into the FA tax interface table.                                                                          *
-- *                                                                                                                     *
-- * AUTHOR       : Padmaja                                                                                              *
-- * DATE WRITTEN : 30-Dec-2011                                                                                          *
-- *                                                                                                                     *
-- * CHANGE CONTROL :                                                                                                    *
-- * Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                                     *
-- *---------------------------------------------------------------------------------------------------------------------*
-- * 1.0.0        |  111122-02448     | Padmaja         |  30-Dec-2011   | Initial Creation                              *
-- ***********************************************************************************************************************/
OPTIONS (SKIP=1)
LOAD DATA
REPLACE 
INTO TABLE fa_tax_interface
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
( asset_number                     "TRIM(:asset_number)",
  book_type_code                   "TRIM(:book_type_code)",
  cost                             DECIMAL EXTERNAL ":cost",
  tax_request_id                   ":tax_request_id",
  created_by                       ":created_by",
  posting_status                   CONSTANT 'POST',
  creation_date                    SYSDATE,
  last_updated_by                  ":created_by",
  last_update_login                CONSTANT "-1",
  last_update_date                 SYSDATE
)
