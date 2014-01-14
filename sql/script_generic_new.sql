REM +=====================================================================+
REM |                Copyright (c) 1999 Oracle Corporation                |
REM |                   Redwood Shores, California, USA                   |
REM |                        All rights reserved.                         |
REM +=====================================================================+
REM |  Name                                                               |
REM |    script_generic_new.sql                                           |
REM |                                                                     |
REM |  Description                                                        |
REM |  Script to update the payment extension                             |
REM |                                                                     |
REM |  Notes                                                              |
REM |                                                                     |
REM |  History                                                            |
REM |   27-AUG-2012      ORACLE    Part of the SR . 3-5304642021          |
REM +=====================================================================+
REM
REM $Header: script_generic_new.sql SR:3-5304642021 2012/08/27 09:37:24 ORACLE ship $
REM
SET SERVEROUTPUT ON SIZE 1000000;
declare
l_payment_func IBY_UPG_INSTRUMENTS.PAYMENT_FUNCTION%TYPE;
l_org_type IBY_UPG_INSTRUMENTS.ORG_TYPE%TYPE;
l_org_id IBY_UPG_INSTRUMENTS.ORG_ID%TYPE;
l_cust_acct_id IBY_UPG_INSTRUMENTS.CUST_ACCOUNT_ID%TYPE;
l_acct_site_use_id IBY_UPG_INSTRUMENTS.ACCT_SITE_USE_ID%TYPE;
l_ext_payer_id IBY_EXTERNAL_PAYERS_ALL.EXT_PAYER_ID%TYPE;
l_instr_assign IBY_PMT_INSTR_USES_ALL.INSTRUMENT_PAYMENT_USE_ID%TYPE;
l_instrument_id IBY_UPG_INSTRUMENTS.INSTRUMENT_ID%TYPE;

cursor c_extension is
select * from ra_customer_Trx_all where payment_trxn_extension_id in (select trxn_Extension_id from 
iby_fndcpt_tx_extensions where instr_assignment_id is null);
--select * from ra_customer_Trx_all where payment_trxn_extension_id in (230431, 230456, 214702, 229289, 232692);

CURSOR c_upg_instruments (pay_cust_id ra_customer_Trx_all.PAYING_CUSTOMER_ID%TYPE, 
                          pay_site_use_id ra_customer_Trx_all.PAYING_SITE_USE_ID%TYPE) IS
select PAYMENT_FUNCTION, ORG_TYPE, ORG_ID, CUST_ACCOUNT_ID, ACCT_SITE_USE_ID, INSTRUMENT_ID 
from   IBY_UPG_INSTRUMENTS 
where  CUST_ACCOUNT_ID = pay_cust_id AND
ACCT_SITE_USE_ID = pay_site_use_id;

begin
DBMS_OUTPUT.ENABLE(1000000);
DBMS_OUTPUT.PUT_LINE('Enter');
FOR ext_rec in c_extension LOOP
	
	DBMS_OUTPUT.PUT_LINE('PAYING_CUSTOMER_ID:'|| ext_rec.PAYING_CUSTOMER_ID);
	DBMS_OUTPUT.PUT_LINE('PAYING_SITE_USE_ID:'|| ext_rec.PAYING_SITE_USE_ID);

	IF(ext_rec.PAYING_CUSTOMER_ID IS NOT NULL AND ext_rec.PAYING_SITE_USE_ID IS NOT NULL) THEN
				
		FOR upg_rec in c_upg_instruments(ext_rec.PAYING_CUSTOMER_ID, ext_rec.PAYING_SITE_USE_ID) 
		LOOP			    
			BEGIN
			DBMS_OUTPUT.PUT_LINE('Instrument ID in IBY_UPG_INSTRUMENTS:'|| upg_rec.INSTRUMENT_ID);

			SELECT EXT_PAYER_ID 
			INTO   l_ext_payer_id
			FROM   IBY_EXTERNAL_PAYERS_ALL 
			WHERE  CUST_ACCOUNT_ID = upg_rec.CUST_ACCOUNT_ID
			 AND    PAYMENT_FUNCTION = upg_rec.PAYMENT_FUNCTION
			 AND    ORG_TYPE = upg_rec.ORG_TYPE
			 AND    ORG_ID  = upg_rec.ORG_ID
			 AND    ACCT_SITE_USE_ID = upg_rec.ACCT_SITE_USE_ID;

			IF(l_ext_payer_id IS NOT NULL AND upg_rec.INSTRUMENT_ID IS NOT NULL) THEN
				
				DBMS_OUTPUT.PUT_LINE('PAYERID in IBY_EXTERNAL_PAYERS_ALL:'|| l_ext_payer_id);

				SELECT INSTRUMENT_PAYMENT_USE_ID 
				INTO   l_instr_assign
				FROM   IBY_PMT_INSTR_USES_ALL 
				WHERE  EXT_PMT_PARTY_ID = l_ext_payer_id
				AND    INSTRUMENT_ID = upg_rec.INSTRUMENT_ID
				AND ORDER_OF_PREFERENCE = 1;

				DBMS_OUTPUT.PUT_LINE('THE FOLLOWING ASIGNMENTID AND PAYERID SET FOR EXTENSION ID:'|| ext_rec.payment_trxn_extension_id);
				DBMS_OUTPUT.PUT_LINE('ASSIGNMENT ID:'|| l_instr_assign);
				DBMS_OUTPUT.PUT_LINE('PAYER ID:'|| l_ext_payer_id);

				IF(l_instr_assign IS NOT NULL) THEN
				    UPDATE iby_fndcpt_tx_extensions 
				    SET INSTR_ASSIGNMENT_ID	= l_instr_assign,	
				    EXT_PAYER_ID = l_ext_payer_id		
				    WHERE TRXN_EXTENSION_ID = ext_rec.payment_trxn_extension_id;
                      commit;
				END IF;
			END IF;
			EXCEPTION
			WHEN OTHERS THEN		
			DBMS_OUTPUT.PUT_LINE('SQLCODE1: ' || SQLCODE);
			DBMS_OUTPUT.PUT_LINE('SQLERRM1: ' || SQLERRM);
			END;
		
		END LOOP;		
	END IF;
END LOOP;

DBMS_OUTPUT.PUT_LINE('Exit');
EXCEPTION
  WHEN OTHERS THEN  
  DBMS_OUTPUT.PUT_LINE('SQLCODE2: ' || SQLCODE);
  DBMS_OUTPUT.PUT_LINE('SQLERRM2: ' || SQLERRM);
end;

/
COMMIT;
