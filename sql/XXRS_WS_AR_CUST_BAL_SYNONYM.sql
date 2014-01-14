DROP SYNONYM  apps.xxrs_ws_ar_cust_bal_type;
DROP SYNONYM  apps.xxrs_ws_ar_cust_bal_tbl;
CREATE 
/*********************************************************************************************************
*                                                                                                        *
* NAME : XXRS_WS_AR_CUST_BAL_SYNONYM.sql                                                                 *
*                                                                                                        *
*DESCRIPTION : Script to create Synonym for types holding Customer Current Balance Data.                 *
*                                                                                                        *
* AUTHOR       : Vaibhav Goyal                                                                           *
* DATE WRITTEN : 21-NOV-2011                                                                             *
*                                                                                                        *
* CHANGE CONTROL :                                                                                       *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                        *
*--------------------------------------------------------------------------------------------------------*
* 1.0.0        |   111122-02448    | Vaibhav Goyal   | 11/21/2011     | Initial Creation                 *
*                                                                                                        *
**********************************************************************************************************/
/* $Header: XXRS_WS_AR_CUST_BAL_SYNONYM.sql 1.0.0 11/21/2011 10:00:00 AM Vaibhav Goyal $ */
SYNONYM  apps.xxrs_ws_ar_cust_bal_type FOR xxrs.xxrs_ws_ar_cust_bal_type;
CREATE SYNONYM  apps.xxrs_ws_ar_cust_bal_tbl FOR xxrs.xxrs_ws_ar_cust_bal_tbl;


