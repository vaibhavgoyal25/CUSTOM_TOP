DROP VIEW APPS.XXRS_SC_DEVICE_PRODUCT_VW;  

 /************************************************************************************************************
  *                                                                                                          *
  * NAME : XXRS_SC_DEVICE_PRODUCT_VW.sql                                                                     *
  *                                                                                                          *
  * DESCRIPTION : Script to create Rackspace Device Product View                                             *
  *                                                                                                          *
  * AUTHOR       : Vaibhav Goyal                                                                             *
  * DATE WRITTEN : 04-MAR-2012                                                                               *
  *                                                                                                          *
  * CHANGE CONTROL :                                                                                         *
  * Version#     | REF#             | WHO                | DATE              | REMARKS                       *
  *--------------------------------------------------------------------------------------------------------  *
  * 1.0.0        | 111122-02448     | Vaibhav Goyal      | 04-MAR-2012       | Initial Build for R12 upgrade *
  ************************************************************************************************************/
  /* $HEADER: XXRS_SC_DEVICE_PRODUCT_VW.sql 1.0.0 04-MAR-2012 12:00:00 PM Vaibhav Goyal $ */
CREATE OR REPLACE FORCE VIEW apps.xxrs_sc_device_product_vw ( row_id,
                                                              device_product_snid,
                                                              orig_device_product_snid,
                                                              org_id,
                                                              cust_account_id,
                                                              cust_acct_site_id,
                                                              product_def_snid,
                                                              device_num,
                                                              contract_snid,
                                                              prev_contract_snid,
                                                              creating_contract_snid,
                                                              product_status_code,
                                                              prev_product_status_code,
                                                              prev_product_status_meaning,
                                                              prev_product_status_tag,
                                                              ec_end_date,
                                                              parent_device_product_snid,
                                                              date_cancelled,
                                                              cancel_reason_code,
                                                              offline_flag,
                                                              bill_flag,
                                                              void_flag,
                                                              free_time_flag,
                                                              location_code,
                                                              po_number,
                                                              online_date,
                                                              monthly_fee,
                                                              change_description,
                                                              udg_monthly_fee_chg,
                                                              setup_fee,
                                                              upgrade_fee,
                                                              cc_number,
                                                              cc_expiration_date,
                                                              cc_name_on_card,
                                                              ncc_account_name,
                                                              ncc_account_number,
                                                              ncc_routing_number,
                                                              contract_term,
                                                              bank_account_uses_id,
                                                              bank_account_name,
                                                              receipt_method_id,
                                                              receipt_method_name,
                                                              component_code,
                                                              device_product_notes,
                                                              locked_flag,
                                                              locked_by,
                                                              locked_by_name,
                                                              old_device_product_snid,
                                                              old_device_num,
                                                              old_monthly_fee,
                                                              old_ec_end_date,
                                                              select_flag,
                                                              on_hold_flag,
                                                              creation_date,
                                                              created_by,
                                                              last_updated_by,
                                                              last_update_login,
                                                              last_update_date,
                                                              product_name,
                                                              payment_method_name,
                                                              component_meaning,
                                                              component_tag,
                                                              product_status_meaning,
                                                              product_status_tag,
                                                              cancel_reason_meaning,
                                                              cancel_reason_tag,
                                                              last_updated_by_username,
                                                              location_meaning,
                                                              location_tag,
                                                              customer_num,
                                                              site_num,
                                                              company_name,
                                                              address1,
                                                              address2,
                                                              city,
                                                              state,
                                                              country,
                                                              postal_code,
                                                              phone_no,
                                                              fax_no,
                                                              billing_contact,
                                                              email,
                                                              currency_code,
                                                              opportunity_num,
                                                              site_use_id,
                                                              party_id,
                                                              one_time_fee,
                                                              attribute_category,
                                                              attribute1,
                                                              attribute2,
                                                              attribute3,
                                                              attribute4,
                                                              attribute5,
                                                              attribute6,
                                                              attribute7,
                                                              attribute8,
                                                              attribute9,
                                                              attribute10,
                                                              attribute11,
                                                              attribute12,
                                                              attribute13,
                                                              attribute14,
                                                              attribute15,
                                                              service,
                                                              service_id )
AS
  SELECT dev_prod.ROWID,
         dev_prod.device_product_snid,
         dev_prod.orig_device_product_snid,
         dev_prod.org_id,
         dev_prod.cust_account_id,
         dev_prod.cust_acct_site_id                                                                          -- (5) ----------------------------------
                                   ,
         dev_prod.product_def_snid,
         dev_prod.device_num,
         dev_prod.contract_snid,
         dev_prod.prev_contract_snid,
         dev_prod.creating_contract_snid                                                                    -- (10) ----------------------------------
                                        ,
         dev_prod.product_status_code,
         dev_prod.prev_product_status_code,
         pps_lookup.meaning,
         pps_lookup.tag,
         dev_prod.ec_end_date                                                                               -- (15) ----------------------------------
                             ,
         dev_prod.parent_device_product_snid,
         dev_prod.date_cancelled,
         dev_prod.cancel_reason_code,
         dev_prod.offline_flag                                                                              -- (20) ----------------------------------
                              ,
         dev_prod.bill_flag,
         dev_prod.void_flag,
         dev_prod.free_time_flag,
         dev_prod.location_code,
         dev_prod.po_number,
         dev_prod.online_date                                                                               -- (25) ----------------------------------
                             ,
         dev_prod.monthly_fee,
         dev_prod.change_description,
         dev_prod.udg_monthly_fee_chg,
         dev_prod.setup_fee,
         dev_prod.upgrade_fee                                                                               -- (30) ----------------------------------
                             -- cc_number ------------------------------
                             -- the logic below assumes that the each product has a receipt method and bank tied
                             -- if the receipt method is null, default to primary else display the overriden value on the product field
         ,
         DECODE ( dev_prod.bank_account_uses_id,
                  NULL, xxrs_utility_pkg.get_cust_site_bank_dtls ( cus.cust_account_id,
                                                                   cus.site_use_id,
                                                                   cus.org_id,
                                                                   'CREDITCARD',
                                                                   'ACCOUNT_NUMBER' ),
                  xxrs_utility_pkg.get_ins_bank_dtls ( dev_prod.bank_account_uses_id,
                                                       'CREDITCARD',
                                                       'ACCOUNT_NUMBER' ) )
           cc_number,
         DECODE ( dev_prod.bank_account_uses_id,
                  NULL, xxrs_utility_pkg.get_cust_site_bank_dtls ( cus.cust_account_id,
                                                                   cus.site_use_id,
                                                                   cus.org_id,
                                                                   'CREDITCARD',
                                                                   'EXPIRATION_DATE' ),
                  xxrs_utility_pkg.get_ins_bank_dtls ( dev_prod.bank_account_uses_id,
                                                       'CREDITCARD',
                                                       'EXPIRATION_DATE' ) )
           cc_expiration_date,
         DECODE ( dev_prod.bank_account_uses_id,
                  NULL, xxrs_utility_pkg.get_cust_site_bank_dtls ( cus.cust_account_id,
                                                                   cus.site_use_id,
                                                                   cus.org_id,
                                                                   'CREDITCARD',
                                                                   'ACCOUNT_NAME' ),
                  xxrs_utility_pkg.get_ins_bank_dtls ( dev_prod.bank_account_uses_id,
                                                       'CREDITCARD',
                                                       'ACCOUNT_NAME' ) )
           cc_name_on_card,
         DECODE ( dev_prod.bank_account_uses_id,
                  NULL, xxrs_utility_pkg.get_cust_site_bank_dtls ( cus.cust_account_id,
                                                                   cus.site_use_id,
                                                                   cus.org_id,
                                                                   'BANKACCOUNT',
                                                                   'ACCOUNT_NAME' ),
                  xxrs_utility_pkg.get_ins_bank_dtls ( dev_prod.bank_account_uses_id,
                                                       'BANKACCOUNT',
                                                       'ACCOUNT_NAME' ) )
           ncc_account_name,
         DECODE ( dev_prod.bank_account_uses_id,
                  NULL, xxrs_utility_pkg.get_cust_site_bank_dtls ( cus.cust_account_id,
                                                                   cus.site_use_id,
                                                                   cus.org_id,
                                                                   'BANKACCOUNT',
                                                                   'ACCOUNT_NUMBER' ),
                  xxrs_utility_pkg.get_ins_bank_dtls ( dev_prod.bank_account_uses_id,
                                                       'BANKACCOUNT',
                                                       'ACCOUNT_NUMBER' ) )
           ncc_account_number,
         DECODE ( dev_prod.bank_account_uses_id,
                  NULL, xxrs_utility_pkg.get_cust_site_bank_dtls ( cus.cust_account_id,
                                                                   cus.site_use_id,
                                                                   cus.org_id,
                                                                   'BANKACCOUNT',
                                                                   'ROUTING_NUMBER' ),
                  xxrs_utility_pkg.get_ins_bank_dtls ( dev_prod.bank_account_uses_id,
                                                       'BANKACCOUNT',
                                                       'ROUTING_NUMBER' ) )
           ncc_routing_number,                                                                              -- (45) ----------------------------------
         dev_prod.contract_term,
         dev_prod.bank_account_uses_id,
         xxrs_utility_pkg.get_cust_bank_dtls ( cus.cust_account_id,
                                               cus.site_use_id,
                                               cus.org_id,
                                               'ACCOUNT_NAME' )
           bank_account_name,
         dev_prod.receipt_method_id                                                                         -- (40) ----------------------------------
                                   ,
         rm.name,
         dev_prod.component_code,
         dev_prod.device_product_notes,
         dev_prod.locked_flag,
         dev_prod.locked_by                                                                                 -- (45) ----------------------------------
                           ,
         usr_lock.user_name,
         dev_prod.old_device_product_snid,
         dev_prod.old_device_num,
         dev_prod.old_monthly_fee,
         dev_prod.old_ec_end_date                                                                           -- (50) ----------------------------------
                                 ,
         dev_prod.select_flag,
         dev_prod.on_hold_flag,
         dev_prod.creation_date,
         dev_prod.created_by,
         dev_prod.last_updated_by                                                                           -- (55) ----------------------------------
                                 ,
         dev_prod.last_update_login,
         dev_prod.last_update_date,
         prod.product_name,
         con.receipt_method_name                                                                            -- (60) ----------------------------------
                                ,
         co_lookup.meaning,
         co_lookup.tag,
         ps_lookup.meaning,
         ps_lookup.tag,
         cr_lookup.meaning                                                                                  -- (65) ----------------------------------
                          ,
         cr_lookup.tag,
         usr.user_name,
         lo_lookup.meaning,
         lo_lookup.tag,
         con.customer_num                                                                                   -- (70) ----------------------------------
                         ,
         party_site.party_site_number,
         con.company_name,
         con.address1,
         con.address2,
         con.city                                                                                           -- (75) ----------------------------------
                 ,
         con.state,
         con.country,
         con.postal_code,
         con.phone_no,
         con.fax_no                                                                                         -- (80) ----------------------------------
                   ,
         con.billing_contact,
         con.email,
         cus.currency_code,
         con.opportunity_num,
         con.site_use_id                                                                                    -- (85) ----------------------------------
                        ,
         cus.party_id,
         dev_prod.one_time_fee,
         dev_prod.attribute_category,
         dev_prod.attribute1,
         dev_prod.attribute2                                                                                -- (90) ----------------------------------
                            ,
         dev_prod.attribute3,
         dev_prod.attribute4,
         dev_prod.attribute5,
         dev_prod.attribute6,
         dev_prod.attribute7                                                                                -- (95) ----------------------------------
                            ,
         dev_prod.attribute8,
         dev_prod.attribute9,
         dev_prod.attribute10,
         dev_prod.attribute11,
         dev_prod.attribute12                                                                              -- (100) ----------------------------------
                             ,
         dev_prod.attribute13,
         dev_prod.attribute14,
         dev_prod.attribute15,
         apps.xxrs_sc_device_resource_pkg.get_service_name ( dev_prod.device_product_snid )                                         -- LY 110223-01761
                                                                                           ,
         apps.xxrs_sc_device_resource_pkg.get_service_id ( dev_prod.device_product_snid )                                           -- LY 110223-01761
    FROM xxrs_sc_device_product_tbl dev_prod,
         xxrs_sc_cust_bill_to_sites_vw cus,
         xxrs_sc_product_def_tbl prod,
         xxrs_sc_contract_vw con,
         xxrs_sc_lookup_vw co_lookup,
         xxrs_sc_lookup_vw ps_lookup,
         xxrs_sc_lookup_vw pps_lookup,
         xxrs_sc_lookup_vw cr_lookup,
         xxrs_sc_lookup_vw lo_lookup,
         applsys.fnd_user usr,
         ar_receipt_methods rm,
         applsys.fnd_user usr_lock,
         hz_party_sites party_site
   WHERE dev_prod.product_def_snid = prod.product_def_snid
     AND dev_prod.cust_acct_site_id = cus.cust_acct_site_id
     AND cus.party_site_id = party_site.party_site_id
     AND dev_prod.creating_contract_snid = con.contract_snid
     AND dev_prod.component_code = co_lookup.lookup_code(+)
     AND co_lookup.lookup_type(+) = 'RS_COMPONENT'
     AND dev_prod.product_status_code = ps_lookup.lookup_code(+)
     AND ps_lookup.lookup_type(+) = 'RS_SC_PRODUCT_STATUS'
     AND dev_prod.prev_product_status_code = pps_lookup.lookup_code(+)
     AND pps_lookup.lookup_type(+) = 'RS_SC_PRODUCT_STATUS'
     AND dev_prod.cancel_reason_code = cr_lookup.lookup_code(+)
     AND cr_lookup.lookup_type(+) = 'RS_CANCEL_REASON'
     AND dev_prod.location_code = lo_lookup.lookup_code(+)
     AND lo_lookup.lookup_type(+) = 'RS_LOCATION'
     AND dev_prod.last_updated_by = usr.user_id(+)
     AND dev_prod.receipt_method_id = rm.receipt_method_id(+)
     AND NVL ( dev_prod.org_id,
               NVL ( TO_NUMBER ( DECODE ( SUBSTRB ( USERENV ( 'CLIENT_INFO' ),
                                                    1,
                                                    1 ),
                                          ' ', NULL,
                                          SUBSTRB ( USERENV ( 'CLIENT_INFO' ),
                                                    1,
                                                    10 ) ) ),
                     -99 ) ) = NVL ( TO_NUMBER ( DECODE ( SUBSTRB ( USERENV ( 'CLIENT_INFO' ),
                                                                    1,
                                                                    1 ),
                                                          ' ', NULL,
                                                          SUBSTRB ( USERENV ( 'CLIENT_INFO' ),
                                                                    1,
                                                                    10 ) ) ),
                                     -99 )
     AND dev_prod.locked_by = usr_lock.user_id(+);


AUDIT GRANT ON APPS.XXRS_SC_DEVICE_PRODUCT_VW BY SESSION WHENEVER SUCCESSFUL;
AUDIT GRANT ON APPS.XXRS_SC_DEVICE_PRODUCT_VW BY SESSION WHENEVER NOT SUCCESSFUL;