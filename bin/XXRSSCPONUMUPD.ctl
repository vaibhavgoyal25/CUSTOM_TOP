-- /**********************************************************************************************************************
-- *                                                                                                                     *
-- * NAME : XXRSSCPONUMUPD.ctl                                                                                           *
-- *                                                                                                                     *
-- * DESCRIPTION :                                                                                                       *
-- * Control file to load PO Number Update data.                                                                         *
-- *                                                                                                                     *
-- * AUTHOR       : VAIBHAV GOYAL                                                                                        *
-- * DATE WRITTEN : 03-SEP-2013                                                                                          *
-- *                                                                                                                     *
-- * CHANGE CONTROL :                                                                                                    *
-- * Ver#  | Ticket #     | WHO             | DATE       |   REMARKS                                                     *
-- *---------------------------------------------------------------------------------------------------------------------*
-- * 1.0.0 | 130621-07223 | VAIBHAV GOYAL   | 03-SEP-2013| Initial Creation.                                             *
-- ***********************************************************************************************************************/

-- /* $Header: XXRSSCPONUMUPD.ctl 1.0.0 03-SEP-2013 11:16:52 AM VAIBHAV GOYAL $ */
OPTIONS(skip=1)
LOAD DATA
REPLACE
INTO TABLE XXRS.XXRS_SC_PO_NUM_UPD
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
( customer_number                   "TRIM(:customer_number)",
  cloud_account                     "TRIM(:cloud_account)",
  product_name                      "TRIM(:product_name)",
  resource_name                     "TRIM(:resource_name)",
  device_num                        "TRIM(:device_num)",
  existing_po_number                "TRIM(:existing_po_number)",
  new_po_number                     "TRIM(:new_po_number)",
  process_status                     CONSTANT "P",
  conc_request_id                   "TRIM(:conc_request_id)",
  creation_date                      SYSDATE,
  created_by                        "TRIM(:created_by)",
  last_update_login                  CONSTANT "-1",
  last_update_date                   SYSDATE,
  last_updated_by                   "TRIM(:created_by)",
  cust_po_num_upd_id                "xxrs.xxrs_sc_po_num_upd_seq.NEXTVAL")