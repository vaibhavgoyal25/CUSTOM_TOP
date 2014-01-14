/* *********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_FA_SISIC_DB_OBJECTS.sql                                                                                    *
*                                                                                                                     *
* DESCRIPTION :                                                                                                       *
* Script to create database objects(tables,indexes,sequences and synonyms) for SISIC                                  *
*                                                                                                                     *
* AUTHOR       : Sunil Kumar Mallina                                                                                  *
* DATE WRITTEN : 29-DEC-2011                                                                                          *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* Version#     |  Ticket Number   | WHO                 |  DATE          |   REMARKS                                 *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0         | 111122-02448      | Sunil Kumar Mallina |  29-DEC-2011   | R12 Upgradation                           *
***********************************************************************************************************************/
/* $Header: XXRS_FA_SISIC_DB_OBJECTS.sql 1.0.0 29-DEC-2011 18:47:00 PM Sunil Kumar M $ */
DROP TABLE xxrs.xxrs_fa_server_by_company;

CREATE TABLE xxrs.xxrs_fa_server_by_company
(
  TRANSFER_ID        NUMBER(15) PRIMARY KEY,
  LOCATOR            VARCHAR2(40 BYTE),
  DC_NAME            VARCHAR2(240 BYTE),
  DC_ORG_ID          NUMBER(15),
  ORG_ID             NUMBER(15),
  ORG_CODE           VARCHAR2(3 BYTE),
  XFER_COMPANY       VARCHAR2(30 BYTE),
  XFER_COMPANY_CODE  VARCHAR2(30 BYTE),
  LOCATOR_ID         NUMBER,
  ERROR_MSG          VARCHAR2(240 BYTE),
  PROCESS_FLAG       NUMBER(1),
  CONC_REQUEST_ID    NUMBER(15),
  CREATION_DATE      DATE,
  CREATED_BY         NUMBER,
  LAST_UPDATED_BY    NUMBER,
  LAST_UPDATE_DATE   DATE,
  LAST_UPDATE_LOGIN  NUMBER,
  CUSTOMER_NUM       VARCHAR2(30 BYTE),
  SKU_NUM            VARCHAR2(50 BYTE),
  SKU_DESC           VARCHAR2 (100 BYTE)
);

DROP SYNONYM apps.xxrs_fa_server_by_company;

CREATE SYNONYM apps.xxrs_fa_server_by_company FOR xxrs.xxrs_fa_server_by_company;  

DROP SEQUENCE xxrs.xxrs_fa_server_by_company_S;     
                                         
CREATE SEQUENCE xxrs.xxrs_fa_server_by_company_S
START WITH 1
INCREMENT BY 1
NOCACHE; 
--
CREATE SYNONYM apps.xxrs_fa_server_by_company_S FOR xxrs.xxrs_fa_server_by_company_S;
--
CREATE INDEX xxrs.xxrs_fa_server_by_company_N1 ON xxrs.xxrs_fa_server_by_company(LOCATOR)
LOGGING
NOPARALLEL;
--
CREATE INDEX xxrs.xxrs_fa_server_by_company_N2 ON xxrs.xxrs_fa_server_by_company(LOCATOR_ID)
LOGGING
NOPARALLEL;

DROP TABLE xxrs.xxrs_fa_xfer_assets_stg;

CREATE TABLE xxrs.xxrs_fa_xfer_assets_stg
(
  XFER_ID              NUMBER(15) PRIMARY KEY,
  SERIAL_NUMBER        VARCHAR2(30 BYTE),
  ORGANIZATION_ID      NUMBER(15),
  CURRENT_SUBINV_CODE  VARCHAR2(10 BYTE),
  LOCATOR_ID           NUMBER(15),
  LOCATOR              VARCHAR2(40 BYTE),
  XFER_COMPANY_CODE    VARCHAR2(30 BYTE),
  XFER_COMPANY         VARCHAR2(30 BYTE),
  DC_NAME              VARCHAR2(240 BYTE),
  COMPANY_CODE         VARCHAR2(30 BYTE),
  BOOK_TYPE_CODE       VARCHAR2(15 BYTE),
  CCID                 NUMBER(15),
  ASSET_ID             NUMBER(15),
  XFER_FA_LOCATION_ID  NUMBER(15),
  FA_LOCATION_ID       NUMBER(15),
  ASSIGNED_TO          NUMBER(15),
  XFER_CCID            NUMBER(15),
  PROCESS_FLAG         NUMBER(1),
  ERROR_MSG            VARCHAR2(2000 BYTE),
  CREATION_DATE        DATE,
  CREATED_BY           NUMBER,
  LAST_UPDATED_BY      NUMBER,
  LAST_UPDATE_DATE     DATE,
  LAST_UPDATE_LOGIN    NUMBER
);

DROP SYNONYM apps.xxrs_fa_xfer_assets_stg;

CREATE SYNONYM apps.xxrs_fa_xfer_assets_stg FOR xxrs.xxrs_fa_xfer_assets_stg;.

DROP SEQUENCE xxrs.xxrs_fa_assets_xfer_s;

CREATE SEQUENCE xxrs.xxrs_fa_assets_xfer_s
START WITH 1
NOCACHE;

DROP  SYNONYM apps.xxrs_fa_assets_xfer_s;

CREATE SYNONYM apps.xxrs_fa_assets_xfer_s FOR xxrs.xxrs_fa_assets_xfer_s;
/