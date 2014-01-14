CREATE OR REPLACE VIEW xxrs_iex_team_mapping_v
/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_IEX_TEAM_MAPPING_V.sql                                                                                  *
*                                                                                                                     *
* DESCRIPTION : View to group advanced collections teams                                                              *
*                                                                                                                     *
* AUTHOR       : Pavan Amirineni                                                                                      *
* DATE WRITTEN : 12/05/2011                                                                                           *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* Version#  | Ticket #      | WHO             |  DATE          |   REMARKS                                            *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0     | 111122-02448  | Pavan Amirineni | 12/05/2011     | Initial Creation                                     *
**********************************************************************************************************************/
/* $Header: XXRS_IEX_TEAM_MAPPING_V.sql 1.0.0 12/05/2011 15:00:00 Pavan Amirineni$ */
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
     AND s.flex_value_set_id =
           (SELECT flex_value_set_id
              FROM fnd_flex_value_sets vs
             WHERE vs.flex_value_set_name = 'RS_AR_SUPPORT_TEAMS')
     AND ( ( ( s.format_type = 'N' )
        AND ( fnd_number.canonical_to_number ( v.flex_value ) BETWEEN fnd_number.canonical_to_number (
                                                                                                       h.child_flex_value_low
                                                                      )
                                                                  AND fnd_number.canonical_to_number (
                                                                                                       h.child_flex_value_high
                                                                      ) ) )
       OR ( ( s.format_type NOT IN ('N') )
       AND ( v.flex_value BETWEEN h.child_flex_value_low
                              AND h.child_flex_value_high ) ) )
     AND ( ( v.summary_flag = 'Y'
        AND h.range_attribute = 'P' )
       OR ( v.summary_flag = 'N'
       AND h.range_attribute = 'C' ) );
/       