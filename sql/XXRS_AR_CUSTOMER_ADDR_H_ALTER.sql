ALTER TABLE xxrs.xxrs_ar_customer_addr_h
/************************************************************************************************************************
  *                                                                                                                     *
  * NAME : XXRS_AR_CUSTOMER_ADDR_H_ALTER.sql                                                                            *
  *                                                                                                                     *
  * DESCRIPTION : Script to add additional columns to xxrs_ar_customer_addr_h.                                          *
  *                                                                                                                     *
  * AUTHOR       : Vaibhav Goyal                                                                                        *
  * DATE WRITTEN : 01/29/2013                                                                                           *
  *                                                                                                                     *
  * CHANGE CONTROL :                                                                                                    *
  * Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                                     *
  *---------------------------------------------------------------------------------------------------------------------*
  * 1.0.0        | 130122-10283      | Vaibhav Goyal   | 01/29/2013     | Initial Creation                              *
  **********************************************************************************************************************/
  /* $Header: XXRS_AR_CUSTOMER_ADDR_H_ALTER.sql 1.0.0 01/29/2013 16:00:00 Vaibhav Goyal $ */
  --
  ADD (cust_acct_site_id NUMBER(15),
       old_print_group VARCHAR2(150),
       new_print_group VARCHAR2(150));