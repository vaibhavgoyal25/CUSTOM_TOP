/**************************************************************************************************
* NAME : XXRS_AR_CHECK_PM_PRIMARY_FLAG_120425-06439.sql                                           *
* DESCRIPTION :                                                                                   *
* AR Payment method conversion to check                                                           *
*                                                                                                 *
* AUTHOR       : Pavan Amirineni                                                                  *
* DATE WRITTEN : 24-APR-2012                                                                      *
*                                                                                                 *
* CHANGE CONTROL :                                                                                *
* Version# | Ticket #     |  WHO            | DATE       |   REMARKS                              *
*-------------------------------------------------------------------------------------------------*
* 1.0.0    | 120425-06439 | Pavan Amirineni | 24-APR-2012 | Initial Creation                      *
***************************************************************************************************/
--  /* $Header: XXRS_AR_CHECK_PM_PRIMARY_FLAG_120425-06439.sql 1.0.0 24-APR-2012 10:54:39 AM Pavan AMirineni $ */
SET SERVEROUTPUT ON SIZE 1000000;
SET LINESIZE 2000
SET PAGESIZE 2000
col file_name   new_value   spool_file_name    noprint
select 'XXRS_AR_CHECK_PM_PRIMARY_FLAG_120425-06439' ||to_char (sysdate, '_mmddyy_hhmiss')||'.log' file_name from dual ;
spool &spool_file_name      
EXEC MO_global.set_policy_context('S',127);
      
PROMPT SQL1: Failed records from interface 

      SELECT hca.account_number            
            ,hps.party_site_number                        
            ,hcsua.site_use_id
            ,racrm.cust_receipt_method_id  
            ,racrm.receipt_method_id
            ,racrm.primary_flag                    
            ,hca.orig_system_reference orig_system_customer_ref
            ,hcasa.orig_system_reference orig_system_address_ref            
        FROM apps.hz_cust_accounts hca
            ,apps.hz_cust_acct_sites hcasa
            ,apps.hz_party_sites hps
            ,apps.hz_cust_site_uses hcsua
            ,apps.ar_receipt_methods arm
            ,apps.ra_cust_receipt_methods racrm
            ,apps.ra_cust_pay_method_int_all int 
       WHERE hcasa.cust_account_id = hca.cust_account_id
         AND hps.party_site_id = hcasa.party_site_id
         AND hps.status = 'A'
         AND hcsua.cust_acct_site_id = hcasa.cust_acct_site_id
         AND racrm.customer_id = hca.cust_account_id
         AND racrm.site_use_id = hcsua.site_use_id
         AND arm.receipt_method_id = racrm.receipt_method_id
         AND int.orig_system_address_ref = hcasa.orig_system_reference 
         AND arm.name = 'CHECK'
         AND trunc(int.start_date) = trunc(sysdate)
         AND int.org_id = 127;
         
PROMPT SQL1: Updating Failed records          
         
UPDATE ra_cust_receipt_methods rcr
   SET primary_flag = 'Y'
     , last_update_date = SYSDATE
     , last_updated_by = -1
     , last_update_login = -1
 WHERE rcr.cust_receipt_method_id IN (
      SELECT racrm.cust_receipt_method_id
        FROM apps.hz_cust_accounts hca
            ,apps.hz_cust_acct_sites hcasa
            ,apps.hz_party_sites hps
            ,apps.hz_cust_site_uses hcsua
            ,apps.ar_receipt_methods arm
            ,apps.ra_cust_receipt_methods racrm
            ,apps.ra_cust_pay_method_int_all int 
       WHERE hcasa.cust_account_id = hca.cust_account_id
         AND hps.party_site_id = hcasa.party_site_id
         AND hps.status = 'A'
         AND hcsua.cust_acct_site_id = hcasa.cust_acct_site_id
         AND racrm.customer_id = hca.cust_account_id
         AND racrm.site_use_id = hcsua.site_use_id
         AND arm.receipt_method_id = racrm.receipt_method_id
         AND int.orig_system_address_ref = hcasa.orig_system_reference 
         AND arm.name = 'CHECK'
         AND trunc(int.start_date) = trunc(sysdate)
         AND int.org_id = 127
         );

PROMPT SQL1: Deleting Failed records from interface             
               
DELETE 
  FROM apps.ra_cust_pay_method_int_all 
 WHERE trunc(start_date) = trunc(sysdate) AND ORG_ID = 127;

PROMPT SQL1: Records that need to be updated manually

      SELECT hca.account_number
            ,hca.cust_account_id
            ,hps.party_site_number
            ,hcasa.cust_acct_site_id
            ,hcsua.site_use_id
            ,hcasa.org_id
            ,racrm.cust_receipt_method_id
            ,arm.name
        FROM apps.hz_cust_accounts hca
            ,apps.hz_cust_acct_sites_all hcasa
            ,apps.hz_party_sites hps
            ,apps.hz_cust_site_uses_all hcsua
            ,apps.ra_cust_receipt_methods racrm
            ,apps.ar_receipt_methods arm 
       WHERE hcasa.cust_account_id = hca.cust_account_id
         AND arm.receipt_method_id = racrm.receipt_method_id
         AND hcasa.status = 'A'
         AND hps.party_site_id = hcasa.party_site_id
         AND hps.status = 'A'
         AND hcsua.cust_acct_site_id = hcasa.cust_acct_site_id
         AND racrm.customer_id = hca.cust_account_id
         AND racrm.site_use_id = hcsua.site_use_id         
         AND racrm.primary_flag = 'N'
         AND arm.name = 'CHECK'
--         AND hcasa.orig_system_reference IN (16258,170643,181356)
         AND NOT EXISTS (SELECT 1
                           FROM apps.ra_cust_receipt_methods
                          WHERE customer_id = hca.cust_account_id
                            AND site_use_id = hcsua.site_use_id
                            AND primary_flag = 'Y')
         ORDER BY hcasa.org_id, hca.cust_account_id, party_site_number; 
