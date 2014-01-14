-- /**********************************************************************************************************************
-- *                                                                                                                     *
-- * NAME : XXRSARDCU.ctl                                                                                                *
-- *                                                                                                                     *
-- * DESCRIPTION :                                                                                                       *
-- * Load data into xxrs_ar_contacts table.                                                                              *
-- *                                                                                                                     *
-- * AUTHOR       : AneeshSingh                                                                                         *
-- * DATE WRITTEN : 23-DEC-2011                                                                                          *
-- *                                                                                                                     *
-- * CHANGE CONTROL :                                                                                                    *
-- * Ver#  | Ticket #     | WHO             | DATE       |   REMARKS                                                     *
-- *---------------------------------------------------------------------------------------------------------------------*
-- * 1.0.0 | 111122-02448 | AneeshSingh     | 23-DEC-2011| Initial Creation for R12 Upgradation                          *
-- ***********************************************************************************************************************/
OPTIONS (SKIP=1)
LOAD DATA
REPLACE
INTO TABLE xxrs.xxrs_ar_contacts
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(  
  account_number        "UPPER(TRIM(:account_number))",
  first_name            "UPPER(TRIM(:first_name))",
  last_name             "UPPER(TRIM(:last_name))",
  email_address         "UPPER(TRIM(:email_address))",
  rr_primary_flag       "DECODE(UPPER(TRIM(:rr_primary_flag)),'PRIMARY CONTACT','Y','N')",
  conc_request_id       ":conc_request_id",
  created_by            ":created_by",
  role_resp_type        CONSTANT "DUN",
  process_flag          CONSTANT "P",
  con_id                "xxrs_ar_contacts_s.nextval",
  creation_date         SYSDATE,
  last_update_login     CONSTANT "-1",
  last_update_date      SYSDATE,
  last_updated_by       ":created_by"
)