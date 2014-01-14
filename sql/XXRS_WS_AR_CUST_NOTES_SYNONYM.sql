DROP SYNONYM  apps.xxrs_ws_ar_cust_notes_type;
DROP SYNONYM  apps.xxrs_ws_ar_cust_notes_tbl;
CREATE 
/*********************************************************************************************************
*                                                                                                        *
* NAME : XXRS_WS_AR_CUST_NOTES_SYNONYM.sql                                                               *
*                                                                                                        *
*DESCRIPTION : Script to create Synonym for types holding Customer Notes Details.                        *
*                                                                                                        *
* AUTHOR       : Vaibhav Goyal                                                                           *
* DATE WRITTEN : 05-DEC-2011                                                                             *
*                                                                                                        *
* CHANGE CONTROL :                                                                                       *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                        *
*--------------------------------------------------------------------------------------------------------*
* 1.0.0        |   111122-02448    | Vaibhav Goyal   | 12/05/2011     | Initial Creation                 *
*                                                                                                        *
**********************************************************************************************************/
/* $Header: XXRS_WS_AR_CUST_NOTES_SYNONYM.sql 1.0.0 12/05/2011 10:00:00 AM Vaibhav Goyal $ */
SYNONYM  apps.xxrs_ws_ar_cust_notes_type FOR xxrs.xxrs_ws_ar_cust_notes_type;
CREATE SYNONYM  apps.xxrs_ws_ar_cust_notes_tbl FOR xxrs.xxrs_ws_ar_cust_notes_tbl;


