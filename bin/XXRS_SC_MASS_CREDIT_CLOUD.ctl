-- /***********************************************************************************************************
-- *                                                                                                          *
-- * NAME : XXRS_SC_MASS_CREDIT_CLOUD.ctl                                                                     *
-- *                                                                                                          *
-- * DESCRIPTION :                                                                                            *
-- * One-time script to load cloud credits into invoice worksheet int table.                                  *
-- *                                                                                                          *
-- * AUTHOR       : Pavan Amirineni                                                                           *
-- * DATE WRITTEN : 07/01/2013                                                                                *
-- *                                                                                                          *
-- * CHANGE CONTROL :                                                                                         *
-- * Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                          *
-- *----------------------------------------------------------------------------------------------------------*
-- * 1.0.0        |  130702-08695     | Pavan Amirineni |  07/01/2013    | Initial Creation                   *
-- ***********************************************************************************************************/
-- /* $Header XXRS_SC_MASS_CREDIT_CLOUD.ctl 1.0.0 07/01/2013 15:00:00 Pavan Amirineni $*/
OPTIONS (SKIP=1)
LOAD DATA
APPEND
INTO TABLE XXRS.XXRS_SC_INVOICE_WKST_INT_TBL
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  account_number "Trim(:account_number)",
  description ":description",
  extended_selling_price "Trim(:extended_selling_price)",
  service_name "Trim(:service_name)",
  period_date "TRUNC(SYSDATE)",
  product_name CONSTANT "Miscellaneous",
  trx_type CONSTANT "Credit Memo",
  uom_code CONSTANT "Ea",
  conc_req_id CONSTANT "1",
  created_by CONSTANT "1",
  invoiced_qty CONSTANT "1",
  unit_selling_price "Trim(:extended_selling_price)",
  status_code CONSTANT "0", 
  invoice_wkst_snid "xxrs_sc_invoice_wkst_snid.nextval",
  creation_date SYSDATE,
  last_update_login CONSTANT "-1",
  last_update_date SYSDATE,
  last_updated_by CONSTANT "1",
  org_id expression "(select org_id from xxrs_sc_cust_bill_to_sites_vw where customer_num = :account_number and site_primary_flag = 'Y')",
  cust_account_id expression "(select cust_account_id from xxrs_sc_cust_bill_to_sites_vw where customer_num = :account_number and site_primary_flag = 'Y')",
  cust_acct_site_id expression "(select cust_acct_site_id from xxrs_sc_cust_bill_to_sites_vw where customer_num = :account_number and site_primary_flag = 'Y')",
  site_use_id expression "(select site_use_id from xxrs_sc_cust_bill_to_sites_vw where customer_num = :account_number and site_primary_flag = 'Y')",
  currency_code expression "(select currency_code from xxrs_sc_cust_bill_to_sites_vw where customer_num = :account_number and site_primary_flag = 'Y')",
  customer_name expression "(select company_name from xxrs_sc_cust_bill_to_sites_vw where customer_num = :account_number and site_primary_flag = 'Y')",
  support_team expression "(select support_team from xxrs_sc_cust_bill_to_sites_vw where customer_num = :account_number and site_primary_flag = 'Y')",
  support_team_acct_seg expression "(select support_team_acct_seg from xxrs_sc_cust_bill_to_sites_vw where customer_num = :account_number and site_primary_flag = 'Y')",
  business_unit expression "(select business_unit from xxrs_sc_cust_bill_to_sites_vw where customer_num = :account_number and site_primary_flag = 'Y')",
  business_unit_acct_seg expression "(select business_unit_acct_seg from xxrs_sc_cust_bill_to_sites_vw where customer_num = :account_number and site_primary_flag = 'Y')",
  product_def_snid expression "(select product_def_snid from xxrs_sc_product_def_tbl where product_name = :product_name)",
  service_id expression "(select service_id from xxrs_sc_service_def where name = :service_name)",
  memo_line_id expression "(select memo_line_id from ar_memo_lines_all_tl a,xxrs_sc_cust_bill_to_sites_vw b where name='CLOUD ACCOUNT CREDIT' and customer_num=:account_number and site_primary_flag = 'Y' and a.org_id=b.org_id)"
)
