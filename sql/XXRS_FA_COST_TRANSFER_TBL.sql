/*********************************************************************************************************************
*                                                                                                                    *
* NAME : XXRS_FA_COST_TRANSFER_TBL.sql                                                                               *
*                                                                                                                    *
* DESCRIPTION :                                                                                                      *
* Staging table and sequence creation  script for FA_COST_TRANSFER_PKG                                               *
*                                                                                                                    *
* AUTHOR       :  Santosh Kumar                                                                                      *
* DATE WRITTEN :  15-Dec-2011                                                                                        *
*                                                                                                                    *
* CHANGE CONTROL :                                                                                                   *
* Version#     |  Racker Ticket #  | WHO                |  DATE             |   REMARKS                              *
*--------------------------------------------------------------------------------------------------------------------*
* 1.0.0        |   111122-02448    | Santosh Kumar E    |  15-Dec-2011      | Initial Creation                       *
**********************************************************************************************************************/
/* $Header:  XXRS_FA_COST_TRANSFER_TBL.sql 1.0.0 15-Dec-2011  10:00:00 AM Santosh Kumar  $ */ 
ALTER TABLE XXRS.XXRS_FA_COST_TRANSFERS
 DROP PRIMARY KEY CASCADE;
DROP TABLE XXRS.XXRS_FA_COST_TRANSFERS CASCADE CONSTRAINTS;

CREATE TABLE XXRS.XXRS_FA_COST_TRANSFERS
(
  TRANSFER_ID               NUMBER(15),
  FROM_SERIAL_NUMBER        VARCHAR2(30 BYTE)   NOT NULL,
  TO_SERIAL_NUMBER          VARCHAR2(30 BYTE),
  TO_ITEM_NUMBER            VARCHAR2(40 BYTE),
  INVENTORY_ORG_ID          NUMBER,
  INVENTORY_ORG_CODE        VARCHAR2(3 BYTE),
  PROCESS_STATUS            VARCHAR2(2 BYTE),
  ERROR_MESSAGE             VARCHAR2(1000 BYTE),
  CONC_REQUEST_ID           NUMBER(15),
  TRANSACTION_INTERFACE_ID  NUMBER(15),
  CREATED_BY                NUMBER(15),
  CREATION_DATE             DATE,
  LAST_UPDATED_BY           NUMBER(15),
  LAST_UPDATE_DATE          DATE,
  LAST_UPDATE_LOGIN         NUMBER(15)
);




ALTER TABLE XXRS.XXRS_FA_COST_TRANSFERS ADD (
  PRIMARY KEY
 (TRANSFER_ID));

DROP SYNONYM APPS.XXRS_FA_COST_TRANSFERS;

CREATE SYNONYM APPS.XXRS_FA_COST_TRANSFERS FOR XXRS.XXRS_FA_COST_TRANSFERS;

DROP SEQUENCE XXRS.XXRS_FA_COST_TRANSFERS_S;                                          

CREATE SEQUENCE XXRS.XXRS_FA_COST_TRANSFERS_S
START WITH 1
INCREMENT BY 1
NOCACHE 
NOCYCLE ;

DROP  SYNONYM APPS.XXRS_FA_COST_TRANSFERS_S;

CREATE SYNONYM APPS.XXRS_FA_COST_TRANSFERS_S FOR XXRS.XXRS_FA_COST_TRANSFERS_S;




