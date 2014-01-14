DROP TYPE xxrs.xxrs_ar_cust_site_dtls_tbl;
DROP TYPE xxrs.xxrs_ar_cust_site_dtls_type;

CREATE OR REPLACE TYPE XXRS.xxrs_ar_cust_site_dtls_type AS OBJECT
/*********************************************************************************************************
*                                                                                                        *
* NAME : XXRS_WS_AR_CUST_SITE_DETAILS_TYPE.sql                                                           *
*                                                                                                        *
*DESCRIPTION : Script to create Data type to hold Customer Site Details.                                 *
*                                                                                                        *
* AUTHOR       : Vaibhav Goyal                                                                           *
* DATE WRITTEN : 24-JAN-2012                                                                             *
*                                                                                                        *
* CHANGE CONTROL :                                                                                       *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                        *
*--------------------------------------------------------------------------------------------------------*
* 1.0.0        |   111122-02448    | Vaibhav Goyal   | 01/24/2012     | Initial Creation                 *
*                                                                                                        *
**********************************************************************************************************/
/* $Header: XXRS_WS_AR_CUST_SITE_DETAILS_TYPE.sql 1.0.0 01/24/2012 10:00:00 AM Vaibhav Goyal $ */
  ( cust_account_id    VARCHAR2(15)
  , cust_acct_site_id  VARCHAR2(15)
  , customer_number    VARCHAR2(30)
  , site_num           VARCHAR2(30)
  , currency_code      VARCHAR2(3)
  , tax_code           VARCHAR2(50)
  , address1           VARCHAR2(240)
  , address2           VARCHAR2(240)
  , address3           VARCHAR2(240)
  , address4           VARCHAR2(240)
  , city               VARCHAR2(60)
  , state              VARCHAR2(60)
  , province           VARCHAR2(60)
  , county             VARCHAR2(60)
  , country            VARCHAR2(60)
  , postal_code        VARCHAR2(60)
  , org_id             VARCHAR2(15)
  , bill_to_status     VARCHAR2(1)
  , primary_flag       VARCHAR2(1)
  , paperless_flag     VARCHAR2(1)
  , contact_email      VARCHAR2(240)
  , contact_frist_name VARCHAR2(40)
  , contact_last_name  VARCHAR2(50)
   );
/
CREATE OR REPLACE TYPE xxrs.xxrs_ar_cust_site_dtls_tbl AS TABLE OF xxrs.xxrs_ar_cust_site_dtls_type;
/

