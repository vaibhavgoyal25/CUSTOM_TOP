/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_IEX_NOTES_DB_OBJ.sql                                                                                    *
*                                                                                                                     *
* DESCRIPTION :                                                                                                       *
* Script to create database objects(Table,sequences, their grants and synonyms)                                       *
*                                                                                                                     *
* AUTHOR       : Sai Manohar                                                                                          *
* DATE WRITTEN : 19-DEC-2011                                                                                          *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* VER #  |  TICKET #    | WHO             |  DATE       |  REMARKS                                                    *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0  | 111122-02448 | Sai Manohar     |  19-DEC-2011  | Initial built for R12 upgrade                             *
***********************************************************************************************************************/
/* $Header: XXRS_IEX_NOTES_DB_OBJ.sql 1.0.0 19-DEC-2011 10:00:00 AM Sai Manohar $ */

DROP TABLE xxrs.xxrs_iex_notes;
CREATE TABLE xxrs.xxrs_iex_notes
(
  note_id            NUMBER(15) PRIMARY KEY,
  account_number     VARCHAR2(30 BYTE),
  note_text          VARCHAR2(2000 BYTE),
  notes_detail       CLOB,
  entered_by         VARCHAR2(30 BYTE),
  entered_date       DATE,
  error_msg          VARCHAR2(240 BYTE),
  process_flag       VARCHAR2(1 BYTE),
  conc_request_id    NUMBER(15),
  creation_date      DATE,
  created_by         NUMBER,
  last_updated_by    NUMBER,
  last_update_date   DATE,
  last_update_login  NUMBER
);


DROP SYNONYM apps.xxrs_iex_notes;
CREATE SYNONYM apps.xxrs_iex_notes for xxrs.xxrs_iex_notes;  

DROP SEQUENCE xxrs.xxrs_iex_notes_s; 
                                         
CREATE SEQUENCE xxrs.xxrs_iex_notes_s
START WITH 1
INCREMENT BY 1
MINVALUE 0
NOCACHE 
NOORDER;

--
DROP SYNONYM apps.xxrs_iex_notes_s;
CREATE SYNONYM apps.xxrs_iex_notes_s for xxrs.xxrs_iex_notes_s;

