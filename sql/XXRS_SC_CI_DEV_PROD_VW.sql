/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_SC_CI_DEV_PROD_VW.sql                                                                                   *
*                                                                                                                     *
* DESCRIPTION : View to list all device products for  billing engine                                                  *
*                                                                                                                     *
* AUTHOR       : Pavan Amirineni                                                                                      *
* DATE WRITTEN : 02/15/2012                                                                                           *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* Version# | Ticket #      | WHO             |  DATE      |   REMARKS                                                 *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0    | 111122-02448  | Pavan Amirineni | 02/25/2012 | Initial Creation                                          *
**********************************************************************************************************************/  
/* $Header: XXRS_SC_CI_DEV_PROD_VW.sql 1.0.0 02/15/2012 03:00:00 PM Pavan Amirineni $ */
CREATE OR REPLACE FORCE VIEW apps.xxrs_sc_ci_dev_prod_vw
(
  org_id
,  cust_account_id
,  cust_acct_site_id
,  contract_snid
,  product_snid
,  resource_snid
,  product_def_snid
,  resource_def_snid
,  product_resource_def_snid
,  service_id
,  opportunity_num
,  device_num
,  support_team
,  account_manager_name
,  location_code
,  resource_name
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
,  component_code
,  upgrade_fee
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
,  prepay_start_date
,  prepay_end_date
)
AS
  SELECT   org_id
         ,  cust_account_id
         ,  cust_acct_site_id
         ,  contract_snid
         ,  product_snid
         ,  resource_snid
         ,  product_def_snid
         ,  resource_def_snid
         ,  product_resource_def_snid
         ,  service_id                                      -- LY 110223-01761
         ,  opportunity_num
         ,  device_num
         ,  support_team
         ,  account_manager_name
         ,  location_code
         ,  resource_name
         ,  CASE
              WHEN NVL ( prepay_months, 0 ) > 0 THEN quantity * prepay_months
              ELSE quantity
            END
              "QUANTITY"
         ,  unit_of_measure_code
         ,  unit_price
         ,  CASE
              WHEN NVL ( prepay_months, 0 ) > 0
              THEN
                ( quantity * unit_price ) * prepay_months
              ELSE
                ( quantity * unit_price )
            END
              "AMOUNT"
         ,  receipt_method_id
         ,  bank_account_uses_id
         ,  po_number
         ,  prepay_months
         ,  product_name
         ,  ticket_num
         ,  component_code
         ,  upgrade_fee
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
         ,  prepay_start_date                                -- PA R12 Changes
         ,  prepay_end_date                                  -- PA R12 changes
      FROM (SELECT dprod.org_id
                 ,  dprod.cust_account_id
                 ,  dprod.cust_acct_site_id
                 ,  dprod.contract_snid
                 ,  dprod.device_product_snid "PRODUCT_SNID"
                 ,  drsrc.device_resource_snid "RESOURCE_SNID"
                 ,  dprod.product_def_snid
                 ,  prdt.resource_def_snid
                 ,  drsrc.product_resource_def_snid
                 ,  drsrc.service_id                        -- LY 110223-01761
                 ,  cont.opportunity_num
                 ,  dprod.device_num
                 ,  cont.support_team
                 ,  cont.account_manager_name
                 ,  dprod.location_code "LOCATION_CODE"
                 ,  rdt.resource_name
                 ,  drsrc.quantity
                 ,  rdt.unit_of_measure_code
                 ,  NVL ( drsrc.unit_price, -1 ) "UNIT_PRICE"
                 ,  0 "AMOUNT"
                 ,  dprod.receipt_method_id "RECEIPT_METHOD_ID"
                 ,  dprod.bank_account_uses_id "BANK_ACCOUNT_USES_ID"
                 ,  dprod.po_number "PO_NUMBER"
                 ,  drsrc.prepay_months
                 ,  pdt.product_name
                 ,  cont.ticket_num
                 ,  dprod.component_code
                 ,  dprod.upgrade_fee
                 ,  drsrc.exclude_from_billing_flag "EXCL_FROM_DAILY_BILL_FLAG"
                 ,  drsrc.resource_num
                 ,  dprod.product_status_code
                 ,  ( SELECT flv.meaning
                        FROM applsys.fnd_lookup_values flv
                           ,  applsys.fnd_application fa
                       WHERE fa.application_short_name = 'XXRS'
                         AND flv.language = USERENV ( 'LANG' )
                         AND flv.view_application_id = fa.application_id
                         AND flv.security_group_id = 0
                         AND flv.lookup_type = 'RS_SC_PRODUCT_STATUS'
                         AND flv.lookup_code = dprod.product_status_code
                         AND flv.enabled_flag = 'Y'
                         AND NVL ( drsrc.billing_start_date, SYSDATE ) BETWEEN NVL (
                                                                                     flv.start_date_active
                                                                                   ,  drsrc.billing_start_date
                                                                               )
                                                                           AND NVL (
                                                                                     flv.end_date_active
                                                                                   ,  drsrc.billing_start_date
                                                                               ) )
                      product_status_name
                 ,  rdt.resource_billing_type_code
                 ,  ( SELECT flv.meaning
                        FROM applsys.fnd_lookup_values flv
                           ,  applsys.fnd_application fa
                       WHERE fa.application_short_name = 'XXRS'
                         AND flv.language = USERENV ( 'LANG' )
                         AND flv.view_application_id = fa.application_id
                         AND flv.security_group_id = 0
                         AND flv.lookup_type = 'XXRS_SC_RESOURCE_BILLING_TYPE'
                         AND flv.lookup_code = rdt.resource_billing_type_code
                         AND flv.enabled_flag = 'Y'
                         AND NVL ( drsrc.billing_start_date, SYSDATE ) BETWEEN NVL (
                                                                                     flv.start_date_active
                                                                                   ,  drsrc.billing_start_date
                                                                               )
                                                                           AND NVL (
                                                                                     flv.end_date_active
                                                                                   ,  drsrc.billing_start_date
                                                                               ) )
                      resource_billing_type_name
                 ,  drsrc.billing_start_date
                 ,  drsrc.billing_end_date
                 ,  drsrc.billed_date
                 ,  dprod.date_cancelled
                 ,  drsrc.prepay_start_date                  -- PA R12 Changes
                 ,  drsrc.prepay_end_date                    -- PA R12 changes
              FROM xxrs.xxrs_sc_device_product_tbl dprod
                 ,  xxrs.xxrs_sc_device_resource_tbl drsrc
                 ,  xxrs.xxrs_sc_product_def_tbl pdt
                 ,  xxrs.xxrs_sc_product_rsrc_def_tbl prdt
                 ,  xxrs.xxrs_sc_resource_def_tbl rdt
                 ,  xxrs.xxrs_sc_contract_tbl cont
             WHERE 1 = 1
               AND dprod.locked_flag != 'P'
               AND dprod.bill_flag = 'T'
               AND dprod.void_flag = 'F'
               AND drsrc.voided_flag = 'F'
               AND drsrc.device_product_snid = dprod.device_product_snid
               AND pdt.product_def_snid = dprod.product_def_snid
               AND dprod.product_status_code IN
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
                          AND NVL ( drsrc.billing_start_date, SYSDATE ) BETWEEN NVL (
                                                                                      flv.start_date_active
                                                                                    ,  drsrc.billing_start_date
                                                                                )
                                                                            AND NVL (
                                                                                      flv.end_date_active
                                                                                    ,  drsrc.billing_start_date
                                                                                ) )
               AND rdt.resource_billing_type_code IN
                     ( SELECT flv.lookup_code
                         FROM applsys.fnd_lookup_values flv
                            ,  applsys.fnd_application fa
                        WHERE fa.application_short_name = 'XXRS'
                          AND flv.language = USERENV ( 'LANG' )
                          AND flv.view_application_id = fa.application_id
                          AND flv.security_group_id = 0
                          AND flv.lookup_type = 'XXRS_SC_RESOURCE_BILLING_TYPE'
                          AND flv.meaning IN ('One-Time', 'Recurring')
                          AND flv.enabled_flag = 'Y'
                          AND NVL ( drsrc.billing_start_date, SYSDATE ) BETWEEN NVL (
                                                                                      flv.start_date_active
                                                                                    ,  drsrc.billing_start_date
                                                                                )
                                                                            AND NVL (
                                                                                      flv.end_date_active
                                                                                    ,  drsrc.billing_start_date
                                                                                ) )
               AND prdt.product_resource_def_snid =
                     drsrc.product_resource_def_snid
               AND rdt.resource_def_snid = prdt.resource_def_snid
               AND pdt.product_type = 'D'
               AND rdt.resource_type = pdt.product_type
               AND rdt.tiered_flag = 'N' -- PA R12 111122-02448, changed tiered_flag def from T, F to Y, N
               AND cont.contract_snid = dprod.contract_snid)
     WHERE 1 = 1
  ORDER BY cust_account_id
         ,  cust_acct_site_id
         ,  po_number
         ,  receipt_method_id
         ,  bank_account_uses_id
         ,  product_name
         ,  resource_name;
/