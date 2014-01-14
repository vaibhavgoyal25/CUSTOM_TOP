/**************************************************************************************************
* NAME : XXRS_AP_WD_DUP_VEN_120504-07090.sql                                                      *
* DESCRIPTION :                                                                                   *
* AR payment schedules review                                                                     *
*                                                                                                 *
* AUTHOR       : Pavan Amirineni                                                                  *
* DATE WRITTEN : 01-JUN-2012                                                                      *
*                                                                                                 *
* CHANGE CONTROL :                                                                                *
* Version# | Ticket #     |  WHO            | DATE        |   REMARKS                             *
*-------------------------------------------------------------------------------------------------*
* 1.0.0    | 120608-04169 | Pavan Amirineni | 01-JUN-2012 | Initial Creation                      *
**************************************************************************************************/
--/* $Header: XXRS_AP_WD_DUP_VEN_120608-04169.sql 1.0.0 01-JUN-2012 10:54:39 AM Pavan AMirineni $ */
SET PAGESIZE 300
col file_name   new_value   spool_file_name    noprint
SELECT 'XXRS_AP_WD_DUP_VEN_120504-07090_'||to_char (sysdate, '_mmddyy_hhmiss')||'.log' file_name from dual ;
SPOOL &spool_file_name
DECLARE
--     
  x_profile_id            NUMBER;      
  l_msg_count             NUMBER;
  l_msg_data              VARCHAR2(4000);
  l_return_status         VARCHAR2(10);   
  lv_msg_count            NUMBER;
  lv_msg_data             VARCHAR2(4000);   
  lv_new_vendor_name      VARCHAR2(240);
  lv_return_status        VARCHAR2(1);
--  
  l_organization_rec hz_party_v2pub.organization_rec_type;
  lv_vendor_rec      ap_vendor_pub_pkg.r_vendor_rec_type;
--     
  CURSOR cur_dup_vendors 
  IS   
  SELECT vendor_name
       , vendor_id
       , segment1
       , vendor_type_lookup_code
       , pv.party_id
       , hp.party_name
       , hp.object_version_number
       , start_date_active
       , end_date_active
    FROM apps.po_vendors pv
       , hz_parties hp 
   WHERE 1 = 1 
     AND pv.party_id = hp.party_id 
     AND NOT EXISTS
                (SELECT 'Y'
                   FROM ap.ap_supplier_sites_all pvs
                  WHERE pvs.vendor_id = pv.vendor_id
                )
     AND pay_group_lookup_code = 'EMPLOYEE'
     AND TRUNC (pv.creation_date) > TO_DATE ('04-22-2012', 'MM-DD-RRRR')
     AND pv.vendor_name NOT LIKE 'Do Not Use%'
--     AND ROWNUM < 4
   ORDER BY 3; 
BEGIN
-- 
  fnd_global.apps_initialize(0,50593,201);  -- Executing the script as SYSADMIN
  mo_global.init('S');
--             
  FOR rec_dup_ven IN cur_dup_vendors 
  LOOP
--                 
    l_return_status    := NULL; 
    l_msg_data         := NULL; 
    l_msg_count        := NULL; 
--    
    lv_new_vendor_name := NULL; 
    lv_return_status   := NULL;
    lv_msg_count       := NULL; 
    lv_return_status   := NULL;   
--    
    l_organization_rec.party_rec.party_id := rec_dup_ven.party_id;    
    lv_new_vendor_name := SUBSTR('Do Not Use'||rec_dup_ven.vendor_name,1,240);
    l_organization_rec.organization_name := SUBSTR('Do Not Use '||rec_dup_ven.vendor_name,1,240);        
--        
    hz_party_v2pub.update_organization ( p_init_msg_list               => fnd_api.g_true,
                                         p_organization_rec            => l_organization_rec,
                                         p_party_object_version_number => rec_dup_ven.object_version_number,
                                         x_profile_id                  => x_profile_id,
                                         x_return_status               => l_return_status,
                                         x_msg_count                   => l_msg_count,
                                         x_msg_data                    => l_msg_data
                                       );
--
    IF (l_return_status = fnd_api.g_ret_sts_success ) THEN 
      COMMIT;  
      dbms_output.put_line(rec_dup_ven.segment1||'|'||rec_dup_ven.vendor_name||'|'||lv_new_vendor_name||'|'||l_return_status||'|'||'No Error');
    ELSE 
      ROLLBACK; 
      dbms_output.put_line(rec_dup_ven.segment1||'|'||rec_dup_ven.vendor_name||'|'||lv_new_vendor_name||'|'||l_return_status||'|'||l_msg_data);
    END IF;
-- 
--  end date the vendor
    lv_vendor_rec.end_date_active:= SYSDATE;   
    lv_vendor_rec.vendor_id      := rec_dup_ven.vendor_id;
--
    ap_vendor_pub_pkg.update_vendor ( p_api_version      => 1.0
                                    , p_init_msg_list    => fnd_api.g_true 
                                    , p_commit           => fnd_api.g_true
                                    , p_validation_level => fnd_api.g_valid_level_full
                                    , x_return_status    => lv_return_status
                                    , x_msg_count        => lv_msg_count
                                    , x_msg_data         => lv_msg_data
                                    , p_vendor_rec       => lv_vendor_rec
                                    , p_vendor_id        => rec_dup_ven.vendor_id
                                    );    
--     
    IF (lv_return_status = fnd_api.g_ret_sts_success ) THEN 
      COMMIT;  
      dbms_output.put_line(rec_dup_ven.segment1||'|'||rec_dup_ven.vendor_name||'|'||lv_new_vendor_name||'|'||lv_return_status||'|'||'Supplier End Dated.');
    ELSE 
      ROLLBACK; 
      dbms_output.put_line(rec_dup_ven.segment1||'|'||rec_dup_ven.vendor_name||'|'||lv_new_vendor_name||'|'||lv_return_status||'|'||lv_msg_data);
    END IF;
-- 
  END LOOP; 
--     
EXCEPTION 
  WHEN OTHERS THEN 
    ROLLBACK; 
    dbms_output.put_line('Encountered Unexpected Error => '||SQLERRM);
END; 
/   
