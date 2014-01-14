/**************************************************************************************************
* Description  : Script to create the indexes per Oracle in order to increase performance of
*   Collcetions
* AUTHOR       : Bruce Martinez                                                                   *
* DATE WRITTEN : 02/04/13                                                                         *
*                                                                                                 *
* CHANGE CONTROL :                                                                                *
* Version# | Ticket #      |  WHO            | DATE       |   REMARKS                             *
*-------------------------------------------------------------------------------------------------*
* 1.0.0    |120801-08023   | Bruce Martinez  | Feb-2013   | Initial Creation                      *
***************************************************************************************************/
set serveroutput on;
set echo on ;
set time on ;
set timing on;

spool XXRS_IEX_XML_REQUEST_HISTORIES_N101_120801-08023.log

DROP   INDEX IEX.IEX_XML_REQUEST_HISTORIES_N101;
CREATE INDEX IEX.IEX_XML_REQUEST_HISTORIES_N101 on IEX_XML_REQUEST_HISTORIES(OBJECT_ID);
EXECUTE fnd_stats.gather_table_stats('IEX','IEX_XML_REQUEST_HISTORIES');

spool off
