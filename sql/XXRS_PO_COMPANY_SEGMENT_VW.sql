DROP VIEW APPS.XXRS_PO_COMPANY_SEGMENT_VW;
/***********************************************************************************************************
*                                                                                                          *
* NAME : XXRS_PO_COMPANY_SEGMENT_VW.sql                                                                    *
*                                                                                                          *
* DESCRIPTION : Rackspace Purchasing View to Pull Company Segment                                          *
*                                                                                                          *
* AUTHOR       : Kalyan                                                                                    *
* DATE WRITTEN : 23-DEC-2011                                                                               *
*                                                                                                          *
* CHANGE CONTROL :                                                                                         *
* Version#     | REF#             | WHO                | DATE              | REMARKS                       *
*--------------------------------------------------------------------------------------------------------  *
* 1.0.0        | 111122-02448     | Kalyan             | 23-DEC-2011       | Initial Build for R12 upgrade *
************************************************************************************************************/

/* $HEADER: XXRS_PO_COMPANY_SEGMENT_VW.sql 1.0.0 28-DEC-2011 9:25:00 AM Kalyan $ */

CREATE OR REPLACE FORCE VIEW apps.xxrs_po_company_segment_vw ( flex_value,
                                                               description,
                                                               org_id )
AS
    SELECT ffv.flex_value,
           ffvt.description,
           pda.org_id
      FROM applsys.fnd_flex_values ffv,
           applsys.fnd_flex_value_sets ffvs,
           applsys.fnd_flex_values_tl ffvt,
           po.po_distributions_all pda,
           gl.gl_code_combinations gcc
     WHERE ffv.flex_value_set_id = ffvs.flex_value_set_id
       AND ffv.flex_value_id = ffvt.flex_value_id
       AND gcc.code_combination_id = pda.code_combination_id
       AND gcc.segment1 = ffv.flex_value
       AND ffvs.flex_value_set_name = 'RS_COMPANY'
       AND ffvt.language = USERENV ( 'LANG' )
  GROUP BY ffv.flex_value, ffvt.description, pda.org_id;