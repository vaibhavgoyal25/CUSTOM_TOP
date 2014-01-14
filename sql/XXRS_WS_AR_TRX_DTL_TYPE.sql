DROP TYPE xxrs.xxrs_ws_ar_trx_dtl_tbl;
DROP TYPE xxrs.xxrs_ws_ar_trx_dtl_type;
CREATE TYPE xxrs.xxrs_ws_ar_trx_dtl_type AS OBJECT
/*********************************************************************************************************
*                                                                                                        *
* NAME : XXRS_WS_AR_TRX_DTL_TYPE.sql                                                                     *
*                                                                                                        *
*DESCRIPTION : Script to create Data type to hold Transaction List Data Corresponding to Costomer.       *
*                                                                                                        *
* AUTHOR       : Vaibhav Goyal                                                                           *
* DATE WRITTEN : 14-NOV-2011                                                                             *
*                                                                                                        *
* CHANGE CONTROL :                                                                                       *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                        *
*--------------------------------------------------------------------------------------------------------*
* 1.0.0        |   111122-02448    | Vaibhav Goyal   | 11/14/2011     | Initial Creation                 *
*                                                                                                        *
**********************************************************************************************************/
/* $Header: XXRS_WS_AR_TRX_TYPE.sql 1.0.0 11/14/2011 10:00:00 AM Vaibhav Goyal $ */
(
transaction_type        VARCHAR2 (20),
transaction_number      VARCHAR2 (60),
posting_date            VARCHAR2 (10),
amount                  VARCHAR2 (15),
currency                VARCHAR2 (15),
status                  VARCHAR2 (10),
org_id                  VARCHAR2 (10),
tax_code                VARCHAR2 (50));
/
CREATE OR REPLACE TYPE xxrs.xxrs_ws_ar_trx_dtl_tbl AS TABLE OF xxrs.xxrs_ws_ar_trx_dtl_type;
/

