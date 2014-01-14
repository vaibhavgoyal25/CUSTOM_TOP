/*****************************************************************************************
* NAME : XXRS_SC_PRICE_ADJ_INT.sql                                                       *
*                                                                                        *
* DESCRIPTION :                                                                          *
* Script to install db objects to support price adjustment                               *
*                                                                                        *
* AUTHOR       : Pavan Amirineni                                                         *
* DATE WRITTEN : 27-AUG-2013                                                             *
*                                                                                        *
* CHANGE CONTROL :                                                                       *
* Version# | Ticket #    | WHO             |  DATE       |   REMARKS                     *
*----------------------------------------------------------------------------------------*
* 1.0.0   | 130829-07967 | Pavan Amirineni | 27-AUG-2013 | Initial Built                 *
*****************************************************************************************/
/* $Header:  XXRS_SC_PRICE_ADJ_INT.sql 1.0.0 27-AUG-2013 10:00:00 AM Pavan Amirineni$ */ 
DROP TABLE xxrs.xxrs_sc_price_adj_int;

CREATE TABLE xxrs.xxrs_sc_price_adj_int
(
  adj_id             NUMBER(15)    PRIMARY KEY,
  header_id          NUMBER(15), 
  account_number     VARCHAR2(30)  NOT NULL,
  product_name       VARCHAR2(40)  NOT NULL, 
  device_num         VARCHAR2(40), 
  resource_name      VARCHAR2(30)  NOT NULL,
  adj_amount         NUMBER(15,2)  NOT NULL, 
  adj_date           DATE          NOT NULL,   
  oppt_number        VARCHAR2(40),   
  ticket_number      VARCHAR2(40)  NOT NULL,     
  component          VARCHAR2(40), 
  component_code     VARCHAR2(40), 
  sales_person       VARCHAR2(100) NOT NULL, 
  change_desc        VARCHAR2(100), 
  process_flag       VARCHAR2(1), 
  date_received      DATE          NOT NULL,
  date_completed     DATE          NOT NULL,
  con_eff_start_date DATE,
  con_eff_end_date   DATE,  
  con_term           NUMBER,
  con_status         VARCHAR2(25),
  cust_account_id    NUMBER,
  cust_acct_site_id  NUMBER,
  org_id             NUMBER,
  prd_type           VARCHAR2(1),
  prd_def_snid       NUMBER, 
  res_def_snid       NUMBER,  
  prd_rsrc_def_snid  NUMBER,
  res_billing_t_code NUMBER,
  res_prepay_flag    VARCHAR2(1),
  prd_status_code    NUMBER,
  dev_prd_snid       NUMBER,
  acc_prd_snid       NUMBER,    
  sales_person_id    NUMBER,
  f_con_type         VARCHAR2(10),
  f_con_snid         NUMBER,    
  f_dev_prd_snid     NUMBER,
  f_acc_prd_snid     NUMBER,     
  error_msg          VARCHAR2(2000),
  conc_request_id    NUMBER(15),
  created_by         NUMBER(15),
  creation_date      DATE,
  last_updated_by    NUMBER(15),
  last_update_date   DATE,
  last_update_login  NUMBER(15)
);
--
DROP SYNONYM apps.xxrs_sc_price_adj_int;
CREATE SYNONYM apps.xxrs_sc_price_adj_int FOR  xxrs.xxrs_sc_price_adj_int;


DROP SEQUENCE xxrs.xxrs_sc_price_adj_int_s;

CREATE SEQUENCE xxrs.xxrs_sc_price_adj_int_s
START WITH 1
INCREMENT BY 1
NOCACHE 
NOCYCLE;  

DROP SEQUENCE xxrs.xxrs_sc_price_adj_int_hdr_s;

CREATE SEQUENCE xxrs.xxrs_sc_price_adj_int_hdr_s
START WITH 1000
INCREMENT BY 1
NOCACHE 
NOCYCLE;  

--
DROP SYNONYM apps.xxrs_sc_price_adj_int_s;
--
CREATE SYNONYM apps.xxrs_sc_price_adj_int_s FOR xxrs.xxrs_sc_price_adj_int_s;

--
CREATE INDEX xxrs.xxrs_sc_price_adj_int_n01 ON xxrs.xxrs_sc_price_adj_int(process_flag)
LOGGING
NOPARALLEL;