DROP SYNONYM apps.xxrs_ar_cust_site_dtls_type;
DROP SYNONYM apps.xxrs_ar_cust_site_dtls_tbl;
CREATE 
/*********************************************************************************************************
*                                                                                                        *
* NAME : XXRS_WS_AR_CUST_DETAILS_SYNONYM.sql                                                             *
*                                                                                                        *
* DESCRIPTION : Script to create Synonym for types holding Customer Site Details.                        *
*                                                                                                        *
* AUTHOR       : Vaibhav Goyal                                                                           *
* DATE WRITTEN : 24-JAN-2012                                                                             *
*                                                                                                        *
* CHANGE CONTROL :                                                                                       *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                        *
*--------------------------------------------------------------------------------------------------------*
* 1.0.0        |   111122-02448    | Vaibhav Goyal   | 01/24/2012     | Initial Creation                 *
**********************************************************************************************************/
/* $Header: XXRS_WS_AR_CUST_DETAILS_SYNONYM.sql 1.0.0 01/24/2012 10:00:00 AM Vaibhav Goyal $ */
SYNONYM apps.xxrs_ar_cust_site_dtls_type FOR xxrs.xxrs_ar_cust_site_dtls_type;
CREATE SYNONYM apps.xxrs_ar_cust_site_dtls_tbl FOR xxrs.xxrs_ar_cust_site_dtls_tbl;


