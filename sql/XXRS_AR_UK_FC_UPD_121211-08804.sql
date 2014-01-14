/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_AR_UK_FC_UPD_121211-08804.sql                                                                           *
*                                                                                                                     *
* DESCRIPTION :                                                                                                       *
* SR# 3-6571090651 error "TABLE ZX_PARTY_TAX_PROFILE NOT IN FND_OBJECTS TABLE" hz_classification_v2pub, Oracle        *
* provided data fix to insert this table so that it becomes available in LOV                                          *
* AUTHOR       : Pavan Amirineni                                                                                      *
* DATE WRITTEN : 19-DEC-2012                                                                                          *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* SR#          |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                                     *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  121211-08804     | Pavan Amirineni |  19-DEC-2012   | Adding FC codes at Customer site level        *
***********************************************************************************************************************/
/* $Header: XXRS_AR_UK_FC_UPD_121211-08804.sql 1.0.0 19-DEC-2012 01:39:56 PM Pavan Amirineni $ */
SET SERVEROUTPUT ON SIZE 1000000;
col file_name   new_value   spool_file_name    noprint
SELECT 'XXRS_AR_UK_FC_UPD_121211-08804_' ||TO_CHAR (SYSDATE, '_mmddyy_hhmiss')||'.log' file_name from dual ;
SPOOL &spool_file_name
DECLARE
    l_class_code_assign_rec  hz_classification_v2pub.code_assignment_rec_type;
    l_code_assignment_id               NUMBER;
    l_procedure_name     VARCHAR2(50);
    l_return_status      VARCHAR2 (1);
    l_api_data           VARCHAR2 (2000) := NULL;
    l_api_msg_indexout   NUMBER := NULL;
    l_api_error          VARCHAR2 (2000) := NULL;
    l_msg_data           VARCHAR2 (1000);
    l_msg_count          NUMBER;
--    
    CURSOR cur_assign_fc 
    IS
    SELECT cust.account_number   
         , ps.party_site_number
         , ps.party_site_id
         , ptp_party.party_tax_profile_id owner_table_id  
      FROM zx_party_tax_profile ptp_party
         , hz_cust_accounts cust
         , hz_cust_acct_sites_all site
         , hz_party_sites ps 
     WHERE 1 = 1
       AND ptp_party.party_type_code = 'THIRD_PARTY_SITE'
       AND ptp_party.party_id = site.party_site_id
       AND site.cust_account_id = cust.cust_account_id
       AND ps.party_site_id = site.party_site_id 
       AND site.org_id = 126
       AND NOT EXISTS (SELECT 'X' 
                         FROM ar.hz_code_assignments  
                        WHERE OWNER_TABLE_NAME = 'ZX_PARTY_TAX_PROFILE'
                          AND OWNER_TABLE_ID   =  ptp_party.party_tax_profile_id
                  )
      ORDER BY 1,2;
--
  BEGIN
    l_procedure_name := 'XXRS_CUSTOM_API';
             
    FOR rec_assign_fc IN cur_assign_fc
    LOOP 
--        
        BEGIN
        --
          l_class_code_assign_rec.owner_table_name := 'ZX_PARTY_TAX_PROFILE';
          l_class_code_assign_rec.owner_table_id   := rec_assign_fc.owner_table_id;
          l_class_code_assign_rec.class_category   := 'RS_CONTRACT_REGION';
          l_class_code_assign_rec.class_code       := 'WITHIN_LE';
          l_class_code_assign_rec.primary_flag     := 'Y';
          l_class_code_assign_rec.start_date_active := TO_DATE ('02/01/2013','mm/dd/yyyy');
          l_class_code_assign_rec.created_by_module := 'TCA_V2_API';
          l_class_code_assign_rec.actual_content_source := 'USER_ENTERED';          
        --
        -- calling API to update retirement details
        --
          hz_classification_v2pub.create_code_assignment(p_init_msg_list          => fnd_api.g_true
                                                        ,p_code_assignment_rec    => l_class_code_assign_rec
                                                        ,x_return_status          => l_return_status
                                                        ,x_msg_count              => l_msg_count
                                                        ,x_msg_data               => l_msg_data
                                                        ,x_code_assignment_id     => l_code_assignment_id
                                                        );                                     
        --
          IF l_return_status <> 'S' THEN
            FOR i IN 1 .. l_msg_count
            LOOP
              fnd_msg_pub.get (i, 'F', l_api_data, l_api_msg_indexout);
              l_api_error := l_api_error || ';' || l_api_data;
            END LOOP;                   
          --
            DBMS_OUTPUT.PUT_LINE(rec_assign_fc.account_number||' | ' || rec_assign_fc.party_site_number||' | ' ||l_api_error);
            ROLLBACK;
          --
          ELSE
            COMMIT;
            DBMS_OUTPUT.PUT_LINE(rec_assign_fc.account_number||' | ' || rec_assign_fc.party_site_number||' | '||l_code_assignment_id); 
          END IF;
        --          
        EXCEPTION
          WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(rec_assign_fc.account_number||' | ' || rec_assign_fc.party_site_number||' | ' ||SQLERRM);        
        END;    
    --                        
    END LOOP;         
         
  EXCEPTION
    WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE('Error 3 :'||SQLERRM );
   END; 
/ 
