Alter 
   /**********************************************************************************************************************
   *                                                                                                                     *
   * NAME : XXRS_SC_PRICE_ADJ_INT_ALTER.sql  140114-11113                                                                *
   *                                                                                                                     *
   * DESCRIPTION :                                                                                                       *
   * Script to Add columns to xxrs.xxrs_sc_price_adj_int for renewals.                                                   *
   *                                                                                                                     *
   * AUTHOR       : Vaibhav Goyal                                                                                        *
   * DATE WRITTEN : 12/17/2013                                                                                           *
   *                                                                                                                     *
   * CHANGE CONTROL :                                                                                                    *
   * Version#     |  Racker Ticket #  | WHO              |  DATE         |   REMARKS                                     *
   *---------------------------------------------------------------------------------------------------------------------*
   * 1.0.0        |  131209-08488     | Vaibhav Goyal    |  12/17/2013   | Initial Creation.                             *
   ***********************************************************************************************************************/
   /* $Header: XXRS_SC_PRICE_ADJ_INT_ALTER.sql 1.0.0 12/17/2013 02:00:00 PM Vaibhav Goyal $ */
table xxrs.xxrs_sc_price_adj_int add (old_mrr_fee NUMBER(15,2));
Alter table xxrs.xxrs_sc_price_adj_int add (new_mrr_fee NUMBER(15,2));
Alter table xxrs.xxrs_sc_price_adj_int add (old_ec_end_date DATE);
Alter table xxrs.xxrs_sc_price_adj_int add (old_monthly_fee NUMBER(15,2));