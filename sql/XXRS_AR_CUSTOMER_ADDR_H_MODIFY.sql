ALTER TABLE xxrs.xxrs_ar_customer_addr_h
/************************************************************************************************************************
  *                                                                                                                     *
  * NAME : XXRS_AR_CUSTOMER_ADDR_H_MODIFY.sql                                                                           *
  *                                                                                                                     *
  * DESCRIPTION : Script to modify columns of xxrs_ar_customer_addr_h.                                                  *
  *                                                                                                                     *
  * AUTHOR       : Vaibhav Goyal                                                                                        *
  * DATE WRITTEN : 01/29/2013                                                                                           *
  *                                                                                                                     *
  * CHANGE CONTROL :                                                                                                    *
  * Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                                     *
  *---------------------------------------------------------------------------------------------------------------------*
  * 1.0.0        | 130122-10283      | Vaibhav Goyal   | 01/29/2013     | Initial Creation                              *
  **********************************************************************************************************************/
  /* $Header: XXRS_AR_CUSTOMER_ADDR_H_MODIFY.sql 1.0.0 01/29/2013 16:00:00 Vaibhav Goyal $ */
  --
  MODIFY LOCATION_ID NUMBER(15) null;