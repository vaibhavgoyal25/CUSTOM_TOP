/**********************************************************************************************************************
* NAME : XXRS_SC_START_DATE_UPDATE.sql                                                                                          *
* DESCRIPTION :                                                                                                       *
* Script to perform the update to the start dates for resource, product and pricing                                   *
*                                                                                                                     *
* AUTHOR       : Vinodh Bhasker                                                                                       *
* DATE WRITTEN : 13-MAR-2012                                                                                          *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* SR#             Ticket#          WHO                DATE                        REMARKS                             *
* 1.0.0           111122-02448     Vinodh Bhasker     13-MAR-2012                 Initial build                       *
***********************************************************************************************************************/

UPDATE xxrs.xxrs_sc_resource_def_tbl
   SET start_effectivity_date = TO_DATE('01-JAN-1952', 'DD-MON-YYYY')
 WHERE start_effectivity_date IS NULL;
 
UPDATE xxrs.xxrs_sc_product_def_tbl
   SET start_effectivity_date = TO_DATE('01-JAN-1952', 'DD-MON-YYYY')
 WHERE start_effectivity_date IS NULL;
 
UPDATE xxrs.xxrs_sc_price_rule_tbl pr
   SET pr.effective_start_date = TO_DATE('01-JAN-1952', 'DD-MON-YYYY')
 WHERE pr.effective_start_date IS NULL;