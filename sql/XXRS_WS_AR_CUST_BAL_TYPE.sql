DROP TYPE xxrs.xxrs_ws_ar_cust_bal_tbl;
DROP TYPE xxrs.xxrs_ws_ar_cust_bal_type;
CREATE TYPE xxrs.xxrs_ws_ar_cust_bal_type AS OBJECT
/*********************************************************************************************************
*                                                                                                        *
* NAME : XXRS_WS_AR_CUST_BAL_TYPE.sql                                                                    *
*                                                                                                        *
*DESCRIPTION : Script to create Data type to hold Customer Current Balance Data.                         *
*                                                                                                        *
* AUTHOR       : Vaibhav Goyal                                                                           *
* DATE WRITTEN : 21-NOV-2011                                                                             *
*                                                                                                        *
* CHANGE CONTROL :                                                                                       *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                        *
*--------------------------------------------------------------------------------------------------------*
* 1.0.0        |   111122-02448    | Vaibhav Goyal   | 11/21/2011     | Initial Creation                 *
*                                                                                                        *
**********************************************************************************************************/
/* $Header: XXRS_WS_AR_CUST_BAL_TYPE.sql 1.0.0 11/21/2011 10:00:00 AM Vaibhav Goyal $ */
(
CUSTOMER_NUMBER		VARCHAR2(60),
AMOUNT			VARCHAR2(60),
CURRENCY_CODE		VARCHAR2(60)
);
/
CREATE OR REPLACE TYPE xxrs.xxrs_ws_ar_cust_bal_tbl AS TABLE OF xxrs.xxrs_ws_ar_cust_bal_type;
/


