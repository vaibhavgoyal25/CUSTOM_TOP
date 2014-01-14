--/***************************************************************************************
--*                                                                                      *
--* NAME : XXRS.XXRS_SC_PRICE_RENEWAL_INT.ctl  Demo3                                         *
--*                                                                                      *
--* DESCRIPTION :                                                                        *
--* Load data into the price adj staging table for renewals.                             *
--*                                                                                      *
--* AUTHOR       : Vaibhav Goyal                                                         *
--* DATE WRITTEN : 09-DEC-2013                                                           *
--*                                                                                      *
--* CHANGE CONTROL :                                                                     *
--* Version# | Ticket #    | WHO             |  DATE        |   REMARKS                  *
--*--------------------------------------------------------------------------------------*
--* 1.0.0   | 131209-08488 | Vaibhav Goyal   | 09-DEC-2013  | Initial built              *
--***************************************************************************************/
--/* $Header:  XXRS.XXRS_SC_PRICE_RENEWAL_INT.ctl 1.0.0 09-DEC-2013  10:00:00 AM Vaibhav Goyal$ */ 
OPTIONS (SKIP=1)
LOAD DATA
INSERT
INTO TABLE xxrs.xxrs_sc_price_adj_int
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  account_number "TRIM(:account_number)",
  product_name   "TRIM(:product_name)",
  resource_name  "TRIM(:resource_name)",
  device_num     "TRIM(:device_num)",
  date_received  ":date_received",
  ticket_number  "TRIM(:ticket_number)",
  oppt_number    "TRIM(:oppt_number)",
  sales_person   "TRIM(:sales_person)",
  con_eff_start_date ":con_eff_start_date",
  con_eff_end_date   ":con_eff_end_date",
  old_mrr_fee        ":old_mrr_fee",
  new_mrr_fee        ":new_mrr_fee",
  adj_date        "ADD_MONTHS(LAST_DAY(to_date(:adj_date,'DD-MON-RRRR')),-1)+1",
  conc_request_id ":conc_request_id",
  created_by     ":created_by",
  adj_id "xxrs_sc_price_adj_int_s.nextval",
  adj_amount      ":new_mrr_fee - :old_mrr_fee",
  date_completed  ":con_eff_start_date",
  f_con_type      CONSTANT "4",
  process_flag    CONSTANT "P",
  creation_date SYSDATE,
  last_update_login CONSTANT "-1",
  last_update_date SYSDATE,
  last_updated_by ":created_by"
)
