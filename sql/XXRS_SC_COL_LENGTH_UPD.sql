ALTER 
/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_SC_COL_LENGTH_UPD.sql                                                                                   *
*                                                                                                                     *
* DESCRIPTION :                                                                                                       *
* Script to Update Column Length on Rackspace SC Tables                                                               *
*                                                                                                                     *
* AUTHOR       : VAIBHAV GOYAL                                                                                        *
* DATE WRITTEN : 09-MAY-2013                                                                                          *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* Version#     |  TICKET          | WHO             |  DATE          |   REMARKS                                      *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  130417-07793    | VAIBHAV GOYAL   |  09-MAY-2013   |  Initial Creation                              *
**********************************************************************************************************************/
TABLE XXRS.XXRS_SC_PRICE_TIER_TBL
MODIFY(QTY_MIN NUMBER(15))
/
ALTER TABLE XXRS.XXRS_SC_PRICE_TIER_TBL
MODIFY(QTY_MAX NUMBER(15))
/
ALTER TABLE XXRS.XXRS_SC_SPCL_PRICE_TIER_TBL
MODIFY(QTY_MIN NUMBER(15))
/
ALTER TABLE XXRS.XXRS_SC_SPCL_PRICE_TIER_TBL
MODIFY(QTY_MAX NUMBER(15))
/
ALTER TABLE XXRS.XXRS_SC_ACCOUNT_RESOURCE_TBL
MODIFY(INITIAL_QUANTITY NUMBER(15))
/
ALTER TABLE XXRS.XXRS_SC_HISTORY_AUDIT_TBL
MODIFY(OLD_INITIAL_QUANTITY NUMBER(15))
/
ALTER TABLE XXRS.XXRS_SC_HISTORY_AUDIT_TBL
MODIFY(NEW_INITIAL_QUANTITY NUMBER(15))
/
ALTER TABLE XXRS.XXRS_SC_HISTORY_TBL
MODIFY(INITIAL_QUANTITY NUMBER(15))
/