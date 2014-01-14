DROP VIEW APPS.XXRS_SC_ACCOUNT_PRODUCT_VW;

 /************************************************************************************************************
  *                                                                                                          *
  * NAME : XXRS_SC_ACCOUNT_PRODUCT_VW.sql                                                                    *
  *                                                                                                          *
  * DESCRIPTION : Script to create Rackspace Account Product View                                            *
  *                                                                                                          *
  * AUTHOR       : Vaibhav Goyal                                                                             *
  * DATE WRITTEN : 04-MAR-2012                                                                               *
  *                                                                                                          *
  * CHANGE CONTROL :                                                                                         *
  * Version#     | REF#             | WHO                | DATE              | REMARKS                       *
  *--------------------------------------------------------------------------------------------------------  *
  * 1.0.0        | 111122-02448     | Vaibhav Goyal      | 04-MAR-2012       | Initial Build for R12 upgrade *
  ************************************************************************************************************/
  /* $HEADER: XXRS_SC_ACCOUNT_PRODUCT_VW.sql 1.0.0 04-MAR-2012 12:00:00 PM Vaibhav Goyal $ */
CREATE OR REPLACE FORCE VIEW apps.xxrs_sc_account_product_vw ( row_id,
                                                               account_product_snid,
                                                               orig_account_product_snid,
                                                               org_id,
                                                               cust_account_id,
                                                               cust_acct_site_id,
                                                               product_def_snid,
                                                               contract_snid,
                                                               prev_contract_snid,
                                                               creating_contract_snid,
                                                               product_status_code,
                                                               product_status_meaning,
                                                               product_status_tag,
                                                               prev_product_status_code,
                                                               prev_product_status_meaning,
                                                               prev_product_status_tag,
                                                               ec_end_date,
                                                               parent_account_product_snid,
                                                               date_cancelled,
                                                               cancel_reason_code,
                                                               cancel_reason_meaning,
                                                               cancel_reason_tag,
                                                               offline_flag,
                                                               virtual_machine_flag,
                                                               bill_flag,
                                                               void_flag,
                                                               device_num,
                                                               location_code,
                                                               location_meaning,
                                                               location_tag,
                                                               po_number,
                                                               online_date,
                                                               monthly_fee,
                                                               setup_fee,
                                                               verisign_fee,
                                                               thawte_fee,
                                                               change_description,
                                                               old_monthly_fee,
                                                               udg_monthly_fee_chg,
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
                                                               locked_flag,
                                                               locked_by,
                                                               locked_by_name,
                                                               old_ec_end_date,
                                                               select_flag,
                                                               on_hold_flag,
                                                               creation_date,
                                                               created_by,
                                                               last_updated_by,
                                                               last_update_login,
                                                               last_update_date,
                                                               product_name,
                                                               last_updated_by_username,
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
                                                               payment_method_name,
                                                               currency_code,
                                                               opportunity_num,
                                                               site_use_id,
                                                               component_code,
                                                               component_meaning,
                                                               component_tag,
                                                               party_id,
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
                                                               service_id,
                                                               service )
AS
  SELECT acc_prod.ROWID,
         acc_prod.account_product_snid,
         acc_prod.orig_account_product_snid,
         acc_prod.org_id,
         acc_prod.cust_account_id,
         acc_prod.cust_acct_site_id,                                                                         -- (5) ----------------------------------
         acc_prod.product_def_snid,
         acc_prod.contract_snid,
         acc_prod.prev_contract_snid,
         acc_prod.creating_contract_snid,
         acc_prod.product_status_code,                                                                      -- (10) ----------------------------------
         ps_lookup.meaning,
         ps_lookup.tag,
         acc_prod.prev_product_status_code,
         pps_lookup.meaning,
         pps_lookup.tag,                                                                                    -- (15) ----------------------------------
         acc_prod.ec_end_date,
         acc_prod.parent_account_product_snid,
         acc_prod.date_cancelled,
         acc_prod.cancel_reason_code,                                                                       -- (20) ----------------------------------
         cr_lookup.meaning,
         cr_lookup.tag,
         acc_prod.offline_flag,
         acc_prod.virtual_machine_flag,
         acc_prod.bill_flag,                                                                                -- (25) ----------------------------------
         acc_prod.void_flag,
         acc_prod.device_num,
         acc_prod.location_code,
         lo_lookup.meaning,
         lo_lookup.tag,                                                                                     -- (30) ----------------------------------
         acc_prod.po_number,
         acc_prod.online_date,
         acc_prod.monthly_fee,                                                                                                 -- acc_prod.MONTHLY_FEE
         acc_prod.setup_fee,
         0,                                                                                                                   -- acc_prod.VERISIGN_FEE
         -- (35) ----------------------------------
         0,                                                                                                                     -- acc_prod.THAWTE_FEE
         acc_prod.change_description,
         acc_prod.old_monthly_fee,
         acc_prod.udg_monthly_fee_chg,
         0,                                                                                                                    -- acc_prod.UPGRADE_FEE
         -- cc_number --------------------------------------------
         -- the logic below assumes that the each product has a receipt method and bank tied
         -- if the receipt method is null, default to primary else display the overriden value on the product field
         DECODE(acc_prod.bank_account_uses_id,
                NULL,
               xxrs_utility_pkg.get_cust_site_bank_dtls(cus.cust_account_id,cus.site_use_id,cus.org_id,'CREDITCARD','ACCOUNT_NUMBER'),
               xxrs_utility_pkg.get_ins_bank_dtls(acc_prod.bank_account_uses_id,'CREDITCARD','ACCOUNT_NUMBER')) 
         cc_number,
         DECODE(acc_prod.bank_account_uses_id,
                NULL,
                xxrs_utility_pkg.get_cust_site_bank_dtls(cus.cust_account_id,cus.site_use_id,cus.org_id,'CREDITCARD','EXPIRATION_DATE'),
                xxrs_utility_pkg.get_ins_bank_dtls(acc_prod.bank_account_uses_id,'CREDITCARD','EXPIRATION_DATE'))  
         cc_expiration_date,
         DECODE(acc_prod.bank_account_uses_id,
                NULL,
                xxrs_utility_pkg.get_cust_site_bank_dtls(cus.cust_account_id,cus.site_use_id,cus.org_id,'CREDITCARD','ACCOUNT_NAME'),
                xxrs_utility_pkg.get_ins_bank_dtls(acc_prod.bank_account_uses_id,'CREDITCARD','ACCOUNT_NAME')) 
         cc_name_on_card,
         DECODE(acc_prod.bank_account_uses_id,
                NULL,
                xxrs_utility_pkg.get_cust_site_bank_dtls(cus.cust_account_id,cus.site_use_id,cus.org_id,'BANKACCOUNT','ACCOUNT_NAME'),
                xxrs_utility_pkg.get_ins_bank_dtls(acc_prod.bank_account_uses_id,'BANKACCOUNT','ACCOUNT_NAME')) 
         ncc_account_name,
         DECODE(acc_prod.bank_account_uses_id,
                NULL,
               xxrs_utility_pkg.get_cust_site_bank_dtls(cus.cust_account_id,cus.site_use_id,cus.org_id,'BANKACCOUNT','ACCOUNT_NUMBER'),
               xxrs_utility_pkg.get_ins_bank_dtls(acc_prod.bank_account_uses_id,'BANKACCOUNT','ACCOUNT_NUMBER')) 
         ncc_account_number,
         DECODE(acc_prod.bank_account_uses_id,
                NULL,
               xxrs_utility_pkg.get_cust_site_bank_dtls(cus.cust_account_id,cus.site_use_id,cus.org_id,'BANKACCOUNT','ROUTING_NUMBER'),
               xxrs_utility_pkg.get_ins_bank_dtls(acc_prod.bank_account_uses_id,'BANKACCOUNT','ROUTING_NUMBER')) 
         ncc_routing_number,                      
         -- (45) ----------------------------------
         acc_prod.contract_term,
         acc_prod.bank_account_uses_id,
         xxrs_utility_pkg.get_cust_bank_dtls(cus.cust_account_id,cus.site_use_id,cus.org_id,'ACCOUNT_NAME') bank_account_name,
         acc_prod.receipt_method_id,
         rm.name,                                                                                           -- (50) ----------------------------------
         acc_prod.locked_flag,
         acc_prod.locked_by,
         usr_lock.user_name,
         acc_prod.old_ec_end_date,
         acc_prod.select_flag,                                                                              -- (55) ----------------------------------
         acc_prod.on_hold_flag,
         acc_prod.creation_date,
         acc_prod.created_by,
         acc_prod.last_updated_by,
         acc_prod.last_update_login,                                                                        -- (60) ----------------------------------
         acc_prod.last_update_date,
         prod.product_name,
         usr.user_name,
         con.customer_num,
         party_site.party_site_number,                                                                      -- (65) ----------------------------------
         con.company_name,
         con.address1,
         con.address2,
         con.city,
         con.state,                                                                                         -- (70) ----------------------------------
         con.country,
         con.postal_code,
         con.phone_no,
         con.fax_no,
         con.billing_contact,                                                                               -- (75) ----------------------------------
         con.email,
         con.receipt_method_name,
         cus.currency_code,
         con.opportunity_num,
         con.site_use_id,                                                                                   -- (80) ----------------------------------
         acc_prod.component_code,
         cp_lookup.meaning,
         cp_lookup.tag,
         cus.party_id,
         acc_prod.attribute_category,                                                                       -- (85) ----------------------------------
         acc_prod.attribute1,
         acc_prod.attribute2,
         acc_prod.attribute3,
         acc_prod.attribute4,
         acc_prod.attribute5,                                                                               -- (90) ----------------------------------
         acc_prod.attribute6,
         acc_prod.attribute7,
         acc_prod.attribute8,
         acc_prod.attribute9,
         acc_prod.attribute10,                                                                              -- (95) ----------------------------------
         acc_prod.attribute11,
         acc_prod.attribute12,
         acc_prod.attribute13,
         acc_prod.attribute14,
         acc_prod.attribute15,
         apps.xxrs_sc_account_resource_pkg.get_service_id ( acc_prod.account_product_snid ),
         apps.xxrs_sc_account_resource_pkg.get_service_name ( acc_prod.account_product_snid ) 
    FROM xxrs_sc_account_product_tbl acc_prod,
         xxrs_sc_cust_bill_to_sites_vw cus,
         xxrs_sc_contract_vw con,
         xxrs_sc_product_def_tbl prod,
         xxrs_sc_lookup_vw ps_lookup,
         xxrs_sc_lookup_vw pps_lookup,
         xxrs_sc_lookup_vw cr_lookup,
         xxrs_sc_lookup_vw lo_lookup,
         xxrs_sc_lookup_vw cp_lookup,
         applsys.fnd_user usr,
         ar_receipt_methods rm,
         applsys.fnd_user usr_lock,
         hz_party_sites party_site
   WHERE acc_prod.product_def_snid = prod.product_def_snid
     AND acc_prod.cust_acct_site_id = cus.cust_acct_site_id
     AND cus.party_site_id = party_site.party_site_id
     AND acc_prod.creating_contract_snid = con.contract_snid
     AND acc_prod.product_status_code = ps_lookup.lookup_code(+)
     AND ps_lookup.lookup_type(+) = 'RS_SC_PRODUCT_STATUS'
     AND acc_prod.prev_product_status_code = pps_lookup.lookup_code(+)
     AND pps_lookup.lookup_type(+) = 'RS_SC_PRODUCT_STATUS'
     AND acc_prod.cancel_reason_code = cr_lookup.lookup_code(+)
     AND cr_lookup.lookup_type(+) = 'RS_CANCEL_REASON'
     AND acc_prod.location_code = lo_lookup.lookup_code(+)
     AND lo_lookup.lookup_type(+) = 'RS_LOCATION'
     AND acc_prod.component_code = cp_lookup.lookup_code(+)
     AND cp_lookup.lookup_type(+) = 'RS_COMPONENT'
     AND acc_prod.last_updated_by = usr.user_id(+)
     AND acc_prod.receipt_method_id = rm.receipt_method_id(+)
     AND NVL ( acc_prod.org_id,
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
     AND acc_prod.locked_by = usr_lock.user_id(+);


AUDIT GRANT ON APPS.XXRS_SC_ACCOUNT_PRODUCT_VW BY SESSION WHENEVER SUCCESSFUL;
AUDIT GRANT ON APPS.XXRS_SC_ACCOUNT_PRODUCT_VW BY SESSION WHENEVER NOT SUCCESSFUL;
