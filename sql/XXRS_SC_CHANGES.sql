/**********************************************************************************************************************
* NAME : XXRS_SC_CHANGES.sql                                                                                          *
* DESCRIPTION :                                                                                                       *
* Script to perform the SC changes for installing the OAF Enchancements                                               *
*                                                                                                                     *
* AUTHOR       : Vinodh Bhasker                                                                                       *
* DATE WRITTEN : 21-NOV-2011                                                                                          *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* SR#             Ticket#          WHO                DATE                        REMARKS                             *
* 1.0.0           111122-02448     Vinodh Bhasker     21-NOV-2011                 Initial build                       *
***********************************************************************************************************************/

ALTER TABLE XXRS.XXRS_SC_PRODUCT_RSRC_DEF_TBL DROP CONSTRAINT XXRS_SC_PR_RS_DEF_PROD_DEF_FK;

ALTER TABLE XXRS.XXRS_SC_PRODUCT_RSRC_DEF_TBL DROP CONSTRAINT XXRS_SC_PR_RS_DEF_RSRC_DEF_FK;

ALTER TABLE XXRS.XXRS_SC_PRICE_RULE_TBL DROP CONSTRAINT XXRS_SC_PRC_RULE_RSRC_DEF_FK;

ALTER TABLE XXRS.XXRS_SC_PRICE_RULE_TBL
  MODIFY CONSTRAINT XXRS_SC_PRICE_RULE_UQ
  DISABLE;

ALTER TABLE XXRS.XXRS_SC_PRICE_EFFECTIVITY_TBL DROP CONSTRAINT XXRS_SC_PRICE_EFF_PRC_RULE_FK;
 
ALTER TABLE XXRS.XXRS_SC_PRICE_TIER_TBL DROP CONSTRAINT XXRS_SC_PRC_TIER_PRC_EFF_FK;

CREATE SEQUENCE XXRS.XXRS_SC_PRICE_RULE_WF_S
START WITH 1
INCREMENT BY 1
MINVALUE 1
NOCYCLE 
NOORDER;

CREATE SYNONYM APPS.XXRS_SC_PRICE_RULE_WF_S FOR XXRS.xxrs_sc_price_rule_wf_s;

CREATE SYNONYM APPS.XXRS_SC_SERVICE_DEF_S FOR XXRS.XXRS_SC_SERVICE_DEF_S;

CREATE SYNONYM APPS.XXRS_SC_PRODUCT_SERVICES_S FOR XXRS.XXRS_SC_PRODUCT_SERVICES_S;

ALTER TABLE XXRS.XXRS_SC_PRICE_RULE_TBL ADD (org_id NUMBER(15));

ALTER TABLE XXRS.XXRS_SC_PRICE_RULE_TBL ADD (parent_price_rule_snid NUMBER(15));

UPDATE xxrs_sc_resource_def_tbl
   SET tiered_flag = 'Y'
 WHERE tiered_flag = 'T';

UPDATE XXRS.XXRS_SC_RESOURCE_DEF_TBL 
   SET TIERED_FLAG = 'N'
 WHERE TIERED_FLAG = 'F';

UPDATE XXRS.XXRS_SC_RESOURCE_DEF_TBL 
   SET INCLUDE_IN_MONTHLY_FEE_FLAG = 'Y'
 WHERE INCLUDE_IN_MONTHLY_FEE_FLAG = 'T';

UPDATE XXRS.XXRS_SC_RESOURCE_DEF_TBL 
   SET INCLUDE_IN_MONTHLY_FEE_FLAG  = 'N'
 WHERE INCLUDE_IN_MONTHLY_FEE_FLAG = 'F';

ALTER TABLE xxrs.xxrs_sc_price_rule_tbl DROP COLUMN unit_of_measure;
