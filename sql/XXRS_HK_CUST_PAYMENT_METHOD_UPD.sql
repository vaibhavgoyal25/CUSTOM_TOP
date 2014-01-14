set verify off;
set linesize 200;
set serveroutput on size 1000000;
spool XXRS_HK_CUST_PAYMENT_METHOD_UPD_130225-07630.log;
DECLARE
--
  /***********************************************************************************************************************************
  *                                                                                                                                  *
  * NAME : XXRS_HK_CUST_PAYMENT_METHOD_UPD.sql                                                                                       *
  *                                                                                                                                  *
  *  DESCRIPTION :                                                                                                                   *
  *  Script to update the CC Payment Method For HK Customers.                                                                        *
  *                                                                                                                                  *
  *  AUTHOR       : VAIBHAV GOYAL                                                                                                    *
  *  DATE WRITTEN : 03/11/2013                                                                                                       *
  *                                                                                                                                  *
  *  CHANGE CONTROL :                                                                                                                *
  *----------------------------------------------------------------------------------------------------------------------------------*
  * VERSION |GENIE TICKET # |       WHO       |  DATE       |                    REMARKS                                             *
  *----------------------------------------------------------------------------------------------------------------------------------*
  * 1.0.0   |130225-07630   | Vaibhav Goyal   | 03/11/2013  | Initial Creation                                                       * 
  ************************************************************************************************************************************/
  /*$Header: XXRS_HK_CUST_PAYMENT_METHOD_UPD.sql 1.0.0 03/11/2013 Vaibhav Goyal $*/
--

CURSOR cur_cust_pay_method is 
       SELECT  cust.account_number,
               arm.name payment_method,
               cust_site.cust_account_id,
               cust_site.cust_acct_site_id,
               cust_site_use.site_use_id, 
               cust_site_use.org_id
             , cust_site.attribute1 site_currency
          FROM ar.hz_cust_site_uses_all cust_site_use
             , ar.hz_cust_acct_sites_all cust_site
             , ar.hz_party_sites party_site
             , ar.hz_locations locations
             , ar.hz_cust_accounts cust
             ,ar.ra_cust_receipt_methods rcrm, ar.ar_receipt_methods arm
         WHERE party_site.location_id = locations.location_id
           AND cust_site.party_site_id = party_site.party_site_id
           AND cust_site_use.site_use_code = 'BILL_TO'
           AND cust_site_use.primary_flag = 'Y' 
           AND cust_site_use.status = 'A'
           AND cust_site.status = 'A'
           AND cust_site.cust_acct_site_id = cust_site_use.cust_acct_site_id
         AND rcrm.primary_flag = 'Y'
         AND rcrm.receipt_method_id = arm.receipt_method_id
         AND SYSDATE BETWEEN NVL ( rcrm.start_date, SYSDATE ) AND NVL ( rcrm.end_date, SYSDATE + 1 )
         AND substr(arm.name,1,2) = 'CC'
         AND arm.name not in ('CC Visa','CC Amex','CC Mastercard')
         AND rcrm.site_use_id = cust_site_use.site_use_id
         AND rcrm.customer_id = cust.cust_account_id
         AND cust_site.org_id = 559
         AND cust_site.cust_account_id = cust.cust_account_id
      GROUP BY cust.account_number,
               arm.name,
               cust_site.cust_account_id,
               cust_site.cust_acct_site_id,
               cust_site_use.site_use_id,
               cust_site_use.org_id,
               cust_site.attribute1;

l_bank_name             VARCHAR2(100);
v_out_return_value      NUMBER := NULL;
v_user_id               applsys.fnd_user.user_id%TYPE := -1;
v_count                 NUMBER(10) := 1;


  --
  --------------------------------------------------------------------------------
  -- Procedure create_update_receipt_method : Function to Insert Or Update the
  -- Receipt Method for Inserted or Updated Bank Account Information
  --------------------------------------------------------------------------------
  --
  PROCEDURE create_update_receipt_method ( p_payment_method_name  IN     VARCHAR2,
                                           p_bank_name            IN     VARCHAR2,
                                           p_currency_code        IN     VARCHAR2,
                                           p_user_id              IN     NUMBER,
                                           p_customer_id          IN     NUMBER,
                                           p_site_use_id          IN     NUMBER,
                                           p_org_id               IN     NUMBER,
                                           p_customer_number      IN     VARCHAR2,
                                           p_from_payment_method  IN     VARCHAR2,                                           
                                           p_out_return_value     OUT NUMBER )
  IS
    v_receipt_method_id        ar_receipt_methods.receipt_method_id%TYPE;
    v_rowid                    VARCHAR2 ( 100 );                                                                 --ra_cust_receipt_methods.rowid%TYPE;
    v_cust_receipt_method_id   ra_cust_receipt_methods.cust_receipt_method_id%TYPE;
    v_receipt_method_name      ar_receipt_methods.name%TYPE;

    --------------------------------------------------------------------------------
    -- Function To Fetch Receipt Method ID
    --------------------------------------------------------------------------------
    FUNCTION get_receipt_method_id ( p_payment_method_name IN VARCHAR2 )
      RETURN NUMBER
    IS
      l_receipt_method_id   NUMBER ( 10 );
    BEGIN
      --
      l_receipt_method_id := NULL;

      --
      IF p_payment_method_name = 'ACH CHASE'
      THEN
        BEGIN
          SELECT receipt_method_id
            INTO l_receipt_method_id
            FROM ar_receipt_methods
           WHERE name = p_payment_method_name;
        EXCEPTION
          WHEN OTHERS
          THEN
            l_receipt_method_id := NULL;
        END;
      ELSE
        BEGIN
          SELECT arm.receipt_method_id
            INTO l_receipt_method_id
            FROM ar_receipt_methods arm, ar_receipt_method_accounts_all arma, ce_bank_accounts cba, ce_bank_acct_uses_all cbau, fnd_lookup_values flv
           WHERE arma.receipt_method_id = arm.receipt_method_id
             AND arma.remit_bank_acct_use_id = cbau.bank_acct_use_id
             AND cbau.bank_account_id = cba.bank_account_id
             AND cbau.org_id = p_org_id
             AND TRUNC ( SYSDATE ) BETWEEN arma.start_date AND NVL ( arma.end_date, SYSDATE + 1 )
             AND arm.end_date IS NULL
             AND NVL ( cba.end_date, SYSDATE ) >= SYSDATE
             AND arma.primary_flag = 'Y'
             AND UPPER ( arm.name ) = DECODE ( cba.currency_code, p_currency_code, UPPER ( meaning ), UPPER ( meaning ) || ' - ' || p_currency_code )
             AND flv.lookup_type = 'XXRS_AR_CREDIT_CARD_TYPES'
             AND flv.description = p_bank_name;
        --
        EXCEPTION
          WHEN OTHERS
          THEN
            l_receipt_method_id := NULL;
        END;
      END IF;

      --
      RETURN l_receipt_method_id;
    --
    EXCEPTION
      WHEN OTHERS
      THEN
        RETURN NULL;
    END;
  --
  BEGIN
    p_out_return_value  := 0;
    --------------------------------------------------------------------------------
    -- Attach receipt method to the customer Once Bank Account Use is created
    --------------------------------------------------------------------------------
    v_receipt_method_id := get_receipt_method_id ( p_payment_method_name );
    
    
        BEGIN
          SELECT name 
            INTO v_receipt_method_name 
            FROM ar_receipt_methods
           WHERE receipt_method_id= v_receipt_method_id;
        EXCEPTION
          WHEN OTHERS
          THEN
            v_receipt_method_name := NULL;
        END;

    --
    BEGIN
      UPDATE ra_cust_receipt_methods
         SET primary_flag = 'N', last_update_date = SYSDATE, last_updated_by = p_user_id
       WHERE site_use_id = p_site_use_id AND customer_id = p_customer_id;

      --
    EXCEPTION
      WHEN OTHERS
      THEN
        p_out_return_value := 0;
    END;

    --
    BEGIN
      arp_crm_pkg.insert_row ( v_rowid,
                               v_cust_receipt_method_id,
                               p_user_id,
                               SYSDATE,
                               p_customer_id,
                               p_user_id,
                               SYSDATE,
                               'Y',
                               v_receipt_method_id,
                               TRUNC ( SYSDATE ),
                               NULL,
                               p_user_id                                                                                         --fnd_global.login_id
                                        ,
                               p_site_use_id,
                               NULL,
                               NULL,
                               NULL,
                               NULL,
                               NULL,
                               NULL,
                               NULL,
                               NULL,
                               NULL,
                               NULL,
                               NULL,
                               NULL,
                               NULL,
                               NULL,
                               NULL,
                               NULL );
      --
    EXCEPTION
      WHEN OTHERS
      THEN
        p_out_return_value := 0;
    END;
--
    BEGIN
      UPDATE ra_cust_receipt_methods
         SET primary_flag = 'Y', last_update_date = SYSDATE, last_updated_by = p_user_id
       WHERE site_use_id = p_site_use_id
         AND customer_id = p_customer_id
         AND receipt_method_id = v_receipt_method_id
         AND cust_receipt_method_id IN
               (SELECT MAX ( cust_receipt_method_id )
                  FROM ra_cust_receipt_methods
                 WHERE site_use_id = p_site_use_id AND customer_id = p_customer_id AND receipt_method_id = v_receipt_method_id);

      --
      p_out_return_value := 100;
  DBMS_OUTPUT.PUT_LINE(v_count||': Successfully Updated payment Method of Customer '||p_customer_number ||' From '||p_from_payment_method||' to '||v_receipt_method_name);
    EXCEPTION
      WHEN OTHERS
      THEN
        p_out_return_value := 0;
    END;
    --
  --
  EXCEPTION
    WHEN OTHERS
    THEN
      p_out_return_value := 0;
  END;

BEGIN

FOR rec_cust_pay_method in cur_cust_pay_method
LOOP

IF instr(upper(rec_cust_pay_method.payment_method),'VISA') != 0 THEN
l_bank_name := 'CREDIT CARD VISA';
ELSIF instr(upper(rec_cust_pay_method.payment_method),'MASTER') != 0 THEN
l_bank_name := 'CREDIT CARD MASTERCARD';
ELSIF instr(upper(rec_cust_pay_method.payment_method),'AMEX') != 0 THEN
l_bank_name := 'CREDIT CARD AMERICAN EXPRESS';
END IF;

                            create_update_receipt_method 
                                         ( 'CREDIT CARD',
                                           l_bank_name,
                                           rec_cust_pay_method.site_currency,
                                           v_user_id,
                                           rec_cust_pay_method.cust_account_id,
                                           rec_cust_pay_method.site_use_id,
                                           rec_cust_pay_method.org_id,
                                           rec_cust_pay_method.account_number,
                                           rec_cust_pay_method.payment_method,
                                           v_out_return_value);

IF v_out_return_value = 100 THEN
  v_count := v_count+1;
--  DBMS_OUTPUT.PUT_LINE(v_count||': Successfully Updated payment Method of Customer '||rec_cust_pay_method.account_number ||' From '||rec_cust_pay_method.payment_method||' to '||l_bank_name);
ELSE
  DBMS_OUTPUT.PUT_LINE('Error While Updating payment Method of Customer '||rec_cust_pay_method.account_number ||' From '||rec_cust_pay_method.payment_method||' to '||l_bank_name);
END IF;

END LOOP;

EXCEPTION
  WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE('Unknown Error '||SQLERRM);    

END;
/