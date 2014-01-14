/* ********************************************************************************************************************
*                                                                                                                     *
* NAME          : xxrs_ar_chase_reference_s.sql                                                                       *
*                                                                                                                     *
* DESCRIPTION   : This script is used to creating sequence and synonym for xxrs_ar_chase_reference_s                  *
*                                                                                                                     *
* AUTHOR        : Ravi                                                                                                *
* DATE WRITTEN  : 09-JAN-2012                                                                                         *
*                                                                                                                     *
* CHANGE CONTROL:                                                                                                     *
* SR#          |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                                     *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  111122-02448     | Ravi            |  09-JAN-2012   | Initial creation for R12 Upgradation          *
***********************************************************************************************************************/
/* $Header: xxrs_ar_chase_reference_s.sql 1.0.0 09-JAN-2012 10:41:56 AM Ravi $ */

DROP SEQUENCE xxrs.xxrs_ar_chase_reference_s;

CREATE SEQUENCE xxrs.xxrs_ar_chase_reference_s
START WITH 1
INCREMENT BY 1
MINVALUE 0
NOCACHE 
NOORDER;

DROP SYNONYM apps.xxrs_ar_chase_reference_s;

CREATE SYNONYM apps.xxrs_ar_chase_reference_s FOR xxrs.xxrs_ar_chase_reference_s;

DROP TABLE XXRS.XXRS_IBY_CREDITCARDS CASCADE CONSTRAINTS;

CREATE GLOBAL TEMPORARY TABLE XXRS.XXRS_IBY_CREDITCARDS
(
  CC_NUMBER    VARCHAR2(30 BYTE),
  EXPIRY_DATE  DATE,
  CHNAME       VARCHAR2(80 BYTE),
  INSTRID      NUMBER                           NOT NULL
)
ON COMMIT PRESERVE ROWS
RESULT_CACHE (MODE DEFAULT)
NOCACHE;


DROP SYNONYM APPS.XXRS_IBY_CREDITCARDS;

CREATE OR REPLACE SYNONYM APPS.XXRS_IBY_CREDITCARDS FOR XXRS.XXRS_IBY_CREDITCARDS;

/
