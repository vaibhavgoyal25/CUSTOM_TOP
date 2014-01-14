/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_AR_PRINT_GROUP_MIG_121211-08804.sql                                                                     *
*                                                                                                                     *
* DESCRIPTION :                                                                                                       *
* Script to migrate print Groups                                                                                      *
*                                                                                                                     *
* AUTHOR       : Pavan Amirineni                                                                                      *
* DATE WRITTEN : 19-DEC-2012                                                                                          *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* SR#          |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                                     *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  121211-08804     | Pavan Amirineni |  19-DEC-2012   | UK Print Group Migration Script               *
***********************************************************************************************************************/
/* $Header: XXRS_AR_PRINT_GROUP_MIG_121211-08804.sql 1.0.0 19-DEC-2012 01:39:56 PM Pavan Amirineni $ */
SET SERVEROUTPUT ON
col file_name   new_value   spool_file_name    noprint
SELECT 'XXRS_AR_PRINT_GROUP_MIG_121211-08804_' ||TO_CHAR (SYSDATE, '_mmddyy_hhmiss')||'.log' file_name from dual ;
SPOOL &spool_file_name
DECLARE
  l_rec_count NUMBER :=0; 
CURSOR cur_mig_print_group
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
            WHEN hcasa.org_id = 126 THEN 
              CASE 
                WHEN (NVL(hl.country,'XX') = 'GB') THEN                        
                  DECODE(hcasa.attribute6,'Domestic','UK/UK Domestic','ROW - Rest of World','UK/UK ROW','Europe','UK/UK Europe','India','UK/UK ROW','Do not print','Do Not Print-UK/UK Domestic',hcasa.attribute6)
                WHEN (NVL(hl.country,'XX') != 'GB') THEN  -- business need to update non UK DO not print customers
                  DECODE(hcasa.attribute6,'Domestic','UK/UK Domestic','ROW - Rest of World','UK/UK ROW','Europe','UK/UK Europe','India','UK/UK ROW',hcasa.attribute6)
              ELSE
                 hcasa.attribute6                    
              END
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
      AND hcasa.attribute6 IN ('Domestic','ROW - Rest of World','Europe','India','Partner Program','Do not print')
      AND hcasa.org_id = 126      
    ORDER BY hcasa.org_id;
BEGIN  
--   
   EXECUTE IMMEDIATE 'DROP TABLE XXRS.XXRS_HCASA_127_BKP' ;
   EXECUTE IMMEDIATE 'DROP TABLE XXRS.XXRS_HCASA_420_BKP';
   EXECUTE IMMEDIATE 'DROP TABLE XXRS.XXRS_HCASA_559_BKP';
--   
   EXECUTE IMMEDIATE  'CREATE TABLE XXRS.XXRS_HCASA_BKP AS SELECT * FROM HZ_CUST_ACCT_SITES_ALL';
--          
  FOR rec_mig_print_group IN cur_mig_print_group
  LOOP    
    UPDATE ar.hz_cust_acct_sites_all hcasa
       SET hcasa.attribute6 = rec_mig_print_group.new_print_group
         , last_update_date = SYSDATE
         , last_updated_by  = 0
     WHERE hcasa.cust_acct_site_id = rec_mig_print_group.cust_acct_site_id;
     l_rec_count := l_rec_count +1;   
  END LOOP;
  dbms_output.put_line ('Updated '||l_rec_count ||' records.');
  COMMIT;  
 EXCEPTION WHEN OTHERS THEN 
   dbms_output.put_line ('Unexpected Error : '||SQLERRM);
END;
/