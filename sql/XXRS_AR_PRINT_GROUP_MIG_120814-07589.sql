/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_AR_PRINT_GROUP_MIG_120814-07589.sql                                                                     *
*                                                                                                                     *
* DESCRIPTION :                                                                                                       *
* Script to migrate print Groups                                                                                      *
*                                                                                                                     *
* AUTHOR       : Vaibhav Goyal                                                                                        *
* DATE WRITTEN : 04-OCT-2012                                                                                          *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* SR#          |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                                     *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  120814-07589     | Vaibhav Goyal   |  04-OCT-2012   | Print Group Migration Script                  *
***********************************************************************************************************************/
/* $Header: XXRS_AR_PRINT_GROUP_MIG_120814-07589.sql 1.0.0 04-OCT-2012 01:39:56 PM Vaibhav Goyal $ */
PROMPT "When prompted for org_id, enter one of these values"
PROMPT "US => 127 , UK => 126 NL => 420 , HK => 559"
/
SET SERVEROUTPUT ON
DECLARE
  l_rec_count NUMBER :=0; 
  P_ORG_ID NUMBER; 
CURSOR cur_mig_print_group( l_org_id IN NUMBER)
IS 
  SELECT haou.name "ORG_NAME",
         hca.account_number "CUSTOMER_NUM",
         hcasa.cust_acct_site_id,
         hp.party_name "COMPANY_NAME",
         hps.party_site_number "SITE_NUMBER",             
         hl.address1 "ADDRESS1",
         hl.address2 "ADDRESS2",
         hl.city "CITY",
         hl.state "STATE",
         hl.country "COUNTRY",
         hl.postal_code "POSTAL_CODE",
         hcasa.attribute6 "PRINT_GROUP",
         (CASE 
            WHEN hcasa.org_id = 127 THEN
              CASE 
                WHEN (NVL(hl.country,'XX') = 'US') THEN                             
                  DECODE(hcasa.attribute6,'Domestic','US/US Domestic','Europe','US/CH ROW','ROW - Rest of World','US/CH ROW','India','US/CH India','Partner Program','US/US Partner Group - Domestic',hcasa.attribute6)
                WHEN (NVL(hl.country,'XX') != 'US') THEN 
                  DECODE(hcasa.attribute6,'Domestic','US/US Domestic','Europe','US/CH ROW','ROW - Rest of World','US/CH ROW','India','US/CH India','Partner Program','US/US Partner Group - ROW',hcasa.attribute6)
               END
            WHEN hcasa.org_id = 126 THEN
              DECODE(hcasa.attribute6,'Domestic','UK/CH Domestic','ROW - Rest of World','UK/CH ROW','Europe','UK/CH Europe','India','UK/CH ROW',hcasa.attribute6)
            WHEN hcasa.org_id = 420 THEN          
              DECODE(hcasa.attribute6,'Domestic','NL/CH Domestic','ROW - Rest of World','NL/CH ROW','Europe','NL/CH Europe',hcasa.attribute6)
            WHEN hcasa.org_id = 559 THEN 
              DECODE(hcasa.attribute6,'Domestic','HK/CH Domestic','ROW - Rest of World','HK/CH ROW','Europe','HK/CH Europe',hcasa.attribute6)
            ELSE
              hcasa.attribute6
           END 
           ) "NEW_PRINT_GROUP"                                                                                
     FROM ar.hz_cust_accounts hca,
          ar.hz_parties hp,
          ar.hz_party_sites hps,
          ar.hz_locations hl,
          ar.hz_cust_acct_sites_all hcasa,
          hr.hr_all_organization_units haou          
    WHERE 1 = 1
      AND hp.party_id = hca.party_id
      AND hps.party_id = hca.party_id
      AND hl.location_id = hps.location_id
      AND hcasa.party_site_id = hps.party_site_id
      AND hcasa.cust_account_id = hca.cust_account_id
      AND haou.organization_id = hcasa.org_id
      AND hcasa.attribute6 IN ('Domestic','ROW - Rest of World','Europe','India','Partner Program')
      AND hcasa.org_id = l_org_id
    ORDER BY hcasa.org_id;   
BEGIN  
   P_ORG_ID := &ORG_ID; 
--   
   IF P_ORG_ID = 127 THEN      
     EXECUTE IMMEDIATE  'CREATE TABLE XXRS.XXRS_HCASA_127_BKP AS SELECT * FROM HZ_CUST_ACCT_SITES_ALL WHERE ORG_ID = 127';   
   ELSIF P_ORG_ID = 126 THEN 
     EXECUTE IMMEDIATE  'CREATE TABLE XXRS.XXRS_HCASA_126_BKP AS SELECT * FROM HZ_CUST_ACCT_SITES_ALL WHERE ORG_ID = 126';
   ELSIF P_ORG_ID = 420 THEN 
     EXECUTE IMMEDIATE  'CREATE TABLE XXRS.XXRS_HCASA_420_BKP AS SELECT * FROM HZ_CUST_ACCT_SITES_ALL WHERE ORG_ID = 420';
   ELSIF P_ORG_ID = 559 THEN 
     EXECUTE IMMEDIATE  'CREATE TABLE XXRS.XXRS_HCASA_559_BKP AS SELECT * FROM HZ_CUST_ACCT_SITES_ALL WHERE ORG_ID = 559';          
   END IF; 
--          
  FOR rec_mig_print_group IN cur_mig_print_group(P_ORG_ID)
  LOOP    
    UPDATE ar.hz_cust_acct_sites_all hcasa
       SET hcasa.attribute6 = rec_mig_print_group.new_print_group
         , last_update_date = SYSDATE
         , last_updated_by  = 0
     WHERE hcasa.cust_acct_site_id = rec_mig_print_group.cust_acct_site_id;
     l_rec_count := l_rec_count +1;   
  END LOOP;
  dbms_output.put_line ('Updated '||l_rec_count ||' records.');
--  COMMIT;  
END;
/