CREATE OR REPLACE TRIGGER xxrs_hz_parties_bru
/**********************************************************************************************************************
*                                                                                                                     *
* NAME : xxrs_hz_parties_bru.sql                                                                                      *
*                                                                                                                     *
* DESCRIPTION : Trigger to handle customer name change event                                                          * 
*                                                                                                                     *
* AUTHOR       : Pavan Amirineni                                                                                      *
* DATE WRITTEN : 12/05/2011                                                                                           *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                                     *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0        | 111122-02448      | Pavan Amirineni | 12/05/2011     | Initial Creation                              *
**********************************************************************************************************************/
/* $Header: xxrs_hz_parties_bru.sql 1.0.0 12/05/2011 09:16:00 Pavan Amirineni$ */
--
  BEFORE UPDATE
  ON HZ_PARTIES
  REFERENCING NEW AS new OLD AS old
  FOR EACH ROW
WHEN (
new.party_name != old.party_name
      )  
DECLARE
  BEGIN
    xxrs_ar_customer_name.record_history (:new.party_id,
                                          :old.party_name,
                                          :new.party_name,
                                          :new.created_by,
                                          :new.creation_date,
                                          :new.last_updated_by,
                                          :new.last_update_date,
                                          :new.last_update_login
                                          );
  EXCEPTION
    WHEN OTHERS
    THEN
      app_exception.raise_exception (app_exception.get_type,
                                     APP_EXCEPTION.GET_CODE,
                                     APP_EXCEPTION.GET_TEXT
                                     || 'Exception:xxrs_hz_parties_bru -> xxrs_ar_customer_name.record_history'
                                     || 'new.party_id:'
                                     || :new.party_id
                                     || 'old.party_name:'
                                     || :old.party_name
                                     || 'new.party_name:'
                                     || :new.party_name
                                     );
  END;
/