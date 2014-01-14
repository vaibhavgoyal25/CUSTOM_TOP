/********************************************************************************************************************
*                                                                                                                   *
* NAME : XXRS_AP_CASH_REQ_REP_GT.sql                                                                                 *
*                                                                                                                   *
* DESCRIPTION :                                                                                                     *
* Table to hold the data returned by the 'Rackspace Aging 7 Bucket Report'                                          *
*                                                                                                                   *
* AUTHOR       : Kalyan                                                                                             *
* DATE WRITTEN : 26-MAR-2012                                                                                        *
*                                                                                                                   *
* CHANGE CONTROL :                                                                                                  *
* Version# | Ticket #    | WHO             |  DATE       |   REMARKS                                                *
*-------------------------------------------------------------------------------------------------------------------*
* 1.0.0   | 111122-02448 | Kalyan         | 26-MAR-2012 | R12 Upgrade                                              *
*********************************************************************************************************************/
/* $Header:  XXRS_AP_CASH_REQ_REP_GT.sql 1.0.0 26-MAR-2012  10:00:00 AM Kalyan  $ */

DROP TABLE xxrs.xxrs_ap_cash_req_rep_gt CASCADE CONSTRAINTS;

CREATE GLOBAL TEMPORARY TABLE xxrs.xxrs_ap_cash_req_rep_gt
(
  supplier_number           VARCHAR2(30),
  supplier_name             VARCHAR2(240),
  invoice_posting_date      VARCHAR2(10),
  payment_due_date          VARCHAR2(20),
  invoice_number            VARCHAR2(50),
  gl_account                VARCHAR2(60),
  distribution_line_number  VARCHAR2(60),
  distribution_line_amount  VARCHAR2(60),
  invoice_amount            VARCHAR2(40),
  invoice_currency_code     VARCHAR2(15)
)
ON COMMIT PRESERVE ROWS
NOCACHE;

DROP SYNONYM apps.xxrs_ap_cash_req_rep_gt;

CREATE SYNONYM apps.xxrs_ap_cash_req_rep_gt FOR xxrs.xxrs_ap_cash_req_rep_gt;

/