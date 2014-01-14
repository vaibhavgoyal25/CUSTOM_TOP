  /**********************************************************************************************************************
  *                                                                                                                     *
  * NAME : XXRS_SC_DEVICE_RESOURCE_VW.sql                                                                               *
  *                                                                                                                     *
  * DESCRIPTION :                                                                                                       *
  * View used by device resource form.                                                                                  *
  *                                                                                                                     *
  * AUTHOR       : Vinodh Bhasker                                                                                       *
  * DATE WRITTEN : 17-FEB-2012                                                                                          *
  *                                                                                                                     *
  * CHANGE CONTROL :                                                                                                    *
  * SR#          |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                                     *
  *---------------------------------------------------------------------------------------------------------------------*
  * 1.0          | 111122-02448      | Vinodh Bhasker  | 02/17/2012     | Initial Creation for R12                      *
  ***********************************************************************************************************************/

CREATE OR REPLACE FORCE VIEW apps.xxrs_sc_device_resource_vw ( row_id
                                                             ,  device_resource_snid
                                                             ,  device_product_snid
                                                             ,  creating_contract_snid
                                                             ,  org_id
                                                             ,  cust_account_id
                                                             ,  cust_acct_site_id
                                                             ,  resource_num
                                                             ,  contract_snid
                                                             ,  product_resource_def_snid
                                                             ,  parent_device_resource_snid
                                                             ,  override_flag
                                                             ,  quantity
                                                             ,  device_num
                                                             ,  billing_start_date
                                                             ,  billing_end_date
                                                             ,  billed_date
                                                             ,  description
                                                             ,  prepay_months
                                                             ,  unit_price
                                                             ,  exclude_from_billing_flag
                                                             ,  creation_date
                                                             ,  created_by
                                                             ,  last_updated_by
                                                             ,  last_update_login
                                                             ,  last_update_date
                                                             ,  resource_name
                                                             ,  resource_billing_type_code
                                                             ,  resource_billing_type_meaning
                                                             ,  resource_billing_type_tag
                                                             ,  unit_of_measure_code
                                                             ,  unit_of_measure_meaning
                                                             ,  tiered_flag
                                                             ,  include_in_monthly_fee_flag
                                                             ,  currency_code
                                                             ,  voided_flag
                                                             ,  prepay_flag
                                                             ,  prepay_start_date
                                                             ,  prepay_end_date
                                                             ,  attribute_category
                                                             ,  attribute1
                                                             ,  attribute2
                                                             ,  attribute3
                                                             ,  attribute4
                                                             ,  attribute5
                                                             ,  attribute6
                                                             ,  attribute7
                                                             ,  attribute8
                                                             ,  attribute9
                                                             ,  attribute10
                                                             ,  attribute11
                                                             ,  attribute12
                                                             ,  attribute13
                                                             ,  attribute14
                                                             ,  attribute15
                                                             ,  service_name
                                                             ,  service_id
                                                             ,  enable_services )
AS
    SELECT dev_res.ROWID
         ,  dev_res.device_resource_snid
         ,  dev_res.device_product_snid
         ,  dev_res.creating_contract_snid
         ,  dev_prod.org_id
         ,  dev_prod.cust_account_id
         ,  dev_prod.cust_acct_site_id
         ,  dev_res.resource_num
         ,  dev_prod.contract_snid
         ,  dev_res.product_resource_def_snid
         ,  dev_res.parent_device_resource_snid
         ,  dev_res.override_flag
         ,  dev_res.quantity
         ,  dev_res.device_num
         ,  dev_res.billing_start_date
         ,  dev_res.billing_end_date
         ,  dev_res.billed_date
         ,  dev_res.description
         ,  dev_res.prepay_months
         ,  dev_res.unit_price
         ,  dev_res.exclude_from_billing_flag
         ,  dev_res.creation_date
         ,  dev_res.created_by
         ,  dev_res.last_updated_by
         ,  dev_res.last_update_login
         ,  dev_res.last_update_date
         ,  rd.resource_name
         ,  rd.resource_billing_type_code
         ,  bt_lookup.meaning
         ,  bt_lookup.tag
         ,  rd.unit_of_measure_code
         ,  um_lookup.unit_of_measure
         ,  rd.tiered_flag
         ,  rd.include_in_monthly_fee_flag
         ,  bil2.currency_code
         ,  dev_res.voided_flag
         ,  rd.prepay_flag
         ,  dev_res.prepay_start_date
         ,  dev_res.prepay_end_date
         ,  dev_res.attribute_category
         ,  dev_res.attribute1
         ,  dev_res.attribute2
         ,  dev_res.attribute3
         ,  dev_res.attribute4
         ,  dev_res.attribute5
         ,  dev_res.attribute6
         ,  dev_res.attribute7
         ,  dev_res.attribute8
         ,  dev_res.attribute9
         ,  dev_res.attribute10
         ,  dev_res.attribute11
         ,  dev_res.attribute12
         ,  dev_res.attribute13
         ,  dev_res.attribute14
         ,  dev_res.attribute15
         ,  ( SELECT name
                FROM xxrs.xxrs_sc_service_def ser
               WHERE ser.service_id = dev_res.service_id )
              service_name                    
         ,  dev_res.service_id                                                                                   
         ,  rd.enable_services                                                                                   
      FROM xxrs.xxrs_sc_device_resource_tbl dev_res
         , xxrs.xxrs_sc_product_rsrc_def_tbl prd
         , xxrs.xxrs_sc_resource_def_tbl rd
         , apps.xxrs_sc_lookup_vw bt_lookup
         , inv.mtl_units_of_measure_tl um_lookup
         , xxrs.xxrs_sc_device_product_tbl dev_prod
         , apps.xxrs_sc_cust_bil2_sites_org_vw bil2
     WHERE dev_res.product_resource_def_snid = prd.product_resource_def_snid
       AND prd.resource_def_snid = rd.resource_def_snid
       AND dev_prod.device_product_snid = dev_res.device_product_snid
       AND rd.resource_billing_type_code = bt_lookup.lookup_code(+)
       AND bt_lookup.lookup_type(+) = 'XXRS_SC_RESOURCE_BILLING_TYPE'
       AND rd.unit_of_measure_code = um_lookup.uom_code(+)
       AND dev_prod.cust_acct_site_id = bil2.cust_acct_site_id
  ORDER BY dev_res.billing_start_date;