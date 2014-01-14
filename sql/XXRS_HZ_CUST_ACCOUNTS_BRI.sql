CREATE OR REPLACE TRIGGER XXRS_HZ_CUST_ACCOUNTS_BRI
/***********************************************************************************************************************
  *                                                                                                                     *
  * NAME : XXRS_HZ_CUST_ACCOUNTS_BRI.sql                                                                                *
  *                                                                                                                     *
  * DESCRIPTION : Trigger to handle customer date established                                                           *
  *                                                                                                                     *
  * AUTHOR       : Pavan Amirineni                                                                                      *
  * DATE WRITTEN : 03/14/2013                                                                                           *
  *                                                                                                                     *
  * CHANGE CONTROL :                                                                                                    *
  * Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                                     *
  *---------------------------------------------------------------------------------------------------------------------*
  * 1.0.0        | 130128-08943      | Pavan Amirineni | 03/14/2013     | Initial Creation                              *
  **********************************************************************************************************************/
  /* $Header: XXRS_HZ_CUST_ACCOUNTS_BRI.sql 1.0.0 03/14/2013 16:38:00 PAVAN AMIRINENI $ */
  --
  BEFORE INSERT               
  ON HZ_CUST_ACCOUNTS
  REFERENCING NEW AS new OLD AS old
  FOR EACH ROW
DECLARE
BEGIN
  IF (:old.account_established_date IS NULL) THEN 
    :new.account_established_date    := TRUNC(SYSDATE);
  END IF;  
EXCEPTION    
   WHEN OTHERS
     THEN
        app_exception.raise_exception ( app_exception.get_type,
                                        app_exception.get_code,
                                        app_exception.get_text 
                                      );  
END; 
/
