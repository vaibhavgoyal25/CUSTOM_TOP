DROP TYPE xxrs.xxrs_ws_sc_contr_mon_tbl;
DROP TYPE xxrs.xxrs_ws_sc_contr_mon_type;
CREATE TYPE xxrs.xxrs_ws_sc_contr_mon_type AS OBJECT
/*********************************************************************************************************
*                                                                                                        *
* NAME : XXRS_WS_SC_CONTR_MON_TYPE.sql                                                                   *
*                                                                                                        *
*DESCRIPTION : Script to create Data type to hold Contract Monthly Charges Details.                      *
*                                                                                                        *
* AUTHOR       : Vaibhav Goyal                                                                           *
* DATE WRITTEN : 07-DEC-2011                                                                             *
*                                                                                                        *
* CHANGE CONTROL :                                                                                       *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                        *
*--------------------------------------------------------------------------------------------------------*
* 1.0.0        |   111122-02448    | Vaibhav Goyal   | 12/07/2011     | Initial Creation                 *
*                                                                                                        *
**********************************************************************************************************/
/* $Header: XXRS_WS_SC_CONTR_MON_TYPE.sql 1.0.0 12/07/2011 10:00:00 AM Vaibhav Goyal $ */
(
VOID_FLAG               VARCHAR2(1),
RESOURCE_NAME		VARCHAR2(60),
QUANTITY  		VARCHAR2(60),
UNIT_OF_MEASURE		VARCHAR2(60),
PREPAY_TERM  		VARCHAR2(60),
UNIT_PRICE  		VARCHAR2(60),
EFFECTIVE_DATE  	VARCHAR2(60),
EXPIRATION_DATE  	VARCHAR2(60)
);
/
CREATE OR REPLACE TYPE xxrs.xxrs_ws_sc_contr_mon_tbl AS TABLE OF xxrs.xxrs_ws_sc_contr_mon_type;
/

