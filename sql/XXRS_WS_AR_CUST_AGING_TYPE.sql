DROP TYPE xxrs.xxrs_ws_ar_cust_aging_tbl;
DROP TYPE xxrs.xxrs_ws_ar_cust_aging_type;
CREATE TYPE xxrs.xxrs_ws_ar_cust_aging_type AS OBJECT
/*********************************************************************************************************
*                                                                                                        *
* NAME : XXRS_WS_AR_CUST_AGING_TYPE.sql                                                                  *
*                                                                                                        *
* DESCRIPTION : Script to create Data type to hold Customer Aging Details.                               *
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
/* $Header: XXRS_WS_AR_CUST_AGING_TYPE.sql 1.0.0 11/14/2011 1:29:41 PM Vaibhav Goyal $ */
(
customer_id              VARCHAR2(15),
customer_site_id         VARCHAR2(15),
customer_site_use_id     VARCHAR2(15),
customer_location        VARCHAR2(1200),
currency_code            VARCHAR2(15),
current_due              VARCHAR2(30),
past_due_01_30           VARCHAR2(30),
past_due_31_60           VARCHAR2(30),
past_due_61_90           VARCHAR2(30),
past_due_91_120          VARCHAR2(30),
past_due_121_180         VARCHAR2(30),
past_due_180_plus        VARCHAR2(30),
outstanding_amount       VARCHAR2(30)
);
/
CREATE TYPE xxrs.xxrs_ws_ar_cust_aging_tbl AS TABLE OF xxrs.xxrs_ws_ar_cust_aging_type;
/