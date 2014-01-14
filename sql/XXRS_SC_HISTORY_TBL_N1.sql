/*****************************************************************************************************************
*                                                                                                                *
* NAME : XXRS_SC_HISTORY_TBL_N1.sql                                                                              *
*                                                                                                                *
* DESCRIPTION    : Rackspace pre-payments report                                                                 *
* AUTHOR         : Mahesh Guddeti                                                                                *
* DATE WRITTEN   : 29-Jul-2013                                                                                   *
*                                                                                                                *
* CHANGE CONTROL :                                                                                               *
*  Version#  |  Ticket #     | WHO              | DATE        |   REMARKS                                        *
*  1.0.0     | 130612-11626  | Mahesh Guddeti   | 29-JUL-2013 | Performance Issue Fix                            *
******************************************************************************************************************/
/* $Header: XXRS_SC_HISTORY_TBL_N1.sql 1.0.0 29-JUL-2013 17:00:00 PM Mahesh Guddeti $ */
DROP INDEX XXRS.XXRS_SC_HISTORY_TBL_N1 ;

CREATE INDEX XXRS.XXRS_SC_HISTORY_TBL_N1 
ON XXRS.XXRS_SC_HISTORY_TBL(product_snid);