--/* ********************************************************************************************************************
--*                                                                                                                     *
--* NAME          : xxrsinvloadtrx.ctl                                                                                  *
--*                                                                                                                     *
--* DESCRIPTION   : Control file to load all the records into XXRS_INV_MISC_TRX_TAB.                                    *
--*                                                                                                                     *
--* AUTHOR        : Ravi                                                                                                *
--* DATE WRITTEN  : 18-JAN-2012                                                                                         *
--*                                                                                                                     *
--* CHANGE CONTROL:                                                                                                     *
--* SR#          |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                                     *
--*---------------------------------------------------------------------------------------------------------------------*
--* 1.0.0        |  111122-02448     | Ravi            |  18-JAN-2012   | Initial creation for R12 Upgradation          *
--***********************************************************************************************************************/
--/* $Header: xxrsinvloadtrx.ctl 1.0.0 18-JAN-2012 11:00:00 AM Ravi $ */
OPTIONS (SKIP=1)
LOAD DATA
INFILE *
REPLACE
INTO TABLE xxrs.xxrs_inv_misc_trx_tab
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING nullcols
( 
  inv_org              "DECODE(:serial_no, NULL, NULL,LTRIM(RTRIM(:inv_org)))",
  transaction_type     "DECODE(:serial_no, NULL, NULL,LTRIM(RTRIM(:transaction_type)))",
  item_no              "DECODE(:serial_no, NULL, NULL,LTRIM(RTRIM(:item_no)))",
  serial_no            "DECODE(:serial_no, NULL, NULL,LTRIM(RTRIM(:serial_no)))",
  qty                  "DECODE(:serial_no, NULL, NULL,LTRIM(RTRIM(:qty)))",
  uom                  "DECODE(:serial_no, NULL, NULL,LTRIM(RTRIM(:uom)))",
  source_subinv        "DECODE(:serial_no, NULL, NULL,LTRIM(RTRIM(:source_subinv)))",
  source_locator       "DECODE(:serial_no, NULL, NULL,LTRIM(RTRIM(:source_locator)))",
  transaction_source   "DECODE(:serial_no, NULL, NULL,LTRIM(RTRIM(:transaction_source)))",
  transfer_org         "DECODE(:serial_no, NULL, NULL,LTRIM(RTRIM(:transfer_org)))",
  shipment_no          "DECODE(:serial_no, NULL, NULL,LTRIM(RTRIM(:shipment_no)))",
  transfer_subinv      "DECODE(:serial_no, NULL, NULL,LTRIM(RTRIM(:transfer_subinv)))",
  transfer_locator     "DECODE(:serial_no, NULL, NULL,LTRIM(RTRIM(:transfer_locator)))",
  reason_code          "DECODE(:serial_no, NULL, NULL,LTRIM(RTRIM(:reason_code)))",	
  conc_request_id      "DECODE(:serial_no, NULL, NULL, :conc_request_id)",
  created_by           "DECODE(:serial_no, NULL, NULL, :created_by)",
  creation_date        "DECODE(:serial_no, NULL, NULL, SYSDATE)",
  last_update_login    "DECODE(:serial_no, NULL, NULL, -1)",
  last_update_date     "DECODE(:serial_no, NULL, NULL, SYSDATE)",
  last_updated_by      "DECODE(:serial_no, NULL, NULL, :created_by)",
  source_reference     "xxrs.xxrs_inv_serial_ref_s.NEXTVAL"
)