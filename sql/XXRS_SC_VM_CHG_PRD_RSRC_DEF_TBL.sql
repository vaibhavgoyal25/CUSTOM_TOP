/**************************************************************************************************************
*                                                                                                             *
* NAME : XXRS_SC_VM_CHG_PRD_RSRC_DEF_TBL.sql                                                                      *
*                                                                                                             *
* DESCRIPTION :                                                                                               *
*   Script to alter XXRS_SC_PRODUCT_RSRC_DEF_TBL                                                              *
*                                                                                                             *
* AUTHOR       : Pavan Amirineni                                                                              *
* DATE WRITTEN : 29-MAY-2013                                                                                  *
*                                                                                                             *
* CHANGE CONTROL :                                                                                            *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                             *
*-------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  130220-05014     | Pavan Amirineni |  29-MAY-2013   | Initial Creation.                     *
***************************************************************************************************************/
--
/* $Header: XXRS_SC_VM_CHG_PRD_RSRC_DEF_TBL.sql 1.0.0 29-MAY-2013 10:46:24 AM Pavan Amirineni $ */
--
ALTER TABLE XXRS.XXRS_SC_PRODUCT_RSRC_DEF_TBL ADD (OPT_EFF_DATES VARCHAR2(1 BYTE));

UPDATE  XXRS.XXRS_SC_PRODUCT_RSRC_DEF_TBL SET OPT_EFF_DATES = 'N';

COMMIT;
