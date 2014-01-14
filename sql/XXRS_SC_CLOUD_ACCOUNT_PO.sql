DROP SYNONYM APPS.XXRS_SC_CLOUD_ACCOUNT_PO;
DROP TABLE XXRS.XXRS_SC_CLOUD_ACCOUNT_PO;
  /******************************************************************************************************************
  *                                                                                                                 *
  * NAME : XXRS_SC_CLOUD_ACCOUNT_PO.sql                                                                             *
  *                                                                                                                 *
  * DESCRIPTION : SQL to create table to hold Cloud Account PO Details.                                             *
  *                                                                                                                 *
  * AUTHOR       : Vaibhav                                                                                          *
  * DATE WRITTEN : 31-AUG-2013                                                                                      *
  *                                                                                                                 *
  * CHANGE CONTROL :                                                                                                *
  * Version#     | REF#             | WHO                | DATE              | REMARKS                              *
  *-----------------------------------------------------------------------------------------------------------------*
  * 1.0.0        | 130621-07223     | Vaibhav Goyal      | 31-AUG-2013       | Initial Creation.                    *
  *******************************************************************************************************************/
  /* $HEADER: XXRS_SC_CLOUD_ACCOUNT_PO.sql 1.0.0 31-AUG-2013 5:00:00 PM VAIBHAV $ */
CREATE TABLE XXRS.XXRS_SC_CLOUD_ACCOUNT_PO
  (RS_CLOUD_XREF_ID  NUMBER PRIMARY KEY,
   RACKSPACE_ACCOUNT_NUMBER VARCHAR2(50) NOT NULL,
   CLOUD_ACCOUNT_NUMBER VARCHAR2(50) NOT NULL,
   PO_NUMBER VARCHAR2(50),
   LAST_UPDATE_DATE DATE NOT NULL,
   LAST_UPDATED_BY NUMBER NOT NULL,
   CREATION_DATE DATE NOT NULL,
   CREATED_BY NUMBER NOT NULL,
   LAST_UPDATE_LOGIN NUMBER NOT NULL,
   ADD_ROW VARCHAR2(50));

CREATE SYNONYM APPS.XXRS_SC_CLOUD_ACCOUNT_PO FOR XXRS.XXRS_SC_CLOUD_ACCOUNT_PO;

ALTER TABLE XXRS.XXRS_SC_CLOUD_ACCOUNT_PO ADD 
CONSTRAINT XXRS_CLOUD_ACCOUNT_UNIQUE
 UNIQUE (CLOUD_ACCOUNT_NUMBER)
 ENABLE
 VALIDATE;