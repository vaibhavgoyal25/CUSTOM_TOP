/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_AP_WKDY_EMP_EXPENSES.sql                                                                                *
*                                                                                                                     *
* DESCRIPTION :                                                                                                       *
* Table to hold Employee expense data from Workday                                                                    *
*                                                                                                                     *
* AUTHOR       : SUDHEER GUNTU                                                                                        *
* DATE WRITTEN : 29-DEC-11                                                                                            *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* Version#     |  TICKET          | WHO             |  DATE          |   REMARKS                                      *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  111122-02448    | SUDHEER GUNTU   |  29-DEC-11     |  Initial Build for R12 upgradation             *
**********************************************************************************************************************/

/* $Header: XXRS_AP_WKDY_EMP_EXPENSES.sql 1.0.0 29-DEC-11 10:21:52 AM SUDHEER GUNTU $ */

DROP TABLE  xxrs.xxrs_ap_wkdy_emp_expenses;

CREATE TABLE xxrs.xxrs_ap_wkdy_emp_expenses 
(
  workday_emp_exp_rec_id     NUMBER(10)           PRIMARY KEY,
  workday_employee_id        VARCHAR2(150),
  organization               VARCHAR2(25),
  employee_first_name        VARCHAR2(150),
  employee_last_name         VARCHAR2(150),
  employee_email             VARCHAR2(2000),
  bank_branch_number         VARCHAR2(25),
  account_number             VARCHAR2(30),
  total_amount               VARCHAR2(15),
  currency                   VARCHAR2(15),
  transaction_date           VARCHAR2(20),
  distribution_account       VARCHAR2(100),
  process_status             VARCHAR2(1),
  error_message              VARCHAR2(1000),
  conc_request_id            NUMBER,
  creation_date              DATE                  NOT NULL,
  created_by                 NUMBER                NOT NULL,
  last_update_login          NUMBER                NOT NULL,
  last_update_date           DATE                  NOT NULL,
  last_updated_by            NUMBER                NOT NULL
);

DROP SYNONYM apps.xxrs_ap_wkdy_emp_expenses;

CREATE SYNONYM apps.xxrs_ap_wkdy_emp_expenses FOR xxrs.xxrs_ap_wkdy_emp_expenses;
/
