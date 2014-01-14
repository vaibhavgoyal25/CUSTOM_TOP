/**************************************************************************************************
*                                                                                                 *
* NAME : XXRS_AR_AUD_RESP_TBL.sql                                                                 *
*                                                                                                 *
* DESCRIPTION :                                                                                   *
* Table to Load Data For Account Updater Response File From Chase.                                * 
*                                                                                                 *
* AUTHOR       : Sai Manohar                                                                      *
* DATE WRITTEN : 04-JAN-2012                                                                      *
*                                                                                                 *
* CHANGE CONTROL :                                                                                *
* VER #  |  TICKET #    | WHO             |  DATE         |  REMARKS                              *
*-------------------------------------------------------------------------------------------------*
* 1.0.0  | 111122-02448 | Sai Manohar     |  04-JAN-2012  | Initial built for R12 upgrade         *
**************************************************************************************************/
/* $Header: XXRS_AR_AUD_RESP_TBL.sql 1.0.0 04-JAN-2012 10:00:00 AM Sai Manohar $ */
DROP SYNONYM apps.xxrs_ar_aud_resp_tbl;
DROP TABLE   xxrs.xxrs_ar_aud_resp_tbl;
CREATE TABLE xxrs.xxrs_ar_aud_resp_tbl
( method_of_payment               VARCHAR2(2 BYTE),  
  transaction_division_number     VARCHAR2(10 BYTE),  
  merchant_order_number           VARCHAR2(22 BYTE),
  old_account_number              VARCHAR2(19 BYTE),
  old_expiration_date             VARCHAR2(4 BYTE),
  new_account_number              VARCHAR2(19 BYTE),
  new_expiration_date             VARCHAR2(4 BYTE),
  response_value                  VARCHAR2(1 BYTE),
  previously_sent_flag            VARCHAR2(1 BYTE),
  conc_request_id                 NUMBER,
  creation_date                   DATE,
  created_by                      NUMBER,
  last_update_login               NUMBER,
  last_update_date                DATE,
  last_updated_by                 NUMBER,
  process_status                  VARCHAR2(1 BYTE),
  error_message                   VARCHAR2(1000 BYTE)
);
CREATE SYNONYM apps.xxrs_ar_aud_resp_tbl FOR xxrs.xxrs_ar_aud_resp_tbl;
/