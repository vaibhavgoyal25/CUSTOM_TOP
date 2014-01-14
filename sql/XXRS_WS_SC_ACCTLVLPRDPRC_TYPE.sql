DROP TYPE xxrs.xxrs_ws_sc_acctlvlprdprc_tbl;
DROP TYPE xxrs.xxrs_ws_sc_acctlvlprdprc_type;

CREATE TYPE xxrs.xxrs_ws_sc_acctlvlprdprc_type AS OBJECT
/*********************************************************************************************************
*                                                                                                        *
* NAME : XXRS_WS_SC_ACCTLVLPRDPRC_TYPE.sql                                                                *
*                                                                                                        *
*DESCRIPTION : Script to create Data type to hold Account Level Product Pricing Data.                    *
*                                                                                                        *
* AUTHOR       : Vaibhav Goyal                                                                           *
* DATE WRITTEN : 13-JAN-2012                                                                             *
*                                                                                                        *
* CHANGE CONTROL :                                                                                       *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                        *
*--------------------------------------------------------------------------------------------------------*
* 1.0.0        |   111122-02448    | Vaibhav Goyal   | 01/13/2012     | Initial Creation                 *
*                                                                                                        *
**********************************************************************************************************/
/* $Header: XXRS_WS_SC_ACCTLVLPRDPRC_TYPE.sql 1.0.0 12/08/2011 10:00:00 AM Vaibhav Goyal $ */
( CUSTOMER_NUMBER		VARCHAR2(30),
  SITE_NUMBER			VARCHAR2(30),
  PRODUCT 			VARCHAR2(40),
  RESOURCES			VARCHAR2(30),
  QUANTITY			VARCHAR2(20),
  DEVICE_NUM			VARCHAR2(40),
  SPECIAL_PRICE_FLAG		VARCHAR2(1),
  PREPAY_TERM			VARCHAR2(20),
  CURRENCY              	VARCHAR2(150),
  UOM				VARCHAR2(30),
  EFFECTIVE_DATE 		VARCHAR2(20),
  EXPIRATION_DATE		VARCHAR2(20),
  PRICE_EFF_DATE 	 	VARCHAR2(20),
  PRICE_EXP_DATE 		VARCHAR2(20),
  UNIT_PRICE			VARCHAR2(20),
  MIN		  	        VARCHAR2(20),
  MAX	  		        VARCHAR2(20),     
  RS_SEGMENT  		        VARCHAR2(150),
  RS_CURRENCY  			VARCHAR2(150),
  RS_UOM                	VARCHAR2(150),
  RS_PRICE_EFF_DATE 		VARCHAR2(150),
  RS_PRICE_EXP_DATE 		VARCHAR2(150),
  RS_UNIT_PRICE			VARCHAR2(150),
  RS_MIN			VARCHAR2(150),
  RS_MAX	  		VARCHAR2(150)
);
/

CREATE OR REPLACE TYPE xxrs.xxrs_ws_sc_acctlvlprdprc_tbl AS TABLE OF xxrs.xxrs_ws_sc_acctlvlprdprc_type;
/

