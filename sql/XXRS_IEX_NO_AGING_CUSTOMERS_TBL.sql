/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_IEX_NO_AGING_CUSTOMERS.sql                                                                          *
*                                                                                                                     *
* DESCRIPTION : Table to hold current customers as per Rackspace custom rules                                         *
*                                                                                                                     *
* AUTHOR       : Pavan Amirineni                                                                                      *
* DATE WRITTEN : 12/08/2011                                                                                           *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* Version#  | Ticket #      | WHO             |  DATE          |   REMARKS                                            *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0     | 111122-02448  | Pavan Amirineni | 12/08/2011     | Initial Creation                                     *
**********************************************************************************************************************/
/* $Header: XXRS_IEX_NO_AGING_CUSTOMERS.sql 1.0.0 12/08/2011 15:00:00 Pavan Amirineni$ */
-- Table to load current aging customers  
CREATE TABLE XXRS.XXRS_IEX_NO_AGING_CUSTOMERS 
(cust_account_id    NUMBER NOT NULL,
 request_id         NUMBER NOT NULL,
 org_id             NUMBER NOT NULL, 
 creation_date      DATE,
 created_by         NUMBER,
 last_update_date   DATE,
 last_updated_by    NUMBER,
 last_update_login  NUMBER
 );
--
ALTER TABLE XXRS.XXRS_IEX_NO_AGING_CUSTOMERS
 ADD CONSTRAINT XXRS_IEX_NO_AGING_CUSTOMERS_PK
 PRIMARY KEY
 (CUST_ACCOUNT_ID,ORG_ID);
CREATE SYNONYM XXRS_IEX_NO_AGING_CUSTOMERS FOR XXRS.XXRS_IEX_NO_AGING_CUSTOMERS;
/