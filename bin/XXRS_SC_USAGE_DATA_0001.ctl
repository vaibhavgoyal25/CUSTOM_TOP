-- ---------------------------- CONFIDENTIAL ---------------------------------
-- This file contains proprietary information of Rackspace Inc. (RSI) and is
-- tendered subject to the condition that no copy or other reproduction be
-- made, in whole or in part, and that no use be made of the information
-- herein except for the purpose for which it is transmitted without express
-- written permission of RSI.
-- ---------------------------------------------------------------------------
--
-- ---------------------------------------------------------------------------
-- MODULE:      XXRS_SC_USAGE_DATA_0001.ctl
-- VERSION:     2.0.0
--
-- DESCRIPTION: This is the SQL Loader script that loads the usage data into
--              the usage data table for the service contract usage data.  It 
--              also creates the log, bad, & discard files as needed. Note
--              there is only one for all usage data types since the usage file
--              formats have been merged into a single format.  Valid usage 
--              types are as follows:
--
--              TS = Tech-Support
--              MB = Managed Backup
--              ME = Managed Exchange
--              BW = Bandwidth
--              VM = Virtual Machine
--              AB = Aggregate Bandwidth
--              CB = Consolidated Billing
--
--              For Consolidated Billing, using the following columns
--              future_col_10 = Amount To Bill
--              future_col_11 = Currency Code
--
-- VERSION  DATE      NAME               DESCRIPTION
-- -------  --------  -----------------  -------------------------------------
-- 1.0.0    08/22/07  Matt Paine         Created.
-- 1.1.0    04/22/08  Matt Paine         Modified software to handle a single
--                                       input file format.
-- 1.2.0    07/06/09  Vinodh Bhasker     As per #090811-06887 requirement
--                                       Using future_col_10 and future_col_11
--                                       consolidated billing data type.
-- 2.0.0    02/20/12  Pavan Amirineni    As per ticket # 111122-02448 R12 changes 
-- ---------------------------------------------------------------------------
--/* $Header: XXRS_SC_USAGE_DATA_0001.ctl 2.0.0 02/20/12 10:00:00 SC Usage Data Audit Pavan Amirineni$ */
--
-- ---------------------------------------------------------------------------
-- Create the XXRS.XXRS_SC_USAGE_DATA_0001 control file.
-- ---------------------------------------------------------------------------
--
LOAD DATA
append
INTO TABLE XXRS.XXRS_SC_USAGE_DATA_TBL
fields terminated BY ',' optionally enclosed BY '"'
TRAILING NULLCOLS
(
 process_status          CONSTANT "RAW DATA",
 process_date            SYSDATE,
 usage_id                CONSTANT 0000,
 data_source             CHAR "ltrim(rtrim(:data_source))",
 customer_num            CHAR "ltrim(rtrim(:customer_num))",
 resource_name           CHAR "ltrim(rtrim(:resource_name))",
 quantity                DECIMAL EXTERNAL,
 uom_name                CHAR "ltrim(rtrim(:uom_name))",
 device_num              CHAR "ltrim(rtrim(:device_num))",
 usage_val               DECIMAL EXTERNAL,
 subscription            DECIMAL EXTERNAL,
 ticket_num              CHAR "ltrim(rtrim(:ticket_num))",
-- amount field #090811-06887
 future_col_10           CHAR "ltrim(rtrim(:future_col_10))",
-- currency code #090811-06887
 future_col_11           CHAR "ltrim(rtrim(:future_col_11))",
-- future_col_12           CHAR "ltrim(rtrim(:future_col_12))",
-- future_col_13           CHAR "ltrim(rtrim(:future_col_13))",
-- future_col_14           CHAR "ltrim(rtrim(:future_col_14))",
-- future_col_15           CHAR "ltrim(rtrim(:future_col_15))",
 conc_req_id             INTEGER  EXTERNAL,
 file_name               CHAR "ltrim(rtrim(:file_name))",
 data_type               CHAR "ltrim(rtrim(:data_type))",
 org_id                  CONSTANT 0000,
 partial_proc_flag       CONSTANT "F",
 creation_date           SYSDATE,
 created_by              CONSTANT 0001,
 last_updated_by         CONSTANT 0001,
 last_update_login       CONSTANT 0001,
 last_update_date        SYSDATE
)
