-- /**********************************************************************************************************************
-- *                                                                                                                     *
-- * NAME : XXRS_AR_CUST_MASS_TEAM_UPDATE.ctl                                                                            *
-- *                                                                                                                     *
-- * DESCRIPTION :                                                                                                       *
-- * Load data into the Mass team update staging table.                                                                  *
-- *                                                                                                                     *
-- * AUTHOR       : Kalyan                                                                                               *
-- * DATE WRITTEN : 29-DEC-2011                                                                                          *
-- *                                                                                                                     *
-- * CHANGE CONTROL :                                                                                                    *
-- * Ver#  | TICKET #     | WHO        | DATE        | REMARKS                                                           *
-- *---------------------------------------------------------------------------------------------------------------------*
-- * 1.0.0 |111122-02448  | Kalyan     | 29-DEC-2011 | Initial Creation for R12 upgrade                                  *
-- * 1.0.1 |120912-03180  | Pavan      | 12-MAR-2013 | altered id columns with team and BU                               *
-- ***********************************************************************************************************************/
-- /* $Header: XXRS_AR_CUST_MASS_TEAM_UPDATE.ctl 1.0.1 29-DEC-2011 15:00:00 Pavan Amirineni$ */
--

OPTIONS (SKIP=1)
LOAD DATA
REPLACE
INTO TABLE xxrs_ar_team_am_upd
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' 
TRAILING NULLCOLS
( 
  customer_number,
  bu_segment,                    -- 120912-03180
  cust_acct_site_id,
  team_segment,                  -- 120912-03180
  business_unit,
  support_team,
  account_manager,
  team_am_upd_id             "xxrs_ar_team_am_upd_s.nextval",
  conc_request_id            ":conc_request_id",
  created_by                 ":created_by",
  creation_date              SYSDATE,
  last_update_login CONSTANT "-1",
  last_update_date SYSDATE,
  last_updated_by            ":created_by"
  )