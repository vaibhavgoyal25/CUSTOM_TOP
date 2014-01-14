/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_ALTER_TEAM_AM_UPD_TBL.sql                                                                               *
*                                                                                                                     *
* DESCRIPTION : Alter table for 'Rackspace Mass Team BU AM Update' program                                            *
*                                                                                                                     *
* AUTHOR       : Pavan Amirineni                                                                                      *
* DATE WRITTEN : 15-MAR-2013                                                                                          *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* VER #  |  TICKET #    | WHO             |  DATE         |  REMARKS                                                  *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0  | 120912-03180 | Pavan Amirineni |  15-MAR-2013  | Initial built for R12 upgrade                             * 
***********************************************************************************************************************/
-- /* $Header: XXRS_ALTER_TEAM_AM_UPD_TBL.sql 1.0.0 15-MAR-2013 15:00:00 Pavan Amirineni$ */

ALTER TABLE xxrs.xxrs_ar_team_am_upd RENAME COLUMN location_id to bu_segment;

ALTER TABLE xxrs.xxrs_ar_team_am_upd MODIFY(bu_segment VARCHAR2(150));

ALTER TABLE xxrs.xxrs_ar_team_am_upd RENAME COLUMN site_use_id TO team_segment;

ALTER TABLE xxrs.xxrs_ar_team_am_upd MODIFY( team_segment VARCHAR2(150));
/

 