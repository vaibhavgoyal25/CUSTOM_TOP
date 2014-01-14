GRANT
  /*********************************************************************************************************
  *                                                                                                        *
  * NAME : XXRS_WS_AR_PAPERLESS_GRANT2.sql                                                                 *
  *                                                                                                        *
  * DESCRIPTION :                                                                                          *
  * Script to Provide Grant on Package to report Paperless Contact Details.                                *
  *                                                                                                        *
  * AUTHOR       : VAIBHAV GOYAL                                                                           *
  * DATE WRITTEN : 24-JAN-2012                                                                             *
  *                                                                                                        *
  * CHANGE CONTROL :                                                                                       *
  * VERSION#     |  RACKER TICKET #  | WHO             |  DATE          |   REMARKS                        *
  *--------------------------------------------------------------------------------------------------------*
  * 1.0.0        |  111122-02448     | VAIBHAV GOYAL   | 01/24/2012     | initial creation                 *
  **********************************************************************************************************/
  /* $Header: XXRS_WS_AR_PAPERLESS_GRANT2.sql 1.0.0 01/24/2012 10:00:00 AM Vaibhav Goyal $ */
EXECUTE ON apps.XXRS_WS_AR_PAPERLESS_PKG to xxrscore;
GRANT EXECUTE ON apps.HZ_PARTY_CONTACT_V2PUB to xxrscore;
GRANT EXECUTE ON apps.hz_cust_account_role_v2pub to xxrscore;
GRANT EXECUTE ON apps.hz_contact_point_v2pub to xxrscore;

GRANT SELECT ON ar.hz_contact_points to xxrscore;
GRANT SELECT ON ar.hz_cust_account_roles to xxrscore;
GRANT SELECT ON ar.hz_parties to xxrscore;
GRANT SELECT ON ar.hz_relationships to xxrscore;
GRANT SELECT ON ar.hz_org_contacts to xxrscore;
GRANT SELECT ON ar.hz_cust_accounts to xxrscore;
GRANT SELECT ON ar.hz_contact_restrictions to xxrscore;
GRANT SELECT ON ar.hz_person_language to xxrscore;
GRANT SELECT ON ar.hz_role_responsibility to xxrscore;
GRANT SELECT ON applsys.fnd_lookup_values to xxrscore;
GRANT SELECT ON applsys.fnd_user to xxrscore;
GRANT SELECT ON apps.fnd_lookup_values_vl to xxrscore;
GRANT SELECT ON applsys.fnd_responsibility to xxrscore;