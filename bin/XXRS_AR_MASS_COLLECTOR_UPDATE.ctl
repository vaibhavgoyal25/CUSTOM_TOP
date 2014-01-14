-- /**********************************************************************************************************************
-- *                                                                                                                     *
-- * NAME : xxrs_ar_mass_collector_update.ctl                                                                            *
-- *                                                                                                                     *
-- * DESCRIPTION :                                                                                                       *
-- * Load data into the Mass Collector update staging table.                                                             *
-- *                                                                                                                     *
-- * AUTHOR       : Ravi                                                                                                 *
-- * DATE WRITTEN : 23-DEC-11                                                                                            *
-- *                                                                                                                     *
-- * CHANGE CONTROL :                                                                                                    *
-- * Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                                     *
-- *---------------------------------------------------------------------------------------------------------------------*
-- * 1.0.0        | 111122-02448      | Ravi            |  23-DEC-11     | Initial Creation for R12 upgrade              *
-- **********************************************************************************************************************/

OPTIONS (SKIP=1)
LOAD DATA
REPLACE
INTO TABLE xxrs.xxrs_mass_collector_update
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
( 
   customer_number
  ,collector_name
  ,creation_date            SYSDATE
  ,conc_request_id          ":conc_request_id"
  ,created_by               ":created_by"
  ,last_update_login        CONSTANT "-1"
  ,last_update_date         SYSDATE
  ,last_updated_by          ":created_by"
)
   