DECLARE
  l_return_status    VARCHAR2(1000);
  l_msg_count        NUMBER;
  l_msg_data         VARCHAR2(4000);
  l_card_id          NUMBER;
  l_response         IBY_FNDCPT_COMMON_PUB.Result_rec_type;
  l_card_instrument  IBY_FNDCPT_SETUP_PUB.CreditCard_rec_type;  
  l_err_msg_tmp      VARCHAR2(2000);
  l_err_msg          VARCHAR2(2000); 
  l_msg_index_out    VARCHAR2(240);
--  
  CURSOR cur_test_cc  
  IS 
    SELECT * 
      FROM (SELECT hp.party_id owner_id
                 , hp.party_name
                 , hca.account_number
                 , hps.party_site_number
                 , SUBSTR(ieba.bank_account_name,1,DECODE(INSTR(ieba.bank_account_name,'-Rackspace'), 0, LENGTH(ieba.bank_account_name), INSTR(ieba.bank_account_name,'-Rackspace')-1)) bank_account_name
                 , hps.party_site_id
                 , ieba.ext_bank_account_id
                 , ieba.bank_id
                 , ieba.branch_id
                 , ieba.country_code
                 , ieba.currency_code
                 , ieba.bank_account_num 
                 , ieba.object_version_number
                 , ipiu.start_date 
                 , ipiu.end_date
                 , ieba.end_date expiry_date
                 , ipiu.instrument_type
                 , ipiu.instrument_id
                 , ipiu.instrument_payment_use_id
                 , ipiu.order_of_preference
                 , iepa.cust_account_id
                 , DECODE(SUBSTR(iebv.bank_name,13),'AMERICAN EXPRESS','AMEX',SUBSTR(iebv.bank_name,13)) bank_card_issuer
                 , iepa.acct_site_use_id
                 , iepa.org_id
                 , ipiu.attribute_category
                 , ipiu.attribute3
                 , ipiu.attribute4
                 , ipiu.attribute13
                 , ipiu.attribute14
                 , ipiu.attribute15 
                 , SUBSTR(( SELECT (arm.name)
                               FROM ar.ra_cust_receipt_methods rcrm
                                  , ar.ar_receipt_methods arm
                              WHERE rcrm.customer_id = hca.cust_account_id
                                AND rcrm.site_use_id = hcsua.site_use_id
                                AND SYSDATE BETWEEN rcrm.start_date
                                         AND NVL ( rcrm.end_date, SYSDATE )
                                AND rcrm.primary_flag = 'Y'
                                AND SYSDATE BETWEEN arm.start_date
                                         AND NVL ( arm.end_date, SYSDATE )
                                AND arm.receipt_method_id = rcrm.receipt_method_id ),1,2) payment_method
               FROM iby_ext_bank_accounts ieba
                  , iby_ext_banks_v iebv
                  , iby_pmt_instr_uses_all ipiu
                  , iby_external_payers_all iepa
                  , hz_cust_accounts hca
                  , hz_parties hp
                  , hz_party_sites hps
                  , hz_cust_acct_sites_all hcasa
                  , hz_cust_site_uses_all hcsua
                  , hz_locations hl
                  , fnd_lookup_values_vl flv
             WHERE ieba.bank_id=iebv.bank_party_id
               AND hca.account_number IN( '872666','835556')
               AND ieba.ext_bank_account_id = ipiu.instrument_id
               AND ipiu.instrument_type = 'BANKACCOUNT'
               AND ipiu.ext_pmt_party_id = iepa.ext_payer_id
               AND iepa.cust_account_id = hca.cust_account_id
               AND hca.party_id = hp.party_id
               AND hp.party_id = hps.party_id
               AND hcasa.party_site_id = hps.party_site_id 
               AND hcasa.cust_account_id = hca.cust_account_id 
               AND hcsua.cust_acct_site_id = hcasa.cust_acct_site_id
               AND hcsua.site_use_code = 'BILL_TO'    -- site use code is bill to
               AND hcsua.status = 'A'                 -- site status is active
             --AND hcsua.primary_flag = 'Y'           -- site is primary, need to consider all active sites
               AND hps.location_id = hl.location_id
               AND flv.lookup_type = 'XXRS_AR_CREDIT_CARD_TYPES'
               AND flv.enabled_flag = 'Y'
               AND iebv.bank_name = flv.description
--               AND NVL(ieba.end_date,SYSDATE) <= SYSDATE
               AND iepa.acct_site_use_id(+) = hcsua.site_use_id
           ) A 
     WHERE payment_method = 'CC'
       AND rownum <=1
       AND NOT EXISTS (SELECT ifpa.party_id
                         FROM iby_creditcard icc
                            , iby_fndcpt_payer_assgn_instr_v ifpa
                        WHERE ifpa.party_id = a.owner_id
                          AND icc.ccnumber = REPLACE(a.bank_account_num, ' ', '')
                          AND icc.instrid = ifpa.instrument_id)
  GROUP BY owner_id
         , party_name 
         , account_number
         , party_site_number
         , bank_account_name
         , party_site_id
         , ext_bank_account_id
         , bank_id
         , branch_id
         , country_code
         , currency_code
         , bank_account_num
         , object_version_number
         , start_date
         , end_date
         , expiry_date
         , instrument_type
         , instrument_id
         , instrument_payment_use_id
         , order_of_preference
         , cust_account_id
         , bank_card_issuer
         , acct_site_use_id
         , org_id
         , attribute_category
         , attribute3
         , attribute4
         , attribute13
         , attribute14
         , attribute15
         , payment_method;  
  
BEGIN
  -----------------------------------------------------
  -- Note: This example works for Vision instances
  -----------------------------------------------------
  FOR rec_test_conv IN cur_test_cc 
  LOOP         
    l_card_instrument.Owner_Id              := rec_test_conv.owner_id;
    l_card_instrument.Card_Holder_Name      := 'Test CC Conv For R12';
    l_card_instrument.Billing_Address_Id    := rec_test_conv.party_site_id;
    l_card_instrument.Card_Number           := '4012888888881881';
    l_card_instrument.Expiration_Date       := '21-OCT-2014';
    l_card_instrument.Instrument_Type       := 'CREDITCARD';
    l_card_instrument.PurchaseCard_Flag     := 'N';
    l_card_instrument.Card_Issuer           := 'VISA';
    l_card_instrument.Single_Use_Flag       := 'N';
    l_card_instrument.Info_Only_Flag        := 'N';
    l_card_instrument.Card_Purpose          := 'N';
    l_card_instrument.Card_Description      := 'Test CC Conv For R12';
    l_card_instrument.Active_Flag           := 'Y';
--    
    IBY_FNDCPT_SETUP_PUB.Create_Card (p_api_version     => 1.0,
                                      x_return_status   => l_return_status,
                                      x_msg_count       => l_msg_count,
                                      x_msg_data        => l_msg_data,
                                      p_card_instrument  => l_card_instrument,
                                      x_card_id          => l_card_id ,
                                      x_response         => l_response,
                                      p_init_msg_list    => FND_API.G_TRUE
                                     );
    dbms_output.put_line('l_return_status = ' || l_return_status);           
    dbms_output.put_line('l_msg_count = ' || l_msg_count);
    dbms_output.put_line('l_card_id = ' || l_card_id);
    dbms_output.put_line('l_response.Result_Code = ' || l_response.Result_Code);
    dbms_output.put_line('l_response.Result_Category = ' || l_response.Result_Category) ;
    dbms_output.put_line('l_response.Result_Message = ' || l_response.Result_Message) ;
----      
      IF l_msg_count >=1 THEN
        FOR i IN 1..l_msg_count  LOOP
          fnd_msg_pub.get(p_msg_index      => i,
                          p_encoded        => fnd_api.g_false,
                          p_data           => l_err_msg_tmp,
                          p_msg_index_out  => l_msg_index_out
                         );
         
          l_err_msg := l_err_msg ||','||l_err_msg_tmp;         
        END LOOP;
--          
        dbms_output.put_line(l_err_msg); 
      END IF;
--      
    END LOOP; 
    ROLLBACK;     
  EXCEPTION
    WHEN OTHERS THEN
      dbms_output.put_line('Error occured while calling Create Card API' || SQLERRM);              
END;