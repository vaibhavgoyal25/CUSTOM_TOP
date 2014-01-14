/**************************************************************************************************************
* NAME : XXRS_IBY_CC_STATUS_FIX_131104-10181.sql                                                              *
*                                                                                                             *
* DESCRIPTION :                                                                                               *
*   Script to update credit card status to active                                                             *
*                                                                                                             *
* AUTHOR       : Pavan Amirineni                                                                              *
* DATE WRITTEN : 04-NOV-2013                                                                                  *
*                                                                                                             *
* CHANGE CONTROL :                                                                                            *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                             *
*-------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  131104-10181     | Pavan Amirineni |  04-NOV-2013   | Initial Creation.                     *
***************************************************************************************************************/
--
/* $Header: XXRS_IBY_CC_STATUS_FIX_131104-10181.sql 1.0.0 11/04/2013 10:46:24 AM Pavan Amirineni $ */
--
SET SERVEROUTPUT ON SIZE 1000000
SET LINES 1000
SET PAGESIZE 1000
SET COLSEP '|'
COL file_name NEW_VALUE spool_file_name NOPRINT
SELECT 'XXRS_IBY_CC_STATUS_FIX_131104-10181_'||TO_CHAR(SYSDATE,'YYYYMMDDHHMISS')||'.log' file_name
FROM DUAL;

SPOOL &spool_file_name
DECLARE 
--  
  cursor cur_get_card
  IS 
  SELECT cust.account_number
       , DECODE(site.org_id, '127','US',126,'UK',420,'NL',559,'HK') ORG_CODE
       , icc.card_issuer_code
       , icc.masked_cc_number
       , u.order_of_preference
       , icc.expirydate       
       , icc.active_flag       
       , icc.instrid 
       , u.start_date
       , u.end_date 
  FROM iby_creditcard icc,
       ar.hz_cust_accounts cust,
       ar.hz_cust_acct_sites_all site,
       ar.hz_cust_site_uses_all uses,
       ar.hz_party_sites psite,
       iby_external_payers_all p,
       iby_pmt_instr_uses_all u
 WHERE     1 = 1
       AND u.ext_pmt_party_id = p.ext_payer_id
       AND u.instrument_type = 'CREDITCARD'
       AND u.instrument_id = icc.instrid
       AND u.payment_flow = 'FUNDS_CAPTURE'
       AND p.cust_account_id = cust.cust_account_id
       AND uses.site_use_id = p.acct_site_use_id
       AND site.cust_acct_site_id = uses.cust_acct_site_id
       AND site.cust_account_id = cust.cust_account_id
       AND site.party_site_id = psite.party_site_id
       AND u.order_of_preference = 1
       AND NVL (icc.active_flag, 'Y') = 'N'
       AND icc.cc_num_sec_segment_id IS NOT NULL
       AND icc.object_version_number > -999
       AND icc.expirydate >= SYSDATE
       AND EXISTS
              (SELECT 'x'
                 FROM ra_cust_receipt_methods rcrm_check,
                      ar_receipt_methods arm_check
                WHERE 1 = 1
                  AND arm_check.receipt_method_id = rcrm_check.receipt_method_id
                  AND rcrm_check.customer_id = cust.cust_account_id
                  AND rcrm_check.site_use_id = uses.site_use_id
                  AND rcrm_check.primary_flag = 'Y'
                  AND SYSDATE BETWEEN NVL (rcrm_check.start_date, SYSDATE - 1)
                                      AND NVL (rcrm_check.end_date, SYSDATE + 1)
                  AND arm_check.name LIKE 'CC%')
      ORDER BY site.org_id;
--                  AND ROWNUM = 1;
  l_card_instrument        IBY_FNDCPT_SETUP_PUB.CreditCard_rec_type;
  l_return_status          VARCHAR2(1000);
  l_t_count  NUMBER := 0;
  l_s_count  NUMBER := 0;
  l_f_count  NUMBER := 0; 
--    
  PROCEDURE update_credit_cards ( p_card_instrument IBY_FNDCPT_SETUP_PUB.CreditCard_rec_type
                                , x_return_status OUT VARCHAR2
                                )
  IS
    l_msg_count          NUMBER;
    l_msg_data           VARCHAR2(4000);
    l_response           IBY_FNDCPT_COMMON_PUB.Result_rec_type;
    l_err_msg_tmp        VARCHAR2(2000);
    l_msg_index_out      VARCHAR2(240);
    l_err_msg            VARCHAR2(2000);        
  BEGIN    
    l_msg_count     := 0; 
    l_msg_data      := NULL;
    l_response      := NULL;    
    l_err_msg       := NULL; 
    l_msg_index_out := NULL;
  --
    IBY_FNDCPT_SETUP_PUB.Update_Card ( p_api_version     =>  1.0
                                     , p_init_msg_list   =>  FND_API.G_TRUE
                                     , p_commit          =>  FND_API.G_FALSE
                                     , x_return_status   =>  x_return_status
                                     , x_msg_count       =>  l_msg_count
                                     , x_msg_data        =>  l_msg_data
                                     , p_card_instrument =>  p_card_instrument
                                     , x_response        =>  l_response
                                     );

      IF l_msg_count >=1 AND x_return_status ='E' THEN
        FOR i IN 1..l_msg_count  LOOP
          fnd_msg_pub.get(p_msg_index      => i,
                          p_encoded        => fnd_api.g_false,
                          p_data           => l_err_msg_tmp,
                          p_msg_index_out  => l_msg_index_out
                         );

          l_err_msg := l_err_msg ||','||l_err_msg_tmp;
        END LOOP;        
      END IF;     
  EXCEPTION
    WHEN OTHERS THEN
      dbms_output.put_line('Error:'||SQLERRM);     
  END update_credit_cards;
--
  BEGIN   
     dbms_output.put_line ('account_number|org_code|card_issuer_code|masked_cc_number|order_of_preference|expirydate|active_flag|instrid|start_date|end_date|Status');
     FOR rec_get_card IN cur_get_card 
     LOOP
       l_card_instrument.card_id          := rec_get_card.instrid;
       l_card_instrument.instrument_type  := 'CREDITCARD';
       l_card_instrument.active_flag      := 'Y';        
       l_return_status := NULL;    
       l_t_count  := l_t_count +1;                        
       update_credit_cards( l_card_instrument
                          , l_return_status
                          );                             
       IF l_return_status ='S' THEN
         l_s_count  := l_s_count + 1;
                          
         dbms_output.put_line (rec_get_card.account_number||'|'||
                               rec_get_card.org_code||'|'||
                               rec_get_card.card_issuer_code||'|'||
                               rec_get_card.masked_cc_number||'|'||
                               rec_get_card.order_of_preference||'|'||
                               rec_get_card.expirydate||'|'||
                               rec_get_card.active_flag||'|'||
                               rec_get_card.instrid||'|'||
                               rec_get_card.start_date||'|'||
                               rec_get_card.end_date||'|'||
                               l_return_status
                              );   
         COMMIT;             
       ELSE
         dbms_output.put_line (rec_get_card.account_number||'|'||
                               rec_get_card.org_code||'|'||
                               rec_get_card.card_issuer_code||'|'||
                               rec_get_card.masked_cc_number||'|'||
                               rec_get_card.order_of_preference||'|'||
                               rec_get_card.expirydate||'|'||
                               rec_get_card.active_flag||'|'||
                               rec_get_card.instrid||'|'||
                               rec_get_card.start_date||'|'||
                               rec_get_card.end_date||'|'||
                               l_return_status
                              );
         l_f_count  := l_f_count +1;
         ROLLBACK; 
       END IF;          
     END LOOP;       
     dbms_output.put_line ('Total Records Processed => '||l_t_count);
     dbms_output.put_line ('      Records Passed    => '||l_s_count);
     dbms_output.put_line ('      Records failed    => '||l_f_count);
     dbms_output.put_line ('Done ! Exiting data fix');
  END;