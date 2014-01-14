 -- /**************************************************************************************************************
 -- *                                                                                                             *
 -- NAME: XXRS_AR_MISC_IB_TBL.ctl                                                                                 *
 -- *                                                                                                             *
 -- * DESCRIPTION:                                                                                                *
 -- *   This file is used to upload miscellaneous payments received data into                                     *
 -- *   the table 'xxrs_ar_misc_ib_tbl'                                                                           *
 -- *                                                                                                             *
 -- * AUTHOR: Sunil Kumar Mallina                                                                                 *
 -- * DATE WRITTEN: 03-JAN-2012                                                                                   *
 -- *                                                                                                             *
 -- * CHANGE CONTROL :                                                                                            *
 -- * Version#     |  Ticket Number    | WHO                     |  DATE          |   REMARKS                     *
 -- *-------------------------------------------------------------------------------------------------------------*
 -- * 1.0.0        |  111122-02448     | Sunil Kumar Mallina     |  03-JAN-2012   | R12 Upgradation               *
 -- ***************************************************************************************************************/ 
LOAD DATA
REPLACE
INTO TABLE xxrs_ar_misc_ib_tbl
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  customer_number "TRIM(:customer_number)",
  amount "NVL (TO_NUMBER (REPLACE (:amount, ',', '')), 0)",
  currency_code "TRIM(:currency_code)",
  payment_method "TRIM(:payment_method)",
  bank_account_num "TRIM(:bank_account_num)",
  payment_description "TRIM(:payment_description)",
  status_code,
  message,
  org_id "fnd_global.org_id",
  creation_date SYSDATE,
  created_by "fnd_global.user_id",
  last_update_login "fnd_global.login_id",
  last_update_date SYSDATE,
  last_updated_by "fnd_global.user_id",
  record_id       "xxrs_ar_misc_ib_tbl_s.nextval"
)
