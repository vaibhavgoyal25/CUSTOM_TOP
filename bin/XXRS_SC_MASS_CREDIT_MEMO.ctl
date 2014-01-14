-- /**********************************************************************************************************************
-- *                                                                                                                     *
-- * NAME : XXRS_SC_MASS_CREDIT_MEMO.ctl                                                                                 *
-- *                                                                                                                     *
-- * DESCRIPTION :                                                                                                       *
-- * Load data into the invoice worksheet int table.                                                                     *
-- *                                                                                                                     *
-- * AUTHOR       : Vaibhav Goyal                                                                                       *
-- * DATE WRITTEN : 03/01/2012                                                                                          *
-- *                                                                                                                     *
-- * CHANGE CONTROL :                                                                                                    *
-- * Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                                     *
-- *---------------------------------------------------------------------------------------------------------------------*
-- * 1.0.0        |  111122-02448     | Vaibhav Goyal   |  03/01/2012    | Initial Creation                              *
-- * 1.0.1        |  130617-06898     | Mahesh Guddeti  |  08/06/2013    | Modified for device level products.           *
-- ***********************************************************************************************************************/
-- /* $Header XXRS_SC_MASS_CREDIT_MEMO.ctl 1.0.1 08/06/2013 15:00:00 Mahesh Guddeti $*/
OPTIONS (SKIP=1)
LOAD DATA
TRUNCATE
INTO TABLE XXRS.XXRS_MASS_CREDIT_MEMO_TEMP
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
( period_date         "TO_DATE(:period_date, 'mm/dd/yyyy')"
 , account_number      "Trim(:account_number)"
 , memo_line           "Trim(:memo_line)"
 , device_number       "Trim(:device_number)"
 , product             "Trim(:product)"
 , product_type        "Trim(:product_type)"
 , resource_name       "Trim(:resource_name)"
 , gl_product_number   "Trim(:gl_product_number)"
 , quantity            "Trim(:quantity)"
 , uom_code            "Trim(:uom_code)"
 , unit_price          "Trim(:unit_price)"
 , description         "Trim(:description)"
 , file_name           ":file_name" 
 , process_flag        CONSTANT "N"
 , creation_date       SYSDATE
 , created_by          ":created_by" 
 , last_update_date    SYSDATE
 , last_updated_by     ":created_by" 
 , last_update_login   CONSTANT "-1"
 , cm_sequence_id      "xxrs_sc_credit_memo_seq.nextval"
)
