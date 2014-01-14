/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_AR_TRX_APPLIED_GT.sql                                                                                   *
*                                                                                                                     *
* DESCRIPTION : Temp table for 'Rackspace Cash Application Program'                                                   *
*                                                                                                                     *
* AUTHOR       : Kalyan                                                                                               *
* DATE WRITTEN : 07-MAR-2011                                                                                          *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* VER #  |  TICKET #    | WHO        |  DATE       |  REMARKS                                                         *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0  | 111122-02448 | Kalyan     |  07-MAR-2011  | Initial built                                                  * 
***********************************************************************************************************************/
/* $Header: xxrs_ar_trx_applied_gt.sql 1.0.0 07-MAR-2011 15:00:00 Kalyan$ */

DROP TABLE xxrs.xxrs_ar_trx_applied_gt CASCADE CONSTRAINTS;

CREATE GLOBAL TEMPORARY TABLE xxrs.xxrs_ar_trx_applied_gt
(
  cust_num           VARCHAR2(30),
  receipt_num        VARCHAR2(30),
  cm_num             VARCHAR2(20),
  trx_num            VARCHAR2(20),  
  amt_applied        NUMBER,
  creation_date      DATE,
  created_by         NUMBER,
  last_update_date   DATE,
  last_updated_by    NUMBER,
  last_update_login  NUMBER  
)
ON COMMIT PRESERVE ROWS
NOCACHE;

DROP SYNONYM apps.xxrs_ar_trx_applied_gt;

CREATE SYNONYM apps.xxrs_ar_trx_applied_gt FOR xxrs.xxrs_ar_trx_applied_gt;
