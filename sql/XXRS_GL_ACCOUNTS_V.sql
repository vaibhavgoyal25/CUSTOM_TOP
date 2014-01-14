/******************************************************************************************************
*                                                                                                     *
* NAME : XXRS_GL_ACCOUNTS_V.sql                                                                       *
*                                                                                                     *
* DESCRIPTION :                                                                                       *
* Hyperion view to get the account code combination segment meta-data                                 *
*                                                                                                     *
* AUTHOR       : Vinodh.Bhasker                                                                       *
* DATE WRITTEN : 12/22/2011                                                                           *
*                                                                                                     *
* CHANGE CONTROL :                                                                                    *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                     *
*-----------------------------------------------------------------------------------------------------*
* 1.0          |  111122-02448     | Vinodh.Bhasker  |  12/22/2011    | R12 Upgrade Project           *
*******************************************************************************************************/

/* $Header: XXRS_GL_ACCOUNTS_V.sql 1.0 12/22/2011 01:57:26 AM Vinodh.Bhasker $ */

CREATE OR REPLACE FORCE VIEW apps.xxrs_gl_accounts_v
(
  parent
, parent_description
, child
, child_description
)
AS
  SELECT v_parent.flex_value "Parent"
       , t_parent.description "Parent Description"
       , v_child.flex_value "Child"
       , t_child.description "Child Description"
    FROM (     SELECT h_data.parent_flex_value
                    , h_data.flex_value
                    , h_data.flex_value_set_id
                 FROM xxrs_fnd_flex_value_children_v h_data
           START WITH h_data.parent_flex_value NOT IN
                          ( SELECT h_child.flex_value
                              FROM xxrs_fnd_flex_value_children_v h_child
                             WHERE h_child.flex_value_set_id =
                                     h_data.flex_value_set_id )
           CONNECT BY NOCYCLE PRIOR h_data.flex_value =
                                h_data.parent_flex_value ) h
       , fnd_flex_values_tl t_child
       , fnd_flex_values v_child
       , fnd_flex_values_tl t_parent
       , fnd_flex_values v_parent
   WHERE 1 = 1
     AND h.flex_value_set_id = v_child.flex_value_set_id
     AND h.flex_value_set_id = v_parent.flex_value_set_id
     AND h.flex_value = v_child.flex_value
     AND v_child.flex_value_id = t_child.flex_value_id
     AND t_child.language = USERENV ( 'LANG' )
     AND h.parent_flex_value = v_parent.flex_value
     AND v_parent.flex_value_id = t_parent.flex_value_id
     AND t_parent.language = USERENV ( 'LANG' );
/
