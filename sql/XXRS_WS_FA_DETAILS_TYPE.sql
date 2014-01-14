DROP TYPE xxrs.xxrs_ws_fa_details_tbl;
DROP TYPE xxrs.xxrs_ws_fa_details_type;

CREATE TYPE xxrs.xxrs_ws_fa_details_type AS OBJECT
/*********************************************************************************************************
*                                                                                                        *
* NAME : XXRS_WS_FA_DETAILS_TYPE.sql                                                                     *
*                                                                                                        *
*DESCRIPTION : Script to create Data type to hold Fixed Asset Details.                                   *
*                                                                                                        *
* AUTHOR       : Vaibhav Goyal                                                                           *
* DATE WRITTEN : 08-DEC-2011                                                                             *
*                                                                                                        *
* CHANGE CONTROL :                                                                                       *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                        *
*--------------------------------------------------------------------------------------------------------*
* 1.0.0        |   111122-02448    | Vaibhav Goyal   | 12/08/2011     | Initial Creation                 *
*                                                                                                        *
**********************************************************************************************************/
/* $Header: XXRS_WS_FA_DETAILS_TYPE.sql 1.0.0 12/08/2011 10:00:00 AM Vaibhav Goyal $ */
( 
SERIAL_NUMBER	VARCHAR2(30),
DESCRIPTION	VARCHAR2(240),
CATEGORY_CODE	VARCHAR2(40),
ASSIGNED_ON	VARCHAR2(10),
RELEASED_ON	VARCHAR2(10) 
);
/

CREATE OR REPLACE TYPE xxrs.xxrs_ws_fa_details_tbl AS TABLE OF xxrs.xxrs_ws_fa_details_type;
/

