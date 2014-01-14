DROP TABLE XXRS.XXRS_CHASE_PROCESSED_PAYMENTS CASCADE CONSTRAINTS;
  /*********************************************************************************************************************************
  *                                                                                                                                *
  * NAME : XXRS_CHASE_PROCESSED_PAYMENTS.sql                                                                                       *
  *                                                                                                                                *
  * DESCRIPTION :                                                                                                                  *
  * Script to create custom table to hold already processed payments.                                                              *
  *                                                                                                                                *
  * AUTHOR       : VAIBHAV GOYAL                                                                                                   *
  * DATE WRITTEN : 02/16/2012                                                                                                      *
  *                                                                                                                                *
  * CHANGE CONTROL :                                                                                                               *
  *--------------------------------------------------------------------------------------------------------------------------------*
  * VERSION |GENIE TICKET # |       WHO       |  DATE       |                    REMARKS                                           *
  *--------------------------------------------------------------------------------------------------------------------------------*
  * 1.0.0   |111122-02448   | Vaibhav Goyal   | 02/16/2012  | Initial Creation                                                     *
  **********************************************************************************************************************************/
 
CREATE TABLE XXRS.XXRS_CHASE_PROCESSED_PAYMENTS
(
  CHECK_ID          VARCHAR2(128 BYTE),
  CREATION_DATE     DATE,
  CREATED_BY        VARCHAR2(100 BYTE),
  LAST_UPDATE_DATE  DATE,
  LAST_UPDATE_BY    VARCHAR2(100 BYTE)
);