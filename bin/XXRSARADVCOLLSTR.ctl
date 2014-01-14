-- /**********************************************************************************************************************
-- *                                                                                                                     *
-- * NAME : XXRSARADVCOLLSTR.ctl                                                                                         *
-- *                                                                                                                     *
-- * DESCRIPTION :                                                                                                       *
-- * Control file to load Advance Collection Strategy Data.                                                              *
--*                                                                                                                      *
--* AUTHOR       : VAIBHAV GOYAL                                                                                         *
--* DATE WRITTEN : 16-MAY-2013                                                                                           *
--*                                                                                                                      *
--* CHANGE CONTROL :                                                                                                     *
--* Version#     |  TICKET          | WHO             |  DATE          |   REMARKS                                       *
--*----------------------------------------------------------------------------------------------------------------------*
--* 1.0.0        |  130514-01651    | VAIBHAV GOYAL   |  16-MAY-2013   |  Initial Build                                  *
--***********************************************************************************************************************/
-- /* $Header: XXRSARADVCOLLSTR.ctl 1.0.0 16-MAY-2013 02:00:00 PM VAIBHAV GOYAL $ */
LOAD DATA
APPEND
INTO TABLE XXRS.XXRS_CUST_SITE_STRATEGY_TMP
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
( ACCOUNT_NUMBER,
  PARTY_SITE_NUMBER,
  ORGANIZATION,
  ATTRIBUTE2,
  PARENT
)