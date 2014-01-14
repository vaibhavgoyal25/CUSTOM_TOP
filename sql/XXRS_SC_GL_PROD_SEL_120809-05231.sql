/**************************************************************************************************************
*                                                                                                             *
* NAME : XXRS_SC_GL_PROD_SEL_120809-05231.sql                                                                 *
*                                                                                                             *
* DESCRIPTION :                                                                                               *
*   Script to update GL product name for the services                                                         *
*                                                                                                             *
* AUTHOR       : Pavan Amirineni                                                                              *
* DATE WRITTEN : 21-SEP-2012                                                                                  *
*                                                                                                             *
* CHANGE CONTROL :                                                                                            *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                             *
*-------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  120809-05231     | Pavan Amirineni |  21-SEP-2012   | Initial Creation.                     *
*              |                   |                 |                |                                       *
***************************************************************************************************************/
--
/* $Header: XXRS_SC_GL_PROD_SEL_120809-05231.sql 1.0.0 09/21/2012 11:06:24 AM Pavan Amirineni $ */
--

SET SERVEROUTPUT ON SIZE 1000000
SET LINES 1000
SET PAGESIZE 1000
SET COLSEP '|'

COL file_name NEW_VALUE spool_file_name NOPRINT

SELECT 'XXRS_SC_GL_PROD_SEL_120809-05231_'||TO_CHAR(SYSDATE,'YYYYMMDDHHMISS')||'.log' file_name
FROM DUAL;

SPOOL &spool_file_name

PROMPT
PROMPT 'BEFORE UPDATING PRODUCTS' 
PROMPT

SELECT dev_prod.device_num
     , dev_prod.device_product_snid
     , con.service_id 
     , CASE WHEN dev_prod.org_id = 127
            THEN 'US'
            WHEN dev_prod.org_id = 126
            THEN 'UK'
            WHEN dev_prod.org_id = 420
            THEN 'NL'
            WHEN dev_prod.org_id = 559
            THEN 'HK'
       END org
     , def.name gl_product_name       
  FROM xxrs.xxrs_sc_device_product_tbl dev_prod 
     , xxrs.xxrs_sc_contract_tbl con
     , xxrs.xxrs_sc_service_def def 
 WHERE dev_prod.service_id is null --device_num = '430944'
   AND dev_prod.contract_snid = con.contract_snid
   AND con.service_id = def.service_id
   AND exists (SELECT 'X'
                 FROM xxrs.XXRS_SC_PRODUCT_SERVICES def2
                WHERE def2.product_def_snid = product_def_snid
               ); 
PROMPT
PROMPT 'BEFORE UPDATING Device resources' 
PROMPT                              
SELECT dev_rsr.device_resource_snid
     , dev_prod.service_id
  FROM xxrs.xxrs_sc_device_product_tbl dev_prod
     , xxrs.xxrs_sc_device_resource_tbl dev_rsr
     , apps.xxrs_sc_lookup_vw lkup
     , ar.hz_cust_accounts cust
     , xxrs.xxrs_sc_product_def_tbl prod
 WHERE 1 = 1
   AND dev_rsr.device_product_snid = dev_prod.device_product_snid
   AND lkup.lookup_type = 'RS_SC_PRODUCT_STATUS'
   AND lkup.lookup_code = dev_prod.product_status_code
   AND dev_rsr.service_id IS NULL
   AND dev_prod.service_id IS NOT NULL 
   AND cust.cust_account_id = dev_prod.cust_account_id
   AND prod.product_def_snid = dev_prod.product_def_snid
   AND EXISTS (SELECT 1 
                 FROM xxrs.xxrs_sc_product_rsrc_def_tbl prd_rsrc,
                      xxrs.xxrs_sc_device_resource_tbl dev_rsrc,
                      xxrs.xxrs_sc_resource_def_tbl rdef
                WHERE dev_rsrc.device_product_snid = dev_prod.device_product_snid                 
                  AND dev_rsrc.product_resource_def_snid = prd_rsrc.product_resource_def_snid
                  AND prd_rsrc.resource_def_snid = rdef.resource_def_snid
                  AND dev_rsrc.voided_flag = 'F'
                  AND rdef.enable_services = 'T'
                  AND dev_rsrc.service_id IS NULL
              );  
PROMPT
PROMPT 'Before Updating Account resources' 
PROMPT                 
              
  SELECT acc_rsr.account_resource_snid
       , acc_prod.service_id
   FROM xxrs.xxrs_sc_account_product_tbl acc_prod
     , xxrs.xxrs_sc_account_resource_tbl acc_rsr
     , apps.xxrs_sc_lookup_vw lkup
     , ar.hz_cust_accounts cust
     , xxrs.xxrs_sc_product_def_tbl prod
 WHERE 1 = 1
   AND acc_rsr.account_product_snid = acc_prod.account_product_snid
   AND lkup.lookup_type = 'RS_SC_PRODUCT_STATUS'
   AND lkup.lookup_code = acc_prod.product_status_code
   AND acc_rsr.service_id IS NULL
   AND acc_prod.service_id IS NOT NULL 
--   AND lkup.meaning IN ('Active', 'Offline')
--   AND acc_prod.locked_flag != 'P'
   AND cust.cust_account_id = acc_prod.cust_account_id
   AND prod.product_def_snid = acc_prod.product_def_snid
--   AND ROWNUM < 1
   AND EXISTS (SELECT 1 
            FROM xxrs.xxrs_sc_product_rsrc_def_tbl prd_rsrc,
                 xxrs.xxrs_sc_account_resource_tbl dev_rsrc,
                 xxrs.xxrs_sc_resource_def_tbl rdef
           WHERE dev_rsrc.account_product_snid = acc_prod.account_product_snid
     --        AND dev_rsrc.creating_contract_snid = dev_prod.contract_snid            
             AND dev_rsrc.product_resource_def_snid =
                                            prd_rsrc.product_resource_def_snid
             AND prd_rsrc.resource_def_snid = rdef.resource_def_snid
             AND dev_rsrc.voided_flag = 'F'
             AND rdef.enable_services = 'T'
             AND dev_rsrc.service_id IS NULL);          
/   