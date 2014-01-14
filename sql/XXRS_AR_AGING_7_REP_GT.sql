/********************************************************************************************************************
*                                                                                                                   *
* NAME : XXRS_AR_AGING_7_REP_GT.sql                                                                                 *
*                                                                                                                   *
* DESCRIPTION :                                                                                                     *
* Table to hold the data returned by the 'Rackspace Aging 7 Bucket Report'                                          *
*                                                                                                                   *
* AUTHOR       : Kalyan                                                                                             *
* DATE WRITTEN : 23-JAN-2012                                                                                        *
*                                                                                                                   *
* CHANGE CONTROL :                                                                                                  *
* Version# | Ticket #    | WHO             |  DATE       |   REMARKS                                                *
*-------------------------------------------------------------------------------------------------------------------*
* 1.0.0   | 111122-02448 | Kalyan         | 23-JAN-2012 | R12 Upgrade                                              *
*********************************************************************************************************************/
/* $Header:  XXRS_AR_AGING_7_REP_GT.sql 1.0.0 23-JAN-2012  10:00:00 AM Kalyan  $ */

DROP TABLE xxrs.xxrs_ar_aging_7_rep_gt CASCADE CONSTRAINTS;

CREATE GLOBAL TEMPORARY TABLE xxrs.xxrs_ar_aging_7_rep_gt
(
  account_number       VARCHAR2(30),
  party_name           VARCHAR2(360),
  total_due            NUMBER(25, 2),
  bucket0_due          NUMBER(20, 2),
  bucket1_due          NUMBER(20, 2),
  bucket2_due          NUMBER(20, 2),
  bucket3_due          NUMBER(20, 2),
  bucket4_due          NUMBER(20, 2),
  bucket5_due          NUMBER(20, 2),
  bucket6_due          NUMBER(20, 2),
  attribute2           VARCHAR2(150),
  attribute3           VARCHAR2(150),
  attribute4           VARCHAR2(150),
  location             VARCHAR2(40),
  receipt_method_name  VARCHAR2(30),
  terms_name           VARCHAR2(15),
  dunning_letters      VARCHAR2(1),
  collector_name       VARCHAR2(30),
  notes                VARCHAR2(3000),
  paperless_flag       VARCHAR2(3)
)
ON COMMIT PRESERVE ROWS
NOCACHE;

DROP SYNONYM apps.xxrs_ar_aging_7_rep_gt;

CREATE SYNONYM apps.xxrs_ar_aging_7_rep_gt FOR xxrs.xxrs_ar_aging_7_rep_gt;