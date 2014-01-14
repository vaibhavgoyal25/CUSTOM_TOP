  /**********************************************************************************************************************
  *                                                                                                                     *
  * NAME : XXRS_SC_RESOURCE_DEF_VW.sql                                                                                  *
  *                                                                                                                     *
  * DESCRIPTION :                                                                                                       *
  * View used for displaying resource information on form                                                               *
  *                                                                                                                     *
  * AUTHOR       : Vinodh Bhasker                                                                                       *
  * DATE WRITTEN : 17-FEB-2012                                                                                          *
  *                                                                                                                     *
  * CHANGE CONTROL :                                                                                                    *
  * SR#          |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                                     *
  *---------------------------------------------------------------------------------------------------------------------*
  * 1.0          | 111122-02448      | Vinodh Bhasker  | 02/17/2012     | Initial Creation for R12                      *
  ***********************************************************************************************************************/

CREATE OR REPLACE FORCE VIEW apps.xxrs_sc_resource_def_vw ( row_id
                                                          ,  resource_def_snid
                                                          ,  resource_name
                                                          ,  resource_type
                                                          ,  resource_billing_type_code
                                                          ,  creation_date
                                                          ,  unit_of_measure_code
                                                          ,  tiered_flag
                                                          ,  prepay_flag
                                                          ,  gl_revenue_acct
                                                          ,  created_by
                                                          ,  last_updated_by
                                                          ,  last_update_login
                                                          ,  last_update_date
                                                          ,  resource_billing_type_meaning
                                                          ,  resource_billing_type_tag
                                                          ,  unit_of_measure_meaning
                                                          ,  start_effectivity_date
                                                          ,  end_effectivity_date
                                                          ,  include_in_monthly_fee_flag
                                                          ,  enable_services )
AS
  SELECT rd.ROWID
       ,  rd.resource_def_snid
       ,  rd.resource_name
       ,  rd.resource_type
       ,  rd.resource_billing_type_code
       ,  rd.creation_date
       ,  rd.unit_of_measure_code
       ,  rd.tiered_flag
       ,  rd.prepay_flag
       ,  rd.gl_revenue_acct
       ,  rd.created_by
       ,  rd.last_updated_by
       ,  rd.last_update_login
       ,  rd.last_update_date
       ,  bt_lookup.meaning
       ,  bt_lookup.tag
       ,  uom.unit_of_measure
       ,  rd.start_effectivity_date
       ,  rd.end_effectivity_date
       ,  rd.include_in_monthly_fee_flag
       ,  rd.enable_services
    FROM xxrs.xxrs_sc_resource_def_tbl rd, apps.xxrs_sc_lookup_vw bt_lookup, inv.mtl_units_of_measure_tl uom
   WHERE rd.resource_billing_type_code = bt_lookup.lookup_code(+)
     AND bt_lookup.lookup_type(+) = 'XXRS_SC_RESOURCE_BILLING_TYPE'
     AND uom.uom_code = rd.unit_of_measure_code;