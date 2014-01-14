/**************************************************************************************************************
*                                                                                                             *
* NAME : XXRS_SC_DEVICE_PP_DATAFIX_2_DEV_120522-07164.sql                                                     *
*                                                                                                             *
* DESCRIPTION :                                                                                               *
*   Script to update Prepay Start Date and End Date For Prepay Devices with null Prepay start and End Dates.  *
*                                                                                                             *
* AUTHOR       : Vaibhav Goyal                                                                                *
* DATE WRITTEN : 31-JUL-2012                                                                                  *
*                                                                                                             *
* CHANGE CONTROL :                                                                                            *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                             *
*-------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  120522-07164     | Vaibhav Goyal   |  31-JUL-2012   | Initial Creation.                     *
*              |                   |                 |                |                                       *
***************************************************************************************************************/
--
/* $Header: XXRS_SC_DEVICE_PP_DATAFIX_2_DEV_120522-07164.sql 1.0.0 07/31/2012 11:06:24 AM Vaibhav Goyal $ */
--
-- -----------------------------------------------------------------------------
--    ARGUMENTS:
--
--
--    RETURNS:
--
--
-- -----------------------------------------------------------------------------
--

SET SERVEROUTPUT ON SIZE 1000000
SET LINES 1000
SET PAGES 10000
SET COLSEP '|'

COL file_name NEW_VALUE spool_file_name NOPRINT

SELECT 'XXRS_SC_DEVICE_PP_DATAFIX_2_DEV_120522-07164_'||TO_CHAR(SYSDATE,'YYYYMMDDHHMISS')||'.log' file_name
FROM DUAL
;

COL org_id FORMAT 9999
COL contract_snid FORMAT 99999999999
COL customer_number FORMAT A15 TRUNC
COL contract_status FORMAT A15 TRUNC
COL support_team FORMAT A15 TRUNC

SET TERM ON

SPOOL &spool_file_name

PROMPT
PROMPT 'BEFORE UPDATE'
PROMPT

SELECT dev_prod.contract_snid
     , dev_prod.device_num
     , dev_res.device_resource_snid
     , dev_res.billing_start_date
     , dev_res.prepay_months
     , prd_def.product_name
     , res_def.resource_name
     , dev_res.prepay_start_date
     , dev_res.prepay_end_date
     , dev_res.billing_start_date after_update_prepay_start_date
     , ADD_MONTHS (dev_res.billing_start_date,  dev_res.prepay_months) - 1 after_update_prepay_end_date
  FROM xxrs.xxrs_sc_device_product_tbl dev_prod
     , xxrs.xxrs_sc_device_resource_tbl dev_res
     , xxrs.xxrs_sc_product_rsrc_def_tbl prd_res_def
     , xxrs.xxrs_sc_resource_def_tbl res_def
     , xxrs.xxrs_sc_product_def_tbl prd_def
     , applsys.fnd_lookup_values flv
     , ar.hz_cust_accounts hca
     , (SELECT xsct.contract_snid
             , flv1.meaning contract_status
             , flv2.meaning contract_type
          FROM xxrs.xxrs_sc_contract_tbl xsct
             , applsys.fnd_lookup_values flv1
             , applsys.fnd_lookup_values flv2
         WHERE xsct.contract_status_code = flv1.lookup_code
           AND flv1.lookup_type = 'RS_CONTRACT_STATUS'
           AND flv1.language = USERENV('LANG')
           AND xsct.contract_type_code = flv2.lookup_code
           AND flv2.lookup_type = 'RS_CONTRACT_TYPE'
           AND flv2.language = USERENV('LANG')
           AND flv1.meaning NOT IN ('Draft', 'Complete')
           AND flv2.meaning IN ('New Sales - New Customer', 'New Sales - Existing Customer', 'Migration')) c
WHERE dev_prod.cust_account_id = hca.cust_account_id
   AND dev_prod.device_product_snid = dev_res.device_product_snid
   AND dev_res.product_resource_def_snid = prd_res_def.product_resource_def_snid
   AND prd_res_def.resource_def_snid = res_def.resource_def_snid
   AND prd_res_def.product_def_snid = prd_def.product_def_snid
   AND res_def.prepay_flag = 'Y'
   AND dev_res.prepay_end_date IS NULL
   AND flv.meaning != ('Void')
   AND flv.lookup_code = dev_prod.product_status_code
   AND flv.lookup_type = 'RS_SC_PRODUCT_STATUS'
   AND flv.language = USERENV('LANG')
   AND flv.meaning NOT IN ('Draft', 'Offline')
   AND dev_prod.contract_snid = c.contract_snid
   AND dev_prod.device_num in ('240201','245715');


PROMPT
PROMPT 'UPDATE PREPAY DEVICES WITH NULL PREPAY DATES'
PROMPT

UPDATE xxrs.xxrs_sc_device_resource_tbl dev_res1
   SET dev_res1.prepay_start_date = dev_res1.billing_start_date,
       dev_res1.prepay_months = 12,
       dev_res1.prepay_end_date = ADD_MONTHS (dev_res1.billing_start_date,  12) - 1
 WHERE dev_res1.device_resource_snid IN
       (SELECT dev_res.device_resource_snid
          FROM xxrs.xxrs_sc_device_product_tbl dev_prod
             , xxrs.xxrs_sc_device_resource_tbl dev_res
             , xxrs.xxrs_sc_product_rsrc_def_tbl prd_res_def
             , xxrs.xxrs_sc_resource_def_tbl res_def
             , xxrs.xxrs_sc_product_def_tbl prd_def
             , applsys.fnd_lookup_values flv
             , ar.hz_cust_accounts hca
             , (SELECT xsct.contract_snid
                     , flv1.meaning contract_status
                     , flv2.meaning contract_type
                  FROM xxrs.xxrs_sc_contract_tbl xsct
                     , applsys.fnd_lookup_values flv1
                     , applsys.fnd_lookup_values flv2
                 WHERE xsct.contract_status_code = flv1.lookup_code
                   AND flv1.lookup_type = 'RS_CONTRACT_STATUS'
                   AND flv1.language = USERENV('LANG')
                   AND xsct.contract_type_code = flv2.lookup_code
                   AND flv2.lookup_type = 'RS_CONTRACT_TYPE'
                   AND flv2.language = USERENV('LANG')
                   AND flv1.meaning NOT IN ('Draft', 'Complete')
                   AND flv2.meaning IN ('New Sales - New Customer', 'New Sales - Existing Customer', 'Migration')) c
WHERE dev_prod.cust_account_id = hca.cust_account_id
   AND dev_prod.device_product_snid = dev_res.device_product_snid
   AND dev_res.product_resource_def_snid = prd_res_def.product_resource_def_snid
   AND prd_res_def.resource_def_snid = res_def.resource_def_snid
   AND prd_res_def.product_def_snid = prd_def.product_def_snid
   AND res_def.prepay_flag = 'Y'
   AND dev_res.prepay_end_date IS NULL
   AND flv.meaning != ('Void')
   AND flv.lookup_code = dev_prod.product_status_code
   AND flv.lookup_type = 'RS_SC_PRODUCT_STATUS'
   AND flv.language = USERENV('LANG')
   AND flv.meaning NOT IN ('Draft', 'Offline')
   AND dev_prod.contract_snid = c.contract_snid
   AND dev_prod.device_num in ('240201','245715'));

PROMPT
PROMPT 'AFTER UPDATE'
PROMPT


SELECT dev_prod.contract_snid
     , dev_prod.device_num
     , dev_res.device_resource_snid
     , dev_res.billing_start_date
     , dev_res.prepay_months
     , prd_def.product_name
     , res_def.resource_name
     , dev_res.prepay_start_date
     , dev_res.prepay_end_date
  FROM xxrs.xxrs_sc_device_product_tbl dev_prod
     , xxrs.xxrs_sc_device_resource_tbl dev_res
     , xxrs.xxrs_sc_product_rsrc_def_tbl prd_res_def
     , xxrs.xxrs_sc_resource_def_tbl res_def
     , xxrs.xxrs_sc_product_def_tbl prd_def
     , applsys.fnd_lookup_values flv
     , ar.hz_cust_accounts hca
     , (SELECT xsct.contract_snid
             , flv1.meaning contract_status
             , flv2.meaning contract_type
          FROM xxrs.xxrs_sc_contract_tbl xsct
             , applsys.fnd_lookup_values flv1
             , applsys.fnd_lookup_values flv2
         WHERE xsct.contract_status_code = flv1.lookup_code
           AND flv1.lookup_type = 'RS_CONTRACT_STATUS'
           AND flv1.language = USERENV('LANG')
           AND xsct.contract_type_code = flv2.lookup_code
           AND flv2.lookup_type = 'RS_CONTRACT_TYPE'
           AND flv2.language = USERENV('LANG')
           AND flv1.meaning NOT IN ('Draft', 'Complete')
           AND flv2.meaning IN ('New Sales - New Customer', 'New Sales - Existing Customer', 'Migration')) c
WHERE dev_prod.cust_account_id = hca.cust_account_id
   AND dev_prod.device_product_snid = dev_res.device_product_snid
   AND dev_res.product_resource_def_snid = prd_res_def.product_resource_def_snid
   AND prd_res_def.resource_def_snid = res_def.resource_def_snid
   AND prd_res_def.product_def_snid = prd_def.product_def_snid
   AND res_def.prepay_flag = 'Y'
   AND dev_res.prepay_end_date IS NULL
   AND flv.meaning != ('Void')
   AND flv.lookup_code = dev_prod.product_status_code
   AND flv.lookup_type = 'RS_SC_PRODUCT_STATUS'
   AND flv.language = USERENV('LANG')
   AND flv.meaning NOT IN ('Draft', 'Offline')
   AND dev_prod.contract_snid = c.contract_snid
   AND dev_prod.device_num in ('240201','245715');