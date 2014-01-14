-- /**********************************************************************************************************************
-- *                                                                                                                     *
-- * NAME : XXRSICXREQS.ctl                                                                                              *
-- *                                                                                                                     *
-- * DESCRIPTION :                                                                                                       *
-- * Load data into xxrs.xxrs_icx_reqs table                                                                             *
-- *                                                                                                                     *
-- * AUTHOR       : SUDHEER GUNTU                                                                                        *
-- * DATE WRITTEN : 20-DEC-2011                                                                                          *
-- *                                                                                                                     *
-- * CHANGE CONTROL :                                                                                                    *
-- * Ver#  | TICKET        | WHO             | DATE       |   REMARKS                                                    *
-- *---------------------------------------------------------------------------------------------------------------------*
-- * 1.0.0 | 111122-02448  | SUDHEER GUNTU   | 20-DEC-2011| Initial Creation for R12 Upgradation                         *
-- ***********************************************************************************************************************/
-- /* $Header: XXRS_ICX_REQS.ctl 1.0.0 22/12/2011 03:23:30 PM SUDHEER GUNTU $ */
OPTIONS (SKIP=1)
LOAD DATA
REPLACE
INTO TABLE xxrs.xxrs_icx_reqs_tbl
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  suggested_vendor_name,
  suggested_vendor_site,
  item_description,
  line_type,
  category_segment1,
  quantity DECIMAL EXTERNAL,
  unit_price DECIMAL EXTERNAL,
  conc_request_id ":conc_request_id",
  created_by ":created_by",
  creation_date SYSDATE,
  reference_num RECNUM,
  last_update_login CONSTANT "-1",
  last_update_date SYSDATE,
  last_updated_by ":created_by",
  org_id "fnd_global.org_id",
  process_flag CONSTANT "P"
)
