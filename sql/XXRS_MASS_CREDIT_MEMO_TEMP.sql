/**************************************************************************************************************
* NAME : XXRS_MASS_CREDIT_MEMO_TEMP.sql                                                                       *
*                                                                                                             *
* DESCRIPTION :                                                                                               *
*   Script to create sequence, table, indexes and synonym for mass credit memo process.                       *
*                                                                                                             *
* AUTHOR       : Mahesh Guddeti                                                                               *
* DATE WRITTEN : 08-AUG-2013                                                                                  *
*                                                                                                             *
* CHANGE CONTROL :                                                                                            *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                             *
*-------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  130617-06898     | Mahesh Guddeti |  08-AUG-2013   | Initial Creation.                     *
***************************************************************************************************************/
--
/* $Header: XXRS_MASS_CREDIT_MEMO_TEMP.sql 1.0.0 08-AUG-2013 10:00:00 AM Mahesh Guddeti $ */

CREATE sequence xxrs_sc_credit_memo_seq START WITH 1;

DROP TABLE XXRS.xxrs_mass_credit_memo_temp;

CREATE TABLE XXRS.xxrs_mass_credit_memo_temp
(
  cm_sequence_id              NUMBER
, period_date                 DATE           NOT NULL
, account_number              VARCHAR2(80)   NOT NULL
, memo_line                   VARCHAR2(240) 
, device_number               VARCHAR2(240)
, product                     VARCHAR2(240)
, product_type                VARCHAR2(3)
, resource_name               VARCHAR2(240)
, gl_product_number           VARCHAR2(240)
, quantity                    NUMBER         NOT NULL
, uom_code                    VARCHAR2(30)   NOT NULL
, unit_price                  NUMBER         NOT NULL
, description                 VARCHAR2(240)  
, file_name                   VARCHAR2(240)  
, process_flag                VARCHAR2(3)
, error_message               VARCHAR2(2000)
, created_by                  NUMBER 
, creation_date               DATE
, last_updated_by             NUMBER 
, last_update_date            DATE 
, last_update_login           NUMBER 
, cust_account_id             NUMBER
, customer_name               VARCHAR2(240)
, customer_site_id            NUMBER
, memo_line_id                NUMBER
, org_id                      NUMBER
, device_resource_snid        NUMBER
, device_product_snid         NUMBER
, product_def_snid            NUMBER
, resource_def_snid           NUMBER
, service_id                  NUMBER
, service_name                VARCHAR2(240)
, product_resource_def_snid   NUMBER
, site_use_id                 NUMBER
, currency                    VARCHAR2(30)
, prepay_term                 NUMBER
, po_number                   VARCHAR2(50)
, business_unit_acct_seg      VARCHAR2(150)
, business_unit               VARCHAR2(150)
, support_team_acct_seg       VARCHAR2(150)
, support_team                VARCHAR2(150)
, location_code               VARCHAR2(30)
, location_meaning            VARCHAR2(80)
, conc_request_id             NUMBER
, trx_type                    VARCHAR2(30)
, invoice_number              VARCHAR2(30)
, invoice_line_number         NUMBER
);


CREATE INDEX XXRS.xxrs_mass_credit_memo_temp_n1 on XXRS.xxrs_mass_credit_memo_temp(period_date);

CREATE INDEX XXRS.xxrs_mass_credit_memo_temp_n2 on XXRS.xxrs_mass_credit_memo_temp(account_number);

CREATE INDEX XXRS.xxrs_mass_credit_memo_temp_n3 on XXRS.xxrs_mass_credit_memo_temp(process_flag);

CREATE INDEX XXRS.xxrs_mass_credit_memo_temp_n4 on XXRS.xxrs_mass_credit_memo_temp(product);


CREATE SYNONYM xxrs_mass_credit_memo_temp FOR XXRS.xxrs_mass_credit_memo_temp;

