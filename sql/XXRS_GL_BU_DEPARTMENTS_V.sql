/******************************************************************************************************
*                                                                                                     *
* NAME : XXRS_GL_BU_DEPARTMENTS_V.sql                                                                 *
*                                                                                                     *
* DESCRIPTION :                                                                                       *
* Hyperion view to get the BU Department code combination segment meta-data                           *
*                                                                                                     *
* AUTHOR       : Vinodh.Bhasker                                                                       *
* DATE WRITTEN : 12/22/2011                                                                           *
*                                                                                                     *
* CHANGE CONTROL :                                                                                    *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                     *
*-----------------------------------------------------------------------------------------------------*
* 1.0          |  111122-02448     | Vinodh.Bhasker  |  12/22/2011    | R12 Upgrade Project           *
*******************************************************************************************************/

/* $Header: XXRS_GL_BU_DEPARTMENTS_V.sql 1.0 12/22/2011 01:57:26 AM Vinodh.Bhasker $ */

CREATE OR REPLACE FORCE VIEW apps.xxrs_gl_bu_departments_v
(
  business_unit
, business_unit_name
, bu_dept
, department_name
)
AS
    SELECT ffv_bu.flex_value "Business Unit"
         , ffvt_bu.description "Business Unit Name"
         , ffv_bu.flex_value || ':' || ffv_dept.flex_value "BU:Dept"
         , ffv_bu.flex_value || ':' || ffv_dept.flex_value || ' ' ||
           ffvt_dept.description
             "Alias"
      FROM fnd_flex_values_tl ffvt_dept
         , fnd_flex_values ffv_dept
         , fnd_id_flex_segments fifs_dept
         , fnd_flex_values_tl ffvt_bu
         , fnd_flex_values ffv_bu
         , fnd_id_flex_segments fifs_bu
     WHERE 1 = 1
       AND fifs_bu.application_id = 101
       AND fifs_bu.id_flex_code = 'GL#'
       AND fifs_bu.id_flex_num = 101
       AND fifs_bu.segment_num = 5
       AND fifs_bu.enabled_flag = 'Y'
       AND ffv_bu.summary_flag = 'N'
       AND ffv_bu.flex_value_set_id = fifs_bu.flex_value_set_id
       AND ffvt_bu.flex_value_id = ffv_bu.flex_value_id
       AND ffvt_bu.language = USERENV ( 'LANG' )
       AND fifs_dept.application_id = 101
       AND fifs_dept.id_flex_code = 'GL#'
       AND fifs_dept.id_flex_num = 101
       AND fifs_dept.segment_num = 6
       AND fifs_dept.enabled_flag = 'Y'
       AND ffv_dept.summary_flag = 'N'
       AND ffv_dept.flex_value_set_id = fifs_dept.flex_value_set_id
       AND NVL ( ffv_dept.end_date_active, SYSDATE ) > TO_DATE ( '31-DEC-2007'
                                                               , 'DD-MON-YYYY'
                                                                ) -- added as invalid depts were displayed
       AND ffvt_dept.flex_value_id = ffv_dept.flex_value_id
       AND ffvt_dept.language = USERENV ( 'LANG' )
  GROUP BY ffv_bu.flex_value
         , ffv_dept.flex_value
         , ffvt_bu.description
         , ffvt_dept.description
  ORDER BY ffv_bu.flex_value
         , ffv_dept.flex_value;
/
