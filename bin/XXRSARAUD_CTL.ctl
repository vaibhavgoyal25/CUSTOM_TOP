-- /**********************************************************************************************************************
-- *                                                                                                                     *
-- * NAME : XXRSARAUD_CTL.ctl                                                                                            *
-- *                                                                                                                     *
-- * DESCRIPTION :                                                                                                       *
-- * Control file to load the account updater response file from Chase Paymentech                                        *
-- *                                                                                                                     *
-- * AUTHOR       : Sai Manohar                                                                                          *
-- * DATE WRITTEN : 04-JAN-2012                                                                                          *
-- *                                                                                                                     *
-- * CHANGE CONTROL :                                                                                                    *
-- * Ver#  | TICKET #     | WHO             | DATE        |   REMARKS                                                    *
-- *---------------------------------------------------------------------------------------------------------------------*
-- * 1.0.0 |111122-02448  | Sai Manohar     | 04-JAN-2012 | Initial Creation                                             *
-- ***********************************************************************************************************************/
LOAD DATA
APPEND
INTO TABLE xxrs.xxrs_ar_aud_resp_tbl
WHEN (3:3) = '|'
FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
( method_of_payment                 ,
  transaction_division_number       ,
  merchant_order_number             ,
  old_account_number                ,
  old_expiration_date               ,
  new_account_number                ,
  new_expiration_date               ,
  response_value                    ,
  previously_sent_flag              ,
  conc_request_id                   ":conc_request_id",  
  created_by                        ":created_by",
  creation_date                     sysdate,
  last_update_login                 constant '-1',
  last_update_date                  sysdate        ,
  last_updated_by                   ":created_by"
)