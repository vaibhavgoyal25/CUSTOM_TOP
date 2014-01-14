--/********************************************************************************************************************
--*                                                                                                                   *
--* NAME : XXRS_FA_AMORTIZED_ADJ.ctl                                                                                  *
--*                                                                                                                   *
--* DESCRIPTION :                                                                                                     *
--* Load data into the amortized adjustment staging table.                                                            *
--*                                                                                                                   *
--* AUTHOR       : Padmaja                                                                                            *
--* DATE WRITTEN : 01-JAN-2012                                                                                        *
--*                                                                                                                   *
--* CHANGE CONTROL :                                                                                                  *
--* Version# | Ticket #    | WHO             |  DATE        |   REMARKS                                               *
--*-------------------------------------------------------------------------------------------------------------------*
--* 1.0.0   | 111122-02448 | Padmaja         | 01-JAN-2012  | Initial Creation for R12 Upgrade                        *
--*********************************************************************************************************************/
OPTIONS (SKIP=1)
LOAD DATA
INSERT
INTO TABLE xxrs.xxrs_fa_amortized_adj
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  adj_trx_type "TRIM(:adj_trx_type)",
  asset_number "TRIM(:asset_number)",  
  life_in_months "TRIM(:life_in_months)",
  conc_request_id ":conc_request_id",
  created_by ":created_by",
  transfer_id "xxrs_fa_amort_adj_s.nextval",
  process_status CONSTANT "P",
  creation_date SYSDATE,
  last_update_login CONSTANT "-1",
  last_update_date SYSDATE,
  last_updated_by ":created_by"
)