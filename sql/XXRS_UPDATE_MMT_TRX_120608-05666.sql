/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_UPDATE_MMT_TRX_120608-05666.sql                                                                         *
*                                                                                                                     *
* DESCRIPTION :                                                                                                       *
* Script to Update Columns in MTL_SERIAL_NUMBERS to NULL For Given Serial Numbers.                                    *
*                                                                                                                     *
* AUTHOR       : Pavan Amirineni                                                                                      *
* DATE WRITTEN : 08-JUN-2012                                                                                          *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* SR#             GENIE Ticket #    WHO                DATE                      REMARKS                              *
* 1.0.0            120608-05666   Pavan Amirineni  08-JUN-2012     Script to Update Costed flag                       *
**********************************************************************************************************************/
/* $Header: XXRS_UPDATE_MMT_TRX_120608-05666.sql 1.0 08-JUN-2012 10:306:00 AM Pavan Amirineni$ */
SET SERVEROUTPUT ON SIZE 100000;
SET LINE 300;
SET PAGESIZE 2000;
SET COLSEP |;
col file_name   new_value   spool_file_name    noprint
select 'XXRS_UPDATE_MMT_TRX_120608-05666_' ||to_char (sysdate, '_mmddyy_hhmiss')||'.log' file_name from dual ;
spool &spool_file_name
SELECT 'Before Updating mtl_material_transactions table' comments from dual;
SELECT transaction_id
     , costed_flag
     , transaction_group_id
     , error_code
     , error_explanation
     , transaction_set_id
  FROM inv.mtl_material_transactions mmt
 WHERE costed_flag ='E';
SELECT 'Updating mtl_material_transactions' comments from dual;   
--  
UPDATE inv.mtl_material_transactions mmt
   SET costed_flag = 'N'
     , error_code = NULL
     , error_explanation = NULL
     , transaction_group_id = NULL
     , transaction_set_id = NULL
     , last_update_date = SYSDATE
     , last_updated_by = 0 
     , last_update_login = -1
where COSTED_FLAG ='E';
--
SELECT 'After Updating mtl_serial_numbers table' comments from dual;                        
SELECT transaction_id
     , costed_flag
     , transaction_group_id
     , error_code
     , error_explanation
     , transaction_set_id
  FROM inv.mtl_material_transactions mmt
 WHERE costed_flag ='E';
-- COMMIT;
--SPOOL OFF;