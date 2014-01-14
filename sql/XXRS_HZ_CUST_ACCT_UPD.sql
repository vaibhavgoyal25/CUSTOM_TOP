/*********************************************************************************************************
*                                                                                                        *
* NAME : XXRS_HZ_CUST_ACCT_UPD.sql                                                                   *
*                                                                                                        *
* DESCRIPTION :                                                                                          *
* Script to update account established date for all customers created after go live                      *
*                                                                                                        *
* AUTHOR       : Pavan Amirineni                                                                         *
* DATE WRITTEN : 14-MAR-2013                                                                             *
*                                                                                                        *
  * CHANGE CONTROL :                                                                                     *
  * Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                      *
  *------------------------------------------------------------------------------------------------------*
  * 1.0.0        | 130128-08943      | Pavan Amirineni | 03/14/2013     | Initial Creation               *
  *******************************************************************************************************/
    /* $Header: XXRS_HZ_CUST_ACCT_UPD.sql 1.0.0 03/14/2013 16:38:00 PAVAN AMIRINENI $ */
SET SERVEROUTPUT ON SIZE 1000000;
SET LINE 300;
SET PAGESIZE 2000;
SET COLSEP |;
col file_name   new_value   spool_file_name    noprint
select 'XXRS_AR_UPD_CUST_EST_DATE' ||to_char (sysdate, '_mmddyy_hhmiss')||'.log' file_name from dual ;
spool &spool_file_name
DECLARE
  CURSOR cur_cust_acct 
  IS 
  SELECT hca.cust_account_id     
       , hca.account_number
       , trunc(hca.creation_date)creation_date
       , hca.object_version_number
       , account_established_date
    FROM hz_cust_accounts hca 
   WHERE 1 = 1 
     AND hca.account_established_date IS NULL;
  l_cust_account_rec          hz_cust_account_v2pub.cust_account_rec_type;
  l_object_version_number     NUMBER;
  x_return_status             VARCHAR2 (1);  
  x_msg_count                 NUMBER;
  x_msg_data                  VARCHAR2 ( 2000 );
BEGIN
-- 
-- Setting client info to 127 as customer is global it won't make any diff
--
  dbms_output.put_line('ACCOUNT NUMBER | API Response'); 
  FOR rec_cust_acct IN cur_cust_acct 
  LOOP 
    l_cust_account_rec.cust_account_id := rec_cust_acct.cust_account_id;
    l_cust_account_rec.account_established_date := TRUNC(rec_cust_acct.creation_date);    
    l_object_version_number := rec_cust_acct.object_version_number;
    hz_cust_account_v2pub.update_cust_account ( p_init_msg_list         => 'T'
                                              , p_cust_account_rec      => l_cust_account_rec
                                              , p_object_version_number => l_object_version_number
                                              , x_return_status         => x_return_status
                                              , x_msg_count             => x_msg_count
                                              , x_msg_data              => x_msg_data
                                              );      
   IF x_return_status != fnd_api.g_ret_sts_success THEN 
      dbms_output.put_line(rec_cust_acct.account_number|| ' | '||SUBSTR(x_msg_data,1,255));
      dbms_output.put('Error : '||SUBSTR(x_msg_data,1,255));
      ROLLBACK; 
   ELSE 
     dbms_output.put_line(rec_cust_acct.account_number|| ' | Sucess');
     COMMIT; 
   END IF; 
  END LOOP; 
END;
/