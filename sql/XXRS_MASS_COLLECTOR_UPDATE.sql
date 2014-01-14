/*********************************************************************************************************************
*                                                                                                                    *
* NAME : xxrs_mass_collector_update.sql                                                                              *
*                                                                                                                    *
* DESCRIPTION :                                                                                                      *
* Staging table creation script for xxrs_mass_coll_update_pkg                                                        *
*                                                                                                                    *
* AUTHOR       : Ravi Gadwala                                                                                        *
* DATE WRITTEN : 28-DEC-2011                                                                                         *
*                                                                                                                    *
* CHANGE CONTROL :                                                                                                   *
* Version#     |   Ticket #        | WHO             |  DATE          |   REMARKS                                    *
*--------------------------------------------------------------------------------------------------------------------*
* 1.0.0        |   111122-02448    | Ravi Gadwala    |  23-DEC-2011   | Initial Creation for R12 Upgradation         *
*********************************************************************************************************************/

/* $Header: xxrs_mass_collector_update.sql 1.0.0 28-DEC-2011 10:13:23 AM Ravi Gadwala $ */

DROP TABLE xxrs.xxrs_mass_collector_update CASCADE CONSTRAINTS;

CREATE TABLE xxrs.xxrs_mass_collector_update
(
  CUSTOMER_NUMBER    VARCHAR2(30 BYTE)          NOT NULL,
  COLLECTOR_NAME     VARCHAR2(30 BYTE),
  CREATION_DATE      DATE,
  STATUS_FLAG        VARCHAR2(1 BYTE),
  ERROR_MSG          VARCHAR2(250),
  CONC_REQUEST_ID    NUMBER(15),
  CREATED_BY         NUMBER(15),
  LAST_UPDATED_BY    NUMBER(15),
  LAST_UPDATE_DATE   DATE,
  LAST_UPDATE_LOGIN  NUMBER
);

GRANT ALL ON xxrs.xxrs_mass_collector_update TO apps; /*111122-02448*/

DROP SYNONYM apps.xxrs_mass_collector_update;

CREATE SYNONYM apps.xxrs_mass_collector_update FOR xxrs.xxrs_mass_collector_update;  
/
