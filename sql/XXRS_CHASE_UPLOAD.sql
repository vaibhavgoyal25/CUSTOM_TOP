DROP TABLE XXRS.XXRS_CHASE_UPLOAD CASCADE CONSTRAINTS;
  /*********************************************************************************************************************************
  *                                                                                                                                *
  * NAME : XXRS_CHASE_UPLOAD.sql                                                                                                   *
  *                                                                                                                                *
  * DESCRIPTION :                                                                                                                  *
  * Table to report AP Payments to Chase.                                                                                          *
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
 
CREATE TABLE XXRS.XXRS_CHASE_UPLOAD
(
  RECORDS        VARCHAR2(128 BYTE),
  TIMESTAMP      DATE,
  RECORD_NUMBER  NUMBER(10),
  INVOICE_ID     VARCHAR2(100 BYTE)
);