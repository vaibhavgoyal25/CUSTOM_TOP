SET SERVEROUTPUT ON SIZE 1000000
/**************************************************************************************************************
* NAME : XXRS_SC_CUST_SITE_DATAFIX_130405-06116.sql                                                           *
*                                                                                                             *
* DESCRIPTION :                                                                                               *
*   Script to update Customer Site Information for Given Customers on Service Contracts.                      *
*                                                                                                             *
* AUTHOR       : Vaibhav Goyal                                                                                *
* DATE WRITTEN : 04-APR-2013                                                                                  *
*                                                                                                             *
* CHANGE CONTROL :                                                                                            *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                             *
*-------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  130405-06116     | Vaibhav Goyal   |  04-APR-2013   | Initial Creation.                     *
***************************************************************************************************************/
--
/* $Header: XXRS_SC_CUST_SITE_DATAFIX_130405-06116.sql 1.0.0 04/03/2013 10:46:24 AM Vaibhav Goyal $ */
--
SET LINES 100
SET PAGESIZE 1000
SET COLSEP '|'
COL file_name NEW_VALUE spool_file_name NOPRINT
SELECT 'XXRS_SC_CUST_SITE_DATAFIX_130405-06116_'||TO_CHAR(SYSDATE,'YYYYMMDDHHMISS')||'.log' file_name
FROM DUAL;

SPOOL &spool_file_name
DECLARE 

CURSOR cur_acc_sites IS
         select cust.account_number, 
                cust_site_i.cust_acct_site_id old_cust_site_id,
                cust_site_a.cust_acct_site_id new_cust_site_id
           from ar.hz_cust_accounts cust,
                ar.hz_cust_acct_sites_all cust_site_i,
                ar.hz_cust_acct_sites_all cust_site_a
          where cust_site_i.cust_account_id = cust.cust_account_id
          AND cust_site_a.cust_account_id = cust.cust_account_id
          AND cust_site_i.status = 'I'
          AND cust_site_a.status = 'A'
          AND EXISTS (select 'Y' from xxrs_sc_account_product_tbl acc
                        where acc.cust_acct_site_id = cust_site_i.cust_acct_site_id
                        UNION
                      select 'Y' from xxrs_sc_device_product_tbl dev
                        where dev.cust_acct_site_id = cust_site_i.cust_acct_site_id)
          AND cust.account_number IN ('1772760',
                                      '1753302',
                                      '1718814',
                                      '1697546',
                                      '1772747',
                                      '1621077',
                                      '1753993',
                                      '1720534',
                                      '1674747',
                                      '1773341',
                                      '1740689',
                                      '760940',
                                      '1771069',
                                      '1627296',
                                      '1746191',
                                      '1766855',
                                      '1772729',
                                      '1746078',
                                      '1767535',
                                      '1759521',
                                      '1767680',
                                      '1774921',
                                      '1379871');                                      
                                      
cursor cur_xxrs_sc_contract_tbl (p_cust_acct_site_id IN NUMBER,
                                 p_last_update_date  IN DATE)
IS
select contract_snid    ,
cust_account_id   ,
cust_acct_site_id 
from  xxrs_sc_contract_tbl
where cust_acct_site_id = p_cust_acct_site_id
  and DECODE(p_last_update_date,null,sysdate,last_update_date) > sysdate-(1/12);

cursor cur_xxrs_sc_acc_prd_tbl (p_cust_acct_site_id IN NUMBER,
                                 p_last_update_date  IN DATE)
IS
select account_product_snid,
cust_account_id,
cust_acct_site_id
from  xxrs_sc_account_product_tbl
where cust_acct_site_id = p_cust_acct_site_id
  and DECODE(p_last_update_date,null,sysdate,last_update_date) > sysdate-(1/12);


cursor cur_xxrs_sc_dev_prd_tbl (p_cust_acct_site_id IN NUMBER,
                                 p_last_update_date  IN DATE)
IS
select device_num,
device_product_snid,
cust_account_id,
cust_acct_site_id
from  xxrs_sc_device_product_tbl
where cust_acct_site_id = p_cust_acct_site_id
  and DECODE(p_last_update_date,null,sysdate,last_update_date) > sysdate-(1/12);

cursor cur_xxrs_sc_history_tbl (p_cust_acct_site_id IN NUMBER,
                                 p_last_update_date  IN DATE)
IS
select history_snid,
cust_account_id,
cust_acct_site_id
from  xxrs_sc_history_tbl
where cust_acct_site_id = p_cust_acct_site_id
  and DECODE(p_last_update_date,null,sysdate,last_update_date) > sysdate-(1/12);

cursor cur_xxrs_sc_contract_tbl_cnt 
IS
select count(*)  xxrs_sc_contract_tbl_cnt
  from  xxrs_sc_contract_tbl
 where cust_acct_site_id IN (select cust_site_i.cust_acct_site_id
                               from ar.hz_cust_accounts cust,
                                    ar.hz_cust_acct_sites_all cust_site_i
                              where cust_site_i.cust_account_id = cust.cust_account_id
                                and cust_site_i.status = 'I'                                
                                AND EXISTS (select 'Y' from xxrs_sc_account_product_tbl acc
                                             where acc.cust_acct_site_id = cust_site_i.cust_acct_site_id
                                            UNION
                                            select 'Y' from xxrs_sc_device_product_tbl dev
                                             where dev.cust_acct_site_id = cust_site_i.cust_acct_site_id)
                                and cust.account_number IN 
                                     ('1772760',
                                      '1753302',
                                      '1718814',
                                      '1697546',
                                      '1772747',
                                      '1621077',
                                      '1753993',
                                      '1720534',
                                      '1674747',
                                      '1773341',
                                      '1740689',
                                      '760940',
                                      '1771069',
                                      '1627296',
                                      '1746191',
                                      '1766855',
                                      '1772729',
                                      '1746078',
                                      '1767535',
                                      '1759521',
                                      '1767680',
                                      '1774921',
                                      '1379871'));

cursor cur_xxrs_sc_acc_prd_tbl_cnt
IS
select count(*) xxrs_sc_acc_prd_tbl_cnt
  from  xxrs_sc_account_product_tbl
 where cust_acct_site_id IN (select cust_site_i.cust_acct_site_id
                               from ar.hz_cust_accounts cust,
                                    ar.hz_cust_acct_sites_all cust_site_i
                              where cust_site_i.cust_account_id = cust.cust_account_id
                                and cust_site_i.status = 'I'
                                AND EXISTS (select 'Y' from xxrs_sc_account_product_tbl acc
                                             where acc.cust_acct_site_id = cust_site_i.cust_acct_site_id
                                            UNION
                                            select 'Y' from xxrs_sc_device_product_tbl dev
                                             where dev.cust_acct_site_id = cust_site_i.cust_acct_site_id)
                                and cust.account_number IN 
                                     ('1772760',
                                      '1753302',
                                      '1718814',
                                      '1697546',
                                      '1772747',
                                      '1621077',
                                      '1753993',
                                      '1720534',
                                      '1674747',
                                      '1773341',
                                      '1740689',
                                      '760940',
                                      '1771069',
                                      '1627296',
                                      '1746191',
                                      '1766855',
                                      '1772729',
                                      '1746078',
                                      '1767535',
                                      '1759521',
                                      '1767680',
                                      '1774921',
                                      '1379871'));                                                         

cursor cur_xxrs_sc_dev_prd_tbl_cnt 
IS
select count(*) xxrs_sc_dev_prd_tbl_cnt
  from  xxrs_sc_device_product_tbl
 where cust_acct_site_id IN (select cust_site_i.cust_acct_site_id
                               from ar.hz_cust_accounts cust,
                                    ar.hz_cust_acct_sites_all cust_site_i
                              where cust_site_i.cust_account_id = cust.cust_account_id
                                and cust_site_i.status = 'I'
                                AND EXISTS (select 'Y' from xxrs_sc_account_product_tbl acc
                                             where acc.cust_acct_site_id = cust_site_i.cust_acct_site_id
                                            UNION
                                            select 'Y' from xxrs_sc_device_product_tbl dev
                                             where dev.cust_acct_site_id = cust_site_i.cust_acct_site_id)
                                and cust.account_number IN 
                                     ('1772760',
                                      '1753302',
                                      '1718814',
                                      '1697546',
                                      '1772747',
                                      '1621077',
                                      '1753993',
                                      '1720534',
                                      '1674747',
                                      '1773341',
                                      '1740689',
                                      '760940',
                                      '1771069',
                                      '1627296',
                                      '1746191',
                                      '1766855',
                                      '1772729',
                                      '1746078',
                                      '1767535',
                                      '1759521',
                                      '1767680',
                                      '1774921',
                                      '1379871'));

cursor cur_xxrs_sc_history_tbl_cnt 
IS
select count(*) xxrs_sc_history_tbl_cnt
  from  xxrs_sc_history_tbl
 where cust_acct_site_id IN (select cust_site_i.cust_acct_site_id
                               from ar.hz_cust_accounts cust,
                                    ar.hz_cust_acct_sites_all cust_site_i
                              where cust_site_i.cust_account_id = cust.cust_account_id
                                and cust_site_i.status = 'I'
                                AND EXISTS (select 'Y' from xxrs_sc_account_product_tbl acc
                                             where acc.cust_acct_site_id = cust_site_i.cust_acct_site_id
                                            UNION
                                            select 'Y' from xxrs_sc_device_product_tbl dev
                                             where dev.cust_acct_site_id = cust_site_i.cust_acct_site_id)
                                and cust.account_number IN 
                                     ('1772760',
                                      '1753302',
                                      '1718814',
                                      '1697546',
                                      '1772747',
                                      '1621077',
                                      '1753993',
                                      '1720534',
                                      '1674747',
                                      '1773341',
                                      '1740689',
                                      '760940',
                                      '1771069',
                                      '1627296',
                                      '1746191',
                                      '1766855',
                                      '1772729',
                                      '1746078',
                                      '1767535',
                                      '1759521',
                                      '1767680',
                                      '1774921',
                                      '1379871'));
                                                            
v_print_after varchar2(1);
BEGIN
------------*********************************************************---------------
DBMS_OUTPUT.PUT_LINE('**********************************');
FOR rec_xxrs_sc_contract_tbl_cnt in cur_xxrs_sc_contract_tbl_cnt 
LOOP
DBMS_OUTPUT.PUT_LINE('About To Update '||rec_xxrs_sc_contract_tbl_cnt.xxrs_sc_contract_tbl_cnt||' Records in xxrs_sc_contract_tbl For all given customers');
END LOOP;
DBMS_OUTPUT.PUT_LINE('Stage'||'|'||'Customer Number'||'|'||'contract_snid'||'|'||'cust_account_id'||'|'||'cust_acct_site_id');
FOR process_update in cur_acc_sites 
LOOP
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------- ');

  v_print_after := 'N';
  FOR rec_xxrs_sc_contract_tbl in cur_xxrs_sc_contract_tbl (process_update.old_cust_site_id,null)
  LOOP
  v_print_after := 'Y';  
    DBMS_OUTPUT.PUT_LINE('BEFORE'||'|'||process_update.account_number||'|'||rec_xxrs_sc_contract_tbl.contract_snid||'|'||rec_xxrs_sc_contract_tbl.cust_account_id||'|'||rec_xxrs_sc_contract_tbl.cust_acct_site_id);
  END LOOP;

BEGIN
UPDATE  xxrs_sc_contract_tbl
  SET cust_acct_site_id = process_update.new_cust_site_id,
       last_updated_by     = 0,
       last_update_date    = SYSDATE,
       last_update_login   = -1
 WHERE cust_acct_site_id = process_update.old_cust_site_id;

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error While Updating Cust Account Site on XXRS_SC_CONTRACT_TBL For Customer '||process_update.account_number);   
END;

  IF v_print_after = 'Y' THEN
    FOR rec_xxrs_sc_contract_tbl in cur_xxrs_sc_contract_tbl (process_update.new_cust_site_id,sysdate)
    LOOP
      DBMS_OUTPUT.PUT_LINE('AFTER'||'|'||process_update.account_number||'|'||rec_xxrs_sc_contract_tbl.contract_snid||'|'||rec_xxrs_sc_contract_tbl.cust_account_id||'|'||rec_xxrs_sc_contract_tbl.cust_acct_site_id);
    END LOOP;
  END IF;
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------- ');
    DBMS_OUTPUT.PUT_LINE('    Updated '||SQL%ROWCOUNT||' Records For Customer '||process_update.account_number||' and customer Site '||process_update.old_cust_site_id);
  
END LOOP;
------------*********************************************************---------------
DBMS_OUTPUT.PUT_LINE('**********************************');
FOR rec_xxrs_sc_history_tbl_cnt in cur_xxrs_sc_history_tbl_cnt 
LOOP
DBMS_OUTPUT.PUT_LINE('About To Update '||rec_xxrs_sc_history_tbl_cnt.xxrs_sc_history_tbl_cnt||' Records in xxrs_sc_history_tbl For all given customers');
END LOOP;
DBMS_OUTPUT.PUT_LINE('Stage'||'|'||'Customer Number'||'|'||'history_snid'||'|'||'cust_account_id'||'|'||'cust_acct_site_id');
FOR process_update in cur_acc_sites 
LOOP
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------- ');
  v_print_after := 'N';
  FOR rec_xxrs_sc_history_tbl in cur_xxrs_sc_history_tbl (process_update.old_cust_site_id,null)
  LOOP
  v_print_after := 'Y';
    DBMS_OUTPUT.PUT_LINE('BEFORE'||'|'||process_update.account_number||'|'||rec_xxrs_sc_history_tbl.history_snid||'|'||rec_xxrs_sc_history_tbl.cust_account_id||'|'||rec_xxrs_sc_history_tbl.cust_acct_site_id);
  END LOOP;

BEGIN
UPDATE  XXRS_SC_HISTORY_TBL
  SET cust_acct_site_id = process_update.new_cust_site_id,
       last_updated_by     = 0,
       last_update_date    = SYSDATE,
       last_update_login   = -1
 WHERE cust_acct_site_id = process_update.old_cust_site_id;


EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error While Updating Cust Account Site on XXRS_SC_HISTORY_TBL For Customer '||process_update.account_number);   
END;

  IF v_print_after = 'Y' THEN
  FOR rec_xxrs_sc_history_tbl in cur_xxrs_sc_history_tbl (process_update.new_cust_site_id,sysdate)
  LOOP
    DBMS_OUTPUT.PUT_LINE('AFTER'||'|'||process_update.account_number||'|'||rec_xxrs_sc_history_tbl.history_snid||'|'||rec_xxrs_sc_history_tbl.cust_account_id||'|'||rec_xxrs_sc_history_tbl.cust_acct_site_id);
  END LOOP;
  END IF; 
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------- ');
    DBMS_OUTPUT.PUT_LINE('    Updated '||SQL%ROWCOUNT||' Records For Customer '||process_update.account_number||' and customer Site '||process_update.old_cust_site_id);
  
END LOOP;
------------*********************************************************---------------
DBMS_OUTPUT.PUT_LINE('**********************************');
FOR rec_xxrs_sc_acc_prd_tbl_cnt in cur_xxrs_sc_acc_prd_tbl_cnt 
LOOP
DBMS_OUTPUT.PUT_LINE('About To Update '||rec_xxrs_sc_acc_prd_tbl_cnt.xxrs_sc_acc_prd_tbl_cnt||' Records in xxrs_sc_account_product_tbl For all given customers');
END LOOP;
DBMS_OUTPUT.PUT_LINE('Stage'||'|'||'Customer Number'||'|'||'account_product_snid'||'|'||'cust_account_id'||'|'||'cust_acct_site_id');
FOR process_update in cur_acc_sites 
LOOP
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------- ');

  v_print_after := 'N';
  FOR rec_xxrs_sc_acc_prd_tbl in cur_xxrs_sc_acc_prd_tbl (process_update.old_cust_site_id,null)
  LOOP
  v_print_after := 'Y';
    DBMS_OUTPUT.PUT_LINE('BEFORE'||'|'||process_update.account_number||'|'||rec_xxrs_sc_acc_prd_tbl.account_product_snid||'|'||rec_xxrs_sc_acc_prd_tbl.cust_account_id||'|'||rec_xxrs_sc_acc_prd_tbl.cust_acct_site_id);
  END LOOP;

BEGIN
UPDATE  xxrs_sc_account_product_tbl
  SET cust_acct_site_id = process_update.new_cust_site_id,
       last_updated_by     = 0,
       last_update_date    = SYSDATE,
       last_update_login   = -1
 WHERE cust_acct_site_id = process_update.old_cust_site_id;

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error While Updating Cust Account Site on XXRS_SC_ACCOUNT_PRODUCT_TBL For Customer '||process_update.account_number);   
END;

  IF v_print_after = 'Y' THEN
    FOR rec_xxrs_sc_acc_prd_tbl in cur_xxrs_sc_acc_prd_tbl (process_update.new_cust_site_id,sysdate)
    LOOP
      DBMS_OUTPUT.PUT_LINE('AFTER'||'|'||process_update.account_number||'|'||rec_xxrs_sc_acc_prd_tbl.account_product_snid||'|'||rec_xxrs_sc_acc_prd_tbl.cust_account_id||'|'||rec_xxrs_sc_acc_prd_tbl.cust_acct_site_id);
    END LOOP;
  END IF; 
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------- ');
    DBMS_OUTPUT.PUT_LINE('    Updated '||SQL%ROWCOUNT||' Records For Customer '||process_update.account_number||' and customer Site '||process_update.old_cust_site_id);

END LOOP;
------------*********************************************************---------------
DBMS_OUTPUT.PUT_LINE('**********************************');
FOR rec_xxrs_sc_dev_prd_tbl_cnt in cur_xxrs_sc_dev_prd_tbl_cnt 
LOOP
DBMS_OUTPUT.PUT_LINE('About To Update '||rec_xxrs_sc_dev_prd_tbl_cnt.xxrs_sc_dev_prd_tbl_cnt||' Records in xxrs_sc_device_product_tbl For all given customers');
END LOOP;
DBMS_OUTPUT.PUT_LINE('Stage'||'|'||'Customer Number'||'|'||'device_num'||'|'||'device_product_snid'||'|'||'cust_account_id'||'|'||'cust_acct_site_id');
FOR process_update in cur_acc_sites 
LOOP
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------- ');

  v_print_after := 'N';
  FOR rec_xxrs_sc_dev_prd_tbl in cur_xxrs_sc_dev_prd_tbl (process_update.old_cust_site_id,null)
  LOOP
  v_print_after := 'Y';
    DBMS_OUTPUT.PUT_LINE('BEFORE'||'|'||process_update.account_number||'|'||rec_xxrs_sc_dev_prd_tbl.device_num||'|'||rec_xxrs_sc_dev_prd_tbl.device_product_snid||'|'||rec_xxrs_sc_dev_prd_tbl.cust_account_id||'|'||rec_xxrs_sc_dev_prd_tbl.cust_acct_site_id);
  END LOOP;
  
BEGIN
UPDATE  xxrs_sc_device_product_tbl
  SET cust_acct_site_id = process_update.new_cust_site_id,
       last_updated_by     = 0,
       last_update_date    = SYSDATE,
       last_update_login   = -1
 WHERE cust_acct_site_id = process_update.old_cust_site_id;
 

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error While Updating Cust Account Site on XXRS_SC_DEVICE_PRODUCT_TBL For Customer '||process_update.account_number);   
END;

  IF v_print_after = 'Y' THEN
    FOR rec_xxrs_sc_dev_prd_tbl in cur_xxrs_sc_dev_prd_tbl (process_update.new_cust_site_id,sysdate)
    LOOP
      DBMS_OUTPUT.PUT_LINE('AFTER'||'|'||process_update.account_number||'|'||rec_xxrs_sc_dev_prd_tbl.device_num||'|'||rec_xxrs_sc_dev_prd_tbl.device_product_snid||'|'||rec_xxrs_sc_dev_prd_tbl.cust_account_id||'|'||rec_xxrs_sc_dev_prd_tbl.cust_acct_site_id);
    END LOOP;
  END IF;
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------- ');
    DBMS_OUTPUT.PUT_LINE('    Updated '||SQL%ROWCOUNT||' Records For Customer '||process_update.account_number||' and customer Site '||process_update.old_cust_site_id);

END LOOP;
------------*********************************************************---------------
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error While Updating Cust Account Site'||SQLERRM);   

END;
/







