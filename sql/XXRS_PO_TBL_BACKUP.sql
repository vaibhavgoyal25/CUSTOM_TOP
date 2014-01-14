/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_PO_TBL_BACKUP.sql                                                                                       *
*                                                                                                                     *
* DESCRIPTION :                                                                                                       *
* Script to create backup tables Before Applying datafix.                                                             *
*                                                                                                                     *
* AUTHOR       : VAIBHAV GOYAL                                                                                        *
* DATE WRITTEN : 11-JUN-2013                                                                                          *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* Version#     |  TICKET          | WHO             |  DATE          |   REMARKS                                      *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  130529-01648    | VAIBHAV GOYAL   |  11-JUN-2013   |  Initial Build                                 *
**********************************************************************************************************************/
/* $Header: XXRS_PO_TBL_BACKUP.sql 1.0.0 11-JUN-2013 02:00:00 PM VAIBHAV GOYAL $ */
CREATE TABLE xxrs.po_action_history_bkp AS SELECT * FROM  po_action_history; 

CREATE TABLE xxrs.po_manual_postings_temp_bkp AS SELECT * FROM po_manual_postings_temp;
 
CREATE TABLE xxrs.po_headers_all_bkp AS SELECT * FROM po_headers_all;
 
CREATE TABLE xxrs.po_distributions_all_bkp AS SELECT * FROM po_distributions_all;
 
CREATE TABLE xxrs.po_line_locations_all_bkp  AS SELECT * FROM po_line_locations_all; 
 
CREATE TABLE xxrs.po_req_distributions_all_bkp AS SELECT * FROM po_req_distributions_all;

CREATE TABLE xxrs.po_lines_all_bkp AS SELECT * FROM po_lines_all;
