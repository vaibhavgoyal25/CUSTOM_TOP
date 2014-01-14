-- ---------------------------- CONFIDENTIAL ---------------------------------
-- This file contains proprietary information of Rackspace Inc. (RSI) and is
-- tendered subject to the condition that no copy or other reproduction be
-- made, in whole or in part, and that no use be made of the information
-- herein except for the purpose for which it is transmitted without express
-- written permission of RSI.
-- ---------------------------------------------------------------------------
--
-- ---------------------------------------------------------------------------
-- MODULE:      XXRS_SC_USAGE_DATA_UNLOAD_0001.SQL
-- VERSION:     1.0.0
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
-- 1.0.0    09/11/07  Matt Paine         Created.
-- 2.0.0    02/20/12  Pavan Amirineni    as per ticket # 111122-02448 R12 changes 
-- ---------------------------------------------------------------------------
--
SET SERVEROUTPUT ON SIZE 1000000
SET Verify ON;
WHENEVER SQLERROR EXIT 8
VARIABLE RET_STATUS NUMBER
--
/* $Header: XXRS_SC_USAGE_DATA_UNLOAD_0001.sql 2.0.0 02/19/12 9:00:00 SC Usage Data Unload Script Pavan Amirineni$ */
-- ---------------------------------------------------------------------------
-- Declare variables used in script.
-- ---------------------------------------------------------------------------
--
DECLARE
--
v_debug_flg           VARCHAR2(8);
v_usage_data_type     VARCHAR2(3);
v_billing_period      VARCHAR2(30);
v_file_name           VARCHAR2(240);
n_count               NUMBER;
--
HTAB      CONSTANT    VARCHAR2(1) := CHR(9);
--
-- ---------------------------------------------------------------------------
-- Declare cursor for data loaded.
-- ---------------------------------------------------------------------------
-- 
CURSOR usage_info_rec
    IS
       SELECT DISTINCT file_name               v_file_name, 
              process_date                     d_process_date, 
              billing_period                   v_billing_period,
              count(*)                         n_count
         FROM XXRS.XXRS_SC_USAGE_DATA_TBL
     GROUP BY file_name, 
              process_date, 
              billing_period
     ORDER BY process_date, 
              billing_period
              ;
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
  :RET_STATUS       := 0;
  v_debug_flg       := LTRIM(RTRIM('&1'));
  v_usage_data_type := LTRIM(RTRIM('&2'));
  v_billing_period  := LTRIM(RTRIM('&3'));
  v_file_name       := LTRIM(RTRIM('&4'));
--
  IF (v_debug_flg = 'TRUE') THEN
     DBMS_OUTPUT.PUT_LINE('v_usage_data_type = ' || v_usage_data_type);
     DBMS_OUTPUT.PUT_LINE('v_billing_period  = ' || v_billing_period);
     DBMS_OUTPUT.PUT_LINE('v_file_name       = ' || v_file_name);
  END IF;
--
-- ---------------------------------------------------------------------------
-- First check if the records to be unload from the usage staging table are
-- partially processed or not.  If so then we need to move them to the 
-- purge table before deleting.
-- ---------------------------------------------------------------------------
--
  SELECT  COUNT(*)
    INTO  n_count
    FROM  XXRS.XXRS_SC_USAGE_DATA_TBL 
   WHERE  data_type         = v_usage_data_type 
     AND  billing_period    = v_billing_period
     AND  file_name         = v_file_name
     AND  partial_proc_flag = 'T';
--
  IF (v_debug_flg = 'TRUE') THEN
     DBMS_OUTPUT.PUT_LINE('.');
     DBMS_OUTPUT.PUT_LINE('Partially processed record count = ' || n_count);
  END IF;
--
  IF (n_count > 0) THEN
     INSERT INTO XXRS.XXRS_SC_USAGE_DATA_PURG
            SELECT *
             FROM  XXRS.XXRS_SC_USAGE_DATA_TBL 
            WHERE  data_type         = v_usage_data_type 
              AND  billing_period    = v_billing_period
              AND  file_name         = v_file_name
              AND  partial_proc_flag = 'T';
     COMMIT;
     :RET_STATUS := 2;
  END IF;
--
-- ---------------------------------------------------------------------------
-- Delete the records that were loaded previously under the file specfied by
-- the user.  Count the records first to make sure that there are records
-- present.  If not inform the user.  If so then perform the actual delete.
-- ---------------------------------------------------------------------------
--
  SELECT  COUNT(*)
    INTO  n_count
    FROM  XXRS.XXRS_SC_USAGE_DATA_TBL 
   WHERE  data_type      = v_usage_data_type 
     AND  billing_period = v_billing_period
     AND  file_name      = v_file_name;
--
  IF (v_debug_flg = 'TRUE') THEN
     DBMS_OUTPUT.PUT_LINE('n_count = ' || n_count);
  END IF;
--
  IF (n_count > 0) THEN
     DELETE 
       FROM  XXRS.XXRS_SC_USAGE_DATA_TBL 
      WHERE  data_type      = v_usage_data_type
        AND  billing_period = v_billing_period
        AND  file_name      = v_file_name;
--
     IF (SQL%ROWCOUNT <= 0) THEN
         DBMS_OUTPUT.PUT_LINE('.');
         DBMS_OUTPUT.PUT_LINE('Unload failed contact Technical Support');
     ELSE
         COMMIT;
         DBMS_OUTPUT.PUT_LINE('.');
         DBMS_OUTPUT.PUT_LINE ('No of records committed in this run: ' ||
                                n_count);
         DBMS_OUTPUT.PUT_LINE (v_file_name || 
                               ' data has been unloaded from Usage Data Table.');
     END IF;
  ELSE
     DBMS_OUTPUT.PUT_LINE('.');
     DBMS_OUTPUT.PUT_LINE('No records found to remove for the given parameters.');
     :RET_STATUS := 1;
  END IF;
--
-- ---------------------------------------------------------------------------
-- Summarize what is now in the usage file.  This is being done to provide
-- visibility to the users as to what is in the table.  This is also being
-- for the unload process as well.
-- ---------------------------------------------------------------------------
--
  DBMS_OUTPUT.PUT_LINE ('.');
  DBMS_OUTPUT.PUT_LINE ('Usage Data Currently in Usage Staging Table');
  DBMS_OUTPUT.PUT_LINE ('.');
  DBMS_OUTPUT.PUT_LINE ('FILE NAME'
                     || HTAB
                     || HTAB
                     || 'PROCESS DATE'
                     || HTAB
                     || 'BILLING PERIOD'
                     || HTAB
                     || 'REC COUNT');
  DBMS_OUTPUT.PUT_LINE ('.');
--
  FOR rec_in IN usage_info_rec
  LOOP
     DBMS_OUTPUT.PUT_LINE (rec_in.v_file_name
                        || HTAB
                        || TO_CHAR(rec_in.d_process_date, 
                           'MM/DD/YYYY HH24:MM:SS')
                        || HTAB
                        || rec_in.v_billing_period
                        || HTAB
                        || TO_CHAR(rec_in.n_count));
  END LOOP;
--
-- ---------------------------------------------------------------------------
-- Error handling.
-- ---------------------------------------------------------------------------
--
EXCEPTION
--
  WHEN OTHERS THEN
     DBMS_OUTPUT.PUT_LINE('.');
     DBMS_OUTPUT.PUT_LINE ('Unknown error.  Contact Technical support.');
     :RET_STATUS := 8;
END;
/
EXIT :RET_STATUS

