-- ---------------------------- CONFIDENTIAL ---------------------------------
-- This file contains proprietary information of Rackspace Inc. (RSI) and is
-- tendered subject to the condition that no copy or other reproduction be
-- made, in whole or in part, and that no use be made of the information
-- herein except for the purpose for which it is transmitted without express
-- written permission of RSI.
-- ---------------------------------------------------------------------------
--
-- ---------------------------------------------------------------------------
-- MODULE:      XXRS_SC_USAGE_DATA_AUDIT_0001.SQL
-- VERSION:     2.0.0
--
-- DESCRIPTION: This is the SQL Unload script that deletes the records that
--              were loaded in the usage data table associated to a file name.
--              In the event that a user loads data from a file and then 
--              realizes that it is incorrect, they can run the same
--              concurrent manager job, toggle the reverse load flag and then
--              unload the table without the intervention of IT.
--
-- VERSION  DATE      NAME               DESCRIPTION
-- -------  --------  -----------------  -------------------------------------
-- 1.0.0    09/12/07  Matt Paine         Created.
-- 1.1.0    04/24/08  Matt Paine         Modified structure to go to single
--                                       input file format.  Added validation
--                                       to support new format per SME's.
-- 1.1.1    02/25/09  Vinodh Bhasker     #090224-05663 --
--                                       Modified the SQL to get the org_id.
--                                       For explicit resources consider
--                                       resource effectivity dates.
-- 1.2.0    07/07/09  Vinodh Bhasker     As per 090811-06887# 
--                                       Modification for Consolidated billing.
-- 1.2.1    05/07/10  Vinodh Bhasker     As per 100201-04237#
--                                       Added code to process VM multiple
--                                       product cards (US and UK) 
-- 1.2.2   08/19/11   Pavan Amirineni    As per Genie # 110817-07598 
--                                       adding Gather stats to improve perf 
-- 2.0.0   02/20/12   Pavan Amirineni    As per Genie # 111122-02448 
--                                       R12 changes         
-- 2.0.1   08/14/13   Pavan Amirineni    130621-07223 Adding po number to CB accounts in usage
-- 2.0.2   11/05/13   Pavan Amirineni    131112-05580 updated logic to extract PO_NUM for CB
-- ---------------------------------------------------------------------------
--
SET serveroutput ON SIZE 1000000
SET verify ON;
WHENEVER SQLERROR EXIT 8
VARIABLE ret_status NUMBER
--
/* $Header: XXRS_SC_USAGE_DATA_AUDIT_0001.sql 2.0.1 08/14/13 10:00:00 SC Usage Data Audit Pavan Amirineni$ */
-- ---------------------------------------------------------------------------
-- Declare variables used in script.
-- ---------------------------------------------------------------------------
--
DECLARE
--
n_ret_status          NUMBER;
n_ret_status_f        NUMBER;
v_debug_flg           VARCHAR2(8);
v_loader_status       VARCHAR2(20);
v_usage_data_type     VARCHAR2(3);
v_billing_period      VARCHAR2(30);
v_concurrent_req_id   VARCHAR2(20);
v_file_name           VARCHAR2(240);
v_process_opts        VARCHAR2(20);
v_user_id             VARCHAR2(30);
n_count               NUMBER;
v_cust_fnd_flag       VARCHAR2(1);
v_prsc_fnd_flag       VARCHAR2(1);
d_billing_date        DATE;
n_org_id              NUMBER;
n_total_amount        NUMBER;
--
usage_import          CONSTANT    VARCHAR2(20)  := 'Usage Import';
validate_only         CONSTANT    VARCHAR2(20)  := 'Validate Only';
ready_to_process      CONSTANT    VARCHAR2(20)  := 'READY TO PROCESS';
p_error               CONSTANT    VARCHAR2(20)  := 'ERROR';
htab                  CONSTANT    VARCHAR2(1)   := CHR(9);
uom_xxx               CONSTANT    VARCHAR2(3)   := 'XXX';
ft_flag               CONSTANT    NUMBER        := -8;
gc_false1             CONSTANT    VARCHAR2(1)   := xxrs_sc_utl_0001.false1;
gc_usr_type_er        CONSTANT    VARCHAR2(2)   := xxrs_sc_utl_0001.usr_type_er;
gc_usr_type_ir        CONSTANT    VARCHAR2(2)   := xxrs_sc_utl_0001.usr_type_ir;
gc_account1           CONSTANT    VARCHAR2(1)   := xxrs_sc_utl_0001.account1;
--110817-07598 
stats_tbl1_usg        CONSTANT    VARCHAR2(40)  := 'XXRS_SC_USAGE_DATA_TBL';
stats_tbl2_devrsr     CONSTANT    VARCHAR2(40)  := 'XXRS_SC_DEVICE_RESOURCE_TBL';
stats_tbl3_accrsr     CONSTANT    VARCHAR2(40)  := 'XXRS_SC_ACCOUNT_RESOURCE_TBL';
stats_tbl4_devprd     CONSTANT    VARCHAR2(40)  := 'XXRS_SC_DEVICE_PRODUCT_TBL';
stats_tbl5_accprd     CONSTANT    VARCHAR2(40)  := 'XXRS_SC_ACCOUNT_PRODUCT_TBL';
stats_tbl6_con        CONSTANT    VARCHAR2(40)  := 'XXRS_SC_CONTRACT_TBL';
stats_xxrs            CONSTANT    VARCHAR2(4)   := 'XXRS';
stats_ar              CONSTANT    VARCHAR2(4)   := 'AR';
stats_percent         CONSTANT    NUMBER        := 99;
stats_degree          CONSTANT    NUMBER        := 4;
-- 110817-07598  end of changes 
e_force_exception     EXCEPTION;
--
-- ---------------------------------------------------------------------------
-- Declare cursor for data loaded.
-- ---------------------------------------------------------------------------
-- 
CURSOR usage_valid_rec ( pn_conc_req_id     NUMBER
                       )
    IS
       SELECT  LTRIM(RTRIM(data_source))             v_data_source,
               LTRIM(RTRIM(customer_num))            v_customer_num,
               LTRIM(RTRIM(resource_name))           v_resource_name,
               quantity                              n_quantity,
               LTRIM(RTRIM(uom_name))                v_uom_name,
               LTRIM(RTRIM(device_num))              v_device_num,
               usage_val                             n_usage_val,
               subscription                          n_subscription,
               LTRIM(RTRIM(ticket_num))              v_ticket_num,
               LTRIM(RTRIM(future_col_10))           v_amount,             -- 090811-06887# Added for CB usage data type
               LTRIM(RTRIM(future_col_11))           v_currency_code,      -- 090811-06887# Added for CB usage data type
               conc_req_id                           n_conc_req_id,
               LTRIM(RTRIM(file_name))               v_file_name,
               LTRIM(RTRIM(data_type))               v_data_type,
               ROWID                                 r_row_id
         FROM  xxrs.xxrs_sc_usage_data_tbl
        WHERE  1 = 1
          AND  conc_req_id = pn_conc_req_id
     ORDER BY  file_name,
               data_source,
               data_type,
               customer_num,
               resource_name,
               device_num
               ;
--
CURSOR usage_info_rec
    IS
       SELECT DISTINCT file_name               v_file_name, 
              process_date                     d_process_date, 
              billing_period                   v_billing_period,
              COUNT(*)                         n_count
         FROM xxrs.xxrs_sc_usage_data_tbl
     GROUP BY file_name, 
              process_date, 
              billing_period
     ORDER BY process_date, 
              billing_period
              ;
--              
-- 110817-07598 added below Procedure to gather stats
--               
PROCEDURE gather_table_stats(p_tbl_name IN VARCHAR2, 
                             p_owner    IN VARCHAR2 DEFAULT 'XXRS',
                             p_hrs      IN NUMBER   DEFAULT 3                       
                            )  
IS 
 l_count  NUMBER := 0;   
BEGIN 
-- If last analyzed time is less than p_hrs then run stats  
  SELECT COUNT(*)
    INTO l_count 
    FROM dba_tables  dt
   WHERE dt.table_name = p_tbl_name  
     AND (SYSDATE-dt.last_analyzed)* 24 >= p_hrs       
     AND dt.owner = p_owner;
--     
  IF (l_count > 0)  THEN     
    dbms_output.put_line ('Gathering stats on ' ||p_tbl_name||' table ...');
    fnd_stats.gather_table_stats(p_owner,
                                 p_tbl_name,
                                 stats_percent,
                                 stats_degree
                                );
    dbms_output.put_line(' ');                 
  END IF;
--         
EXCEPTION 
  WHEN OTHERS THEN 
    dbms_output.put_line('Failed to Gather Stats');
    dbms_output.put_line('Error Code => '||SQLERRM);  
END gather_table_stats;                                
--
-- ---------------------------------------------------------------------------
-- Start of procedure.
-- ---------------------------------------------------------------------------
--
BEGIN
--
-- ---------------------------------------------------------------------------
-- Assign the input arguments to the internal vairables.
-- ---------------------------------------------------------------------------
--
  :ret_status         := 0;
  n_ret_status        := xxrs_sc_utl_0001.success;
  n_ret_status_f      := xxrs_sc_utl_0001.success;
  v_debug_flg         := LTRIM(RTRIM('&1'));
  v_loader_status     := LTRIM(RTRIM('&2'));
  v_billing_period    := LTRIM(RTRIM('&3'));
  v_concurrent_req_id := LTRIM(RTRIM('&4'));
  v_file_name         := LTRIM(RTRIM('&5'));
  v_process_opts      := LTRIM(RTRIM('&6'));
  v_user_id           := LTRIM(RTRIM('&7'));
--
-- 110817-07598 gather table stats if needed 
--     
  dbms_output.put_line(' ');  
  dbms_output.put_line('**************************************************************');
  dbms_output.put_line('Calling Gather stats Program to enhance Performance ');
  dbms_output.put_line( 'Start Time => '||TO_CHAR(SYSDATE, 'YYYYMMDDHH24MISS'));
  gather_table_stats (p_tbl_name => stats_tbl1_usg,p_hrs => 0);
  gather_table_stats (p_tbl_name => stats_tbl2_devrsr);
  gather_table_stats (p_tbl_name => stats_tbl3_accrsr);
  gather_table_stats (p_tbl_name => stats_tbl4_devprd);
  gather_table_stats (p_tbl_name => stats_tbl5_accprd);
  gather_table_stats (p_tbl_name => stats_tbl6_con);
  dbms_output.put_line ('Successfully Completed Gathered stats ');
  dbms_output.put_line ('End Time => '||TO_CHAR(SYSDATE, 'YYYYMMDDHH24MISS'));
  dbms_output.put_line ('**************************************************************');
--
  dbms_output.enable (1000000);
--
  IF (v_debug_flg = 'TRUE') THEN
     dbms_output.put_line('v_loader_status     = ' || v_loader_status);
     dbms_output.put_line('v_billing_period    = ' || v_billing_period);
     dbms_output.put_line('v_concurrent_req_id = ' || v_concurrent_req_id);
     dbms_output.put_line('v_file_name         = ' || v_file_name);
     dbms_output.put_line('v_process_opts      = ' || v_process_opts);
     dbms_output.put_line('v_user_id           = ' || v_user_id);
  END IF;
--
-- ---------------------------------------------------------------------------
-- Start of procedure.  If the SQL load status failed.  This means that the 
-- SQL loader job could not load all of the usage data into the usage data 
-- staging table.  We must assume that there may be a partial load so we
-- need to ensure the table is clean by checking the table for records.  If
-- some of the records exist then we need to delete them from the table.
-- ---------------------------------------------------------------------------
--
  IF (v_loader_status != 'SUCCESS') THEN
--
     dbms_output.put_line ('.');
     dbms_output.put_line('load FAILED.  cleaning up TABLE.'); 
--
-- ---------------------------------------------------------------------------
-- The loader approach is all or nothing.  Check to see if any rows made it
-- into the usage data staging table.  If so then delete them.
-- ---------------------------------------------------------------------------
--
  SELECT  COUNT(*)
    INTO  n_count
    FROM  xxrs.xxrs_sc_usage_data_tbl 
   WHERE  conc_req_id = TO_NUMBER(v_concurrent_req_id);
--
  IF (v_debug_flg = 'TRUE') THEN
     dbms_output.put_line('n_count = ' || n_count);
  END IF;
--
  IF (n_count > 0) THEN
     DELETE 
       FROM  xxrs.xxrs_sc_usage_data_tbl 
      WHERE  conc_req_id = TO_NUMBER(v_concurrent_req_id);
--
     IF (SQL%ROWCOUNT <= 0) THEN
         dbms_output.put_line ('.');
         dbms_output.put_line('unload FAILED contact technical support');
     ELSE
         COMMIT;
         dbms_output.put_line ('.');
         dbms_output.put_line ('NO OF records COMMITTED IN this RUN: ' ||
                                n_count);
         dbms_output.put_line (v_file_name || 
                               ' DATA has been unloaded FROM USAGE DATA TABLE.');
     END IF;
  END IF;
--
-- ---------------------------------------------------------------------------
-- If this section of code is executed it means that the SQL loader job
-- succeeded and the usage data was loaded into the usage data staging 
-- table.  Once here then open the cursor and walk the data a record at 
-- a time and validate it.  If the we have the Usage Import option then
-- set the process status to Ready To Process.  We will then set the process
-- status to Error for those that fail the usage validation.
-- ---------------------------------------------------------------------------
--
  ELSE
     dbms_output.put_line (xxrs_sc_utl_0001.msg_dashes);
     dbms_output.put_line ('starting USAGE DATA VALIDATION.');
     dbms_output.put_line ('.');
     dbms_output.put_line ('DATA KEY:  COLUMN/DATA description');
     dbms_output.put_line ('.');
     dbms_output.put_line ('01 - billing Date');
     dbms_output.put_line ('02 - DATA SOURCE');
     dbms_output.put_line ('03 - customer Number');
     dbms_output.put_line ('04 - RESOURCE NAME');
     dbms_output.put_line ('05 - quantity');
     dbms_output.put_line ('06 - uom NAME');
     dbms_output.put_line ('07 - device Number');
     dbms_output.put_line ('08 - USAGE VALUE');
     dbms_output.put_line ('09 - subscription');
     dbms_output.put_line ('10 - ticket Number');
     dbms_output.put_line ('11 - amount');             -- 090811-06887# Added for CB usage data type 
     dbms_output.put_line ('12 - currency code');      -- 090811-06887# Added for CB usage data type
     dbms_output.put_line (xxrs_sc_utl_0001.msg_dashes);
     dbms_output.put_line ('.');
--
     v_cust_fnd_flag := xxrs_sc_utl_0001.false1;  -- dummy value (not needed here)
     v_prsc_fnd_flag := xxrs_sc_utl_0001.false1;  -- dummy value (not needed here)
--
     xxrs_sc_utl_0001.gb_write_log_flg := TRUE;
--
     IF (v_billing_period IS NULL OR LENGTH(LTRIM(RTRIM(v_billing_period))) = 0) THEN
        d_billing_date := NULL;
     ELSE
        d_billing_date := TO_DATE('01-'||v_billing_period,'dd-mon-rr');
     END IF;
--
     IF (v_process_opts = usage_import) THEN
        UPDATE  xxrs.xxrs_sc_usage_data_tbl
           SET  process_status = ready_to_process
         WHERE  conc_req_id    = TO_NUMBER(v_concurrent_req_id);
        COMMIT;
     END IF;
--
-- -----------------------------------------------------------------------------
-- As per 090811-06887# for cloud consolidated billing,
-- Need to validate future_col_10 to see if all the values are numeric. We need 
-- to do this because we are using the contingent columns and these columns are 
-- VARCHAR2 fields.  
--
     IF (v_process_opts = usage_import) THEN
        BEGIN
          SELECT SUM(TO_NUMBER(NVL(LTRIM(RTRIM(future_col_10)), '0')))
            INTO n_total_amount
            FROM xxrs.xxrs_sc_usage_data_tbl
           WHERE conc_req_id    = TO_NUMBER(v_concurrent_req_id);
--
        EXCEPTION
          WHEN INVALID_NUMBER
          THEN
            dbms_output.put_line ('.');
            dbms_output.put_line ('got non-numeric VALUE IN amount field. please CHECK USAGE FILE: '||v_file_name);
            dbms_output.put_line ('.');
            RAISE e_force_exception;
--
        END;
     END IF;
--
-- End of CB change
--
     FOR rec_in IN usage_valid_rec ( TO_NUMBER(v_concurrent_req_id)
                                   )
     LOOP
        n_ret_status_f := xxrs_sc_utl_0001.xxrs_chk_usage_data_n_f 
                                         ( TRUE,
                                           d_billing_date,
                                           rec_in.v_data_source,
                                           v_billing_period,
                                           rec_in.v_customer_num,
                                           rec_in.v_resource_name,
                                           rec_in.n_quantity,
                                           rec_in.v_uom_name,
                                           rec_in.v_device_num,
                                           rec_in.n_usage_val,
                                           rec_in.n_subscription,
                                           rec_in.v_ticket_num,
                                           rec_in.v_amount,
                                           rec_in.v_currency_code,
                                           rec_in.v_data_type,
                                           v_cust_fnd_flag,
                                           v_prsc_fnd_flag
                                         );
--
       IF (n_ret_status_f != xxrs_sc_utl_0001.success) THEN
          IF (n_ret_status_f = xxrs_sc_utl_0001.error_func_wrn) THEN
             n_ret_status := n_ret_status_f;
--
             IF (v_process_opts = usage_import) THEN
                UPDATE  xxrs.xxrs_sc_usage_data_tbl
                   SET  process_status = p_error
                 WHERE  rowid          = rec_in.r_row_id;
             END IF;
          ELSE
             RAISE e_force_exception;
          END IF;
       END IF;
--
     END LOOP;  -- End of USD validation processing.
--
     IF (v_process_opts = usage_import) THEN
        IF (n_ret_status != xxrs_sc_utl_0001.success) THEN
           COMMIT;
        END IF;
     END IF;
--
-- ---------------------------------------------------------------------------
-- If the validation is successful then set the data status as "READY TO 
-- PROCESS" so that the billing procedure can process the data for billing.
-- If not then delete the data from the table.
-- ---------------------------------------------------------------------------
--
     IF (v_process_opts = usage_import) THEN
        UPDATE  xxrs.xxrs_sc_usage_data_tbl
           SET  billing_period    = LTRIM(RTRIM(v_billing_period)),
                usage_id          = xxrs.xxrs_sc_usage_id.NEXTVAL,
                created_by        = TO_NUMBER(v_user_id),
                last_updated_by   = TO_NUMBER(v_user_id),
                last_update_login = TO_NUMBER(v_user_id)
         WHERE  conc_req_id       = TO_NUMBER(v_concurrent_req_id);
--
        COMMIT;
--
-- ---------------------------------------------------------------------------
-- Update the customer_id here.  This is needed for performance.
-- ---------------------------------------------------------------------------
--
        UPDATE  xxrs.xxrs_sc_usage_data_tbl usd
           SET  cust_account_id = (SELECT DISTINCT cust.cust_account_id
                                     FROM apps.xxrs_sc_cust_bill_to_sites_vw cust
                                    WHERE cust.customer_num = usd.customer_num
                                  )
         WHERE  conc_req_id = TO_NUMBER(v_concurrent_req_id);
--
        COMMIT;
--
-- -------------------------------------------------------------------------------
-- 100201-04237# Updating resources from the usage file with mutiple product cards  
-- with resource type as ER and process status as ERROR. Today VM have mutiple 
-- prod cards (US and UK) but if the device number in the usage file could not be 
-- then mutiple products will be returned when expecting one in the following
-- SQLs
--
        UPDATE xxrs.xxrs_sc_usage_data_tbl usd
           SET process_status = p_error
             , usd.usage_rscs_type = gc_usr_type_er
         WHERE usd.partial_proc_flag = gc_false1
           AND usd.billing_period = v_billing_period
           AND EXISTS (SELECT acct.product_snid
                         FROM apps.xxrs_sc_ci_act_usage_ex_vw acct
                        WHERE 1 = 1
                          AND acct.unit_price != ft_flag
                          AND acct.resource_name = usd.resource_name
                          AND ((acct.device_num = usd.device_num) OR                      --device number matched
                               (acct.device_num IS NULL AND usd.device_num IS NULL) OR    --usage does not contain device number
                                NOT EXISTS (SELECT 'x'                                    --device number not found
                                              FROM apps.xxrs_sc_ci_act_usage_ex_vw acct1
                                             WHERE acct1.device_num = usd.device_num
                                               AND acct1.cust_account_id = usd.cust_account_id
                                               AND d_billing_date BETWEEN NVL(acct1.billing_start_date,d_billing_date) AND NVL(acct1.billing_end_date,d_billing_date))
                              )
                          AND d_billing_date BETWEEN NVL(acct.billing_start_date,d_billing_date) AND NVL(acct.billing_end_date,d_billing_date)
                          AND acct.cust_account_id = usd.cust_account_id
                        GROUP BY acct.product_snid
                       HAVING COUNT(*) > 1
                      );
-- 
-- 100201-04237# End of addition
--
-- ---------------------------------------------------------------------------
-- Update the org_id, usage_rscs_type, and uom_code here for performance.
-- ---------------------------------------------------------------------------
--
        n_org_id := fnd_global.org_id;
--
        UPDATE xxrs.xxrs_sc_usage_data_tbl usd
           SET usd.org_id = (SELECT acct1.org_id
                               FROM apps.xxrs_sc_ci_act_usage_ex_vw acct1
                              WHERE 1 = 1
                                AND acct1.unit_price != ft_flag
                                AND acct1.resource_name = usd.resource_name
                                AND ((acct1.device_num = usd.device_num) OR
                                     (acct1.device_num IS NULL AND usd.device_num IS NULL)
                                    )
                                AND acct1.cust_account_id = usd.cust_account_id
                                AND d_billing_date BETWEEN NVL(acct1.billing_start_date,d_billing_date) AND NVL(acct1.billing_end_date,d_billing_date) --#090224-05663 - Resource with device num should consider Eff. dates
                               ),
               usd.usage_rscs_type = gc_usr_type_er,
               usd.uom_code = CASE WHEN (SELECT COUNT(muomt.uom_code)
                                           FROM inv.mtl_units_of_measure_tl muomt
                                          WHERE muomt.unit_of_measure = NVL(usd.uom_name,uom_xxx)) = 1
                                   THEN (SELECT muomt.uom_code
                                           FROM inv.mtl_units_of_measure_tl muomt
                                          WHERE muomt.unit_of_measure = usd.uom_name)
                                   ELSE (SELECT DISTINCT acct2.unit_of_measure_code
                                           FROM apps.xxrs_sc_ci_act_usage_ex_vw acct2
                                          WHERE 1 = 1
                                            AND acct2.unit_price != ft_flag
                                            AND acct2.resource_name = usd.resource_name
                                            AND ((acct2.device_num = usd.device_num) OR
                                                 (acct2.device_num IS NULL AND usd.device_num IS NULL)
                                                )
                                            AND acct2.cust_account_id = usd.cust_account_id
                                        )
                                   END
         WHERE usd.partial_proc_flag = gc_false1
           AND usd.usage_id IN (SELECT usd1.usage_id
                                  FROM xxrs.xxrs_sc_usage_data_tbl usd1,
                                       apps.xxrs_sc_ci_act_usage_ex_vw acct
                                 WHERE 1 = 1
                                   AND usd1.billing_period = v_billing_period
                                   AND acct.unit_price != ft_flag
                                   AND acct.resource_name = usd1.resource_name
                                   AND ((acct.device_num = usd1.device_num) OR
                                        (acct.device_num IS NULL AND usd1.device_num IS NULL)
                                       )
                                   AND acct.cust_account_id = usd1.cust_account_id
                               );
        COMMIT;
--
        UPDATE xxrs.xxrs_sc_usage_data_tbl usd
           SET usd.org_id = (SELECT acct2.org_id
                               FROM apps.xxrs_sc_ci_act_usage_im_vw acct2
                              WHERE 1 = 1
                                AND acct2.product_def_snid IN (SELECT DISTINCT (prdt2.product_def_snid)
                                                                 FROM xxrs.xxrs_sc_resource_def_tbl rdt2,
                                                                      xxrs.xxrs_sc_product_rsrc_def_tbl prdt2,
                                                                      xxrs.xxrs_sc_product_def_tbl pdt2
                                                                WHERE rdt2.resource_name = usd.resource_name
                                                                  AND rdt2.resource_type = gc_account1
                                                                  AND prdt2.resource_def_snid = rdt2.resource_def_snid
                                                                  AND pdt2.product_def_snid = prdt2.product_def_snid
                                                                  AND pdt2.product_type = gc_account1
                                                              )
                                AND acct2.cust_account_id = usd.cust_account_id
                            ),
               usd.usage_rscs_type = gc_usr_type_ir,
               usd.uom_code = CASE WHEN (SELECT COUNT(muomt.uom_code)
                                           FROM inv.mtl_units_of_measure_tl muomt
                                          WHERE muomt.unit_of_measure = NVL(usd.uom_name,uom_xxx)) = 1
                                   THEN (SELECT muomt.uom_code
                                           FROM inv.mtl_units_of_measure_tl muomt
                                          WHERE muomt.unit_of_measure = usd.uom_name)
                                   ELSE NULL
                                   END
         WHERE usd.partial_proc_flag = gc_false1
           AND usd.usage_id IN (SELECT usd1.usage_id
                                  FROM xxrs.xxrs_sc_usage_data_tbl usd1,
                                       apps.xxrs_sc_ci_act_usage_im_vw acct
                                 WHERE 1 = 1
                                   AND usd1.billing_period = v_billing_period
                                   AND (usd1.usage_rscs_type != gc_usr_type_er OR usd1.usage_rscs_type IS NULL)
                                   AND usd1.data_type != xxrs_sc_utl_0001.usd_type_cb   --#090811-06887 should not update CB usage data type
                                   AND acct.product_def_snid IN (SELECT DISTINCT (prdt.product_def_snid)
                                                                   FROM xxrs.xxrs_sc_resource_def_tbl rdt,
                                                                        xxrs.xxrs_sc_product_rsrc_def_tbl prdt,
                                                                        xxrs.xxrs_sc_product_def_tbl pdt
                                                                  WHERE rdt.resource_name = usd1.resource_name
                                                                    AND rdt.resource_type = gc_account1
                                                                    AND prdt.resource_def_snid = rdt.resource_def_snid
                                                                    AND pdt.product_def_snid = prdt.product_def_snid
                                                                    AND pdt.product_type = gc_account1
                                                                )
                                   AND acct.cust_account_id = usd1.cust_account_id 
                               );
        COMMIT;
--
-- -----------------------------------------------------------------------------
-- As per #090811-06887 
-- For consolidated billing, we need to get the org_id from the customer sites 
-- and currency code assigned to the sites
--
        UPDATE xxrs.xxrs_sc_usage_data_tbl usd
           SET usd.org_id = (SELECT cust.org_id
                               FROM apps.xxrs_ar_cust_site_details_vw cust
                              WHERE 1 = 1
                                AND cust.cust_acct_site_id = xxrs_sc_utl_0001.xxrs_get_cust_most_active_site(usd.cust_account_id, usd.future_col_11)
                            ),
               usd.usage_rscs_type = gc_usr_type_ir,
               usd.uom_name = (SELECT muomt.unit_of_measure
                                 FROM inv.mtl_units_of_measure_tl muomt
                                    , xxrs.xxrs_sc_resource_def_tbl rdt
                                WHERE muomt.uom_code = rdt.unit_of_measure_code
                                  AND rdt.resource_name = usd.resource_name
                                GROUP BY muomt.unit_of_measure),
               usd.uom_code = (SELECT rdt.unit_of_measure_code
                                 FROM xxrs.xxrs_sc_resource_def_tbl rdt
                                WHERE 1 = 1
                                  AND rdt.resource_name = usd.resource_name
                                GROUP BY rdt.unit_of_measure_code)
         WHERE usd.partial_proc_flag = gc_false1
           AND usd.usage_id IN (SELECT usd1.usage_id
                                  FROM xxrs.xxrs_sc_usage_data_tbl usd1
                                 WHERE 1 = 1
                                   AND usd1.billing_period = v_billing_period
                                   AND usd1.usage_rscs_type IS NULL
                                   AND usd1.data_type = xxrs_sc_utl_0001.usd_type_cb
                               );
        COMMIT;					
--
-- -----------------------------------------------------------------------------
-- As per #090811-06887, End of Addition 
--     
-- -----------------------------------------------------------------------------
-- 130621-07223 adding PO Number to Consolidated accounts usage data  
-- -----------------------------------------------------------------------------      
     UPDATE xxrs.xxrs_sc_usage_data_tbl usd
        SET usd.po_number= ( SELECT cpo.po_number
                              FROM xxrs.xxrs_sc_cloud_account_po cpo 
                             WHERE 1 = 1
                               -- AND trim(cpo.cloud_account_number) = SUBSTR(usd.ticket_num,11) -- 131112-05580 Commenting old logic and adding below condition					   
                               AND TRIM(cpo.cloud_account_number) = TRIM(SUBSTR(usd.ticket_num, INSTR(usd.ticket_num,':', 1, 1)+1,INSTR(usd.ticket_num,':',1,2)-INSTR(usd.ticket_num,':',1,1)-5))							   
                               AND cpo.rackspace_account_number = usd.customer_num
                               AND ROWNUM = 1                           
                           )
      WHERE usd.billing_period = LTRIM(RTRIM(v_billing_period))
        AND usd.data_type      = xxrs_sc_utl_0001.usd_type_cb 
        AND conc_req_id        = TO_NUMBER(v_concurrent_req_id)                                   
        AND EXISTS (SELECT 'x'
                      FROM xxrs.xxrs_sc_cloud_account_po cpo
                      WHERE 1 = 1
                        -- AND trim(cpo.cloud_account_number) = SUBSTR(usd.ticket_num,11) -- 131112-05580 Commenting old logic and adding below condition		
                        AND TRIM(cpo.cloud_account_number) = TRIM(SUBSTR(usd.ticket_num, INSTR(usd.ticket_num,':', 1, 1)+1,INSTR(usd.ticket_num,':',1,2)-INSTR(usd.ticket_num,':',1,1)-5))						
                        AND cpo.rackspace_account_number = usd.customer_num                           
                    );
	  COMMIT;
-- -----------------------------------------------------------------------------                    
-- end of changes -- 130621-07223                     
-- -----------------------------------------------------------------------------	 	 
        dbms_output.put_line ('.');
        dbms_output.put_line ('AUDIT DATA has been successfully UPDATED IN '
                          ||  'USAGE staging TABLE FOR '
                          ||  v_file_name);
--
     ELSIF (v_process_opts = validate_only) THEN
        DELETE 
          FROM  xxrs.xxrs_sc_usage_data_tbl 
         WHERE  file_name      = v_file_name
           AND  conc_req_id    = TO_NUMBER(v_concurrent_req_id);
--
        COMMIT;
        dbms_output.put_line ('.');
        dbms_output.put_line ('validated FILE '
                          ||  v_file_name
                          ||  ' has been removed FROM USAGE staging TABLE. ');
     ELSE
        dbms_output.put_line ('.');
        dbms_output.put_line ('ERROR:  process OPTION NOT programmed FOR.  '
                          ||  'contact technical support.');
        RAISE e_force_exception;
     END IF;
  END IF;
--
-- ---------------------------------------------------------------------------
-- Summarize what is now in the usage file.  This is being done to provide
-- visibility to the users as to what is in the table.  This is also being
-- for the unload process as well.
-- ---------------------------------------------------------------------------
--
  dbms_output.put_line ('.');
  dbms_output.put_line ('USAGE DATA currently IN USAGE staging TABLE');
  dbms_output.put_line ('.');
  dbms_output.put_line ('FILE NAME'
                     || htab
                     || htab
                     || 'process DATE'
                     || htab
                     || htab
                     || 'billing period'
                     || htab
                     || 'rec COUNT');
  dbms_output.put_line ('.');
--
  FOR rec_in IN usage_info_rec
  LOOP
     dbms_output.put_line (rec_in.v_file_name
                        || htab
                        || htab
                        || TO_CHAR(rec_in.d_process_date, 
                           'mm/dd/yyyy hh24:mm:ss')
                        || htab
                        || rec_in.v_billing_period
                        || htab
                        || htab
                        || TO_CHAR(rec_in.n_count));
  END LOOP;
--
  IF (n_ret_status != xxrs_sc_utl_0001.success) THEN
     RAISE e_force_exception;
  END IF;
--
-- ---------------------------------------------------------------------------
-- Error handling.
-- ---------------------------------------------------------------------------
--
EXCEPTION
--
  WHEN OTHERS THEN
     IF (n_ret_status = xxrs_sc_utl_0001.error_func_wrn) THEN
        dbms_output.put_line ('.');
        dbms_output.put_line ('functional warnings.  ');
        :ret_status := 1;
--
     ELSE
        DELETE 
          FROM  xxrs.xxrs_sc_usage_data_tbl 
         WHERE  conc_req_id = TO_NUMBER(v_concurrent_req_id);
--
        COMMIT;
--
        dbms_output.put_line ('.');
        dbms_output.put_line ('unknown ERROR.  contact technical support.');
        :ret_status := 8;
     END IF;
END;
/
EXIT :ret_status
