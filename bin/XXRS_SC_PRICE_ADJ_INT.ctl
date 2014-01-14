--/***************************************************************************************
--*                                                                                      *
--* NAME : XXRS.XXRS_SC_PRICE_ADJ_INT.ctl                                                *
--*                                                                                      *
--* DESCRIPTION :                                                                        *
--* Load data into the price adj staging table.                                          *
--*                                                                                      *
--* AUTHOR       : Pavan Amirineni                                                       *
--* DATE WRITTEN : 27-AUG-2013                                                           *
--*                                                                                      *
--* CHANGE CONTROL :                                                                     *
--* Version# | Ticket #    | WHO             |  DATE        |   REMARKS                  *
--*--------------------------------------------------------------------------------------*
--* 1.0.0   | 130829-07967 | Pavan Amirineni | 27-AUG-2013  | Initial built              *
--***************************************************************************************/
--/* $Header:  XXRS_SC_PRICE_ADJ_INT.ctl 1.0.0 27-AUG-2013  10:00:00 AM Pavan Amirineni$ */ 
OPTIONS (SKIP=1)
LOAD DATA
INSERT
INTO TABLE xxrs.xxrs_sc_price_adj_int
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  account_number "TRIM(:account_number)",
  product_name   "TRIM(:product_name)",
  device_num     "TRIM(:device_num)",
  resource_name  "TRIM(:resource_name)",
  adj_amount     ":adj_amount",
  adj_date       "TRUNC(to_date(TRIM(:adj_date), 'MON-RRRR'))",
  date_received  ":date_received",
  date_completed ":date_completed",
  oppt_number    "TRIM(:oppt_number)",
  ticket_number  "TRIM(:ticket_number)",
  component      "TRIM(:component)",
  sales_person   "TRIM(:sales_person)",
  change_desc    "TRIM(:change_desc)",  
  conc_request_id ":conc_request_id",
  created_by     ":created_by",
  adj_id "xxrs_sc_price_adj_int_s.nextval",
  process_flag    CONSTANT "P",
  creation_date SYSDATE,
  last_update_login CONSTANT "-1",
  last_update_date SYSDATE,
  last_updated_by ":created_by"
)
