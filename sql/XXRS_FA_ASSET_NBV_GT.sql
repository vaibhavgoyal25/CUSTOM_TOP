/***************************************************************************************************************
*                                                                                                              *
* NAME : XXRS_FA_ASSET_NBV_GT.sql                                                                              *
*                                                                                                              *
*  DESCRIPTION :                                                                                               *
*  Script to Create table to Store Net Book Value Data.                                                        *
*                                                                                                              *
*  AUTHOR       : SUDHEEER GUNTU                                                                               *
*  DATE WRITTEN : 23-JAN-2012                                                                                  *
*                                                                                                              *
*  CHANGE CONTROL :                                                                                            *
*--------------------------------------------------------------------------------------------------------------*
* VERSION |GENIE TICKET # |       WHO         |  DATE       |  REMARKS                                         *
*--------------------------------------------------------------------------------------------------------------*
* 1.0.0   |111122-02448   |   SUDHEER GUNTU   | 23-JAN-2012 |  Initial Creation for R12 Upgrade                *
***************************************************************************************************************/

CREATE GLOBAL TEMPORARY TABLE xxrs.xxrs_fa_asset_nbv_gt
(
  asset_id                NUMBER(15),
  book_value              NUMBER,
  date_placed_in_service  DATE,
  serial_number           VARCHAR2(30),
  inv_organization_id     NUMBER,
  inventory_item_id       NUMBER
)
ON COMMIT PRESERVE ROWS
NOCACHE;

CREATE SYNONYM apps.xxrs_fa_asset_nbv_gt FOR xxrs.xxrs_fa_asset_nbv_gt;

CREATE INDEX xxrs.xxrs_fa_asset_nbv_gt_n01 ON xxrs.xxrs_fa_asset_nbv_gt
(serial_number, inv_organization_id, inventory_item_id);

/
