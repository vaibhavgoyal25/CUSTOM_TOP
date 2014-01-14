CREATE OR REPLACE FORCE VIEW APPS.XXRS_SC_ACCOUNT_RESOURCE_VW
  /******************************************************************************************************************
  *                                                                                                                 *
  * NAME : XXRS_SC_ACCOUNT_RESOURCE_VW.sql                                                                          *
  *                                                                                                                 *
  * DESCRIPTION : Script to recreate view XXRS_SC_ACCOUNT_RESOURCE_VW with PO _NUMBER field added.                  *
  *                                                                                                                 *
  * AUTHOR       : Vaibhav                                                                                          *
  * DATE WRITTEN : 31-AUG-2013                                                                                      *
  *                                                                                                                 *
  * CHANGE CONTROL :                                                                                                *
  * Version#     | REF#             | WHO                | DATE              | REMARKS                              *
  *-----------------------------------------------------------------------------------------------------------------*
  * 1.0.0        | 111122-02448     | Vinodh Bhasker     | 28-FEB-2012       | Initial Creation for R12.            *
  * 1.0.0        | 130621-07223     | Vaibhav Goyal      | 31-AUG-2013       | Added PO Number Column to the View.  *
  *******************************************************************************************************************/
  /* $HEADER: XXRS_SC_ACCOUNT_RESOURCE_VW.sql 1.0.0 31-AUG-2013 5:00:00 PM VAIBHAV $ */
(
   ROW_ID,
   ACCOUNT_RESOURCE_SNID,
   ACCOUNT_PRODUCT_SNID,
   CREATING_CONTRACT_SNID,
   ORG_ID,
   CUST_ACCOUNT_ID,
   CUST_ACCT_SITE_ID,
   RESOURCE_NUM,
   CONTRACT_SNID,
   PRICE_TIER_SNID,
   PRODUCT_RESOURCE_DEF_SNID,
   PARENT_ACCOUNT_RESOURCE_SNID,
   OVERRIDE_FLAG,
   INITIAL_QUANTITY,
   QUANTITY,
   DEVICE_NUM,
   BILLING_START_DATE,
   BILLING_END_DATE,
   BILLED_DATE,
   EXCLUDE_FROM_BILLING_FLAG,
   DESCRIPTION,
   PREPAY_MONTHS,
   SPCL_PRICE_FLAG,
   UNIT_PRICE,
   CREATION_DATE,
   CREATED_BY,
   LAST_UPDATED_BY,
   LAST_UPDATE_LOGIN,
   LAST_UPDATE_DATE,
   RESOURCE_NAME,
   RESOURCE_BILLING_TYPE_CODE,
   RESOURCE_BILLING_TYPE_MEANING,
   RESOURCE_BILLING_TYPE_TAG,
   UNIT_OF_MEASURE_CODE,
   UNIT_OF_MEASURE_MEANING,
   TIERED_FLAG,
   INCLUDE_IN_MONTHLY_FEE_FLAG,
   CURRENCY_CODE,
   BUSINESS_SEGMENT_CODE,
   RESOURCE_DEF_SNID,
   VOIDED_FLAG,
   PREPAY_FLAG,
   PREPAY_START_DATE,
   PREPAY_END_DATE,
   ATTRIBUTE_CATEGORY,
   ATTRIBUTE1,
   ATTRIBUTE2,
   ATTRIBUTE3,
   ATTRIBUTE4,
   ATTRIBUTE5,
   ATTRIBUTE6,
   ATTRIBUTE7,
   ATTRIBUTE8,
   ATTRIBUTE9,
   ATTRIBUTE10,
   ATTRIBUTE11,
   ATTRIBUTE12,
   ATTRIBUTE13,
   ATTRIBUTE14,
   ATTRIBUTE15,
   SERVICE_NAME,
   SERVICE_ID,
   ENABLE_SERVICES,
   PO_NUMBER        --130621-07223
)
AS
     SELECT acc_res.ROWID,
            acc_res.account_resource_snid,
            acc_res.account_product_snid,
            acc_res.creating_contract_snid,
            acc_prod.org_id,
            acc_prod.cust_account_id,
            acc_prod.cust_acct_site_id,
            acc_res.resource_num,
            acc_prod.contract_snid,
            acc_res.price_tier_snid,
            acc_res.product_resource_def_snid,
            acc_res.parent_account_resource_snid,
            acc_res.override_flag,
            acc_res.initial_quantity,
            acc_res.quantity,
            acc_res.device_num,
            acc_res.billing_start_date,
            acc_res.billing_end_date,
            acc_res.billed_date,
            acc_res.exclude_from_billing_flag,
            acc_res.description,
            acc_res.prepay_months,
            acc_res.spcl_price_flag,
            acc_res.unit_price,
            acc_res.creation_date,
            acc_res.created_by,
            acc_res.last_updated_by,
            acc_res.last_update_login,
            acc_res.last_update_date,
            rd.resource_name,
            rd.resource_billing_type_code,
            bt_lookup.meaning,
            bt_lookup.tag,
            rd.unit_of_measure_code,
            um_lookup.unit_of_measure,
            rd.tiered_flag,
            rd.include_in_monthly_fee_flag,
            bil2.currency_code,
            bil2.business_unit,
            prd.resource_def_snid,
            acc_res.voided_flag,
            rd.prepay_flag,
            acc_res.prepay_start_date,
            acc_res.prepay_end_date,
            acc_res.attribute_category,
            acc_res.attribute1,
            acc_res.attribute2,
            acc_res.attribute3,
            acc_res.attribute4,
            acc_res.attribute5,
            acc_res.attribute6,
            acc_res.attribute7,
            acc_res.attribute8,
            acc_res.attribute9,
            acc_res.attribute10,
            acc_res.attribute11,
            acc_res.attribute12,
            acc_res.attribute13,
            acc_res.attribute14,
            acc_res.attribute15,
            (SELECT name
               FROM xxrs.xxrs_sc_service_def ser
              WHERE ser.service_id = acc_res.service_id)
               service_name,
            acc_res.service_id,
            rd.enable_services,
            acc_res.po_number   --130621-07223
       FROM xxrs.xxrs_sc_account_resource_tbl acc_res,
            xxrs.xxrs_sc_product_rsrc_def_tbl prd,
            xxrs.xxrs_sc_resource_def_tbl rd,
            apps.xxrs_sc_lookup_vw bt_lookup,
            inv.mtl_units_of_measure_tl um_lookup,
            xxrs.xxrs_sc_account_product_tbl acc_prod,
            apps.xxrs_sc_cust_bil2_sites_org_vw bil2
      WHERE     acc_res.product_resource_def_snid =
                   prd.product_resource_def_snid
            AND prd.resource_def_snid = rd.resource_def_snid
            AND acc_prod.account_product_snid = acc_res.account_product_snid
            AND rd.resource_billing_type_code = bt_lookup.lookup_code(+)
            AND bt_lookup.lookup_type(+) = 'XXRS_SC_RESOURCE_BILLING_TYPE'
            AND rd.unit_of_measure_code = um_lookup.uom_code(+)
            AND acc_prod.cust_acct_site_id = bil2.cust_acct_site_id
            AND acc_res.account_product_snid = acc_prod.account_product_snid
   ORDER BY acc_res.billing_start_date;
