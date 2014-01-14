/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_SC_CI_ACT_USAGE_IM_VW.sql                                                                               *
*                                                                                                                     *
* DESCRIPTION : View to support implicit resources in usage for  billing engine                                       *
*                                                                                                                     *
* AUTHOR       : Pavan Amirineni                                                                                      *
* DATE WRITTEN : 02/25/2012                                                                                           *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* Version# | Ticket #      | WHO             |  DATE      |   REMARKS                                                 *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0    | 111122-02448  | Pavan Amirineni | 02/25/2012 | Initial Creation                                          *
**********************************************************************************************************************/  
/* $Header:  XXRS_SC_CI_ACT_USAGE_IM_VW.sql 1.0.0 02/25/2012 03:00:00 PM Pavan Amirineni $ */ 
CREATE OR REPLACE FORCE VIEW apps.xxrs_sc_ci_act_usage_im_vw
(
  org_id
,  cust_account_id
,  cust_acct_site_id
,  contract_snid
,  product_snid
,  prod_creation_date
,  resource_snid
,  product_def_snid
,  resource_def_snid
,  product_resource_def_snid
,  opportunity_num
,  device_num
,  support_team
,  account_manager_name
,  location_code
,  resource_name
,  spcl_price_flag
,  tiered_flag
,  quantity
,  unit_of_measure_code
,  unit_price
,  amount
,  receipt_method_id
,  bank_account_uses_id
,  po_number
,  prepay_months
,  product_name
,  ticket_num
,  excl_from_daily_bill_flag
,  resource_num
,  product_status_code
,  product_status_name
,  resource_billing_type_code
,  resource_billing_type_name
,  billing_start_date
,  billing_end_date
,  billed_date
,  date_cancelled
,  service_id
)
AS
  SELECT aprod.org_id
       ,  aprod.cust_account_id
       ,  aprod.cust_acct_site_id
       ,  aprod.contract_snid
       ,  aprod.account_product_snid "PRODUCT_SNID"
       ,  aprod.creation_date "PROD_CREATION_DATE"
       ,  0 "RESOURCE_SNID"
       ,  aprod.product_def_snid
       ,  0 "RESOURCE_DEF_SNID"
       ,  0 "PRODUCT_RESOURCE_DEF_SNID"
       ,  cont.opportunity_num
       ,  NULL "DEVICE_NUM"
       ,  cont.support_team
       ,  cont.account_manager_name
       ,  aprod.location_code "LOCATION_CODE"
       ,  NULL "RESOURCE_NAME"
       ,  'F' "SPCL_PRICE_FLAG"
       ,  NULL "TIERED_FLAG"
       ,  0 "QUANTITY"
       ,            -- Cannot be defined since quantity comes from usage file.
        NULL "UNIT_OF_MEASURE_CODE"
       ,  0 "UNIT_SELLING_PRICE"
       ,  0 "AMOUNT"
       ,            -- Cannot be defined since quantity comes from usage file.
        aprod.receipt_method_id "RECEIPT_METHOD_ID"
       ,  aprod.bank_account_uses_id "BANK_ACCOUNT_USES_ID"
       ,  aprod.po_number "PO_NUMBER"
       ,  0 "PREPAY_MONTHS"
       ,  pdt.product_name
       ,  cont.ticket_num
       ,                                    --           dprod.component_code,
          --           dprod.upgrade_fee,
          'F' "EXCL_FROM_DAILY_BILL_FLAG"
       ,  NULL "RESOURCE_NUM"
       ,  aprod.product_status_code
       ,  ( SELECT flv.meaning
              FROM applsys.fnd_lookup_values flv
                 ,  applsys.fnd_application fa
             WHERE fa.application_short_name = 'XXRS'
               AND flv.language = USERENV ( 'LANG' )
               AND flv.view_application_id = fa.application_id
               AND flv.security_group_id = 0
               AND flv.lookup_type = 'RS_SC_PRODUCT_STATUS'
               AND flv.lookup_code = aprod.product_status_code
               AND flv.enabled_flag = 'Y'
               AND NVL ( SYSDATE, SYSDATE ) BETWEEN NVL (
                                                          flv.start_date_active
                                                        ,  SYSDATE
                                                    )
                                                AND NVL ( flv.end_date_active
                                                        ,  SYSDATE
                                                         ) )
            "PRODUCT_STATUS_NAME"
       ,  0 "RESOURCE_BILLING_TYPE_CODE"
       ,  NULL "RESOURCE_BILLING_TYPE_NAME"
       ,  NULL "BILLING_START_DATE"
       ,  NULL "BILLING_END_DATE"
       ,  NULL "BILLED_DATE"
       ,  aprod.date_cancelled
       ,  aprod.service_id service_id --110223-01761# as per BA confirmation, adding service
    FROM xxrs.xxrs_sc_account_product_tbl aprod
       ,  xxrs.xxrs_sc_product_def_tbl pdt
       ,  xxrs.xxrs_sc_contract_tbl cont
   WHERE 1 = 1
     AND aprod.locked_flag != 'P'
     AND aprod.bill_flag = 'T'
     AND aprod.void_flag = 'F'
     AND aprod.product_status_code IN
           ( SELECT flv.lookup_code
               FROM applsys.fnd_lookup_values flv
                  ,  applsys.fnd_application fa
              WHERE fa.application_short_name = 'XXRS'
                AND flv.language = USERENV ( 'LANG' )
                AND flv.view_application_id = fa.application_id
                AND flv.security_group_id = 0
                AND flv.lookup_type = 'RS_SC_PRODUCT_STATUS'
                AND flv.meaning IN ('Active', 'Pending Cancellation')
                AND flv.enabled_flag = 'Y'
                AND NVL ( SYSDATE, SYSDATE ) BETWEEN NVL (
                                                           flv.start_date_active
                                                         ,  SYSDATE
                                                     )
                                                 AND NVL (
                                                           flv.end_date_active
                                                         ,  SYSDATE
                                                     ) )
     AND pdt.product_def_snid = aprod.product_def_snid
     AND pdt.product_type = 'A'
     AND pdt.product_def_snid =
           ( SELECT DISTINCT prdt.product_def_snid
               FROM xxrs.xxrs_sc_product_rsrc_def_tbl prdt
                  ,  xxrs.xxrs_sc_resource_def_tbl rdt
              WHERE prdt.product_def_snid = pdt.product_def_snid
                AND rdt.resource_def_snid = prdt.resource_def_snid
                AND rdt.resource_type = pdt.product_type
                AND rdt.resource_billing_type_code IN
                      ( SELECT flv.lookup_code
                          FROM applsys.fnd_lookup_values flv
                             ,  applsys.fnd_application fa
                         WHERE fa.application_short_name = 'XXRS'
                           AND flv.language = USERENV ( 'LANG' )
                           AND flv.view_application_id = fa.application_id
                           AND flv.security_group_id = 0
                           AND flv.lookup_type =
                                 'XXRS_SC_RESOURCE_BILLING_TYPE'
                           AND flv.meaning IN ('Auto/File')
                           AND flv.enabled_flag = 'Y'
                           AND NVL ( rdt.start_effectivity_date, SYSDATE ) BETWEEN NVL (
                                                                                         flv.start_date_active
                                                                                       ,  rdt.start_effectivity_date
                                                                                   )
                                                                               AND NVL (
                                                                                         flv.end_date_active
                                                                                       ,  SYSDATE
                                                                                   ) ) )
     AND cont.contract_snid = aprod.contract_snid;
/