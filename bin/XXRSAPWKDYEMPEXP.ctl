-- /**********************************************************************************************************************
-- *                                                                                                                     *
-- * NAME : XXRSAPWKDYEMPEXP.ctl                                                                                         *
-- *                                                                                                                     *
-- * DESCRIPTION :                                                                                                       *
-- * Control file to load Employee expense data from Workday                                                             *
-- *                                                                                                                     *
-- * AUTHOR       : SUDHEER GUNTU                                                                                        *
-- * DATE WRITTEN : 29-DEC-2011                                                                                          *
-- *                                                                                                                     *
-- * CHANGE CONTROL :                                                                                                    *
-- * Ver#  | Ticket #     | WHO             | DATE       |   REMARKS                                                     *
-- *---------------------------------------------------------------------------------------------------------------------*
-- * 1.0.0 | 111122-02448 | SUDHEER GUNTU   | 29-DEC-2011| Initial Creation for R12 Upgradation                          *
-- ***********************************************************************************************************************/

-- /* $Header: XXRSAPWKDYEMPEXP.ctl 1.0.0 29-DEC-11 11:16:52 AM SUDHEER GUNTU $ */

LOAD DATA
APPEND
INTO TABLE xxrs.xxrs_ap_wkdy_emp_expenses
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  workday_employee_id               "TRIM(:workday_employee_id)",
  organization                      "TRIM(:organization)",
  transaction_date                  "TRIM(:transaction_date)",
  employee_first_name               "TRIM(:employee_first_name)",
  employee_last_name                "TRIM(:employee_last_name)",
  employee_email                    "TRIM(:employee_email)",
  bank_branch_number                "TRIM(:bank_branch_number)",
  account_number                    "TRIM(:account_number)",
  total_amount                      "TRIM(:total_amount)",
  currency                          "TRIM(SUBSTR(:currency,1,3))",
  process_status                     CONSTANT "R",
  conc_request_id                   "TRIM(:conc_request_id)",
  created_by                        "TRIM(:created_by)",
  creation_date                      SYSDATE,
  last_update_login                  CONSTANT "-1",
  last_update_date                   SYSDATE,
  last_updated_by                   "TRIM(:created_by)",
  workday_emp_exp_rec_id            "xxrs.xxrs_ap_wkdy_emp_exp_s.NEXTVAL"
)