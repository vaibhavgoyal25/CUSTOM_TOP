-- /**********************************************************************************************************************
-- *                                                                                                                     *
-- * NAME : XXRS_IEX_NOTES.ctl                                                                                           *
-- *                                                                                                                     *
-- * DESCRIPTION :                                                                                                       *
-- * Load data into xxrs_iex_notes table.                                                                                *
-- *                                                                                                                     *
-- * AUTHOR       : Sai Manohar                                                                                          *
-- * DATE WRITTEN : 19-DEC-2011                                                                                          *
-- *                                                                                                                     *
-- * CHANGE CONTROL :                                                                                                    *
-- * Ver#  | TICKET #     | WHO             | DATE       |   REMARKS                                                     *
-- *---------------------------------------------------------------------------------------------------------------------*
-- * 1.0.0 |111122-02448  | sai manohar     | 19-DEC-2011 | Initial Creation                                             *
-- ***********************************************************************************************************************/
OPTIONS (SKIP=1)
LOAD DATA
REPLACE
INTO TABLE xxrs.xxrs_iex_notes
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(  
  account_number     	"TRIM(:account_number)",  
  note_text        	"TRIM(:note_text)",
  entered_by          	"TRIM(:entered_by)",  
  conc_request_id       ":conc_request_id",
  created_by            ":created_by",
   process_flag    	 CONSTANT P,
  note_id           	"xxrs_iex_notes_s.nextval",
  entered_date         	SYSDATE,
  creation_date         SYSDATE,
  last_update_login     CONSTANT "-1",
  last_update_date      SYSDATE,
  last_updated_by       ":created_by"  
)