DROP VIEW APPS.XXRS_SC_CUST_BILL_TO_SITES_VW;

 /************************************************************************************************************
  *                                                                                                          *
  * NAME : XXRS_SC_CUST_BILL_TO_SITES_VW.sql                                                                 *
  *                                                                                                          *
  * DESCRIPTION : Script to create Rackspace Customer Bill to Site View                                      *
  *                                                                                                          *
  * AUTHOR       : Vaibhav Goyal                                                                             *
  * DATE WRITTEN : 04-MAR-2012                                                                               *
  *                                                                                                          *
  * CHANGE CONTROL :                                                                                         *
  * Version#     | REF#             | WHO                | DATE              | REMARKS                       *
  *--------------------------------------------------------------------------------------------------------  *
  * 1.0.0        | 111122-02448     | Vaibhav Goyal      | 04-MAR-2012       | Initial Build for R12 upgrade *
  ************************************************************************************************************/
  /* $HEADER: XXRS_SC_CUST_BILL_TO_SITES_VW.sql 1.0.0 04-MAR-2012 12:00:00 PM Vaibhav Goyal $ */
CREATE OR REPLACE FORCE VIEW apps.xxrs_sc_cust_bill_to_sites_vw ( site_status,
                                                                  site_primary_flag,
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
                                                                  currency_code,
                                                                  support_team_acct_seg,
                                                                  support_team,
                                                                  account_manager,
                                                                  business_unit_acct_seg,
                                                                  business_unit,
                                                                  payment_method,
                                                                  receipt_method_id,
                                                                  acct_term_name,
                                                                  site_term_name,
                                                                  account_type,
                                                                  bank_name,
                                                                  bank_account_uses_id,
                                                                  cc_or_ncc_acct_name,
                                                                  cc_or_ncc_acct_number,
                                                                  cc_expiration_date,
                                                                  ncc_routing_number,
                                                                  cust_type,
                                                                  org_id,
                                                                  party_id,
                                                                  party_site_number,
                                                                  party_site_id,
                                                                  cust_account_id,
                                                                  location_id,
                                                                  cust_acct_site_id,
                                                                  site_use_id,
                                                                  cust_account_profile_id,
                                                                  contract_party_id,
                                                                  gl_id_rec,
                                                                  gl_id_rev,
                                                                  gl_id_tax,
                                                                  gl_id_freight,
                                                                  gl_id_clearing,
                                                                  gl_id_unbilled,
                                                                  gl_id_unearned,
                                                                  gl_id_unpaid_rec,
                                                                  gl_id_remittance,
                                                                  gl_id_factor )
AS
  SELECT hcsua.status "SITE_STATUS",
         hcsua.primary_flag "SITE_PRIMARY_FLAG",
         hca.account_number "CUSTOMER_NUM",
         hp.party_name "COMPANY_NAME",
         hl.address1 "ADDRESS1",
         hl.address2 "ADDRESS2",
         hl.city "CITY",
         hl.state "STATE",
         hl.country "COUNTRY",
         hl.postal_code "POSTAL_CODE",
         ( SELECT SUBSTR ( hp1.party_name,
                           1,
                           ( INSTR ( hp1.party_name,
                           '-' ) ) - 1 )
             FROM ar.hz_parties hp1
            WHERE hp1.party_id =
                    ( SELECT hr.party_id
                        FROM ar.hz_relationships hr, ar.hz_cust_account_roles hcar, ar.hz_role_responsibility hrr
                       WHERE 1 = 1
                         AND hr.party_id = hp.party_id
                         AND hr.subject_type = 'ORGANIZATION'
                         AND hr.subject_table_name = 'HZ_PARTIES'
                         AND hr.status = 'A'
                         AND hcar.party_id = hr.party_id
                         AND hcar.cust_account_id = hca.cust_account_id
                         AND hcar.cust_acct_site_id = hcasa.cust_acct_site_id
                         AND hrr.cust_account_role_id = hcar.cust_account_role_id
                         AND hrr.responsibility_type = 'BILL_TO'
                         AND hrr.primary_flag = 'Y' )
              AND hp1.orig_system_reference = hp1.party_id
              AND hp1.party_type = 'PARTY_RELATIONSHIP' )
           "BILLING CONTACT",
         ( SELECT hp1.primary_phone_area_code || '-' || hp1.primary_phone_number
             FROM ar.hz_parties hp1
            WHERE hp1.party_id =
                    ( SELECT hr.party_id
                        FROM ar.hz_relationships hr, ar.hz_cust_account_roles hcar, ar.hz_role_responsibility hrr
                       WHERE 1 = 1
                         AND hr.party_id = hp.party_id
                         AND hr.subject_type = 'ORGANIZATION'
                         AND hr.subject_table_name = 'HZ_PARTIES'
                         AND hr.status = 'A'
                         AND hcar.party_id = hr.party_id
                         AND hcar.cust_account_id = hca.cust_account_id
                         AND hcar.cust_acct_site_id = hcasa.cust_acct_site_id
                         AND hrr.cust_account_role_id = hcar.cust_account_role_id
                         AND hrr.responsibility_type = 'BILL_TO'
                         AND hrr.primary_flag = 'Y' )
              AND hp1.orig_system_reference = hp1.party_id
              AND hp1.party_type = 'PARTY_RELATIONSHIP'
              AND hp1.primary_phone_line_type = 'GEN' )
           "PHONE NO",
         ( SELECT hcp.raw_phone_number
             FROM ar.hz_contact_points hcp
            WHERE hcp.owner_table_id =
                    ( SELECT hr.party_id
                        FROM ar.hz_relationships hr, ar.hz_cust_account_roles hcar, ar.hz_role_responsibility hrr
                       WHERE 1 = 1
                         AND hr.party_id = hp.party_id
                         AND hr.subject_type = 'ORGANIZATION'
                         AND hr.subject_table_name = 'HZ_PARTIES'
                         AND hr.status = 'A'
                         AND hcar.party_id = hr.party_id
                         AND hcar.cust_account_id = hca.cust_account_id
                         AND hcar.cust_acct_site_id = hcasa.cust_acct_site_id
                         AND hrr.cust_account_role_id = hcar.cust_account_role_id
                         AND hrr.responsibility_type = 'BILL_TO'
                         AND hrr.primary_flag = 'Y' )
              AND hcp.owner_table_name = 'HZ_PARTIES'
              AND hcp.status = 'A'
              AND hcp.contact_point_type = 'PHONE'
              AND hcp.phone_line_type = 'FAX' )
           "FAX NO",
         ( SELECT hp1.email_address
             FROM ar.hz_parties hp1
            WHERE hp1.party_id =
                    ( SELECT hr.party_id
                        FROM ar.hz_relationships hr, ar.hz_cust_account_roles hcar, ar.hz_role_responsibility hrr
                       WHERE 1 = 1
                         AND hr.party_id = hp.party_id
                         AND hr.subject_type = 'ORGANIZATION'
                         AND hr.subject_table_name = 'HZ_PARTIES'
                         AND hr.status = 'A'
                         AND hcar.party_id = hr.party_id
                         AND hcar.cust_account_id = hca.cust_account_id
                         AND hcar.cust_acct_site_id = hcasa.cust_acct_site_id
                         AND hrr.cust_account_role_id = hcar.cust_account_role_id
                         AND hrr.responsibility_type = 'BILL_TO'
                         AND hrr.primary_flag = 'Y' )
              AND hp1.orig_system_reference = hp1.party_id
              AND hp1.party_type = 'PARTY_RELATIONSHIP' )
           "EMAIL",
         hcsua.tax_reference "TAX EXEMPTION NO",
         hcsua.tax_code "TAX CODE",
         hcasa.attribute1 "CURRENCY CODE",
         hcasa.attribute2 "SUPPORT TEAM ACCT SEG",
         ( SELECT ffvt.description
             FROM applsys.fnd_flex_value_sets ffvs, applsys.fnd_flex_values ffv, applsys.fnd_flex_values_tl ffvt
            WHERE UPPER ( ffvs.flex_value_set_name ) = 'RS_AR_SUPPORT_TEAMS'
              AND ffv.flex_value_set_id = ffvs.flex_value_set_id
              AND ffvt.flex_value_id = ffv.flex_value_id
              AND ffv.enabled_flag = 'Y'
              AND ffv.flex_value = hcasa.attribute2
              AND SYSDATE BETWEEN NVL ( ffv.start_date_active, SYSDATE ) AND NVL ( ffv.end_date_active, SYSDATE ) )
           "SUPPORT TEAM",
         hcasa.attribute3 "ACCOUNT MANAGER",
         hcasa.attribute4 "BUSINESS UNIT ACCT SEG",
         ( SELECT ffvt.description
             FROM applsys.fnd_flex_value_sets ffvs, applsys.fnd_flex_values ffv, applsys.fnd_flex_values_tl ffvt
            WHERE UPPER ( ffvs.flex_value_set_name ) = 'RS_AR_SEGMENTS'
              AND ffv.flex_value_set_id = ffvs.flex_value_set_id
              AND ffvt.flex_value_id = ffv.flex_value_id
              AND ffv.enabled_flag = 'Y'
              AND ffv.flex_value = hcasa.attribute4
              AND SYSDATE BETWEEN NVL ( ffv.start_date_active, SYSDATE ) AND NVL ( ffv.end_date_active, SYSDATE ) )
           "BUSINESS UNIT",
         ( SELECT arm.name
             FROM ar.ra_cust_receipt_methods rcrm, ar.ar_receipt_methods arm
            WHERE rcrm.customer_id = hca.cust_account_id
              AND rcrm.site_use_id = hcsua.site_use_id
              AND SYSDATE BETWEEN rcrm.start_date AND NVL ( rcrm.end_date, SYSDATE )
              AND rcrm.primary_flag = 'Y'
              AND SYSDATE BETWEEN arm.start_date AND NVL ( arm.end_date, SYSDATE )
              AND arm.receipt_method_id = rcrm.receipt_method_id )
           "PAYMENT METHOD",
         ( SELECT arm.receipt_method_id
             FROM ar.ra_cust_receipt_methods rcrm, ar.ar_receipt_methods arm
            WHERE rcrm.customer_id = hca.cust_account_id
              AND rcrm.site_use_id = hcsua.site_use_id
              AND SYSDATE BETWEEN rcrm.start_date AND NVL ( rcrm.end_date, SYSDATE )
              AND rcrm.primary_flag = 'Y'
              AND SYSDATE BETWEEN arm.start_date AND NVL ( arm.end_date, SYSDATE )
              AND arm.receipt_method_id = rcrm.receipt_method_id )
           "RECEIPT METHOD ID",
         ( SELECT rtt.name
             FROM ar.ra_terms_tl rtt, ar.hz_customer_profiles hzp
            WHERE hzp.cust_account_id = hca.cust_account_id
              AND ( hzp.site_use_id = 0 OR hzp.site_use_id IS NULL )
              AND rtt.term_id = hzp.standard_terms )
           "ACCT_TERM_NAME",
         ( SELECT rtt.name
             FROM ar.ra_terms_tl rtt, ar.hz_customer_profiles hzp
            WHERE hzp.cust_account_id = hca.cust_account_id AND hzp.site_use_id = hcsua.site_use_id AND rtt.term_id = hzp.standard_terms )
           "SITE_TERM_NAME",
         xxrs_utility_pkg.get_cust_bank_dtls(hca.cust_account_id,hcsua.site_use_id,hcsua.org_id,'ACCOUNT_TYPE'),
         xxrs_utility_pkg.get_cust_bank_dtls(hca.cust_account_id,hcsua.site_use_id,hcsua.org_id,'BANK_NAME'),
         xxrs_utility_pkg.get_cust_bank_dtls(hca.cust_account_id,hcsua.site_use_id,hcsua.org_id, 'INSTR_ASSIGNMENT_ID'),
         xxrs_utility_pkg.get_cust_bank_dtls(hca.cust_account_id,hcsua.site_use_id,hcsua.org_id,'ACCOUNT_NAME'),
         xxrs_utility_pkg.get_cust_bank_dtls(hca.cust_account_id,hcsua.site_use_id,hcsua.org_id,'ACCOUNT_NUMBER'),
         xxrs_utility_pkg.get_cust_bank_dtls(hca.cust_account_id,hcsua.site_use_id,hcsua.org_id,'EXPIRATION_DATE'),
         xxrs_utility_pkg.get_cust_bank_dtls(hca.cust_account_id,hcsua.site_use_id,hcsua.org_id,'ROUTING_NUMBER'),
         ( SELECT flv.meaning
             FROM applsys.fnd_lookup_values flv
            WHERE flv.language = USERENV ( 'LANG' )
              AND flv.view_application_id = 222
              AND flv.security_group_id = 0
              AND flv.lookup_type = 'CUSTOMER_CATEGORY'
              AND flv.lookup_code = hp.category_code )
           "CUST TYPE",
         hcasa.org_id,
         hca.party_id,
         hps.party_site_number,
         hps.party_site_id,
         hca.cust_account_id,
         hl.location_id,
         hcasa.cust_acct_site_id,
         hcsua.site_use_id,
         ( SELECT hzp.cust_account_profile_id
             FROM ar.hz_customer_profiles hzp
            WHERE hzp.cust_account_id = hca.cust_account_id AND hzp.site_use_id = hcsua.site_use_id )
           "CUST ACCOUNT PROFILE ID",
         ( SELECT hr.party_id
             FROM ar.hz_relationships hr, ar.hz_cust_account_roles hcar, ar.hz_role_responsibility hrr
            WHERE 1 = 1
              AND hr.party_id = hp.party_id
              AND hr.subject_type = 'ORGANIZATION'
              AND hr.subject_table_name = 'HZ_PARTIES'
              AND hr.status = 'A'
              AND hcar.party_id = hr.party_id
              AND hcar.cust_account_id = hca.cust_account_id
              AND hcar.cust_acct_site_id = hcasa.cust_acct_site_id
              AND hrr.cust_account_role_id = hcar.cust_account_role_id
              AND hrr.responsibility_type = 'BILL_TO'
              AND hrr.primary_flag = 'Y' )
           "CONTRACT PARTY ID",
         hcsua.gl_id_rec,
         hcsua.gl_id_rev,
         hcsua.gl_id_tax,
         hcsua.gl_id_freight,
         hcsua.gl_id_clearing,
         hcsua.gl_id_unbilled,
         hcsua.gl_id_unearned,
         hcsua.gl_id_unpaid_rec,
         hcsua.gl_id_remittance,
         hcsua.gl_id_factor
    FROM ar.hz_cust_accounts hca,
         ar.hz_parties hp,
         ar.hz_party_sites hps,
         ar.hz_locations hl,
         ar.hz_cust_acct_sites_all hcasa,
         ar.hz_cust_site_uses_all hcsua
   WHERE 1 = 1
     AND hp.party_id = hca.party_id
     AND hps.party_id = hca.party_id
     AND hl.location_id = hps.location_id
     AND hcasa.party_site_id = hps.party_site_id
     AND hcasa.cust_account_id = hca.cust_account_id
     AND hcsua.cust_acct_site_id = hcasa.cust_acct_site_id
     AND hcsua.site_use_code = 'BILL_TO'
     AND hcsua.status = 'A';


AUDIT GRANT ON APPS.XXRS_SC_CUST_BILL_TO_SITES_VW BY SESSION WHENEVER SUCCESSFUL;
AUDIT GRANT ON APPS.XXRS_SC_CUST_BILL_TO_SITES_VW BY SESSION WHENEVER NOT SUCCESSFUL;

GRANT SELECT ON APPS.XXRS_SC_CUST_BILL_TO_SITES_VW TO XXRS_DW_QUERY;
