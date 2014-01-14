CREATE OR REPLACE FORCE VIEW apps.XXRS_AR_CUST_MULTI_ORG_V
/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_AR_CUST_MULTI_ORG_V.sql                                                                                 *
*                                                                                                                     *
* DESCRIPTION : View to group advanced collections teams                                                              *
*                                                                                                                     *
* AUTHOR       : Pavan Amirineni                                                                                      *
* DATE WRITTEN : 12/05/2011                                                                                           *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* Version#  | Ticket #      | WHO             |  DATE          |   REMARKS                                            *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0     | 111122-02448  | Pavan Amirineni | 12/05/2011     | Initial Creation                                     *
**********************************************************************************************************************/
/* $Header: XXRS_AR_CUST_MULTI_ORG_V.sql 1.0.0 12/05/2011 15:00:00 Pavan Amirineni$ */
(
  cust_account_id
)
AS
  SELECT   customer_id cust_account_id
      FROM (SELECT   org_id
                   ,  SUM ( amount_due_remaining )
                   ,  customer_id
                   ,  COUNT ( * )
                FROM ar_payment_schedules_all
                   ,  (SELECT   cust_account_id
                           FROM (SELECT   hca.cust_account_id
                                        ,  hcsa.org_id
                                     FROM hz_cust_accounts_all hca
                                        ,  hz_cust_acct_sites_all hcsa
                                    WHERE hca.cust_account_id = hcsa.cust_account_id
                                 GROUP BY hca.cust_account_id
                                        ,  hcsa.org_id) a
                       GROUP BY cust_account_id
                         HAVING COUNT ( * ) > 1) mul
               WHERE customer_id = mul.cust_account_id
                 AND amount_due_remaining > 0
            GROUP BY org_id
                   ,  customer_id)
     WHERE 1 = 1
  GROUP BY customer_id
    HAVING COUNT ( * ) > 1
  UNION ALL
  SELECT   cust_account_id cust_account_id
      FROM (SELECT   hca.account_number
                   ,  hca.cust_account_id
                   ,  hcsa.org_id
                FROM hz_cust_accounts_all hca
                   ,  hz_cust_acct_sites_all hcsa
               WHERE hca.cust_account_id = hcsa.cust_account_id
                 AND hcsa.status = 'A'
            GROUP BY hca.account_number
                   ,  hca.cust_account_id
                   ,  hcsa.org_id) a
  GROUP BY account_number
         ,  cust_account_id
    HAVING COUNT ( * ) > 1;
/    