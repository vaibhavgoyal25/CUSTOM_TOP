SET SERVEROUTPUT ON;
SET LINES 100
SET PAGESIZE 1000
SET COLSEP '|'
COL file_name NEW_VALUE spool_file_name NOPRINT
SELECT 'XXRS_IEX_F_STRATEGY_VIEWS_130514-01651_'||TO_CHAR(SYSDATE,'YYYYMMDDHHMISS')||'.log' file_name
FROM DUAL;
PROMPT 'RECREATING VIEW APPS.IEX_F_XXRS_US_ENT_V';
/**************************************************************************************************
*                                                                                                 *
* NAME : IEX_F_STRATEGY_VIEWS.sql                                                                 *
*                                                                                                 *
* DESCRIPTION :                                                                                   *
* Script To update Rackspace Advance collection strategy Views.                                   *
*                                                                                                 *
* AUTHOR       : Vaibhav Goyal                                                                    *
*                                                                                                 *
* CHANGE CONTROL :                                                                                *
* VER #  |  TICKET #    | WHO             |  DATE         |  REMARKS                              *
*-------------------------------------------------------------------------------------------------*
* 1.0.0  | 130514-01651 | Vaibhav Goyal   |  15-MAY-2013  | Initial Creation                      *
**************************************************************************************************/
/* $Header: IEX_F_STRATEGY_VIEWS.sql 1.0.0 15-MAY-2013 10:00:00 AM Vaibhav Goyal $ */

CREATE OR REPLACE FORCE VIEW APPS.IEX_F_XXRS_US_ENT_V
(
   CUST_ACCOUNT_ID
)
AS
/* $Header: IEX_F_XXRS_US_ENT_V 1.0.1 15-MAY-2013 10:00:00 AM Vaibhav Goyal $ */
     SELECT cust_account_id
       FROM iex_delinquencies de
      WHERE     1 = 1
            AND de.status <> 'CURRENT'
            AND 127 = mo_global.get_current_org_id
            AND NOT EXISTS
                   (SELECT 'X'
                      FROM xxrs_ar_cust_multi_org_v
                     WHERE cust_account_id = de.cust_account_id)
            AND NOT EXISTS
                   (SELECT 'X'
                      FROM apps.iex_f_xxrs_no_aging_v navw
                     WHERE navw.cust_account_id = de.cust_account_id)
            AND EXISTS
                   (SELECT 'X'
                      FROM ar.hz_cust_accounts hca,
                           ar.hz_cust_acct_sites_all hcsa,
                           ar.hz_cust_site_uses_all hcsua
                     WHERE     1 = 1
                           AND hca.cust_account_id = hcsa.cust_account_id
                           AND hcsua.cust_acct_site_id = hcsa.cust_acct_site_id
                           AND hcsua.primary_flag = 'Y'
                           AND hca.cust_account_id = de.cust_account_id
                           AND hcsa.attribute5 = 'ENT')
   GROUP BY cust_account_id;
-----------------------------------------
PROMPT 'RECREATING VIEW APPS.IEX_F_XXRS_US_EMG_V';

CREATE OR REPLACE FORCE VIEW APPS.IEX_F_XXRS_US_EMG_V
(
   CUST_ACCOUNT_ID
)
AS
/* $Header: IEX_F_XXRS_US_EMG_V 1.0.1 15-MAY-2013 10:00:00 AM Vaibhav Goyal $ */
     SELECT cust_account_id
       FROM apps.iex_delinquencies de
      WHERE     1 = 1
            AND de.status <> 'CURRENT'
            AND 127 = mo_global.get_current_org_id
            AND NOT EXISTS
                   (SELECT 'X'
                      FROM apps.xxrs_ar_cust_multi_org_v
                     WHERE cust_account_id = de.cust_account_id)
            AND NOT EXISTS
                   (SELECT 'X'
                      FROM apps.iex_f_xxrs_no_aging_v navw
                     WHERE navw.cust_account_id = de.cust_account_id)
            AND EXISTS
                   (SELECT 'X'
                      FROM ar.hz_cust_accounts hca,
                           ar.hz_cust_acct_sites_all hcsa,
                           ar.hz_cust_site_uses_all hcsua
                     WHERE     1 = 1
                           AND hca.cust_account_id = hcsa.cust_account_id
                           AND hcsua.cust_acct_site_id = hcsa.cust_acct_site_id
                           AND hcsua.primary_flag = 'Y'
                           AND hca.cust_account_id = de.cust_account_id
                           AND hcsa.attribute5 = 'EMG')
   GROUP BY cust_account_id;
-----------------------------------------
PROMPT 'RECREATING VIEW APPS.IEX_F_XXRS_US_EMA_V';

CREATE OR REPLACE FORCE VIEW APPS.IEX_F_XXRS_US_EMA_V
(
   CUST_ACCOUNT_ID
)
AS
/* $Header: IEX_F_XXRS_US_EMA_V 1.0.1 15-MAY-2013 10:00:00 AM Vaibhav Goyal $ */
     SELECT cust_account_id
       FROM iex_delinquencies de
      WHERE     1 = 1
            AND de.status <> 'CURRENT'
            AND 127 = mo_global.get_current_org_id
            AND NOT EXISTS
                   (SELECT 'X'
                      FROM xxrs_ar_cust_multi_org_v
                     WHERE cust_account_id = de.cust_account_id)
            AND NOT EXISTS
                   (SELECT 'X'
                      FROM apps.iex_f_xxrs_no_aging_v navw
                     WHERE navw.cust_account_id = de.cust_account_id)
            AND EXISTS
                   (SELECT 'X'
                      FROM hz_cust_accounts hca,
                           hz_cust_acct_sites_all hcsa,
                           ar.hz_cust_site_uses_all hcsua
                     WHERE     1 = 1
                           AND hca.cust_account_id = hcsa.cust_account_id
                           AND hcsua.cust_acct_site_id = hcsa.cust_acct_site_id
                           AND hcsua.primary_flag = 'Y'
                           AND hca.cust_account_id = de.cust_account_id
                           AND hcsa.attribute5 = 'EMA')
   GROUP BY cust_account_id;
-----------------------------------------
PROMPT 'RECREATING VIEW APPS.IEX_F_XXRS_US_CRP_V';

CREATE OR REPLACE FORCE VIEW APPS.IEX_F_XXRS_US_CRP_V
(
   CUST_ACCOUNT_ID
)
AS
/* $Header: IEX_F_XXRS_US_CRP_V 1.0.1 15-MAY-2013 10:00:00 AM Vaibhav Goyal $ */
     SELECT cust_account_id
       FROM iex_delinquencies de
      WHERE     1 = 1
            AND de.status <> 'CURRENT'
            AND 127 = mo_global.get_current_org_id
            AND NOT EXISTS
                   (SELECT 'X'
                      FROM xxrs_ar_cust_multi_org_v
                     WHERE cust_account_id = de.cust_account_id)
            AND NOT EXISTS
                   (SELECT 'X'
                      FROM apps.iex_f_xxrs_no_aging_v navw
                     WHERE navw.cust_account_id = de.cust_account_id)
            AND EXISTS
                   (SELECT 'X'
                      FROM hz_cust_accounts hca,
                           hz_cust_acct_sites_all hcsa,
                           ar.hz_cust_site_uses_all hcsua
                     WHERE     1 = 1
                           AND hca.cust_account_id = hcsa.cust_account_id
                           AND hcsua.cust_acct_site_id = hcsa.cust_acct_site_id
                           AND hcsua.primary_flag = 'Y'
                           AND hca.cust_account_id = de.cust_account_id
                           AND hcsa.attribute5 = 'CRP')
   GROUP BY cust_account_id;
-----------------------------------------
PROMPT 'RECREATING VIEW APPS.IEX_F_XXRS_UNKNOWN_V';

CREATE OR REPLACE FORCE VIEW APPS.IEX_F_XXRS_UNKNOWN_V
(
   CUST_ACCOUNT_ID
)
AS
/* $Header: IEX_F_XXRS_UNKNOWN_V 1.0.1 15-MAY-2013 10:00:00 AM Vaibhav Goyal $ */
     SELECT cust_account_id
       FROM iex_delinquencies de
      WHERE     1 = 1
            AND de.status <> 'CURRENT'
            AND NOT EXISTS
                   (SELECT 'X'
                      FROM xxrs_ar_cust_multi_org_v
                     WHERE cust_account_id = de.cust_account_id)
            AND NOT EXISTS
                   (SELECT 'X'
                      FROM apps.iex_f_xxrs_no_aging_v navw
                     WHERE navw.cust_account_id = de.cust_account_id)
            AND EXISTS
                   (SELECT 'X'
                      FROM ar.hz_cust_accounts hca,
                           ar.hz_cust_acct_sites_all hcsa,
                           ar.hz_cust_site_uses_all hcsua
                     WHERE     1 = 1
                           AND hca.cust_account_id = hcsa.cust_account_id
                           AND hcsua.cust_acct_site_id = hcsa.cust_acct_site_id
                           AND hcsua.primary_flag = 'Y'
                           AND hca.cust_account_id = de.cust_account_id
                           AND hcsa.attribute5 = 'NTM')
   GROUP BY de.cust_account_id;

-----------------------------------------
PROMPT 'RECREATING VIEW APPS.IEX_F_XXRS_UK_SMB_V';

CREATE OR REPLACE FORCE VIEW APPS.IEX_F_XXRS_UK_SMB_V
(
   CUST_ACCOUNT_ID
)
AS
/* $Header: IEX_F_XXRS_UK_SMB_V 1.0.1 15-MAY-2013 10:00:00 AM Vaibhav Goyal $ */
     SELECT cust_account_id
       FROM apps.iex_delinquencies de
      WHERE     1 = 1
            AND de.status <> 'CURRENT'
            AND 126 = mo_global.get_current_org_id
            AND NOT EXISTS
                   (SELECT 'X'
                      FROM apps.xxrs_ar_cust_multi_org_v
                     WHERE cust_account_id = de.cust_account_id)
            AND NOT EXISTS
                   (SELECT 'X'
                      FROM apps.iex_f_xxrs_no_aging_v navw
                     WHERE navw.cust_account_id = de.cust_account_id)
            AND EXISTS
                   (SELECT 'X'
                      FROM ar.hz_cust_accounts hca,
                           ar.hz_cust_acct_sites_all hcsa,
                           ar.hz_cust_site_uses_all hcsua
                     WHERE     1 = 1
                           AND hca.cust_account_id = hcsa.cust_account_id
                           AND hcsua.cust_acct_site_id = hcsa.cust_acct_site_id
                           AND hcsua.primary_flag = 'Y'
                           AND hca.cust_account_id = de.cust_account_id
                           AND hcsa.attribute5 = 'EMG')
   GROUP BY cust_account_id;

-----------------------------------------
PROMPT 'RECREATING VIEW APPS.IEX_F_XXRS_UK_ENT_V';

CREATE OR REPLACE FORCE VIEW APPS.IEX_F_XXRS_UK_ENT_V
(
   CUST_ACCOUNT_ID
)
AS
/* $Header: IEX_F_XXRS_UK_ENT_V 1.0.1 15-MAY-2013 10:00:00 AM Vaibhav Goyal $ */
     SELECT cust_account_id
       FROM iex_delinquencies de
      WHERE     1 = 1
            AND de.status <> 'CURRENT'
            AND 126 = mo_global.get_current_org_id
            AND NOT EXISTS
                   (SELECT 'X'
                      FROM xxrs_ar_cust_multi_org_v
                     WHERE cust_account_id = de.cust_account_id)
            AND NOT EXISTS
                   (SELECT 'X'
                      FROM apps.iex_f_xxrs_no_aging_v navw
                     WHERE navw.cust_account_id = de.cust_account_id)
            AND EXISTS
                   (SELECT 'X'
                      FROM hz_cust_accounts hca,
                           hz_cust_acct_sites_all hcsa,
                           ar.hz_cust_site_uses_all hcsua
                     WHERE     1 = 1
                           AND hca.cust_account_id = hcsa.cust_account_id
                           AND hcsua.cust_acct_site_id = hcsa.cust_acct_site_id
                           AND hcsua.primary_flag = 'Y'
                           AND hca.cust_account_id = de.cust_account_id
                           AND hcsa.attribute5 = 'ENT')
   GROUP BY cust_account_id;
-----------------------------------------
PROMPT 'RECREATING VIEW APPS.IEX_F_XXRS_NL_ENT_V';

CREATE OR REPLACE FORCE VIEW APPS.IEX_F_XXRS_NL_ENT_V
(
   CUST_ACCOUNT_ID
)
AS
/* $Header: IEX_F_XXRS_NL_ENT_V 1.0.1 15-MAY-2013 10:00:00 AM Vaibhav Goyal $ */
     SELECT cust_account_id
       FROM apps.iex_delinquencies de
      WHERE     1 = 1
            AND de.status <> 'CURRENT'
            AND 420 = mo_global.get_current_org_id
            AND NOT EXISTS
                   (SELECT 'X'
                      FROM apps.xxrs_ar_cust_multi_org_v
                     WHERE cust_account_id = de.cust_account_id)
            AND NOT EXISTS
                   (SELECT 'X'
                      FROM apps.iex_f_xxrs_no_aging_v navw
                     WHERE navw.cust_account_id = de.cust_account_id)
            AND EXISTS
                   (SELECT 'X'
                      FROM ar.hz_cust_accounts hca,
                           ar.hz_cust_acct_sites_all hcsa,
                           ar.hz_cust_site_uses_all hcsua
                     WHERE     1 = 1
                           AND hca.cust_account_id = hcsa.cust_account_id
                           AND hcsua.cust_acct_site_id = hcsa.cust_acct_site_id
                           AND hcsua.primary_flag = 'Y'
                           AND hca.cust_account_id = de.cust_account_id
                           AND hcsa.attribute5 = 'ENT')
   GROUP BY cust_account_id;
-----------------------------------------
PROMPT 'RECREATING VIEW APPS.IEX_F_XXRS_NL_EMG_V';

CREATE OR REPLACE FORCE VIEW APPS.IEX_F_XXRS_NL_EMG_V
(
   CUST_ACCOUNT_ID
)
AS
/* $Header: IEX_F_XXRS_NL_EMG_V 1.0.1 15-MAY-2013 10:00:00 AM Vaibhav Goyal $ */
     SELECT cust_account_id
       FROM apps.iex_delinquencies de
      WHERE     1 = 1
            AND de.status <> 'CURRENT'
            AND 420 = mo_global.get_current_org_id
            AND NOT EXISTS
                   (SELECT 'X'
                      FROM apps.xxrs_ar_cust_multi_org_v
                     WHERE cust_account_id = de.cust_account_id)
            AND NOT EXISTS
                   (SELECT 'X'
                      FROM apps.iex_f_xxrs_no_aging_v navw
                     WHERE navw.cust_account_id = de.cust_account_id)
            AND EXISTS
                   (SELECT 'X'
                      FROM ar.hz_cust_accounts hca,
                           ar.hz_cust_acct_sites_all hcsa,
                           ar.hz_cust_site_uses_all hcsua
                     WHERE     1 = 1
                           AND hca.cust_account_id = hcsa.cust_account_id
                           AND hcsua.cust_acct_site_id = hcsa.cust_acct_site_id
                           AND hcsua.primary_flag = 'Y'
                           AND hca.cust_account_id = de.cust_account_id
                           AND hcsa.attribute5 = 'EMG')
   GROUP BY cust_account_id;
-----------------------------------------
PROMPT 'RECREATING VIEW APPS.IEX_F_XXRS_HK_ENT_V';

CREATE OR REPLACE FORCE VIEW APPS.IEX_F_XXRS_HK_ENT_V
(
   CUST_ACCOUNT_ID
)
AS
/* $Header: IEX_F_XXRS_HK_ENT_V 1.0.1 15-MAY-2013 10:00:00 AM Vaibhav Goyal $ */
     SELECT cust_account_id
       FROM iex_delinquencies de
      WHERE     1 = 1
            AND de.status <> 'CURRENT'
            AND 559 = mo_global.get_current_org_id
            AND NOT EXISTS
                   (SELECT 'X'
                      FROM xxrs_ar_cust_multi_org_v
                     WHERE cust_account_id = de.cust_account_id)
            AND NOT EXISTS
                   (SELECT 'X'
                      FROM apps.iex_f_xxrs_no_aging_v navw
                     WHERE navw.cust_account_id = de.cust_account_id)
            AND EXISTS
                   (SELECT 'X'
                      FROM hz_cust_accounts hca,
                           hz_cust_acct_sites_all hcsa,
                           ar.hz_cust_site_uses_all hcsua
                     WHERE     1 = 1
                           AND hca.cust_account_id = hcsa.cust_account_id
                           AND hcsua.cust_acct_site_id = hcsa.cust_acct_site_id
                           AND hcsua.primary_flag = 'Y'
                           AND hca.cust_account_id = de.cust_account_id
                           AND hcsa.attribute5 = 'ENT')
   GROUP BY cust_account_id;
-----------------------------------------
PROMPT 'RECREATING VIEW APPS.IEX_F_XXRS_HK_EMG_V';

CREATE OR REPLACE FORCE VIEW APPS.IEX_F_XXRS_HK_EMG_V
(
   CUST_ACCOUNT_ID
)
AS
/* $Header: IEX_F_XXRS_HK_EMG_V 1.0.1 15-MAY-2013 10:00:00 AM Vaibhav Goyal $ */
     SELECT cust_account_id
       FROM apps.iex_delinquencies de
      WHERE     1 = 1
            AND de.status <> 'CURRENT'
            AND 559 = mo_global.get_current_org_id
            AND NOT EXISTS
                   (SELECT 'X'
                      FROM apps.xxrs_ar_cust_multi_org_v
                     WHERE cust_account_id = de.cust_account_id)
            AND NOT EXISTS
                   (SELECT 'X'
                      FROM apps.iex_f_xxrs_no_aging_v navw
                     WHERE navw.cust_account_id = de.cust_account_id)
            AND EXISTS
                   (SELECT 'X'
                      FROM ar.hz_cust_accounts hca,
                           ar.hz_cust_acct_sites_all hcsa,
                           ar.hz_cust_site_uses_all hcsua
                     WHERE     1 = 1
                           AND hca.cust_account_id = hcsa.cust_account_id
                           AND hcsua.cust_acct_site_id = hcsa.cust_acct_site_id
                           AND hcsua.primary_flag = 'Y'
                           AND hca.cust_account_id = de.cust_account_id
                           AND hcsa.attribute5 = 'EMG')
   GROUP BY cust_account_id;
-----------------------------------------




