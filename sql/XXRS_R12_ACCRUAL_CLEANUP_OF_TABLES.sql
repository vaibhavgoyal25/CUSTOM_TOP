  /**************************************************************************************************
  * NAME : R12Accrual_Cleanup.sql                                                                   *
  *                                                                                                 *
  * DESCRIPTION :                                                                                   *
  *  This script was written by Oracle Support as per Oracle SR  3-5655788651                       *
  *                                                                                                 *
  * AUTHOR       :                                                                                  *
  * DATE WRITTEN :                                                                                  *
  *                                                                                                 *
  * CHANGE CONTROL :                                                                                *
  * Version# | Ticket #     |  WHO            | DATE         |   REMARKS                            *
  *-------------------------------------------------------------------------------------------------*
  * 1.0.0    | 120503-13059 |                 |              |                                      *
  ***************************************************************************************************/

-- Accrual data clean up script
SET SERVEROUT ON
set echo on
set time on 
set timing on

col file_name   new_value   spool_file_name    noprint
select 'XXRS_R12_ACCRUAL_CLEANUP_OF_TABLES' ||to_char (sysdate, '_mmddyy_hhmiss')||'.log' file_name from dual ;



spool &spool_file_name

select count(*) from cst_write_offs ;
select count(*) from cst_write_off_details ;
select count(*) from CST_RECONCILIATION_BUILD ;
select count(*) from CST_RECONCILIATION_SUMMARY;
select count(*) from cst_misc_reconciliation;
select count(*) from CST_AP_PO_RECONCILIATION;

DECLARE
  p_operating_unit NUMBER := &OP_UNIT_ID;
  p_operating_unit_validate NUMBER := &ReEnter_OU_ID;

BEGIN

 IF p_operating_unit <> p_operating_unit_validate THEN
    dbms_output.put_line(' Incorrect Operating Unit provided.' );
    dbms_output.put_line(' Data cleanup not done.... ');
    RETURN;
 END IF;

 DELETE FROM   cst_write_offs
  WHERE operating_unit_id = p_operating_unit
    AND EXISTS
        (SELECT 1
           FROM    po_accrual_write_offs_all pawo
          WHERE   pawo.write_off_id=cst_write_offs.write_off_id);

 DELETE FROM   cst_write_off_details
  WHERE operating_unit_id = p_operating_unit
    AND EXISTS
        (SELECT 1
   FROM po_accrual_write_offs_all pawo
  WHERE pawo.write_off_id=cst_write_off_details.write_off_id);

  dbms_output.put_line(' Cleaned up Write Offs....' );

 DELETE  FROM   CST_RECONCILIATION_BUILD
  WHERE  operating_unit_id = p_operating_unit;

 DELETE  FROM   CST_RECONCILIATION_SUMMARY
  WHERE  operating_unit_id = p_operating_unit;

 DELETE  FROM   cst_misc_reconciliation
  WHERE  operating_unit_id = p_operating_unit;

 DELETE FROM   CST_AP_PO_RECONCILIATION
  WHERE  operating_unit_id = p_operating_unit;

  dbms_output.put_line(' Data clean Up Complete....' );

 COMMIT;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    dbms_output.put_line(' Exception Raised : ' || SQLERRM);
END;
/
--select count(*) from cst_write_offs ;
--select count(*) from cst_write_off_details ;
--select count(*) from CST_RECONCILIATION_BUILD ;
--select count(*) from CST_RECONCILIATION_SUMMARY;
--select count(*) from cst_misc_reconciliation;
--select count(*) from CST_AP_PO_RECONCILIATION;

spool 

