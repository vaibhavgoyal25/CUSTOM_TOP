  /**********************************************************************************************************************
  *                                                                                                                     *
  * NAME : XXRS_SC_PRODUCT_RSRC_DEF_VW.sql                                                                              *
  *                                                                                                                     *
  * DESCRIPTION :                                                                                                       *
  * View used for defining the cross relationship between product and resource.                                         *
  *                                                                                                                     *
  * AUTHOR       : Vinodh Bhasker                                                                                       *
  * DATE WRITTEN : 17-FEB-2012                                                                                          *
  *                                                                                                                     *
  * CHANGE CONTROL :                                                                                                    *
  * SR#          |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                                     *
  *---------------------------------------------------------------------------------------------------------------------*
  * 1.0          | 111122-02448      | Vinodh Bhasker  | 02/17/2012     | Initial Creation for R12                      *
  ***********************************************************************************************************************/

CREATE OR REPLACE FORCE VIEW apps.xxrs_sc_product_rsrc_def_vw ( row_id
                                                              ,  product_resource_def_snid
                                                              ,  product_def_snid
                                                              ,  resource_def_snid
                                                              ,  creation_date
                                                              ,  created_by
                                                              ,  last_updated_by
                                                              ,  last_update_login
                                                              ,  last_update_date
                                                              ,  resource_name
                                                              ,  resource_type
                                                              ,  resource_billing_type_code
                                                              ,  resource_billing_type_meaning
                                                              ,  resource_billing_type_tag
                                                              ,  unit_of_measure_code
                                                              ,  unit_of_measure_meaning
                                                              ,  tiered_flag
                                                              ,  prepay_flag
                                                              ,  start_effectivity_date
                                                              ,  end_effectivity_date
                                                              ,  enable_services )
AS
  SELECT pr.ROWID
       ,  pr.product_resource_def_snid
       ,  pr.product_def_snid
       ,  pr.resource_def_snid
       ,  pr.creation_date
       ,  pr.created_by
       ,  pr.last_updated_by
       ,  pr.last_update_login
       ,  pr.last_update_date
       ,  rd.resource_name
       ,  rd.resource_type
       ,  rd.resource_billing_type_code
       ,  rd.resource_billing_type_meaning
       ,  rd.resource_billing_type_tag
       ,  rd.unit_of_measure_code
       ,  rd.unit_of_measure_meaning
       ,  rd.tiered_flag
       ,  rd.prepay_flag
       ,  rd.start_effectivity_date
       ,  rd.end_effectivity_date
       ,  rd.enable_services 
    FROM xxrs.xxrs_sc_product_rsrc_def_tbl pr, apps.xxrs_sc_resource_def_vw rd
   WHERE pr.resource_def_snid = rd.resource_def_snid;