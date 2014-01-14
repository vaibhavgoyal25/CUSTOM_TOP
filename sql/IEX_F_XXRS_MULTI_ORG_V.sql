/**********************************************************************************************************************
*                                                                                                                     *
* NAME : IEX_F_XXRS_MULTI_ORG_V.sql   140114-11116                                                                              *
*                                                                                                                     *
* DESCRIPTION : View to list delinquent multi org customers                                                 *
*                                                                                                                     *
* AUTHOR       : Pavan Amirineni                                                                                      *
* DATE WRITTEN : 12/05/2011                                                                                           *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* Version#  | Ticket #      | WHO             |  DATE          |   REMARKS                                            *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0     | 111122-02448  | Pavan Amirineni | 12/05/2011     | Initial Creation                                     *
**********************************************************************************************************************/
/* $Header: IEX_F_XXRS_MULTI_ORG_V.sql 1.0.0 12/05/2011 15:00:00 Pavan Amirineni$ */
CREATE OR REPLACE FORCE VIEW apps.iex_f_xxrs_multi_org_v ( cust_account_id )
AS
  SELECT   cust_account_id
      FROM iex_delinquencies de
     WHERE 1 = 1
       AND de.status <> 'CURRENT'
       AND EXISTS
             (SELECT 'X'
                FROM xxrs_ar_cust_multi_org_v
               WHERE cust_account_id = de.cust_account_id)
  GROUP BY cust_account_id;
/