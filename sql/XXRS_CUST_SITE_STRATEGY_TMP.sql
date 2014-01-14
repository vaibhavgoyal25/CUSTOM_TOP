CREATE 
/**************************************************************************************************
*                                                                                                 *
* NAME : XXRS_CUST_SITE_STRATEGY_TMP.sql                                                          *
*                                                                                                 *
* DESCRIPTION :                                                                                   *
* Script To Create temporary table to hold customer strategy data.                                *
*                                                                                                 *
* AUTHOR       : Vaibhav Goyal                                                                    *
*                                                                                                 *
* CHANGE CONTROL :                                                                                *
* VER #  |  TICKET #    | WHO             |  DATE         |  REMARKS                              *
*-------------------------------------------------------------------------------------------------*
* 1.0.0  | 130514-01651 | Vaibhav Goyal   |  15-MAY-2013  | Initial Creation                      *
**************************************************************************************************/
/* $Header: IEX_F_STRATEGY_VIEWS.sql 1.0.0 15-MAY-2013 10:00:00 AM Vaibhav Goyal $ */
TABLE XXRS.XXRS_CUST_SITE_STRATEGY_TMP
(
  CUST_ACCOUNT_ID    VARCHAR2(30 BYTE),
  CUST_ACCT_SITE_ID  VARCHAR2(30 BYTE),
  ORG_ID             VARCHAR2(30 BYTE),
  ACCOUNT_NUMBER     VARCHAR2(30 BYTE),
  PARTY_SITE_NUMBER  VARCHAR2(30 BYTE),
  ORGANIZATION       VARCHAR2(240 BYTE),
  ATTRIBUTE2         VARCHAR2(150 BYTE),
  PARENT             VARCHAR2(60 BYTE)
);