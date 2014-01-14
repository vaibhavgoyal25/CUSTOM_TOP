/********************************************************************************************************************
*                                                                                                                   *
* NAME : XXRS_FA_AMO_DB_OBJECTS.sql                                                                                 *
*                                                                                                                   *
* DESCRIPTION :                                                                                                     *
* Script to install db objects to support amortized adjustment                                                      *
*                                                                                                                   *
* AUTHOR       : Padmaja                                                                                            *
* DATE WRITTEN : 12-JAN-2012                                                                                        *
*                                                                                                                   *
* CHANGE CONTROL :                                                                                                  *
* Version# | Ticket #    | WHO             |  DATE       |   REMARKS                                                *
*-------------------------------------------------------------------------------------------------------------------*
* 1.0.0   | 111122-02448 | Padmaja         | 12-JAN-2012 | R12 Upgrade                                              *
*********************************************************************************************************************/
/* $Header:  XXRS_FA_AMO_DB_OBJECTS.sql 1.0.0 12-JAN-2012  10:00:00 AM Padmaja  $ */ 
DROP TABLE xxrs.xxrs_fa_amortized_adj;

CREATE TABLE xxrs.xxrs_fa_amortized_adj
(
  transfer_id        NUMBER(15) ,
  book_type_code     VARCHAR2(15),
  asset_id           NUMBER(15),
  asset_number       VARCHAR2(15 BYTE),
  deprn_method_code  VARCHAR2(12 BYTE),
  adj_trx_type       VARCHAR2(9 BYTE),    
  life_in_months     NUMBER(15),    
  process_status     VARCHAR2(2 BYTE),
  error_message      VARCHAR2(1000 BYTE),
  conc_request_id    NUMBER(15),
  created_by         NUMBER(15),
  creation_date      DATE,
  last_updated_by    NUMBER(15),
  last_update_date   DATE,
  last_update_login  NUMBER(15)
);
--
DROP SYNONYM apps.xxrs_fa_amortized_adj;
CREATE SYNONYM apps.xxrs_fa_amortized_adj FOR  xxrs.xxrs_fa_amortized_adj;


DROP SEQUENCE xxrs.xxrs_fa_amort_adj_s;

CREATE SEQUENCE xxrs.xxrs_fa_amort_adj_s
START WITH 1
INCREMENT BY 1
NOCACHE 
NOCYCLE;  
--
DROP SYNONYM apps.xxrs_fa_amort_adj_s;
--
CREATE SYNONYM apps.xxrs_fa_amort_adj_s FOR xxrs.xxrs_fa_amort_adj_s;
--
--
CREATE INDEX xxrs.xxrs_fa_amortized_adj_u01 ON xxrs.xxrs_fa_amortized_adj(transfer_id)
LOGGING
NOPARALLEL;
--
CREATE INDEX xxrs.xxrs_fa_amortized_adj_n01 ON xxrs.xxrs_fa_amortized_adj(process_status)
LOGGING
NOPARALLEL;