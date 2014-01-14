/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_INV_STRUCK_TRX_CREATE_OBJ.sql                                                                           *
*                                                                                                                     *
* DESCRIPTION :                                                                                                       *
* Script to create the tables for Rackspace Release Struck Transaction Datafix Program.                               *
*                                                                                                                     *
* AUTHOR       : Vaibhav.Goyal                                                                                       *
* DATE WRITTEN : 08/10/2012                                                                                           *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                                     *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  120802-05087     | Vaibhav.Goyal   |  08/10/2012    | Initial Creation                              *
***********************************************************************************************************************/
--
/* $Header: XXRS_INV_STRUCK_TRX_CREATE_OBJ.sql 1.0.0 08/31/2011 02:00:00 PM Vaibhav.Goyal $ */
--

SET serveroutput ON
DECLARE
  l_exists NUMBER := 0;
BEGIN

  BEGIN
    SELECT 1 INTO l_exists FROM all_tables WHERE table_name = 'XXRS_INV_MTLT_BKUP_GENERIC';
    Dbms_Output.put_line('Table xxrs_inv_mtlt_bkup_generic exists.');
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      EXECUTE IMMEDIATE 'CREATE TABLE XXRS.XXRS_INV_MTLT_BKUP_GENERIC AS SELECT * FROM mtl_transaction_lots_temp WHERE 1=2';
      EXECUTE IMMEDIATE 'ALTER TABLE XXRS.XXRS_INV_MTLT_BKUP_GENERIC add (creating_request_id NUMBER(15),record_creation_date DATE)';
      Dbms_Output.put_line('Table xxrs_inv_mtlt_bkup_generic created.');
  END;


  l_exists := 0;
  BEGIN
    SELECT 1 INTO l_exists FROM all_tables WHERE table_name = 'XXRS_INV_MSNT_BKUP_GENERIC';
    Dbms_Output.put_line('Table xxrs_inv_msnt_bkup_generic exists.');
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      EXECUTE IMMEDIATE 'CREATE TABLE XXRS.XXRS_INV_MSNT_BKUP_GENERIC AS SELECT * FROM mtl_serial_numbers_temp WHERE 1=2';
      EXECUTE IMMEDIATE 'ALTER TABLE XXRS.XXRS_INV_MSNT_BKUP_GENERIC add (creating_request_id NUMBER(15),record_creation_date DATE)';
      Dbms_Output.put_line('Table xxrs_inv_msnt_bkup_generic created.');
  END;


  l_exists := 0;
  BEGIN
    SELECT 1 INTO l_exists FROM all_tables WHERE table_name = 'XXRS_INV_MSN_BKUP_GENERIC';
    Dbms_Output.put_line('Table xxrs_inv_msn_bkup_generic exists.');
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      EXECUTE IMMEDIATE 'CREATE TABLE XXRS.XXRS_INV_MSN_BKUP_GENERIC AS SELECT * FROM mtl_serial_numbers WHERE 1=2';
      EXECUTE IMMEDIATE 'ALTER TABLE XXRS.XXRS_INV_MSN_BKUP_GENERIC add (creating_request_id NUMBER(15),record_creation_date DATE)';
      Dbms_Output.put_line('Table xxrs_inv_msn_bkup_generic created.');
  END;
END;
/