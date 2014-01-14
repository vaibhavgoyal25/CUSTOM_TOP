/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_AR_ORBITAL_ALTER_TBLS.sql                                                                               *
*                                                                                                                     *
* DESCRIPTION :                                                                                                       *
* Alter Table XXRS_AR_ORBITAL_GATEWAY_DTLS,XXRS_AR_ORBITAL_GATEWAY_ARC with                                           *
* new columns Module and req_receipt_method_id                                                                        *
*                                                                                                                     *
* AUTHOR       : SUDHEER GUNTU                                                                                        *
* DATE WRITTEN : 30-JAN-2012                                                                                          *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* Version#     |  TICKET          | WHO             |  DATE          |   REMARKS                                      *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  111122-02448    | SUDHEER GUNTU   |  30-JAN-2012   |  Initial Build for R12 upgradation             *
**********************************************************************************************************************/

/* $Header: XXRS_AR_ORBITAL_ALTER_TBLS.sql 1.0.0 30-JAN-2012 02:20:52 PM SUDHEER GUNTU $ */

ALTER TABLE xxrs.xxrs_ar_orbital_gateway_dtls
ADD (module                VARCHAR2(10),
     req_receipt_method_id NUMBER(15),
     instrument_id         NUMBER(15)
     );
     
ALTER TABLE xxrs.xxrs_ar_orbital_gateway_arc
ADD (module                VARCHAR2(10),
     req_receipt_method_id NUMBER(15)
     );
     
/