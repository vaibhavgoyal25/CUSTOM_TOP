DROP TYPE xxrs.xxrs_ws_ar_invoice_dtl_tbl;
DROP TYPE xxrs.xxrs_ws_ar_invoice_dtl_type;
CREATE TYPE xxrs.xxrs_ws_ar_invoice_dtl_type AS OBJECT
/*********************************************************************************************************
*                                                                                                        *
* NAME : XXRS_WS_AR_INVOICE_DTL_TYPE.sql                                                                 *
*                                                                                                        *
*DESCRIPTION : Script to create Data type to report invoice details corresponding to Invoice number.     *
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
/* $Header: XXRS_WS_AR_INVOICE_DTL_TYPE.sql 1.0.0 01/27/2012 10:00:00 AM Vaibhav Goyal $ */
(

c1_customer_number            VARCHAR2(60),-- level1
c2_invoice_number             VARCHAR2(60),-- level1
c3_invoice_date               VARCHAR2(60),-- level1
c4_invoice_currency           VARCHAR2(60),-- level1
c5_amount_due                 VARCHAR2(60),-- level1
c6_payment_term               VARCHAR2(60),-- level1
c7_customer_name              VARCHAR2(360),-- level1
c8_contact_name               VARCHAR2(100),-- level1
c9_address_line1              VARCHAR2(240),-- level1
c10_address_line2             VARCHAR2(240),-- level1
c10_address_line3             VARCHAR2(240),-- level1
c10_address_line4             VARCHAR2(240),-- level1
c11_city                      VARCHAR2(60),-- level1
c11_state                     VARCHAR2(60),-- level1
c11_zip                       VARCHAR2(60),-- level1
c12_country                   VARCHAR2(60),-- level1
c12a_tax_registration_num     VARCHAR2(60),-- level1
c12b_exemption_reason         VARCHAR2(60),-- level1
c12c_purchase_order           VARCHAR2(60),-- level1
c13_payment_source            VARCHAR2(60),-- level1
c13a_credit_card              VARCHAR2(60),-- level1
c13b_invoice_number           VARCHAR2(60),-- level1
c13c_invoice_amount           VARCHAR2(60),-- level1
c_as_display_flag             VARCHAR2(1), -- level1 
c_as_previous_invoice_date    DATE        ,-- level1 
c_as_previous_balance         NUMBER(15,2),-- level1 
c_as_payments                 NUMBER(15,2),-- level1 
c_as_credits                  NUMBER(15,2),-- level1 
c_as_debits                   NUMBER(15,2),-- level1 
c_as_balance_forward          NUMBER(15,2),-- level1 
c_as_current_invoice_charges  NUMBER(15,2),-- level1 
c_as_account_balance_due      NUMBER(15,2),-- level1 
c14_billing_cycle             VARCHAR2(60),-- level1
c15a_line_product             VARCHAR2(60),-- level2
c16_line_description          VARCHAR2(60),-- level3
c17_line_ref_number           VARCHAR2(60),-- level3
c18_line_subscr_number        VARCHAR2(60),-- level3
c19_line_pre_pay_term         VARCHAR2(60),-- level3
c20_line_qty                  VARCHAR2(60),-- level3
c21_line_uom                  VARCHAR2(60),-- level3
c22_line_unit_price           VARCHAR2(60),-- level3
c23_line_total                VARCHAR2(60),-- level3
c24_invoice_subtotal          VARCHAR2(60),-- level2
c25_sales_tax                 VARCHAR2(60),-- level1
c25_converted_currency        VARCHAR2(60),-- level1 
c25_converted_amount          VARCHAR2(60),-- level1 
c25_tax_code                  VARCHAR2(60),-- level1 
c25_tax_rate                  VARCHAR2(60),-- level1 
c26_current_invoice_charges   VARCHAR2(60),-- level1
c26a_extra                    VARCHAR2(60),-- level1
c26b_extra                    VARCHAR2(60),-- level1
c27_extra                     VARCHAR2(60),-- level1
c28_extra                     VARCHAR2(60),-- level1
c29_extra                     VARCHAR2(60),-- level1
c30_extra                     VARCHAR2(60),-- level1
c31_logo                      VARCHAR2(60),-- level1
c32_a                         VARCHAR2(60),-- level1
c_org                         VARCHAR2(60)
);
/
CREATE OR REPLACE TYPE xxrs.xxrs_ws_ar_invoice_dtl_tbl AS TABLE OF xxrs.xxrs_ws_ar_invoice_dtl_type;
/

