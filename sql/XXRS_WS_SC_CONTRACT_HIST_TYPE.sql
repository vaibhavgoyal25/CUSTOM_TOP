DROP TYPE xxrs.xxrs_ws_sc_contract_hist_tbl;
DROP TYPE xxrs.xxrs_ws_sc_contract_hist_type;

CREATE TYPE xxrs.xxrs_ws_sc_contract_hist_type AS OBJECT
/*********************************************************************************************************
*                                                                                                        *
* NAME : XXRS_WS_SC_CONTRACT_HIST_TYPE.sql                                                               *
*                                                                                                        *
*DESCRIPTION : Script to create Data type to hold Contract History Data.                                 *
*                                                                                                        *
* AUTHOR       : Vaibhav Goyal                                                                           *
* DATE WRITTEN : 08-DEC-2011                                                                             *
*                                                                                                        *
* CHANGE CONTROL :                                                                                       *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                        *
*--------------------------------------------------------------------------------------------------------*
* 1.0.0        |   111122-02448    | Vaibhav Goyal   | 12/08/2011     | Initial Creation                 *
*                                                                                                        *
**********************************************************************************************************/
/* $Header: XXRS_WS_SC_CONTRACT_HIST_TYPE.sql 1.0.0 12/08/2011 10:00:00 AM Vaibhav Goyal $ */
( transaction_typ VARCHAR2 ( 40 ),
  transaction VARCHAR2 ( 40 ),
  opportunity_no VARCHAR2 ( 40 ),
  site_no VARCHAR2 ( 60 ),
  date_received VARCHAR2 ( 10 ),
  date_completed VARCHAR2 ( 10 ),
  monthly_fee VARCHAR2 ( 20 ),
  old_month_fee VARCHAR2 ( 20 ),
  monthly_increase VARCHAR2 ( 20 ),
  monthly_decrease VARCHAR2 ( 20 ),
  setup_fee VARCHAR2 ( 20 ),
  one_time_fee VARCHAR2 ( 20 ),
  component VARCHAR2 ( 80 ),
  se_am_primary_salesperson VARCHAR2 ( 240 ),
  old_term_end_date VARCHAR2 ( 10 ),
  term_eff_date VARCHAR2 ( 10 ),
  new_contract_term VARCHAR2 ( 10 ),
  ticket_no VARCHAR2 ( 40 ),
  notes VARCHAR2 ( 1000 ) );
/

CREATE OR REPLACE TYPE xxrs.xxrs_ws_sc_contract_hist_tbl AS TABLE OF xxrs.xxrs_ws_sc_contract_hist_type;
/

