/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_AR_CUST_SITE_DETAILS_VW.sql                                                                             *
*                                                                                                                     *
* DESCRIPTION : View to support billing engine, this view replaces XXRS_SC_CUST_BILL_TO_SITES_VW                      *
*                                                                                                                     *
* AUTHOR       : Pavan Amirineni                                                                                      *
* DATE WRITTEN : 02/15/2012                                                                                           *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* Version# | Ticket #      | WHO             |  DATE      |   REMARKS                                                 *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0    | 111122-02448  | Pavan Amirineni | 02/15/2012 | Initial Creation                                          *
**********************************************************************************************************************/  
/* $Header: XXRS_AR_CUST_SITE_DETAILS_VW.sql 1.0.0 02/15/2012 03:00:00 PM Pavan Amirineni $ */
CREATE OR REPLACE FORCE VIEW apps.xxrs_ar_cust_site_details_vw
(
  site_status
,  site_primary_flag
,  customer_num
,  company_name
,  address1
,  address2
,  city
,  state
,  country
,  postal_code
,  tax_exemption_no
,  tax_code
,  currency_code
,  support_team_acct_seg
,  support_team
,  account_manager
,  business_unit_acct_seg
,  business_unit
,  org_id
,  party_id
,  party_site_number
,  party_site_id
,  cust_account_id
,  location_id
,  cust_acct_site_id
,  site_use_id
,  gl_id_rec
,  gl_id_rev
,  gl_id_tax
,  gl_id_freight
,  gl_id_clearing
,  gl_id_unbilled
,  gl_id_unearned
,  gl_id_unpaid_rec
,  gl_id_remittance
,  gl_id_factor
)
AS
  SELECT hcsua.status "SITE_STATUS"
       ,  hcsua.primary_flag "SITE_PRIMARY_FLAG"
       ,  hca.account_number "CUSTOMER_NUM"
       ,  hp.party_name "COMPANY_NAME"
       ,  hl.address1 "ADDRESS1"
       ,  hl.address2 "ADDRESS2"
       ,  hl.city "CITY"
       ,  hl.state "STATE"
       ,  hl.country "COUNTRY"
       ,  hl.postal_code "POSTAL_CODE"
       ,  hcsua.tax_reference "TAX EXEMPTION NO"
       ,  hcsua.tax_code "TAX CODE"
       ,  hcasa.attribute1 "CURRENCY CODE"
       ,  hcasa.attribute2 "SUPPORT TEAM ACCT SEG"
       ,  ( SELECT ffvt.description
              FROM applsys.fnd_flex_value_sets ffvs
                 ,  applsys.fnd_flex_values ffv
                 ,  applsys.fnd_flex_values_tl ffvt
             WHERE UPPER ( ffvs.flex_value_set_name ) = 'RS_AR_SUPPORT_TEAMS'
               AND ffv.flex_value_set_id = ffvs.flex_value_set_id
               AND ffvt.flex_value_id = ffv.flex_value_id
               AND ffv.enabled_flag = 'Y'
               AND ffv.flex_value = hcasa.attribute2
               AND SYSDATE BETWEEN NVL ( ffv.start_date_active, SYSDATE )
                               AND NVL ( ffv.end_date_active, SYSDATE ) )
            "SUPPORT TEAM"
       ,  hcasa.attribute3 "ACCOUNT MANAGER"
       ,  hcasa.attribute4 "BUSINESS UNIT ACCT SEG"
       ,  ( SELECT ffvt.description
              FROM applsys.fnd_flex_value_sets ffvs
                 ,  applsys.fnd_flex_values ffv
                 ,  applsys.fnd_flex_values_tl ffvt
             WHERE UPPER ( ffvs.flex_value_set_name ) = 'RS_AR_SEGMENTS'
               AND ffv.flex_value_set_id = ffvs.flex_value_set_id
               AND ffvt.flex_value_id = ffv.flex_value_id
               AND ffv.enabled_flag = 'Y'
               AND ffv.flex_value = hcasa.attribute4
               AND SYSDATE BETWEEN NVL ( ffv.start_date_active, SYSDATE )
                               AND NVL ( ffv.end_date_active, SYSDATE ) )
            "BUSINESS UNIT"
       ,  hcasa.org_id
       ,  hca.party_id
       ,  hps.party_site_number
       ,  hps.party_site_id
       ,  hca.cust_account_id
       ,  hl.location_id
       ,  hcasa.cust_acct_site_id
       ,  hcsua.site_use_id
       ,  hcsua.gl_id_rec
       ,  hcsua.gl_id_rev
       ,  hcsua.gl_id_tax
       ,  hcsua.gl_id_freight
       ,  hcsua.gl_id_clearing
       ,  hcsua.gl_id_unbilled
       ,  hcsua.gl_id_unearned
       ,  hcsua.gl_id_unpaid_rec
       ,  hcsua.gl_id_remittance
       ,  hcsua.gl_id_factor
    FROM ar.hz_cust_accounts hca
       ,  ar.hz_parties hp
       ,  ar.hz_party_sites hps
       ,  ar.hz_locations hl
       ,  ar.hz_cust_acct_sites_all hcasa
       ,  ar.hz_cust_site_uses_all hcsua
   WHERE 1 = 1
     AND hp.party_id = hca.party_id
     AND hps.party_id = hca.party_id
     AND hl.location_id = hps.location_id
     AND hcasa.party_site_id = hps.party_site_id
     AND hcasa.cust_account_id = hca.cust_account_id
     AND hcsua.cust_acct_site_id = hcasa.cust_acct_site_id
     AND hcsua.site_use_code = 'BILL_TO'
     AND hcsua.status = 'A';
/