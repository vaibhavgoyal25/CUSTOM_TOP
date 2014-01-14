/**************************************************************************************************************
*                                                                                                             *
* NAME : XXRS_SC_MIGRATED_DEVICES_VW_bkp.sql                                                                  *
*                                                                                                             *
* DESCRIPTION :                                                                                               *
*   Modifying View to reflect flag changes from F, T to Y,N                                                   *
*                                                                                                             *
* AUTHOR       : Pavan Amirineni                                                                              *
* DATE WRITTEN : 22-JAN-2013                                                                                  *
*                                                                                                             *
* CHANGE CONTROL :                                                                                            *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                             *
*-------------------------------------------------------------------------------------------------------------*
* 1.0.0        |                   | Mark            |  01-JAN-2009   | Initial Creation.                     *
***************************************************************************************************************/
--
/* $Header: XXRS_SC_MIGRATED_DEVICES_VW_bkp.sql 1.0.1 01/01/2009 11:06:24 Mark  $ */
--
CREATE OR REPLACE FORCE VIEW APPS.XXRS_SC_MIGRATED_DEVICES_VW
(
   ROW_ID,
   OLD_DEVICE_PRODUCT_SNID,
   NEW_DEVICE_PRODUCT_SNID,
   CONTRACT_SNID,
   OLD_DEVICE_NUM_PICK,
   OWNS_MONTHLY_FEE,
   OLD_MONTHLY_FEE_PICK
)
AS
   SELECT mig_dev.ROWID,
          mig_dev.old_device_product_snid,
          mig_dev.new_device_product_snid,
          mig_dev.contract_snid,
          dev_prod.device_num,
          mig_dev.owns_monthly_fee,
          DECODE (
             mig_dev.owns_monthly_fee,
             'Y', (SELECT NVL (SUM (unit_price), 0)
                     FROM xxrs_sc_device_resource_vw
                    WHERE     resource_billing_type_code = 1
                          AND tiered_flag = 'F'
                          AND include_in_monthly_fee_flag = 'T'
                          AND billing_start_date <= SYSDATE
                          AND billing_end_date IS NULL
                          AND device_product_snid =
                                 dev_prod.device_product_snid),
             0)
     FROM xxrs_sc_device_product_tbl dev_prod,
          xxrs_sc_migrated_devices_tbl mig_dev
    WHERE     mig_dev.old_device_product_snid = dev_prod.device_product_snid
          AND NVL (
                 dev_prod.org_id,
                 NVL (
                    TO_NUMBER (
                       DECODE (SUBSTRB (USERENV ('CLIENT_INFO'), 1, 1),
                               ' ', NULL,
                               SUBSTRB (USERENV ('CLIENT_INFO'), 1, 10))),
                    -99)) =
                 NVL (
                    TO_NUMBER (
                       DECODE (SUBSTRB (USERENV ('CLIENT_INFO'), 1, 1),
                               ' ', NULL,
                               SUBSTRB (USERENV ('CLIENT_INFO'), 1, 10))),
                    -99);