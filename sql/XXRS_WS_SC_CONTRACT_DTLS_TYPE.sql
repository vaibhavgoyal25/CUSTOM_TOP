DROP TYPE xxrs.xxrs_ws_sc_con_dev_dtls_tbl;
DROP TYPE xxrs.xxrs_ws_sc_con_dev_dtls_type;
DROP TYPE xxrs.xxrs_ws_sc_con_acc_dtls_tbl;
DROP TYPE xxrs.xxrs_ws_sc_con_acc_dtls_type;
CREATE TYPE xxrs.xxrs_ws_sc_con_dev_dtls_type AS OBJECT
/*********************************************************************************************************
*                                                                                                        *
* NAME : XXRS_WS_SC_CONTRACT_DTLS_TYPE.sql                                                               *
*                                                                                                        *
*DESCRIPTION : Script to create Data type to hold Customer Contract Details.                             *
*                                                                                                        *
* AUTHOR       : Vaibhav Goyal                                                                           *
* DATE WRITTEN : 06-DEC-2011                                                                             *
*                                                                                                        *
* CHANGE CONTROL :                                                                                       *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                        *
*--------------------------------------------------------------------------------------------------------*
* 1.0.0        |   111122-02448    | Vaibhav Goyal   | 12/06/2011     | Initial Creation                 *
*                                                                                                        *
**********************************************************************************************************/
/* $Header: XXRS_WS_SC_CONTRACT_DTLS_TYPE.sql 1.0.0 12/06/2011 10:00:00 AM Vaibhav Goyal $ */
(
DEVICE_NO		VARCHAR2(60),
SITE_NO			VARCHAR2(60),
CURRENCY		VARCHAR2(60),
STATUS  		VARCHAR2(60),
ONLINE_DATE  		VARCHAR2(60),
CANCELLATION_DATE  	VARCHAR2(60),
CONTRACT_END_DATE  	VARCHAR2(60),
CREATION_DATE  		VARCHAR2(60)
);
/
CREATE OR REPLACE TYPE xxrs.xxrs_ws_sc_con_dev_dtls_tbl AS TABLE OF xxrs.xxrs_ws_sc_con_dev_dtls_type;
/
CREATE TYPE xxrs.xxrs_ws_sc_con_acc_dtls_type AS OBJECT
(
SITE_NO			VARCHAR2(60),
CURRENCY		VARCHAR2(60),
STATUS  		VARCHAR2(60),
PRODUCT                 VARCHAR2(60),
ONLINE_DATE  		VARCHAR2(60),
CANCELLATION_DATE  	VARCHAR2(60),
CONTRACT_END_DATE  	VARCHAR2(60),
CREATION_DATE  		VARCHAR2(60)
);
/
CREATE OR REPLACE TYPE xxrs.xxrs_ws_sc_con_acc_dtls_tbl AS TABLE OF xxrs.xxrs_ws_sc_con_acc_dtls_type;
/

