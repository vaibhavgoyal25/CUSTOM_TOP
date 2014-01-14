/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_SC_ALTER_BIL_ENG_TBL.sql                                                                                *
*                                                                                                                     *
* DESCRIPTION : Script to alter billing engine tables to accomodate R12 columns                                       *
*                                                                                                                     *
* AUTHOR       : Pavan Amirineni                                                                                      *
* DATE WRITTEN : 02/10/2012                                                                                           *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* Version# | Ticket #      | WHO             |  DATE      |   REMARKS                                                 *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0    | 111122-02448  | Pavan Amirineni | 02/10/2012 | Initial Creation                                          *
**********************************************************************************************************************/  
/* $Header: XXRS_SC_ALTER_BIL_ENG_TBL.sql 1.0.0 02/10/2012 03:00:00 PM Pavan Amirineni $ */

ALTER TABLE xxrs.xxrs_sc_ra_interface_lines_all ADD (PAYMENT_TRXN_EXTENSION_ID NUMBER);

ALTER TABLE xxrs.xxrs_sc_rila_arch_sc_data_tbl ADD (PAYMENT_TRXN_EXTENSION_ID NUMBER);

ALTER TABLE xxrs.xxrs_sc_billing_data_tbl ADD  (PREPAY_START_DATE DATE ,PREPAY_END_DATE DATE );  

ALTER TABLE xxrs.xxrs_sc_billing_data_hst ADD  (PREPAY_START_DATE DATE ,PREPAY_END_DATE DATE );  

ALTER TABLE xxrs.xxrs_sc_ci_dev_prod_vw_tbl ADD  (PREPAY_START_DATE DATE ,PREPAY_END_DATE DATE );

ALTER TABLE xxrs.xxrs_sc_ci_act_prod_vw_tbl ADD  (PREPAY_START_DATE DATE ,PREPAY_END_DATE DATE );

--*******************************************************************************************************************************

DROP TABLE xxrs.xxrs_sc_rila_data_tmp_tbl; 

CREATE TABLE xxrs.xxrs_sc_rila_data_tmp_tbl AS SELECT * FROM AR.RA_INTERFACE_LINES_ALL WHERE 1 = 2;

DROP TABLE xxrs.xxrs_sc_rida_data_tmp_tbl;

CREATE TABLE  xxrs.xxrs_sc_rida_data_tmp_tbl  AS SELECT * FROM AR.RA_INTERFACE_DISTRIBUTIONS_ALL WHERE 1 = 2;


--******************************************************************************************************************************


CREATE TABLE xxrs.xxrs_sc_rila_err_purge_archbkp AS SELECT * FROM XXRS.XXRS_SC_RILA_ERR_PURGE_ARCH;  

DROP TABLE  XXRS.XXRS_SC_RILA_ERR_PURGE_ARCH; 

CREATE TABLE xxrs.xxrs_sc_rila_err_purge_arch AS SELECT SYSDATE "PROCESS_DATE", rila.* FROM AR.RA_INTERFACE_LINES_ALL rila WHERE 1 = 2;

 
--******************************************************************************************************************************

CREATE TABLE xxrs.xxrs_sc_rida_err_purge_archbkp AS SELECT * FROM XXRS.XXRS_SC_RILA_ERR_PURGE_ARCH; 

DROP TABLE  XXRS.XXRS_SC_RIDA_ERR_PURGE_ARCH; 

CREATE TABLE xxrs.xxrs_sc_rida_err_purge_arch AS SELECT SYSDATE "PROCESS_DATE", rida.* FROM AR.RA_INTERFACE_DISTRIBUTIONS_ALL rida WHERE 1 = 2; 


--******************************************************************************************************************************

DROP TABLE XXRS.XXRS_SC_LEGACY_CONV1_DATA_TBL;

DROP TABLE XXRS.XXRS_SC_LEGACY_CONV1_DATA_ARCH;

DROP TABLE XXRS.XXRS_SC_RILA_ARCH_CONV1_DATA;

DROP TABLE XXRS.XXRS_SC_RIDA_ARCH_CONV1_DATA;
/