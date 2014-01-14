/**************************************************************************************************************
* NAME : XXRS_SC_VM_OLD_INT_TBL.sql                                                                           *
*                                                                                                             *
* DESCRIPTION :                                                                                               *
*   Script to create XXRS_SC_VM_OLD_INT_TBL  table                                                            *
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
/* $Header: XXRS_SC_VM_OLD_INT_TBL.sql 1.0.0 29-MAY-2013 10:46:24 AM Pavan Amirineni $ */

CREATE TABLE XXRS.XXRS_SC_VM_OLD_INT_TBL
(
  DEVICE_NUM        NUMBER,
  CORE_ONLINE_DATE  DATE 
);
/