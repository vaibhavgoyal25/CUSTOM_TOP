DROP TYPE xxrs.xxrs_ws_ar_get_rec_pay_tbl;
DROP TYPE xxrs.xxrs_ws_ar_get_rec_pay_type;
CREATE TYPE xxrs.xxrs_ws_ar_get_rec_pay_type AS OBJECT
/*********************************************************************************************************
*                                                                                                        *
* NAME : XXRS_WS_AR_GET_REC_PAY_TYPE.sql                                                                 *
*                                                                                                        *
*DESCRIPTION : Script to create Data type to hold Recurring Payment Data Corresponding to Costomer.      *
*                                                                                                        *
* AUTHOR       : Vaibhav Goyal                                                                           *
* DATE WRITTEN : 27-JAN-2012                                                                             *
*                                                                                                        *
* CHANGE CONTROL :                                                                                       *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                        *
*--------------------------------------------------------------------------------------------------------*
* 1.0.0        |   111122-02448    | Vaibhav Goyal   | 01/27/2012     | Initial Creation                 *
*                                                                                                        *
**********************************************************************************************************/
/* $Header: XXRS_WS_AR_GET_REC_PAY_TYPE.sql 1.0.0 01/27/2012 10:00:00 AM Vaibhav Goyal $ */
( CUSTOMER_ID            VARCHAR2(15),   
  CUST_SITE_ID           VARCHAR2(15),    
  CUST_SITE_USE_ID       VARCHAR2(15),    
  CUST_SITE_DETAILS      VARCHAR2(480),  
  ORG_ID                 VARCHAR2(15),    
  BANK_ACCOUNT_USES_ID   VARCHAR2(60),   
  CORE_ACCOUNT_NUMBER    VARCHAR2(60),
  PAYMENT_TYPE           VARCHAR2(60),
  NAME_ON_CARD           VARCHAR2(60),
  CREDIT_CARD_NUMBER     VARCHAR2(60),
  CREDIT_CARD_EXP_DATE   VARCHAR2(60),
  CREDIT_CARD_TYPE       VARCHAR2(60),
  NAME_ON_BANK_ACCOUNT   VARCHAR2(60),
  BANK_ROUTING_NUMBER    VARCHAR2(60),
  BANK_ACCOUNT_NUMBER    VARCHAR2(60),
  BANK_NAME              VARCHAR2(60),   
  CURRENCY_CODE          VARCHAR2(15),   
  ERROR_CODE             VARCHAR2(60)    
);
/
CREATE OR REPLACE TYPE xxrs.xxrs_ws_ar_get_rec_pay_tbl AS TABLE OF xxrs.xxrs_ws_ar_get_rec_pay_type;
/

