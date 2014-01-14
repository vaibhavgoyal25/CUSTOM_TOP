/**********************************************************************************************************************
*                                                                                                                     *
* NAME : xxrs_ar_cash_application_gt.sql                                                                              *
*                                                                                                                     *
* DESCRIPTION : Temp table for 'Rackspace Cash Application Program'                                                   *
*                                                                                                                     *
* AUTHOR       : Kalyan                                                                                               *
* DATE WRITTEN : 16-FEB-2011                                                                                          *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* VER #  |  TICKET #    | WHO        |  DATE       |  REMARKS                                                         *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0  | 111122-02448 | Kalyan     |  16-FEB-2011  | Initial built                                                  * 
***********************************************************************************************************************/
/* $Header: xxrs_ar_cash_application_gt.sql 1.0.0 16-FEB-2011 15:00:00 Kalyan$ */

DROP TABLE xxrs.xxrs_ar_cash_application_gt CASCADE CONSTRAINTS;

CREATE GLOBAL TEMPORARY TABLE xxrs.xxrs_ar_cash_application_gt
(
  customer_id        NUMBER,
  receipt_id         NUMBER,
  receipt_number     VARCHAR2(30),
  credit_memo_id     NUMBER,  
  credit_memo_num    VARCHAR2(20),
  currency_code      VARCHAR2(3),
  error_msg          VARCHAR2(2000),
  status_flag        VARCHAR2(1),
  creation_date      DATE,
  created_by         NUMBER,
  last_update_date   DATE,
  last_updated_by    NUMBER,
  last_update_login  NUMBER  
)
ON COMMIT PRESERVE ROWS
NOCACHE;

DROP SYNONYM apps.xxrs_ar_cash_application_gt;

CREATE SYNONYM apps.xxrs_ar_cash_application_gt FOR xxrs.xxrs_ar_cash_application_gt;