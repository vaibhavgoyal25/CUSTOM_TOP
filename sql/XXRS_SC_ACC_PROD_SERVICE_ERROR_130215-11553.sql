/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_SC_ACC_PROD_SERVICE_ERROR_130215-11553.sql                                                              *
*                                                                                                                     *
* DESCRIPTION :                                                                                                       *
* Script to update the service for account products                                                                   *
*                                                                                                                     *
* AUTHOR       : Vinodh Bhasker                                                                                       *
* DATE WRITTEN : 21-FEB-2013                                                                                          *
*                                                                                                                     *
* CHANGE CONTROL : 1.0.0                                                                                              *
* SR#                 GENIE Ticket #    WHO                DATE                          REMARKS                      *
*                    130215-11553      Vinodh Bhasker   21-FEB-2013     Script to Update account product and          *
*                                                                       resource that are missing GL product code.    *
**********************************************************************************************************************/
/* $Header: XXRS_SC_ACC_PROD_SERVICE_ERROR_130215-11553.sql 1.0 21-FEB-2013 04:15:00 PM Vinodh Bhasker$ */
SET SERVEROUTPUT ON SIZE 100000;
SET LINE 300;
SET PAGESIZE 2000;
SET COLSEP |;
col file_name   new_value   spool_file_name    noprint
select 'XXRS_SC_ACC_PROD_SERVICE_ERROR_130215-11553' ||to_char (sysdate, '_mmddyy_hhmiss')||'.log' file_name from dual ;
spool &spool_file_name

PROMPT 'CREATE a temp table to hold the list that need to be corrected'
CREATE TABLE xxrs.xxrs_sc_acc_prod_err_tmp
AS
SELECT acc_prod.account_product_snid
     , prod.product_name
     , prod.product_def_snid
     , acc_prod.service_id
     , svc.name gl_product
     , DECODE(acc_prod.org_id, 127, 'US'
                             , 126, 'UK'
                             , 420, 'NL'
                             , 559, 'HK', acc_prod.org_id) org
     , cust.account_number
     , ps.party_site_number
     , con.contract_snid contract_number
     , (SELECT svc1.name
          FROM xxrs.xxrs_sc_service_def svc1
         WHERE con.service_id = svc1.service_id) contract_service
     , con.creation_date
  FROM xxrs.xxrs_sc_account_product_tbl acc_prod
     , xxrs.xxrs_sc_product_def_tbl prod
     , ar.hz_cust_accounts cust
     , ar.hz_cust_acct_sites_all site
     , ar.hz_party_sites ps
     , xxrs.xxrs_sc_contract_tbl con
     , xxrs.xxrs_sc_service_def svc
 WHERE 1 = 1
   AND con.contract_snid = acc_prod.contract_snid
   AND acc_prod.product_def_snid = prod.product_def_snid
   AND acc_prod.cust_account_id = cust.cust_account_id
   AND acc_prod.cust_acct_site_id = site.cust_acct_site_id
   AND site.party_site_id = ps.party_site_id
   AND svc.service_id(+) = acc_prod.service_id
   AND acc_prod.service_id IS NULL
   AND acc_prod.locked_flag != 'T'
   AND con.service_id IS NOT NULL
 ORDER BY con.creation_date desc, acc_prod.org_id, cust.account_number, ps.party_site_number, prod.product_name;

PROMPT 'SPOOL records that need to be corrected'
SELECT *
  FROM xxrs.xxrs_sc_acc_prod_err_tmp;
  
PROMPT 'UPDATE account products that have single GL product code'
UPDATE xxrs.xxrs_sc_account_product_tbl acc_prod
   SET acc_prod.service_id = (SELECT ps.service_id
                                FROM xxrs.xxrs_sc_product_services ps
                               WHERE 1 = 1
                                 AND ps.product_def_snid = acc_prod.product_def_snid 
                                 AND SYSDATE < NVL (ps.end_date, SYSDATE + 1))
 WHERE 1 = 1
   AND acc_prod.service_id IS NULL
   AND EXISTS ( SELECT 'x'
                  FROM xxrs.xxrs_sc_acc_prod_err_tmp acc_prod_err
                 WHERE 1 = 1
                   AND acc_prod_err.account_product_snid = acc_prod.account_product_snid )
   AND acc_prod.product_def_snid IN ( SELECT ps.product_def_snid
                                        FROM xxrs.xxrs_sc_product_services ps
                                       WHERE SYSDATE < NVL (ps.end_date, SYSDATE + 1)
                                       GROUP BY ps.product_def_snid
                                      HAVING COUNT (*) = 1 );

PROMPT 'UPDATE account products GL product code from Contract'
UPDATE xxrs.xxrs_sc_account_product_tbl acc_prod
   SET acc_prod.service_id = (SELECT con.service_id
                                FROM xxrs.xxrs_sc_contract_tbl con
                               WHERE 1 = 1
                                 AND con.contract_snid = acc_prod.contract_snid)
 WHERE 1 = 1
   AND acc_prod.service_id IS NULL 
   AND EXISTS ( SELECT 'x'
                  FROM xxrs.xxrs_sc_acc_prod_err_tmp acc_prod_err
                 WHERE 1 = 1
                   AND acc_prod_err.account_product_snid = acc_prod.account_product_snid )
   AND EXISTS ( SELECT 'x'
                  FROM xxrs.xxrs_sc_product_services ps1
                     , xxrs.xxrs_sc_contract_tbl con1
                 WHERE 1 = 1
                   AND con1.contract_snid = acc_prod.contract_snid
                   AND con1.service_id = ps1.service_id
                   AND ps1.product_def_snid = acc_prod.product_def_snid
                   AND SYSDATE < NVL (ps1.end_date, SYSDATE + 1));

PROMPT 'UPDATE one-off account products to their correct GL Code'
PROMPT '3 products should be updated for contract number: 666069'
UPDATE xxrs.xxrs_sc_account_product_tbl acc_prod
   SET acc_prod.service_id = (SELECT service_id
                                FROM xxrs.xxrs_sc_service_def svc
                               WHERE name = 'MANAGED COLO')
 WHERE acc_prod.contract_snid = 666069
   AND acc_prod.service_id IS NULL
   AND EXISTS ( SELECT 'x'
                  FROM xxrs.xxrs_sc_acc_prod_err_tmp acc_prod_err
                 WHERE 1 = 1
                   AND acc_prod_err.account_product_snid = acc_prod.account_product_snid )
   AND acc_prod.product_def_snid NOT IN ( SELECT ps.product_def_snid
                                            FROM xxrs.xxrs_sc_product_services ps
                                           WHERE SYSDATE < NVL (ps.end_date, SYSDATE + 1)
                                           GROUP BY ps.product_def_snid
                                          HAVING COUNT (*) = 1 );

PROMPT '1 products should be updated for contract number: 661489'                   
UPDATE xxrs.xxrs_sc_account_product_tbl acc_prod
   SET acc_prod.service_id = (SELECT service_id
                                FROM xxrs.xxrs_sc_service_def svc
                               WHERE name = 'MANAGED COLO')
 WHERE acc_prod.contract_snid = 661489
   AND acc_prod.service_id IS NULL
   AND EXISTS ( SELECT 'x'
                  FROM xxrs.xxrs_sc_acc_prod_err_tmp acc_prod_err
                 WHERE 1 = 1
                   AND acc_prod_err.account_product_snid = acc_prod.account_product_snid )
   AND acc_prod.product_def_snid NOT IN ( SELECT ps.product_def_snid
                                            FROM xxrs.xxrs_sc_product_services ps
                                           WHERE SYSDATE < NVL (ps.end_date, SYSDATE + 1)
                                           GROUP BY ps.product_def_snid
                                          HAVING COUNT (*) = 1 );
                                          
PROMPT '1 products should be updated for contract number: 669297'                   
UPDATE xxrs.xxrs_sc_account_product_tbl acc_prod
   SET acc_prod.service_id = (SELECT service_id
                                FROM xxrs.xxrs_sc_service_def svc
                               WHERE name = 'MANAGED')
 WHERE acc_prod.contract_snid = 669297
   AND acc_prod.service_id IS NULL
   AND EXISTS ( SELECT 'x'
                  FROM xxrs.xxrs_sc_acc_prod_err_tmp acc_prod_err
                 WHERE 1 = 1
                   AND acc_prod_err.account_product_snid = acc_prod.account_product_snid )
   AND acc_prod.product_def_snid NOT IN ( SELECT ps.product_def_snid
                                            FROM xxrs.xxrs_sc_product_services ps
                                           WHERE SYSDATE < NVL (ps.end_date, SYSDATE + 1)
                                           GROUP BY ps.product_def_snid
                                          HAVING COUNT (*) = 1 ); 
                                          
PROMPT '1 products should be updated for contract number: 662885'                   
UPDATE xxrs.xxrs_sc_account_product_tbl acc_prod
   SET acc_prod.service_id = (SELECT service_id
                                FROM xxrs.xxrs_sc_service_def svc
                               WHERE name = 'INTENSIVE')
 WHERE acc_prod.contract_snid = 662885
   AND acc_prod.service_id IS NULL
   AND EXISTS ( SELECT 'x'
                  FROM xxrs.xxrs_sc_acc_prod_err_tmp acc_prod_err
                 WHERE 1 = 1
                   AND acc_prod_err.account_product_snid = acc_prod.account_product_snid )
   AND acc_prod.product_def_snid NOT IN ( SELECT ps.product_def_snid
                                            FROM xxrs.xxrs_sc_product_services ps
                                           WHERE SYSDATE < NVL (ps.end_date, SYSDATE + 1)
                                           GROUP BY ps.product_def_snid
                                          HAVING COUNT (*) = 1 );
                                          
PROMPT '1 products should be updated for contract number: 660991'                   
UPDATE xxrs.xxrs_sc_account_product_tbl acc_prod
   SET acc_prod.service_id = (SELECT service_id
                                FROM xxrs.xxrs_sc_service_def svc
                               WHERE name = 'MANAGED')
 WHERE acc_prod.contract_snid = 660991
   AND acc_prod.service_id IS NULL
   AND EXISTS ( SELECT 'x'
                  FROM xxrs.xxrs_sc_acc_prod_err_tmp acc_prod_err
                 WHERE 1 = 1
                   AND acc_prod_err.account_product_snid = acc_prod.account_product_snid )
   AND acc_prod.product_def_snid NOT IN ( SELECT ps.product_def_snid
                                            FROM xxrs.xxrs_sc_product_services ps
                                           WHERE SYSDATE < NVL (ps.end_date, SYSDATE + 1)
                                           GROUP BY ps.product_def_snid
                                          HAVING COUNT (*) = 1 ); 
                                          
PROMPT '1 products should be updated for contract number: 661418'                   
UPDATE xxrs.xxrs_sc_account_product_tbl acc_prod
   SET acc_prod.service_id = (SELECT service_id
                                FROM xxrs.xxrs_sc_service_def svc
                               WHERE name = 'MANAGED')
 WHERE acc_prod.contract_snid = 661418
   AND acc_prod.service_id IS NULL
   AND EXISTS ( SELECT 'x'
                  FROM xxrs.xxrs_sc_acc_prod_err_tmp acc_prod_err
                 WHERE 1 = 1
                   AND acc_prod_err.account_product_snid = acc_prod.account_product_snid )
   AND acc_prod.product_def_snid NOT IN ( SELECT ps.product_def_snid
                                            FROM xxrs.xxrs_sc_product_services ps
                                           WHERE SYSDATE < NVL (ps.end_date, SYSDATE + 1)
                                           GROUP BY ps.product_def_snid
                                          HAVING COUNT (*) = 1 );  
                                          
PROMPT '1 products should be updated for contract number: 670184'               --Added this new segment as per Abhay from QA instance    
UPDATE xxrs.xxrs_sc_account_product_tbl acc_prod
   SET acc_prod.service_id = (SELECT service_id
                                FROM xxrs.xxrs_sc_service_def svc
                               WHERE name = 'MANAGED')
 WHERE acc_prod.contract_snid = 670184
   AND acc_prod.service_id IS NULL
   AND EXISTS ( SELECT 'x'
                  FROM xxrs.xxrs_sc_acc_prod_err_tmp acc_prod_err
                 WHERE 1 = 1
                   AND acc_prod_err.account_product_snid = acc_prod.account_product_snid )
   AND acc_prod.product_def_snid NOT IN ( SELECT ps.product_def_snid
                                            FROM xxrs.xxrs_sc_product_services ps
                                           WHERE SYSDATE < NVL (ps.end_date, SYSDATE + 1)
                                           GROUP BY ps.product_def_snid
                                          HAVING COUNT (*) = 1 );                                               
   
PROMPT 'UPDATE all the modified account product - resources to the new service'
PROMPT 'NO records updated should be fine. Having this will protect the sanity'
UPDATE xxrs.xxrs_sc_account_resource_tbl acc_res
   SET acc_res.service_id = (SELECT acc_prod.service_id
                                FROM xxrs.xxrs_sc_account_product_tbl acc_prod
                               WHERE 1 = 1
                                 AND acc_res.account_product_snid = acc_prod.account_product_snid)
 WHERE 1 = 1
   AND EXISTS ( SELECT 'x'
                  FROM xxrs.xxrs_sc_acc_prod_err_tmp acc_prod_err
                 WHERE 1 = 1
                   AND acc_prod_err.account_product_snid = acc_res.account_product_snid );

PROMPT 'After all the updates. SPOOLing the corrected records'
SELECT acc_prod.account_product_snid
     , prod.product_name
     , prod.product_def_snid
     , acc_prod.service_id
     , svc.name gl_product
     , DECODE(acc_prod.org_id, 127, 'US'
                             , 126, 'UK'
                             , 420, 'NL'
                             , 559, 'HK', acc_prod.org_id) org
     , cust.account_number
     , ps.party_site_number
     , con.contract_snid contract_number
     , (SELECT svc.name
          FROM xxrs.xxrs_sc_service_def svc
         WHERE con.service_id = svc.service_id) contract_service
     , con.creation_date
  FROM xxrs.xxrs_sc_account_product_tbl acc_prod
     , xxrs.xxrs_sc_product_def_tbl prod
     , ar.hz_cust_accounts cust
     , ar.hz_cust_acct_sites_all site
     , ar.hz_party_sites ps
     , xxrs.xxrs_sc_contract_tbl con
     , xxrs.xxrs_sc_service_def svc
 WHERE 1 = 1
   AND con.contract_snid = acc_prod.contract_snid
   AND acc_prod.product_def_snid = prod.product_def_snid
   AND acc_prod.cust_account_id = cust.cust_account_id
   AND acc_prod.cust_acct_site_id = site.cust_acct_site_id
   AND site.party_site_id = ps.party_site_id
   AND svc.service_id(+) = acc_prod.service_id
   AND acc_prod.locked_flag != 'T'
   AND acc_prod.service_id IS NOT NULL        --only spooling out fixed records and not everything
   AND EXISTS ( SELECT 'x'
                  FROM xxrs.xxrs_sc_acc_prod_err_tmp acc_prod_err
                 WHERE 1 = 1
                   AND acc_prod_err.account_product_snid = acc_prod.account_product_snid )
 ORDER BY con.creation_date desc, acc_prod.org_id, cust.account_number, ps.party_site_number, prod.product_name;

PROMPT 'After all the updates. SPOOLing the records that didn''t get updated.'
SELECT acc_prod.account_product_snid
     , prod.product_name
     , prod.product_def_snid
     , acc_prod.service_id
     , svc.name gl_product
     , DECODE(acc_prod.org_id, 127, 'US'
                             , 126, 'UK'
                             , 420, 'NL'
                             , 559, 'HK', acc_prod.org_id) org
     , cust.account_number
     , ps.party_site_number
     , con.contract_snid contract_number
     , (SELECT svc.name
          FROM xxrs.xxrs_sc_service_def svc
         WHERE con.service_id = svc.service_id) contract_service
     , con.creation_date
  FROM xxrs.xxrs_sc_account_product_tbl acc_prod
     , xxrs.xxrs_sc_product_def_tbl prod
     , ar.hz_cust_accounts cust
     , ar.hz_cust_acct_sites_all site
     , ar.hz_party_sites ps
     , xxrs.xxrs_sc_contract_tbl con
     , xxrs.xxrs_sc_service_def svc
 WHERE 1 = 1
   AND con.contract_snid = acc_prod.contract_snid
   AND acc_prod.product_def_snid = prod.product_def_snid
   AND acc_prod.cust_account_id = cust.cust_account_id
   AND acc_prod.cust_acct_site_id = site.cust_acct_site_id
   AND site.party_site_id = ps.party_site_id
   AND svc.service_id(+) = acc_prod.service_id
   AND acc_prod.service_id IS NULL
   AND acc_prod.locked_flag != 'T'
   AND EXISTS ( SELECT 'x'
                  FROM xxrs.xxrs_sc_acc_prod_err_tmp acc_prod_err
                 WHERE 1 = 1
                   AND acc_prod_err.account_product_snid = acc_prod.account_product_snid )
 ORDER BY con.creation_date desc, acc_prod.org_id, cust.account_number, ps.party_site_number, prod.product_name;

PROMPT 'Dropping the temporary table after all the updates'
PROMPT 'Caution: DML statement issues commit. All the updates till this point are saved!!'
DROP TABLE xxrs.xxrs_sc_acc_prod_err_tmp;

SPOOL OFF;

