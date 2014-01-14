/*********************************************************************************************************
* NAME  XXRS_IEX_CLOSE_STR_120423-12496.sql                                                              *
* DESCRIPTION                                                                                            *
* Script to Close strategies using API                                                                   *
*                                                                                                        *
* AUTHOR        Pavan Amirineni                                                                          *
* DATE WRITTEN  26-APR-2012                                                                              *
*                                                                                                        *
* CHANGE CONTROL                                                                                         *
* SR#             Ticket#       WHO                DATE                        REMARKS                   *
* 1.0.0          120423-12496  Pavan Amirineni     26-APR-2012                 Initial build             *
*********************************************************************************************************/
/* $Header: XXRS_IEX_CLOSE_STR_120423-12496.sql 1.0.0 26-APR-2012  10:00:00 AM Pavan $ */
SET SERVEROUTPUT ON SIZE 1000000;
col file_name   new_value   spool_file_name    noprint
select 'XXRS_IEX_CLOSE_STR_120423-12496' ||to_char (sysdate, '_mmddyy_hhmiss')||'.log' file_name from dual ;
spool &spool_file_name
DECLARE
 x_return_status VARCHAR2(1);
 x_msg_count     NUMBER;
 x_msg_data      VARCHAR2(2000);
 CURSOR cur_open_str 
 IS    
   SELECT str.strategy_id
        , str.status_code 
        , str.strategy_template_id
        , hca.account_number
        , str.object_id
        , str.org_id
        , DECODE(str.org_id, 127, 'RS_US_IEX_MANAGER'
                           , 126, 'RS_UK_IEX_MANAGER'
                           , 420, 'RS_NL_IEX_MANAGER'
                           , 559, 'RS_HK_IEX_MANAGER'
                           , 'RS_US_IEX_MANAGER') org_resp 
    FROM iex.iex_strategies str
       , iex.iex_strategy_templates_tl temp
       , ar.hz_cust_accounts hca
   WHERE 1 = 1
     AND str.strategy_template_id = temp.strategy_temp_id
     AND str.status_code = 'OPEN'
     AND str.object_id = hca.cust_account_id
     AND UPPER(temp.strategy_name) = 'RS DEFAULT STRATEGY'
     ORDER BY str.org_id;     
--     
  l_count NUMBER :=0;
  l_reset NUMBER :=0;
  l_resp_id NUMBER;
  l_appl_id NUMBER;
  l_current_org_id  hr_operating_units.organization_id%TYPE := 0;          
--
BEGIN
--  
  dbms_output.put_line('Error Report');
  dbms_output.put_line('strategy_id, API_Status, Error_Text');                              
-- close strategies                              
  FOR rec_open_str IN cur_open_str
  LOOP
--
    IF l_current_org_id <> rec_open_str.org_id
    THEN
      -- initalize apps
      SELECT responsibility_id
           , application_id
        INTO l_resp_id
           , l_appl_id
        FROM applsys.fnd_responsibility resp
       WHERE responsibility_key = rec_open_str.org_resp;
                                    
      fnd_global.apps_initialize (user_id      => 0 -- SYSADMIN
                                 ,resp_id      => l_resp_id
                                 ,resp_appl_id => l_appl_id
                                 );      
--                                    
      l_current_org_id := rec_open_str.org_id;
    END IF;
--
--    l_count := l_count +1;
    l_reset := l_reset +1;                       
    IEX_STRATEGY_PUB.close_strategy (P_Api_Version_Number => 2.0  
                                    ,P_Init_Msg_List      => FND_API.G_TRUE
                                    ,P_Commit             => FND_API.G_FALSE
                                    ,p_validation_level   => FND_API.G_VALID_LEVEL_FULL
                                    ,x_Return_Status      => x_return_status
                                    ,x_msg_count          => x_msg_count
                                    ,x_Msg_Data           => x_msg_data
                                    ,p_DelinquencyID      => NULL
                                    ,p_ObjectType         => 'ACCOUNT'
                                    ,p_objectid           => rec_open_str.object_id 
                                 );                                                                                   
--                                  
    IF ( x_return_status = fnd_api.g_ret_sts_success)
    THEN            
      COMMIT;
    ELSE            
      ROLLBACK;
      l_count := l_count +1;
      dbms_output.put_line(rec_open_str.strategy_id ||',E,'||SUBSTR(x_msg_data,250));
    END IF;
--        
    IF (l_reset = 16000)
    THEN
      DBMS_LOCK.SLEEP(120);
      DBMS_OUTPUT.DISABLE;
      DBMS_OUTPUT.ENABLE(1000000); 
      l_reset :=0;
    END IF;      
  END LOOP;
--
  IF l_count = 0 THEN
    dbms_output.put_line(' . ' );
    dbms_output.put_line(' . ');
    dbms_output.put_line('*****************************************************************');
    dbms_output.put_line('No errors found, all open strategies are closed successfully');
    dbms_output.put_line('*****************************************************************');
  END IF;
EXCEPTION
  WHEN OTHERS THEN 
    ROLLBACK; 
    dbms_output.put_line('EXC '||SQLERRM);  
END;
/
