DROP TYPE xxrs.xxrs_ws_ar_cust_notes_tbl;
DROP TYPE xxrs.xxrs_ws_ar_cust_notes_type;
CREATE TYPE xxrs.xxrs_ws_ar_cust_notes_type AS OBJECT
/*********************************************************************************************************
*                                                                                                        *
* NAME : XXRS_WS_AR_CUST_NOTES_TYPE.sql                                                                  *
*                                                                                                        *
*DESCRIPTION : Script to create Data type to hold Customer Notes Data.                                   *
*                                                                                                        *
* AUTHOR       : Vaibhav Goyal                                                                           *
* DATE WRITTEN : 05-DEC-2011                                                                             *
*                                                                                                        *
* CHANGE CONTROL :                                                                                       *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                        *
*--------------------------------------------------------------------------------------------------------*
* 1.0.0        |   111122-02448    | Vaibhav Goyal   | 12/05/2011     | Initial Creation                 *
* 1.0.1        |   120911-08923    | Vaibhav Goyal   | 09/12/2012     | Changed Length for Collector and *
*              |                   |                 |                | Notes Fields.                    *
**********************************************************************************************************/
/* $Header: XXRS_WS_AR_CUST_NOTES_TYPE.sql 1.0.0 12/05/2011 10:00:00 AM Vaibhav Goyal $ */
(
COLLECTOR		VARCHAR2(360),  --120911-08923
NOTE_DATE		VARCHAR2(60),
NOTES			VARCHAR2(2000), --120911-08923
CONTACT			VARCHAR2(60)
);
/
CREATE OR REPLACE TYPE xxrs.xxrs_ws_ar_cust_notes_tbl AS TABLE OF xxrs.xxrs_ws_ar_cust_notes_type;
/

