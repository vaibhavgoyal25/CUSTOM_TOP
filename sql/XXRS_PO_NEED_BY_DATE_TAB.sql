DROP TABLE xxrs.xxrs_po_need_by_date_tab;

CREATE TABLE xxrs.xxrs_po_need_by_date_tab
/*********************************************************************************************************
*                                                                                                        *
* NAME : XXRS.XXRS_PO_NEED_BY_DATE_TAB.sql                                                               *
*                                                                                                        *
* DESCRIPTION :                                                                                          *
* Script to create Staging Table required to PO Need By Date report details.                             *
*                                                                                                        *
* AUTHOR       : SUDHEER GUNTU                                                                           *
* DATE WRITTEN : 01-MAR-2012                                                                             *
*                                                                                                        *
* Version# | Ticket #     |  WHO            | DATE       |   REMARKS                                     *
*-------------------------------------------------------------------------------------------------       *
* 1.0.0    | 111122-02448 | SUDHEER GUNTU   | 01-MAR-2012|   Initial Creation for R12 upgradation        *
*********************************************************************************************************/
(REQUESTOR               VARCHAR2(240),
 REQUEST_NUMBER          VARCHAR2(25),
 PURCHASE_ORDER_NUMBER   VARCHAR2(20),
 RELEASE_NUMBER          NUMBER,
 NEED_BY_DATE            VARCHAR2(60),
 SUPPLIER                VARCHAR2(240),
 ITEM_NUMBER             VARCHAR2(60),
 ITEM_DESCRIPTION        VARCHAR2(500),
 QUANTITY                NUMBER,
 QUANTITY_DUE            NUMBER,
 UNIT_PRICE              NUMBER,
 SHIP_TO_LOCATION        VARCHAR2(60),
 APPROVED_DATE           VARCHAR2(60),
 CREATE_DATE             VARCHAR2(60),
 ORG_ID                  NUMBER,
 REQUESTOR_EMAIL_ADDRESS VARCHAR2(240)
 );

/
