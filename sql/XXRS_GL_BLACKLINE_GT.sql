/* *********************************************************************************************************
*                                                                                                         *
* NAME : XXRS_GL_BLACKLINE_GT.sql                                                                         *
*                                                                                                         *
* DESCRIPTION :                                                                                           *
* Script to create Global Temperory table for Blackline                                                   *
*                                                                                                         *
* AUTHOR       : Kalyan                                                                                   *
* DATE WRITTEN : 20-DEC-2011                                                                              *
*                                                                                                         *
* CHANGE CONTROL :                                                                                        *
* SR#   |  Ticket #       | WHO             |  DATE          |   REMARKS                                  *
*---------------------------------------------------------------------------------------------------------*
* 1.0.0 | 111122-02448    | Kalyan          |  20-DEC-2011   | R12 Upgradation                            *
***********************************************************************************************************/

/* $Header: XXRS_GL_BLACKLINE_GT.sql 1.0.0 20-DEC-2011 08:37:00 PM Kalyan $ */

DROP TABLE xxrs.xxrs_gl_blackline_gt CASCADE CONSTRAINTS;

CREATE GLOBAL TEMPORARY TABLE xxrs.xxrs_gl_blackline_gt
(  
  entity                 VARCHAR2(150 BYTE)     NOT NULL,
  account                VARCHAR2(150 BYTE)     NOT NULL,
  business_unit          VARCHAR2(150 BYTE)     NOT NULL,
  account_description    VARCHAR2(240 BYTE),
  financial_statement    VARCHAR2(1 BYTE),
  account_type           VARCHAR2(10 BYTE),
  active_account         VARCHAR2(5 BYTE),
  activity_in_period     VARCHAR2(5 BYTE),
  fun_cur_code           VARCHAR2(15 BYTE),
  acc_cur_code           VARCHAR2(15 BYTE),
  period_name            VARCHAR2(6 BYTE),
  name                   VARCHAR2(30 BYTE),
  gl_reporting_balance   NUMBER,
  gl_functional_balance  NUMBER,
  gl_account_balance     NUMBER,
  period_year            NUMBER(4),
  start_date             DATE,
  period_num             NUMBER(2),
  end_date               VARCHAR2(10 BYTE)
)
ON COMMIT PRESERVE ROWS
NOCACHE;

DROP SYNONYM apps.xxrs_gl_blackline_gt;

CREATE SYNONYM apps.xxrs_gl_blackline_gt FOR xxrs.xxrs_gl_blackline_gt;
/