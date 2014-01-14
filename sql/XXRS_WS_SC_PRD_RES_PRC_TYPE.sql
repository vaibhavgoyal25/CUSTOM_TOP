DROP TYPE xxrs.xxrs_ws_sc_prd_res_prc_tbl;
DROP TYPE xxrs.xxrs_ws_sc_prd_res_prc_type;

CREATE OR REPLACE TYPE xxrs.xxrs_ws_sc_prd_res_prc_type AS OBJECT
/*********************************************************************************************************
*                                                                                                        *
* NAME : XXRS_WS_SC_PRD_RES_PRC_TYPE.sql                                                                 *
*                                                                                                        *
*DESCRIPTION : Script to create Data type to hold Product Pricing Details.                               *
*                                                                                                        *
* AUTHOR       : Vaibhav Goyal                                                                           *
* DATE WRITTEN : 24-JAN-2012                                                                             *
*                                                                                                        *
* CHANGE CONTROL :                                                                                       *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                        *
*--------------------------------------------------------------------------------------------------------*
* 1.0.0        |   111122-02448    | Vaibhav Goyal   | 01/24/2012     | Initial Creation                 *
*                                                                                                        *
**********************************************************************************************************/
/* $Header: XXRS_WS_SC_PRD_RES_PRC_TYPE.sql 1.0.0 01/24/2012 10:00:00 AM Vaibhav Goyal $ */
(
CUSTOMER_NUMBER  	VARCHAR2(30),
SITE_NUMBER     	VARCHAR2(30),
SEGMENT                 VARCHAR2(80),
CURRENCY_CODE   	VARCHAR2(150),
UNIT_OF_MEASURE         VARCHAR2(30),
MIN     		NUMBER,
MAX     		NUMBER,
UNIT_PRICE		NUMBER,
ERROR_CODE              VARCHAR2(10)
);
/
CREATE OR REPLACE TYPE xxrs.xxrs_ws_sc_prd_res_prc_tbl AS TABLE OF xxrs.xxrs_ws_sc_prd_res_prc_type;
/

