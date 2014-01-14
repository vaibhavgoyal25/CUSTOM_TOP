CREATE OR REPLACE TRIGGER XXRS_HZ_LOCATIONS_BRU
/**********************************************************************************************************************
  *                                                                                                                     *
  * NAME : xxrs_hz_locations_bru.sql                                                                                    *
  *                                                                                                                     *
  * DESCRIPTION : Trigger to handle customer Address change event                                                       *
  *                                                                                                                     *
  * AUTHOR       : Sudheer Guntu                                                                                        *
  * DATE WRITTEN : 17/02/2012                                                                                           *
  *                                                                                                                     *
  * CHANGE CONTROL :                                                                                                    *
  * Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                                     *
  *---------------------------------------------------------------------------------------------------------------------*
  * 1.0.0        | 111122-02448      | Sudheer Guntu   | 17/02/2012     | Initial Creation                              *
  * 1.0.1        | 120530-05225      | Pavan Amirineni | 06/11/2012     | Changed the trigger to be only on before      *
  *              |                   |                 |                | update only.                                  *
  **********************************************************************************************************************/
  /* $Header: xxrs_hz_locations_bru.sql 1.0.1 06/11/2012 16:38:00 PAVAN AMIRINENI $ */
  --
  BEFORE UPDATE               -- 120530-05225 changed to only before update and removed the insert
  ON HZ_LOCATIONS
  REFERENCING NEW AS new OLD AS old
  FOR EACH ROW
DECLARE
BEGIN
--
-- While Update or Insert Capitalize the address details
--
  BEGIN
    :new.address1    := UPPER ( :new.address1 );
    :new.address2    := UPPER ( :new.address2 );
    :new.address3    := UPPER ( :new.address3 );
    :new.address4    := UPPER ( :new.address4 );
    :new.city        := UPPER ( :new.city );
    :new.postal_code := UPPER ( :new.postal_code );
    :new.state       := UPPER ( :new.state );
  EXCEPTION
    WHEN OTHERS
    THEN
      app_exception.raise_exception ( app_exception.get_type,
                                      app_exception.get_code,
                                      app_exception.get_text );
  END;
--
-- While Update populate the history table if there is change in Address Details
--
  IF ( ( NVL ( UPPER ( :new.country ), 'A' ) != NVL ( UPPER ( :old.country ), 'A' )
      OR NVL ( UPPER ( :new.address1 ), 'A' ) != NVL ( UPPER ( :old.address1 ), 'A' )
      OR NVL ( UPPER ( :new.address2 ), 'A' ) != NVL ( UPPER ( :old.address2 ), 'A' )
      OR NVL ( UPPER ( :new.address3 ), 'A' ) != NVL ( UPPER ( :old.address3 ), 'A' )
      OR NVL ( UPPER ( :new.address4 ), 'A' ) != NVL ( UPPER ( :old.address4 ), 'A' )
      OR NVL ( UPPER ( :new.city ), 'A' ) != NVL ( UPPER ( :old.city ), 'A' )
      OR NVL ( UPPER ( :new.postal_code ), 'A' ) != NVL ( UPPER ( :old.postal_code ), 'A' )
      OR NVL ( UPPER ( :new.state ), 'A' ) != NVL ( UPPER ( :old.state ), 'A' ) )
   AND :old.location_id IS NOT NULL )
  THEN
    BEGIN
      xxrs_ar_customer_addr.record_history ( :new.location_id,
                                             :old.country,
                                             :new.country,
                                             :old.address1,
                                             :new.address1,
                                             :old.address2,
                                             :new.address2,
                                             :old.address3,
                                             :new.address3,
                                             :old.address4,
                                             :new.address4,
                                             :old.city,
                                             :new.city,
                                             :old.postal_code,
                                             :new.postal_code,
                                             :old.state,
                                             :new.state,
                                             :new.created_by,
                                             :new.creation_date,
                                             :new.last_updated_by,
                                             :new.last_update_date,
                                             :new.last_update_login );
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