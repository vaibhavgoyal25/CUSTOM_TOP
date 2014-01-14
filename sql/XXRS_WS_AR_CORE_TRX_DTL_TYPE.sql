DROP TYPE xxrs.xxrs_ws_ar_core_trx_dtl_tbl;
DROP TYPE xxrs.xxrs_ws_ar_core_trx_dtl_type;
CREATE TYPE xxrs.xxrs_ws_ar_core_trx_dtl_type AS OBJECT
/*********************************************************************************************************
*                                                                                                        *
* NAME : XXRS_WS_AR_CORE_TRX_DTL_TYPE.sql                                                                *
*                                                                                                        *
*DESCRIPTION : Script to create Data type to hold Transaction List Data Corresponding to Costomer.       *
*                                                                                                        *
* AUTHOR       : Vaibhav Goyal                                                                           *
* DATE WRITTEN : 26-JAN-2012                                                                             *
*                                                                                                        *
* CHANGE CONTROL :                                                                                       *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                        *
*--------------------------------------------------------------------------------------------------------*
* 1.0.0        |   111122-02448    | Vaibhav Goyal   | 01/26/2012     | Initial Creation                 *
*                                                                                                        *
**********************************************************************************************************/
/* $Header: XXRS_WS_AR_CORE_TRX_DTL_TYPE.sql 1.0.0 01/26/2012 10:00:00 AM Vaibhav Goyal $ */
(
transaction_date    VARCHAR2(10),
trx_class           VARCHAR2(20),
customer_location   VARCHAR2(240),
trx_number          VARCHAR2(30),
trx_currency        VARCHAR2(15),
original_amount     VARCHAR2(20),
amount_applied      VARCHAR2(20),
balance_due         VARCHAR2(20),
status              VARCHAR2(30)
);
/
CREATE OR REPLACE TYPE xxrs.xxrs_ws_ar_core_trx_dtl_tbl AS TABLE OF xxrs.xxrs_ws_ar_core_trx_dtl_type;
/

