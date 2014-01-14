SELECT 
  /******************************************************************************************************************
  *                                                                                                                 *
  * NAME : XXRS_CUSTOMER_LISTING.sql                                                                                *
  *                                                                                                                 *
  * DESCRIPTION : Query For Rackspace Customer Listing Discoverer Report.                                           *
  *                                                                                                                 *
  * AUTHOR       : Mahesh Guddeti                                                                                   *
  * DATE WRITTEN : 07-JUN-2013                                                                                      *
  *                                                                                                                 *
  * CHANGE CONTROL :                                                                                                *
  * Version#| REF#        | WHO            | DATE         | REMARKS                                                 *
  *-----------------------------------------------------------------------------------------------------------------*
  * 1.0.0   | 130514-01752| Mahesh Guddeti | 07-JUN-2013  | Added Column to Display Customer Site Strategy Segment  * 
  *******************************************************************************************************************/
  /* $HEADER: XXRS_CUSTOMER_LISTING.sql Discoverer Report 1.0.0 07-JUN-2013 9:25:00 AM Mahesh $ */
       haou.name ou_name
     , hca.account_number customer_number
     , hp.party_name customer_name
     , hl.address1 address1
     , hl.address2 address2
     , hl.address3 address3
     , hl.address4 address4
     , hl.city city
     , NVL(hl.state,hl.province) state
     , hl.postal_code postal_code
     , hl.country country_code
     , ftv.territory_short_name country
     , hcsua.primary_flag primary
     , hcsua.tax_reference tax_registration_number
     , DECODE(exemptions.customer_id,
         NULL,'N',
         'Y'
       ) exempted
     , hcpc.name profile_name
     , hcasa.attribute6 print_group 
     , hcasa.attribute5 Strategy_Segment --130514-01752
  FROM ar.hz_cust_accounts hca
     , ar.hz_parties hp
     , ar.hz_cust_acct_sites_all hcasa
     , ar.hz_party_sites hps
     , ar.hz_locations hl
     , ar.hz_cust_site_uses_all hcsua
     , apps.fnd_territories_vl ftv
     , (SELECT DISTINCT rtea.org_id org_id,
                        rtea.customer_id customer_id
          FROM ar.ra_tax_exemptions_all rtea
         WHERE SYSDATE BETWEEN NVL(rtea.start_date,SYSDATE) AND NVL(rtea.end_date,SYSDATE)
       ) exemptions
     , ar.hz_cust_profile_classes hcpc
     , ar.hz_customer_profiles hcp
     , apps.hr_all_organization_units haou
 WHERE hp.party_id = hca.party_id
   AND hcasa.cust_account_id = hca.cust_account_id
   AND hcasa.status = 'A'
   AND hps.party_id = hca.party_id
   AND hps.party_site_id = hcasa.party_site_id
   AND hps.status = 'A'
   AND hl.location_id = hps.location_id
   AND hcsua.cust_acct_site_id = hcasa.cust_acct_site_id
   AND hcsua.org_id = hcasa.org_id
   AND hcsua.status = 'A'
   AND ftv.territory_code = hl.country
   AND exemptions.customer_id(+) = hcasa.cust_account_id
   AND exemptions.org_id(+) = hcasa.org_id
   AND hcp.party_id = hca.party_id
   AND hcp.cust_account_id = hca.cust_account_id
   AND ((hcp.site_use_id IS NOT NULL
         AND hcp.site_use_id = hcsua.site_use_id
        )
        OR (hcp.site_use_id IS NULL
            AND (NOT EXISTS (SELECT 'c'
                               FROM ar.hz_customer_profiles hcp_sel
                              WHERE hcp_sel.party_id = hcp.party_id
                                AND hcp_sel.cust_account_id = hcp.cust_account_id
                                AND hcp_sel.site_use_id IS NOT NULL
                                AND hcp_sel.site_use_id = hcsua.site_use_id
                            )
                )
           )
       )
   AND hcpc.profile_class_id = hcp.profile_class_id
   AND haou.organization_id = hcasa.org_id
   AND haou.type = 'OU'
