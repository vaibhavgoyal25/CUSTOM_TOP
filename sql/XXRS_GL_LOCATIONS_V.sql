/******************************************************************************************************
*                                                                                                     *
* NAME : XXRS_GL_LOCATIONS_V.sql                                                                      *
*                                                                                                     *
* DESCRIPTION :                                                                                       *
* Hyperion view to get the location code combination segment meta-data                                *
*                                                                                                     *
* AUTHOR       : Vinodh.Bhasker                                                                       *
* DATE WRITTEN : 12/22/2011                                                                           *
*                                                                                                     *
* CHANGE CONTROL :                                                                                    *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                     *
*-----------------------------------------------------------------------------------------------------*
* 1.0          |  111122-02448     | Vinodh.Bhasker  |  12/22/2011    | R12 Upgrade Project           *
*******************************************************************************************************/

/* $Header: XXRS_GL_LOCATIONS_V.sql 1.0 12/22/2011 01:57:26 AM Vinodh.Bhasker $ */

CREATE OR REPLACE FORCE VIEW apps.xxrs_gl_locations_v
(
  child
, parent
, business_name
)
AS
  SELECT ffv2.flex_value "CHILD"
       , ffv1.flex_value "PARENT"
       , ffvt2.description "BUSINESS_NAME"
    FROM fnd_flex_values_tl ffvt2
       , fnd_flex_values ffv2
       , fnd_flex_value_hierarchies ffvh
       , fnd_flex_hierarchies_tl h
       , fnd_flex_values_tl ffvt1
       , fnd_flex_values ffv1
       , fnd_id_flex_segments fifs
   WHERE fifs.application_id = 101
     AND fifs.id_flex_code = 'GL#'
     AND fifs.id_flex_num = 101
     AND fifs.segment_num = 2
     AND fifs.enabled_flag = 'Y'
     AND ffv1.summary_flag = 'Y'
     AND ffv1.flex_value_set_id = fifs.flex_value_set_id + 0
     AND ffvt1.flex_value_id = ffv1.flex_value_id + 0
     AND h.flex_value_set_id(+) = ffv1.flex_value_set_id
     AND h.hierarchy_id(+) = ffv1.structured_hierarchy_level
     AND ffvh.flex_value_set_id = fifs.flex_value_set_id + 0
     AND ffvh.parent_flex_value = ffv1.flex_value
     AND ffv2.summary_flag = 'N'
     AND ffv2.flex_value_set_id + 0 = fifs.flex_value_set_id + 0
     AND ffv2.flex_value BETWEEN ffvh.child_flex_value_low
                             AND  ffvh.child_flex_value_high
     AND ffvt2.flex_value_id = ffv2.flex_value_id + 0
  UNION
  SELECT ffvtl.flex_value_meaning "CHILD"
       , 'OTHER' "PARENT"
       , ffvtl.description "BUSINESS_NAME"
    FROM apps.fnd_flex_value_sets ffvs
       , apps.fnd_flex_values ffv
       , apps.fnd_flex_values_tl ffvtl
   WHERE flex_value_set_name = 'RS_LOCATION'
     AND ffv.flex_value_id = ffvtl.flex_value_id
     AND ffv.flex_value_set_id = ffvs.flex_value_set_id
     AND ffv.summary_flag = 'N'
     AND ffv.flex_value NOT IN
             ( SELECT ffv2.flex_value
                 FROM fnd_flex_values_tl ffvt2
                    , fnd_flex_values ffv2
                    , fnd_flex_value_hierarchies ffvh
                    , fnd_flex_hierarchies_tl h
                    , fnd_flex_values_tl ffvt1
                    , fnd_flex_values ffv1
                    , fnd_id_flex_segments fifs
                WHERE fifs.application_id = 101
                  AND fifs.id_flex_code = 'GL#'
                  AND fifs.id_flex_num = 101
                  AND fifs.segment_num = 2
                  AND fifs.enabled_flag = 'Y'
                  AND ffv1.summary_flag = 'Y'
                  AND ffv1.flex_value_set_id = fifs.flex_value_set_id + 0
                  AND ffvt1.flex_value_id = ffv1.flex_value_id + 0
                  AND h.flex_value_set_id(+) = ffv1.flex_value_set_id
                  AND h.hierarchy_id(+) = ffv1.structured_hierarchy_level
                  AND ffvh.flex_value_set_id = fifs.flex_value_set_id + 0
                  AND ffvh.parent_flex_value = ffv1.flex_value
                  AND ffv2.summary_flag = 'N'
                  AND ffv2.flex_value_set_id + 0 = fifs.flex_value_set_id +
                                                   0
                  AND ffv2.flex_value BETWEEN ffvh.child_flex_value_low
                                          AND  ffvh.child_flex_value_high
                  AND ffvt2.flex_value_id = ffv2.flex_value_id + 0 )
  ORDER BY 2
         , 1;
/