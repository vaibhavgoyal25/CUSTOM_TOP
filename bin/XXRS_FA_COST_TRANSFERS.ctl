-- /**********************************************************************************************************************
-- *                                                                                                                     *
-- * NAME : XXRS_FA_COST_TRANSFERS.ctl                                                                                   *
-- *                                                                                                                     *
-- * DESCRIPTION :                                                                                                       *
-- * Load data into the cost transfer staging table.                                                                     *
-- *                                                                                                                     *
-- * AUTHOR       : Santosh Kumar                                                                                        *
-- * DATE WRITTEN : 15-Dec-2011                                                                                          *
-- *                                                                                                                     *
-- * CHANGE CONTROL :                                                                                                    *
-- * Version#     |  Racker Ticket #  | WHO              |  DATE           |   REMARKS                                   *
-- *---------------------------------------------------------------------------------------------------------------------*
-- * 1.0.0        | 111122-02448      | Santosh Kumar    |  15-Dec-2011    | Initial Creation                            *
-- ***********************************************************************************************************************/
OPTIONS (SKIP=1)
LOAD DATA
APPEND
INTO TABLE xxrs.xxrs_fa_cost_transfers
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  from_serial_number "Trim(:from_serial_number)"
, to_serial_number "Trim(:to_serial_number)"  
, inventory_org_code "Trim(:inventory_org_code)"
, to_item_number "Trim(:to_item_number)"
, conc_request_id ":conc_request_id"
, created_by ":created_by"
, transfer_id "xxrs_fa_cost_transfers_s.nextval"
, process_status CONSTANT "P"
, creation_date SYSDATE
, last_update_login CONSTANT "-1"
, last_update_date SYSDATE
, last_updated_by ":created_by"
)