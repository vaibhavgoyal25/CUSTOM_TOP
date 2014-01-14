/*************************************************************************************************************
*                                                                                                            *
* NAME : XXRS_INV_SNAPSHOT_REP_GT.sql                                                                        *
*                                                                                                            *
*  DESCRIPTION :                                                                                             *
*  Script to Create table to Store Inventory Snapshot Data.                                                  *
*                                                                                                            *
*  AUTHOR       : SUDHEER GUNTU                                                                              *
*  DATE WRITTEN : 23-JAN-2012                                                                                *
*                                                                                                            *
*  CHANGE CONTROL :                                                                                          *
*------------------------------------------------------------------------------------------------------------*
* VERSION |GENIE TICKET # |       WHO         |  DATE       | REMARKS                                        *
*------------------------------------------------------------------------------------------------------------*
* 1.0.0   |111122-02448   |   SUDHEER GUNTU   | 23-JAN-2012 | Initial Creation of R12 upgrade                *
*************************************************************************************************************/

CREATE GLOBAL TEMPORARY TABLE xxrs.xxrs_inv_snapshot_rep_gt
(
  datacenter                        VARCHAR2 (3),
  org_id                            NUMBER,
  inventory_item_id                 NUMBER,
  item_number                       VARCHAR2 (40),
  item_description                  VARCHAR2 (240),
  status                            VARCHAR2 (10),
  currently_deployed                NUMBER,
  currently_in_stock                NUMBER,
  current_stock_book_value          NUMBER,
  average_stock_book_value          NUMBER,
  deployed_transactions             NUMBER,
  churn_transactions                NUMBER,
  number_of_days                    NUMBER,
  average_net_deployment            NUMBER,
  days_supply_of_inventory          NUMBER,
  excess_inventory_book_value       NUMBER,
  obsolete_inventory_book_value     NUMBER,
  last_update_by                    NUMBER(15),
  last_update_date                  DATE,
  process_status                    VARCHAR2 (1),
  error_message                     VARCHAR2 (1000)
)
ON COMMIT PRESERVE ROWS
NOCACHE;

CREATE INDEX xxrs.xxrs_inv_snapshot_rep_gt_n01
  ON xxrs.xxrs_inv_snapshot_rep_gt (inventory_item_id);

CREATE INDEX xxrs.xxrs_inv_snapshot_rep_gt_n02
  ON xxrs.xxrs_inv_snapshot_rep_gt (org_id);

/