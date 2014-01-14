/**************************************************************************************************************
*                                                                                                             *
* NAME : XXRS_SC_SER_ID_UPD_121210-05556.sql                                                                  *
*                                                                                                             *
* DESCRIPTION :                                                                                               *
*   Script to update service id for device and account products                                               *
*                                                                                                             *
* AUTHOR       : Pavan Amirineni                                                                              *
* DATE WRITTEN : 02-JAN-2013                                                                                  *
*                                                                                                             *
* CHANGE CONTROL :                                                                                            *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                             *
*-------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  121210-05556     | Pavan Amirineni |  02-JAN-2013   | Initial Creation.                     *
***************************************************************************************************************/
--
/* $Header: XXRS_SC_SER_ID_UPD_121210-05556.sql 1.0.0 02-JAN-2013 10:46:24 AM Pavan Amirineni $ */
--
SET SERVEROUTPUT ON SIZE 1000000
SET LINES 1000
SET PAGESIZE 1000
SET COLSEP '|'
COL file_name NEW_VALUE spool_file_name NOPRINT
SELECT 'XXRS_SC_SER_ID_UPD_121210-05556_'||TO_CHAR(SYSDATE,'YYYYMMDDHHMISS')||'.log' file_name FROM DUAL;
SPOOL &spool_file_name
DECLARE 
  CURSOR cur_dev_prd_upd 
  IS 
  SELECT dev.device_product_snid 
       , dev.device_num        
       , sdef1.name service_at_product
       , apps.xxrs_sc_device_resource_pkg.get_service_id (dev.device_product_snid) r_service_id         
       , DECODE (dev.org_id,127, 'RS US ORG',126,'RS UK ORG',420, 'RS NL ORG', 559, 'RS HK ORG',dev.org_id) org_name 
    FROM XXRS.XXRS_SC_DEVICE_PRODUCT_TBL DEV  
       , xxrs.xxrs_sc_service_def sdef1    
   WHERE 1 = 1  
     AND dev.service_id = sdef1.service_id
     AND dev.locked_flag = 'F'
     AND dev.service_id != apps.xxrs_sc_device_resource_pkg.get_service_id (dev.device_product_snid) ;
--     
  CURSOR cur_acc_prd_upd 
  IS 
  SELECT acc.account_product_snid
       , acc.service_id
       , sdef1.name service_at_product
       , apps.xxrs_sc_account_resource_pkg.get_service_id (acc.account_product_snid) r_service_id
       , DECODE (acc.org_id,127, 'RS US ORG',126,'RS UK ORG',420, 'RS NL ORG', 559, 'RS HK ORG',acc.org_id) ORG_NAME                                                                     
    FROM xxrs.xxrs_sc_account_product_tbl acc
       , xxrs.xxrs_sc_service_def sdef1 
   WHERE 1 = 1
     AND acc.locked_flag = 'F'     
     AND acc.service_id = sdef1.service_id
     AND acc.service_id != apps.xxrs_sc_account_resource_pkg.get_service_id (acc.account_product_snid);

BEGIN 
--  
 dbms_output.put_line(' ');
 dbms_output.put_line('Device Products');
  FOR rec_dev_prd_upd IN cur_dev_prd_upd 
  LOOP       
    dbms_output.put_line(rec_dev_prd_upd.device_num||' | '||rec_dev_prd_upd.service_at_product||' | '||rec_dev_prd_upd.r_service_id||' | '||rec_dev_prd_upd.org_name);
    UPDATE xxrs.xxrs_sc_device_product_tbl dprod
       SET dprod.service_id = rec_dev_prd_upd.r_service_id 
         , last_updated_by = 0
         , last_update_date = SYSDATE
         , last_update_login = -1
     WHERE dprod.device_product_snid  = rec_dev_prd_upd.device_product_snid;
  END LOOP  ;  
--   
--     
 dbms_output.put_line(' ');
 dbms_output.put_line('Account Products');
  FOR rec_acc_prd_upd IN cur_acc_prd_upd 
  LOOP
    dbms_output.put_line(rec_acc_prd_upd.account_product_snid||' | '||rec_acc_prd_upd.service_at_product||' | '||rec_acc_prd_upd.r_service_id||' | '||rec_acc_prd_upd.org_name);     
    UPDATE xxrs.xxrs_sc_account_product_tbl aprod
       SET aprod.service_id = rec_acc_prd_upd.r_service_id 
         , last_updated_by = 0
         , last_update_date = SYSDATE
         , last_update_login = -1
     WHERE aprod.account_product_snid  = rec_acc_prd_upd.account_product_snid;
  END LOOP;
--     
--   COMMIT;
--
 EXCEPTION 
  WHEN OTHERS THEN 
    dbms_output.put_line('Error while updating : '||TO_CHAR(SYSDATE, 'DD-MON-YYYY hh24:mi:ss'));
END; 
/
