CREATE OR REPLACE FORCE VIEW XXRS.XXRS_AR_CUSTOMER_ACCOUNT
  /******************************************************************************************************************
  *                                                                                                                 *
  * NAME : XXRS_AR_CUSTOMER_ACCOUNT_VW.sql                                                                          *
  *                                                                                                                 *
  * DESCRIPTION : Script to recreate view XXRS_AR_CUSTOMER_ACCOUNT.                                                 *
  *                                                                                                                 *
  * AUTHOR       : SUDHEER GUNTU                                                                                    *
  * DATE WRITTEN : 09-JAN-2012                                                                                      *
  *                                                                                                                 *
  * CHANGE CONTROL :                                                                                                *
  * Version#     | REF#             | WHO                | DATE              | REMARKS                              *
  *-----------------------------------------------------------------------------------------------------------------*
  * 1.0.0        | 111122-02448     | SUDHEER GUNTU      | 09-JAN-2012       | Initial Build for R12 upgradation    *
  * 1.0.1        | 130920-04291     | Vaibhav Goyal      | 20-SEP-2013       | Accounting for payments recived on   *
  *              |                  |                    |                   | due date.                            *
  *******************************************************************************************************************/
  /* $HEADER: XXRS_AR_CUSTOMER_ACCOUNT_VW.sql 1.0.1 19-SEP-2013 5:00:00 PM VAIBHAV $ */
(
   CUSTOMER_OR_LOCATION,
   ACCTD_OR_ENTERED,
   CUSTOMER_ID,
   CUSTOMER_NAME,
   CUSTOMER_NUMBER,
   CUSTOMER_STATUS,
   CUSTOMER_SITE_USE_ID,
   LOCATION,
   CURRENCY_CODE,
   BALANCE
)
AS
     SELECT 'L',                                    /* CUSTOMER_OR_LOCATION */
            'E',                                        /* ACCTD_OR_ENTERED */
            cust_acct.cust_account_id,                       /* customer_id */
            SUBSTRB (party.party_name, 1, 50),             /* customer_name */
            cust_acct.account_number,                    /* customer_number */
            cust_acct.status,                            /* customer_status */
            su.site_use_id,                         /* customer_site_use_id */
            su.location,                                        /* location */
            ps.invoice_currency_code,                      /* currency_code */
              SUM (
                 DECODE (
                    SIGN (TRUNC (SYSDATE) - TRUNC (NVL (ps.due_date, SYSDATE))),
                    1, DECODE (SIGN (ps.amount_due_remaining),
                               1, ps.amount_due_remaining,
                               0),
                    0))
            + SUM (
                 DECODE (SIGN (ps.amount_due_remaining),
                         -1, ps.amount_due_remaining,
                         0))                                     /* Calculating total payment balance irrespective of due date 130920-04291*/
       FROM apps.ar_payment_schedules ps,
            apps.hz_cust_site_uses su,
            apps.hz_cust_acct_sites a,
            ar.hz_cust_accounts cust_acct,
            ar.hz_parties party
      WHERE     cust_acct.cust_account_id = a.cust_account_id
            AND cust_acct.party_id = party.party_id
            AND a.cust_acct_site_id = su.cust_acct_site_id
            AND su.site_use_id = ps.customer_site_use_id(+)
            AND su.site_use_code IN ('BILL_TO', 'DRAWEE')
            AND NVL (ps.receipt_confirmed_flag(+), 'Y') = 'Y'
   GROUP BY cust_acct.cust_account_id,
            party.party_name,
            cust_acct.account_number,
            cust_acct.status,
            su.site_use_id,
            su.location,
            ps.invoice_currency_code;
