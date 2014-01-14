/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_SC_CI_IL_DFF_SRC_VW.sql                                                                                 *
*                                                                                                                     *
* DESCRIPTION : View to populate descriptive flex field in   auto invoice                                             *
*                                                                                                                     *
* AUTHOR       : Pavan Amirineni                                                                                      *
* DATE WRITTEN : 02/15/2012                                                                                           *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* Version# | Ticket #      | WHO             |  DATE      |   REMARKS                                                 *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0    | 111122-02448  | Pavan Amirineni | 02/15/2012 | Initial Creation                                          *
**********************************************************************************************************************/  
/* $Header:  XXRS_SC_CI_IL_DFF_SRC_VW.sql 1.0.0 02/15/2012 03:00:00 PM Pavan Amirineni $ */
CREATE OR REPLACE FORCE VIEW apps.xxrs_sc_ci_il_dff_src_vw
(
  process_status
,  process_date
,  load_conc_req_id
,  data_source
,  org_id
,  cust_account_id
,  cust_acct_site_id
,  contract_snid
,  billing_data_type
,  product_snid
,  resource_snid
,  product_def_snid
,  resource_def_snid
,  product_resource_def_snid
,  invoice_wkst_snid
,  usage_id
,  bill_cycle
,  product
,  description
,  device_num
,  prepay_term
,  domain_name
,  agg_num
,  subscription
,  actual_use
,  product_status_code
,  product_status_name
,  resource_billing_type_code
,  resource_billing_type_name
)
AS
  SELECT /*+ RULE INDEX(bdt XXRS_SC_BILLING_DATA_IN5) */
        bdt.process_status
       ,  bdt.process_date
       ,  bdt.load_conc_req_id
       ,  bdt.data_source
       ,  bdt.org_id
       ,  bdt.cust_account_id
       ,  bdt.cust_acct_site_id
       ,  bdt.contract_snid
       ,  bdt.billing_data_type
       ,  bdt.product_snid
       ,  bdt.resource_snid
       ,  bdt.product_def_snid
       ,  bdt.resource_def_snid
       ,  bdt.product_rsrc_def_snid
       ,  bdt.invoice_wkst_snid
       ,  bdt.usage_id
       ,  NULL
       ,  bdt.product_name
       ,  CASE
            WHEN bdt.usage_id <= 0
             AND bdt.invoice_wkst_snid > 0
            THEN
              bdt.iw_description
            WHEN bdt.usage_id > 0
             AND bdt.invoice_wkst_snid <= 0
            THEN
              bdt.ticket_num
            -- PA R12 Populating prepay start and end date in DFF as per Ticket # 111122-02448
            WHEN bdt.usage_id <= 0
             AND bdt.invoice_wkst_snid <= 0
             AND ( bdt.prepay_start_date IS NOT NULL
               OR bdt.prepay_end_date IS NOT NULL )
            THEN
              TO_CHAR (
                           bdt.prepay_start_date
                        || ' to '
                        || bdt.prepay_end_date
              )
            -- End of PA R12 Changes
            ELSE
              NULL
          END
       ,  bdt.device_number
       ,  TO_CHAR ( bdt.prepay_months )
       ,  bdt.device_number
       ,  bdt.device_number
       ,  CASE
            WHEN bdt.usage_id > 0
             AND bdt.invoice_wkst_snid <= 0
            THEN
              TO_CHAR ( bdt.subscription )
            ELSE
              NULL
          END
       ,  CASE
            WHEN bdt.usage_id > 0
             AND bdt.invoice_wkst_snid <= 0
            THEN
              TO_CHAR ( bdt.usage_val )
            ELSE
              NULL
          END
       ,  bdt.product_status_code
       ,  bdt.product_status_name
       ,  bdt.resource_billing_type_code
       ,  bdt.resource_billing_type_name
    FROM xxrs.xxrs_sc_billing_data_tbl bdt
   WHERE 1 = 1;
/