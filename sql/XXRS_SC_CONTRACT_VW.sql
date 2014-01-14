DROP VIEW APPS.XXRS_SC_CONTRACT_VW;

 /************************************************************************************************************
  *                                                                                                          *
  * NAME : XXRS_SC_CONTRACT_VW.sql                                                                           *
  *                                                                                                          *
  * DESCRIPTION : Script to create Rackspace Contract View                                                   *
  *                                                                                                          *
  * AUTHOR       : Vaibhav Goyal                                                                             *
  * DATE WRITTEN : 04-MAR-2012                                                                               *
  *                                                                                                          *
  * CHANGE CONTROL :                                                                                         *
  * Version#     | REF#             | WHO                | DATE              | REMARKS                       *
  *--------------------------------------------------------------------------------------------------------  *
  * 1.0.0        | 111122-02448     | Vaibhav Goyal      | 04-MAR-2012       | Initial Build for R12 upgrade *
  ************************************************************************************************************/
  /* $HEADER: XXRS_SC_CONTRACT_VW.sql 1.0.0 04-MAR-2012 12:00:00 PM Vaibhav Goyal $ */
CREATE OR REPLACE FORCE VIEW apps.xxrs_sc_contract_vw ( row_id,
                                                        contract_snid,
                                                        parent_contract_snid,
                                                        bank_account_uses_id,
                                                        bank_account_name,
                                                        contract_type_code,
                                                        contract_type_meaning,
                                                        contract_type_tag,
                                                        contract_status_code,
                                                        contract_status_meaning,
                                                        contract_status_tag,
                                                        date_received,
                                                        date_completed,
                                                        end_date,
                                                        effective_date,
                                                        support_team,
                                                        support_team_desc,
                                                        location_code,
                                                        location_meaning,
                                                        location_tag,
                                                        po_number,
                                                        contract_term,
                                                        prepay_months,
                                                        bill_all,
                                                        do_not_bill_before,
                                                        free_time,
                                                        ticket_num,
                                                        months_retro,
                                                        customer_num,
                                                        company_name,
                                                        address1,
                                                        address2,
                                                        city,
                                                        state,
                                                        country,
                                                        postal_code,
                                                        billing_contact,
                                                        phone_no,
                                                        fax_no,
                                                        email,
                                                        tax_exemption_no,
                                                        tax_code,
                                                        receipt_method_id,
                                                        receipt_method_name,
                                                        cc_number,
                                                        cc_expiration_date,
                                                        cc_name_on_card,
                                                        ncc_account_name,
                                                        ncc_account_number,
                                                        ncc_routing_number,
                                                        org_id,
                                                        party_id,
                                                        party_site_id,
                                                        cust_account_id,
                                                        cust_acct_site_id,
                                                        location_id,
                                                        site_use_id,
                                                        contract_party_id,
                                                        primary_salesperson_name,
                                                        primary_salesperson_snid,
                                                        person_snid,
                                                        psp_percent_split,
                                                        account_manager_name,
                                                        processor_notes,
                                                        locked_flag,
                                                        locked_by,
                                                        locked_by_name,
                                                        opportunity_num,
                                                        currency_code,
                                                        eva_value,
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
                                                        creation_date,
                                                        created_by,
                                                        created_by_username,
                                                        last_updated_by,
                                                        last_updated_by_username,
                                                        last_update_login,
                                                        last_update_date,
                                                        billed_date,
                                                        service_name,
                                                        service_id )
AS
  SELECT con.ROWID,
         con.contract_snid,
         con.parent_contract_snid,
         con.bank_account_uses_id,
         xxrs_utility_pkg.get_cust_bank_dtls(cus.cust_account_id,cus.site_use_id,cus.org_id,'ACCOUNT_NAME') bank_account_name,
         con.contract_type_code,
         ct_lookup.meaning contract_type_meaning,
         ct_lookup.tag contract_type_tag,
         con.contract_status_code,
         cs_lookup.meaning contract_status_meaning,
         cs_lookup.tag contract_status_tag,
         con.date_received,
         con.date_completed,
         con.end_date,
         con.effective_date,
         con.support_team,
         vsv.description support_team_desc,
         con.location_code,
         lo_lookup.meaning,
         lo_lookup.tag,
         con.po_number,
         con.contract_term,
         con.prepay_months,
         con.bill_all,
         con.do_not_bill_before,
         con.free_time,
         con.ticket_num,
         con.months_retro,
         hca.account_number customer_num,
         hp.party_name company_name,
         cus.address1,
         cus.address2,
         cus.city,
         cus.state,
         cus.country,
         cus.postal_code,
         cus.billing_contact,
         cus.phone_no,
         cus.fax_no,
         cus.email,
         con.tax_exemption_no,
         cus.tax_code,
         con.receipt_method_id,
         rm.name, -- If con.BANK_ACCOUNT_USES_ID is null, get bank account information for primary payment method for site from cus.
         DECODE(con.bank_account_uses_id,
                NULL,
               xxrs_utility_pkg.get_cust_site_bank_dtls(cus.cust_account_id,cus.site_use_id,cus.org_id,'CREDITCARD','ACCOUNT_NUMBER'),
               xxrs_utility_pkg.get_ins_bank_dtls(con.bank_account_uses_id,'CREDITCARD','ACCOUNT_NUMBER')) 
         cc_number,
         DECODE(con.bank_account_uses_id,
                NULL,
                xxrs_utility_pkg.get_cust_site_bank_dtls(cus.cust_account_id,cus.site_use_id,cus.org_id,'CREDITCARD','EXPIRATION_DATE'),
                xxrs_utility_pkg.get_ins_bank_dtls(con.bank_account_uses_id,'CREDITCARD','EXPIRATION_DATE'))  
         cc_expiration_date,
         DECODE(con.bank_account_uses_id,
                NULL,
                xxrs_utility_pkg.get_cust_site_bank_dtls(cus.cust_account_id,cus.site_use_id,cus.org_id,'CREDITCARD','ACCOUNT_NAME'),
                xxrs_utility_pkg.get_ins_bank_dtls(con.bank_account_uses_id,'CREDITCARD','ACCOUNT_NAME')) 
         cc_name_on_card,
         DECODE(con.bank_account_uses_id,
                NULL,
                xxrs_utility_pkg.get_cust_site_bank_dtls(cus.cust_account_id,cus.site_use_id,cus.org_id,'BANKACCOUNT','ACCOUNT_NAME'),
                xxrs_utility_pkg.get_ins_bank_dtls(con.bank_account_uses_id,'BANKACCOUNT','ACCOUNT_NAME')) 
         ncc_account_name,
         DECODE(con.bank_account_uses_id,
                NULL,
               xxrs_utility_pkg.get_cust_site_bank_dtls(cus.cust_account_id,cus.site_use_id,cus.org_id,'BANKACCOUNT','ACCOUNT_NUMBER'),
               xxrs_utility_pkg.get_ins_bank_dtls(con.bank_account_uses_id,'BANKACCOUNT','ACCOUNT_NUMBER')) 
         ncc_account_number,
         DECODE(con.bank_account_uses_id,
                NULL,
               xxrs_utility_pkg.get_cust_site_bank_dtls(cus.cust_account_id,cus.site_use_id,cus.org_id,'BANKACCOUNT','ROUTING_NUMBER'),
               xxrs_utility_pkg.get_ins_bank_dtls(con.bank_account_uses_id,'BANKACCOUNT','ROUTING_NUMBER')) 
         ncc_routing_number,
         con.org_id,
         hca.party_id,
         cus.party_site_id,
         con.cust_account_id,
         con.cust_acct_site_id,
         cus.location_id,
         cus.site_use_id,
         cus.contract_party_id,
         sp.full_name,
         sp.sales_person_snid,
         sp.person_snid,
         sp.percent_split,
         con.account_manager_name,
         con.processor_notes,
         con.locked_flag,
         con.locked_by,
         usr_lock.user_name,
         con.opportunity_num,
         cus.currency_code,
         eva_value,
         con.attribute_category,
         con.attribute1,
         con.attribute2,
         con.attribute3,
         con.attribute4,
         con.attribute5,
         con.attribute6,
         con.attribute7,
         con.attribute8,
         con.attribute9,
         con.attribute10,
         con.attribute11,
         con.attribute12,
         con.attribute13,
         con.attribute14,
         con.attribute15,
         con.creation_date,
         con.created_by,
         usr_cb.user_name,
         con.last_updated_by,
         usr.user_name,
         con.last_update_login,
         con.last_update_date,
         con.billed_date,
         ( SELECT name
             FROM xxrs.xxrs_sc_service_def
            WHERE service_id = con.service_id )                                                                                     -- LY 110223-01761
                                               ,
         con.service_id                                                                                                             -- LY 110223-01761
    FROM xxrs_sc_contract_tbl con,
         xxrs_sc_cust_bil2_sites_org_vw cus,
         (  SELECT sp1.contract_snid,
                   ppf.full_name,
                   sp1.sales_person_snid,
                   sp1.person_snid,
                   sp1.percent_split
              FROM xxrs_sc_sales_person_tbl sp1           --#090428-03374 - Removed the use of xxrs_sc_sales_person_vw since it validates against HRMS
                                               , xxrs.xxrs_sc_person_tbl per, hr.per_all_people_f ppf
             WHERE sp1.primary_sales_person_flag = 'T'
               AND sp1.person_snid = per.person_snid
               AND per.person_id = ppf.person_id
               AND ppf.effective_start_date = (SELECT MAX ( ppf_latest.effective_start_date )            --#090514-01622 to get the latest HRMS record
                                                 FROM hr.per_all_people_f ppf_latest
                                                WHERE ppf_latest.person_id = ppf.person_id)
          GROUP BY sp1.contract_snid, ppf.full_name, sp1.sales_person_snid, sp1.person_snid, sp1.percent_split) sp,
         applsys.fnd_user usr,
         applsys.fnd_user usr_lock,
         applsys.fnd_user usr_cb,
         xxrs_sc_lookup_vw ct_lookup,
         xxrs_sc_lookup_vw cs_lookup,
         xxrs_sc_lookup_vw lo_lookup,
         ar_receipt_methods rm,
         xxrs_sc_value_set_vw vsv,
         hz_cust_accounts hca,
         hz_parties hp
   WHERE con.cust_acct_site_id = cus.cust_acct_site_id(+)
     AND con.contract_snid = sp.contract_snid(+)
     AND con.last_updated_by = usr.user_id(+)
     AND con.locked_by = usr_lock.user_id(+)
     AND con.created_by = usr_cb.user_id
     AND con.support_team = vsv.flex_value(+)
     AND vsv.flex_value_set_name(+) = 'RS_AR_SUPPORT_TEAMS'
     AND con.contract_type_code = ct_lookup.lookup_code(+)
     AND ct_lookup.lookup_type(+) = 'RS_CONTRACT_TYPE'
     AND con.contract_status_code = cs_lookup.lookup_code(+)
     AND cs_lookup.lookup_type(+) = 'RS_CONTRACT_STATUS'
     AND con.location_code = lo_lookup.lookup_code(+)
     AND lo_lookup.lookup_type(+) = 'RS_LOCATION'
     AND rm.receipt_method_id(+) = con.receipt_method_id
     AND con.cust_account_id = hca.cust_account_id
     AND hca.party_id = hp.party_id
     AND NVL ( con.org_id,
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
                                     -99 );


AUDIT GRANT ON APPS.XXRS_SC_CONTRACT_VW BY SESSION WHENEVER SUCCESSFUL;
AUDIT GRANT ON APPS.XXRS_SC_CONTRACT_VW BY SESSION WHENEVER NOT SUCCESSFUL;