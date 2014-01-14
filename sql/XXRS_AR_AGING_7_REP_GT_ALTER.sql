/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_AR_AGING_7_REP_GT_ALTER.sql                                                                             *
*                                                                                                                     *
* DESCRIPTION :                                                                                                       *
* Table to hold Aging 7 Buckets data                                                                                  *
*                                                                                                                     *
* AUTHOR       : Rahul BODDIREDDY                                                                                     *
* DATE WRITTEN : 22-NOV-2013                                                                                          *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* Version#     |  TICKET          | WHO             |  DATE          |   REMARKS                                      *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  130514-01752    | MAHESH GUDDETI  |  31-MAY-2013   |  Initial Build                                 *
* 1.0.1        |  131112-05738    | RAHUL B         |  22-NOV-2013   |  Added 3 More columns to Aging Report staging. *
**********************************************************************************************************************/

/* $Header: XXRS_AR_AGING_7_REP_GT_ALTER.sql 1.0.1 22-NOV-2013 02:00:00 PM RAHUL B $ */

ALTER TABLE XXRS.XXRS_AR_AGING_7_REP_GT 
ADD (FIRST_INV_DATE DATE);

ALTER TABLE XXRS.XXRS_AR_AGING_7_REP_GT 
ADD (LAST_PAY_DATE DATE);

ALTER TABLE XXRS.XXRS_AR_AGING_7_REP_GT 
ADD (TOTAL_PAYMENT_TODATE  NUMBER(25,2));