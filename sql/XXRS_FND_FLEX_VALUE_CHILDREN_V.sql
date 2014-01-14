/******************************************************************************************************
*                                                                                                     *
* NAME : XXRS_FND_FLEX_VALUE_CHILDREN_V.sql                                                           *
*                                                                                                     *
* DESCRIPTION :                                                                                       *
* Suppliment view to get the flex field value for account related relationships                       *
*                                                                                                     *
* AUTHOR       : Vinodh.Bhasker                                                                       *
* DATE WRITTEN : 12/22/2011                                                                           *
*                                                                                                     *
* CHANGE CONTROL :                                                                                    *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                     *
*-----------------------------------------------------------------------------------------------------*
* 1.0          |  111122-02448     | Vinodh.Bhasker  |  12/22/2011    | R12 Upgrade Project           *
*******************************************************************************************************/

/* $Header: XXRS_FND_FLEX_VALUE_CHILDREN_V.sql 1.0 12/22/2011 01:57:26 AM Vinodh.Bhasker $ */

CREATE OR REPLACE FORCE VIEW apps.xxrs_fnd_flex_value_children_v
(
  flex_value_set_id
, parent_flex_value
, flex_value
, description
, summary_flag
)
AS
  SELECT v.flex_value_set_id
       , h.parent_flex_value
       , v.flex_value
       , v.description
       , v.summary_flag
    FROM fnd_flex_values_vl v
       , fnd_flex_value_norm_hierarchy h
       , fnd_flex_value_sets s
   WHERE h.flex_value_set_id = v.flex_value_set_id
     AND v.flex_value_set_id = s.flex_value_set_id
     AND s.flex_value_set_id = (SELECT acc_s.flex_value_set_id
                                  FROM fnd_id_flex_segments acc_s
                                 WHERE acc_s.application_id = 101
                                   AND acc_s.id_flex_code = 'GL#'
                                   AND acc_s.id_flex_num = 101
                                   AND acc_s.segment_num = 3
                                   AND acc_s.enabled_flag = 'Y')
     AND ( ( ( s.format_type = 'N' )
        AND ( fnd_number.canonical_to_number ( v.flex_value ) BETWEEN fnd_number.canonical_to_number(h.child_flex_value_low)
                                                                  AND  fnd_number.canonical_to_number(h.child_flex_value_high) ) )
       OR ( ( s.format_type NOT IN ('N') )
       AND ( v.flex_value BETWEEN h.child_flex_value_low
                              AND  h.child_flex_value_high ) ) )
     AND ( ( v.summary_flag = 'Y'
        AND h.range_attribute = 'P' )
       OR ( v.summary_flag = 'N'
       AND h.range_attribute = 'C' ) );
/