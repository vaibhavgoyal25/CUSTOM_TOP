CREATE OR REPLACE TRIGGER APPS.XXRS_HZ_CUST_ACCT_SITE_BRU
/************************************************************************************************************************
  *                                                                                                                     *
  * NAME : xxrs_hz_cust_acct_site_bru.sql                                                                               *
  *                                                                                                                     *
  * DESCRIPTION : Trigger to handle customer site change event                                                          *
  *                                                                                                                     *
  * AUTHOR       : Vaibhav Goyal                                                                                        *
  * DATE WRITTEN : 01/29/2013                                                                                           *
  *                                                                                                                     *
  * CHANGE CONTROL :                                                                                                    *
  * Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                                     *
  *---------------------------------------------------------------------------------------------------------------------*
  * 1.0.0        | 130122-10283      | Vaibhav Goyal   | 01/29/2013     | Initial Creation                              *
  **********************************************************************************************************************/
  /* $Header: xxrs_hz_cust_acct_site_bru.sql 1.0.0 01/29/2013 16:00:00 Vaibhav Goyal $ */
  --
  BEFORE UPDATE   
  ON HZ_CUST_ACCT_SITES_ALL
  REFERENCING NEW AS new OLD AS old
  FOR EACH ROW
DECLARE
BEGIN
--
-- While Update populate the history table if there is change in print group Details
--
  IF ( ( NVL ( UPPER ( :new.attribute6 ), 'A' ) != NVL ( UPPER ( :old.attribute6 ), 'A' )
   AND :old.cust_acct_site_id IS NOT NULL ))
  THEN
    BEGIN

      INSERT INTO xxrs.xxrs_ar_customer_addr_h  (cust_history_id,
                                                 cust_acct_site_id,
                                                 old_print_group,
                                                 new_print_group,
                                                 creation_date,
                                                 created_by,
                                                 last_updated_by,
                                                 last_update_date,
                                                 last_update_login) 
                                         VALUES (xxrs.xxrs_ar_customer_addr_s.NEXTVAL
                                                , :old.cust_acct_site_id
                                                , :old.attribute6
                                                , :new.attribute6                 
                                                , :new.creation_date
                                                , :new.created_by                                            
                                                , :new.last_updated_by
                                                , :new.last_update_date
                                                , :new.last_update_login);

    EXCEPTION
      WHEN OTHERS
      THEN
        app_exception.raise_exception ( app_exception.get_type,
                                        app_exception.get_code,
                                        app_exception.get_text );
    END;
  END IF;
END;
/