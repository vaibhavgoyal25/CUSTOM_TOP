 -- |=========================================================================+
 -- |                                                                         |
 -- | NAME : xxrs_ar_cc_chase_ib_tbl.ctl                                      |  
 -- |                                                                         |
 -- | DESCRIPTION                                                             |
 -- |    This file is used to upload Credit Card data into                    |
 -- |    the table xxrs_ar_cc_chase_ib_tbl                                    |
 -- |                                                                         |
 -- | MODIFICATION HISTORY                                                    |
 -- | Version | Ticket       | WHO     |  DATE        | REMARKS               |
 -- | 1.0.0   | 111122-02448 | Ravi    |  11-JAN-2012 | Initial Creation      |
 -- |                                                                         |
 -- |                                                                         |
 -- +==========================================================================
 -- $Header: xxrs_ar_cc_chase_ib_tbl.ctl  1.0.0 11-JAN-2012 10:41:56 AM Ravi $
LOAD DATA
REPLACE
INTO TABLE xxrs_ar_cc_chase_ib_tbl
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  amount             "Nvl(:amount,0)",
  card_type          "Trim(:card_type)",
  authorization_code "Trim(:authorization_code)",
  customer_number    "Trim(:customer_number)",
  currency_code      "Trim(:currency_code)",
  status_code,
  message            "Decode(Trim(:authorization_code),'100','Approved','Rejected'||' - Code '||Trim(:authorization_code))",
  org_id             "fnd_global.org_id",
  record_id          "xxrs_ar_credit_card_ib_tbl_s.nextval",
  creation_date      SYSDATE,
  created_by         "fnd_global.user_id",
  last_update_login  "fnd_global.login_id",
  last_update_date   SYSDATE,
  last_updated_by    "fnd_global.user_id"
)
