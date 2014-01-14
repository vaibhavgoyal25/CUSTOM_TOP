/**************************************************************************************************
* NAME : XXRS_AR_PM_CONV_TO_CHECK_120425-06439.sql                                                *
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
--  /* $Header: XXRS_AR_PM_CONV_TO_CHECK_120425-06439.sql 1.0.0 24-APR-2012 10:54:39 AM Pavan AMirineni $ */
SET SERVEROUTPUT ON SIZE 1000000;
col file_name   new_value   spool_file_name    noprint
select 'XXRS_AR_PM_CONV_TO_CHECK_120425-06439' ||to_char (sysdate, '_mmddyy_hhmiss')||'.log' file_name from dual ;
spool &spool_file_name
DECLARE
   CURSOR cur_cc_to_check
   IS
      SELECT hca.account_number
            ,hca.cust_account_id
            ,hps.party_site_number
            ,hca.orig_system_reference orig_system_customer_ref
            ,hcasa.orig_system_reference orig_system_address_ref            
            ,hcasa.org_id
            ,hcsua.site_use_id
            ,racrm.cust_receipt_method_id  
        FROM apps.hz_cust_accounts hca
            ,apps.hz_cust_acct_sites hcasa
            ,apps.hz_party_sites hps
            ,apps.hz_cust_site_uses hcsua
            ,apps.ar_receipt_methods arm
            ,apps.ra_cust_receipt_methods racrm
       WHERE hcasa.cust_account_id = hca.cust_account_id
         AND hps.party_site_id = hcasa.party_site_id
         AND hps.status = 'A'
         AND hcsua.cust_acct_site_id = hcasa.cust_acct_site_id
         AND racrm.customer_id = hca.cust_account_id
         AND racrm.site_use_id = hcsua.site_use_id
         AND racrm.primary_flag = 'Y'
         AND TRUNC (SYSDATE) BETWEEN TRUNC (NVL (racrm.start_date, SYSDATE)) AND TRUNC (NVL (racrm.end_date, SYSDATE))
         AND arm.receipt_method_id = racrm.receipt_method_id
         AND arm.NAME LIKE 'CC%'
         AND NOT EXISTS (
                        SELECT 'c'
                          FROM apps.iby_fndcpt_payer_assgn_instr_v ifpai
                         WHERE ifpai.cust_account_id = hca.cust_account_id
                           AND ifpai.acct_site_use_id = hcsua.site_use_id
                           AND ifpai.order_of_preference =
                                                      (SELECT MIN (order_of_preference)
                                                         FROM iby_fndcpt_payer_assgn_instr_v
                                                        WHERE 1 = 1
                                                          AND cust_account_id = ifpai.cust_account_id
                                                          AND acct_site_use_id = ifpai.acct_site_use_id
                                                          AND instrument_type = 'CREDITCARD'
                                                      )
                           AND ifpai.instrument_type = 'CREDITCARD'
                           AND TRUNC(SYSDATE) BETWEEN TRUNC(ifpai.assignment_start_date) AND TRUNC(NVL (ifpai.assignment_end_date, SYSDATE))
                        )
         AND hcasa.org_id IN(127,126)
         ORDER BY hcasa.org_id,
         hca.account_number;
         
   CURSOR cur_op_unit
   IS
      SELECT organization_id org_id, 
             name ou_name,
             organization_id
        FROM hr_operating_units
       WHERE name IN ('Rackspace UK - Operating Unit'
                     ,'Rackspace US - Operating Unit'                     
                     );
              
   lv_user_id                    NUMBER;
   lv_resp_id                    NUMBER;
   lv_application_id             NUMBER;         

/* Procedure to log the debug messages */
   PROCEDURE log_message ( p_message                VARCHAR2
                 )
   IS
   BEGIN
      DBMS_OUTPUT.put_line (p_message);
   END;

/* Procedure to launch the Customer Interface concurrent program */
   PROCEDURE launch_concurrent_prg ( p_short_name                        VARCHAR2
                                   , p_app_short_name                    VARCHAR2
                                   , p_org_id                            NUMBER
                                   )
   IS
      l_request_id                  fnd_concurrent_requests.request_id%TYPE;
      l_call_status                 BOOLEAN;
      l_request_phase               VARCHAR2 (15);
      l_request_status              VARCHAR2 (15);
      l_dev_request_phase           VARCHAR2 (15);
      l_dev_request_status          VARCHAR2 (15);
      l_request_status_mesg         VARCHAR2 (80);
      excep_unable_to_submit        EXCEPTION;
      excep_unable_to_load          EXCEPTION;
   BEGIN
--      log_message ('Start of procedure launch_concurrent_prg');
      l_request_id := fnd_request.submit_request (p_app_short_name
                                                 ,p_short_name
                                                 ,NULL
                                                 ,SYSDATE
                                                 ,FALSE
                                                 , 'N'
                                                 , p_org_id                                                 
                                                 );
      COMMIT;
      log_message ('launch_concurrent_prg: got request id: ' || l_request_id);

      IF l_request_id = 0 THEN
         RAISE excep_unable_to_submit;
      ELSE
--         log_message ('launch_concurrent_prg: waiting for request id: ' || l_request_id);
         l_call_status :=
            fnd_concurrent.wait_for_request (l_request_id
                                            ,30
                                            ,0
                                            ,l_request_phase
                                            ,l_request_status
                                            ,l_dev_request_phase
                                            ,l_dev_request_status
                                            ,l_request_status_mesg
                                            );

         IF l_call_status = FALSE THEN
            RAISE excep_unable_to_load;
         END IF;

         log_message ('End of procedure launch_concurrent_prg. Concurrent request completed. Request id: ' || l_request_id);
      END IF;
   EXCEPTION
      WHEN excep_unable_to_submit THEN
         log_message ('launch_concurrent_prg: Unable to submit concurrent request ' || p_short_name);
         RAISE;
      WHEN excep_unable_to_load THEN
         log_message ('launch_concurrent_prg: Unable to wait for concurrent request ' || p_short_name);
         RAISE;
   END launch_concurrent_prg;

BEGIN
 
  FOR rec_cur_op_unit IN cur_op_unit
     LOOP
       log_message ('Customer Account | Org ID | orig_system_customer_ref | orig_system_address_ref | receipt_method_id');         
           SELECT user_id
             INTO lv_user_id
             FROM fnd_user
            WHERE user_name = 'SYSADMIN';
            
           SELECT responsibility_id
             INTO lv_resp_id
             FROM fnd_responsibility_vl
            WHERE responsibility_name = DECODE(rec_cur_op_unit.ou_name,'Rackspace UK - Operating Unit','RS UK AR Super User'
                                                                      ,'Rackspace US - Operating Unit','RS US AR Super User'                                                                     
                                              );
           SELECT application_id
             INTO lv_application_id
             FROM fnd_application_vl
            WHERE application_name = 'Receivables';
            
           fnd_global.apps_initialize (lv_user_id
                                      ,lv_resp_id
                                      ,lv_application_id
                                      );                                      
           MO_GLOBAL.init('AR');                                           
           FOR rec_cur_cc_to_check IN cur_cc_to_check
           LOOP
                 log_message (rec_cur_cc_to_check.account_number ||'|'||
                              rec_cur_cc_to_check.org_id||'|'||
                              rec_cur_cc_to_check.orig_system_customer_ref||'|'||
                              rec_cur_cc_to_check.orig_system_address_ref||'|'||
                              rec_cur_cc_to_check.cust_receipt_method_id
                             );    
                 
              BEGIN
                    ----------------------------------------------------------------------------
                    -- Switch Primary Flag of Receipt Method for the Site to 'N'
                    ----------------------------------------------------------------------------
                  UPDATE ra_cust_receipt_methods
                     SET primary_flag = 'N'
                       , last_update_date = SYSDATE
                       , last_updated_by = lv_user_id
                       , last_update_login = -1
                   WHERE customer_id = rec_cur_cc_to_check.cust_account_id
                     AND site_use_id = rec_cur_cc_to_check.site_use_id;

              EXCEPTION
                  WHEN OTHERS THEN
                    log_message ( 'Error while updating Receipt Method Primary Flag Customer Account: '|| rec_cur_cc_to_check.account_number||' '||SQLERRM);
              END;         
                    
              BEGIN
                 INSERT INTO apps.ra_cust_pay_method_interface
                             (orig_system_customer_ref
                             ,orig_system_address_ref
                             ,payment_method_name
                             ,primary_flag
                             ,start_date
                             ,end_date
                             ,org_id
                             ,last_updated_by
                             ,last_update_date
                             ,creation_date
                             ,created_by
                             ,last_update_login
                             )
                      VALUES (rec_cur_cc_to_check.orig_system_customer_ref
                             ,rec_cur_cc_to_check.orig_system_address_ref
                             ,DECODE(rec_cur_cc_to_check.ORG_ID,127,'CHECK',126,'CHEQUE')
                             ,'Y'
                             ,SYSDATE
                             ,NULL
                             ,rec_cur_cc_to_check.org_id
                             ,lv_user_id
                             ,SYSDATE
                             ,SYSDATE
                             ,lv_user_id
                             ,-1
                             );
              EXCEPTION
                 WHEN OTHERS THEN
                    log_message ('Error while inserting records to interface table for Customer Account: '|| rec_cur_cc_to_check.account_number|| ' and Site Number: '|| rec_cur_cc_to_check.party_site_number|| ' '|| SQLCODE|| ' '|| SQLERRM);
              END;
           END LOOP;
           
           COMMIT;

        /* Call the Customer Interface Program */
           launch_concurrent_prg ('RACUST', 'AR',rec_cur_op_unit.organization_id); 
     END LOOP;           
       
EXCEPTION
   WHEN OTHERS THEN
      log_message ('Unexpected error occured: ' || SQLCODE || ' ' || SQLERRM);
END;
/
