/**********************************************************************************************************************
*                                                                                                                     *
* NAME : IEX_F_XXRS_NO_AGING_V.sql                                                                                 *
*                                                                                                                     *
* DESCRIPTION : View to list delinquent customers with no agin as per Rackspace custom rules                          *
*                                                                                                                     *
* AUTHOR       : Pavan Amirineni                                                                                      *
* DATE WRITTEN : 12/05/2011                                                                                           *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* Version#  | Ticket #      | WHO             |  DATE          |   REMARKS                                            *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0     | 111122-02448  | Pavan Amirineni | 12/05/2011     | Initial Creation                                     *
**********************************************************************************************************************/
/* $Header: IEX_F_XXRS_NO_AGING_V.sql 1.0.0 12/05/2011 15:00:00 Pavan Amirineni$ */
CREATE OR REPLACE FORCE VIEW apps.IEX_F_XXRS_NO_AGING_V
(
  cust_account_id
)
AS
  SELECT cust_account_id
    FROM iex_f_xxrs_delinq_cust_v delinq
   WHERE 1 = 1
     AND EXISTS
           (SELECT 1
              FROM xxrs.xxrs_iex_no_aging_customers nac
             WHERE 1 = 1
               AND nac.cust_account_id = delinq.cust_account_id
               AND nac.org_id = mo_global.get_current_org_id
               );