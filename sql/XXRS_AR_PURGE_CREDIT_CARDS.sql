/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_AR_PURGE_CREDIT_CARDS.sql                                                                               *
*                                                                                                                     *
* DESCRIPTION :                                                                                                       *
*   Script to create the temporary table that holds the purge credit card details.                                    *
*                                                                                                                     *
* AUTHOR       : Vinodh Bhasker                                                                                       *
* DATE WRITTEN : 21-AUG-2013                                                                                          *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* Version#     | Ticket Number    | WHO             |  DATE          |   REMARKS                                      *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0        | 130226-06458     | Vinodh Bhasker  |  21-AUG-2013   | Initial build.                                 *
***********************************************************************************************************************/
/* $Header: XXRS_AR_PURGE_CREDIT_CARDS.sql 1.0.0 21-AUG-2013 10:47:00 PM Vinodh Bhasker $ */

CREATE GLOBAL TEMPORARY TABLE xxrs.xxrs_ar_purge_credit_cards
(
   instrid                 NUMBER NOT NULL,
   account_number          VARCHAR2 (30) NOT NULL,
   site_num                VARCHAR2 (30),
   cust_account_id         NUMBER NOT NULL,
   site_use_id             NUMBER,
   party_id                NUMBER,
   masked_cc_number        VARCHAR2 (30) NOT NULL,
   card_holder_name        VARCHAR2 (360),
   card_expirydate         DATE,
   card_issuer_name        VARCHAR2 (100),
   assignment_start_date   DATE,
   assignment_end_date     DATE,
   order_of_preference     NUMBER,
   account_activity        VARCHAR2 (1),
   balance                 NUMBER,
   site_status             VARCHAR2 (1),
   valid_receipt_method    VARCHAR2 (1),
   org_id                  NUMBER,
   site_use_creation_date  DATE,  
   load_date               DATE NOT NULL,
   concurrent_request_id   NUMBER NOT NULL
) ON COMMIT PRESERVE ROWS;

CREATE INDEX XXRS.XXRS_AR_PURGE_CREDIT_CARDS_N1
   ON XXRS.XXRS_AR_PURGE_CREDIT_CARDS (INSTRID);
   
CREATE INDEX XXRS.XXRS_AR_PURGE_CREDIT_CARDS_N2
   ON XXRS.XXRS_AR_PURGE_CREDIT_CARDS (cust_account_id, site_use_id);
   
CREATE INDEX XXRS.XXRS_AR_PURGE_CREDIT_CARDS_N3
   ON XXRS.XXRS_AR_PURGE_CREDIT_CARDS (org_id);