-- /**********************************************************************************************************************
-- *                                                                                                                     *
-- * NAME : XXRSARGGRANGE.ctl                                                                                            *
-- *                                                                                                                     *
-- * DESCRIPTION :                                                                                                       *
-- * Control file to load the Credit Card Range Data from Chase Paymentech                                               *
-- *                                                                                                                     *
-- * AUTHOR       : SUDHEER GUNTU                                                                                        *
-- * DATE WRITTEN : 09-JAN-2012                                                                                          *
-- *                                                                                                                     *
-- * CHANGE CONTROL :                                                                                                    *
-- * Ver#  | Ticket #     | WHO             | DATE       |   REMARKS                                                     *
-- *---------------------------------------------------------------------------------------------------------------------*
-- * 1.0.0 | 111122-02448 | SUDHEER GUNTU   | 09-JAN-2012| Initial Creation for R12 Upgradation                          *
-- ***********************************************************************************************************************/

-- /* $Header: XXRSARGGRANGE.ctl 1.0.0 09-JAN-12 01:11:52 PM SUDHEER GUNTU $ */

OPTIONS (SKIP=1)
LOAD DATA
REPLACE
INTO TABLE xxrs.xxrs_ar_orbital_gateway_range
WHEN (9:27) != '' and (28:46) != '' and (52:54) != ''
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
( record_sequence_number   POSITION(1:8)  ,
  low_range                POSITION(9:27) ,
  high_range               POSITION(28:46),
  business_card_indicator  POSITION(47:47),
  pc_indicator             POSITION(48:48),
  corporate_indicator      POSITION(49:49),
  fleet_card_indicator     POSITION(50:50),
  epayment_indicator       POSITION(51:51),
  country_code             POSITION(52:54),
  conc_request_id          POSITION(81:95)  "TO_NUMBER(:conc_request_id)",
  created_by               POSITION(96:110) "TO_NUMBER(:created_by)",
  creation_date            SYSDATE        ,
  last_update_login        CONSTANT '-1',
  last_update_date         SYSDATE        ,
  last_updated_by          POSITION(96:110) "TO_NUMBER(:last_updated_by)"

)