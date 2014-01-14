/********************************************************************************************************************
* NAME : XXRS_SC_INVOICE_WKST_INT_TBL.sql                                                                           *
*                                                                                                                   *
* DESCRIPTION :                                                                                                     *
*   Script to modify XXRS_SC_INVOICE_WKST_INT_TBL,XXRS_SC_INVOICE_WKST_ARCH andXXRS_SC_INVOICE_WKST_STG_TBL table   *
*                                                                                                                   *
* AUTHOR       : Mahesh Guddeti                                                                                    *
* DATE WRITTEN : 12-AUG-2013                                                                                        *
*                                                                                                                   *
* CHANGE CONTROL :                                                                                                  *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                                   *
*-------------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  130617-06898     | Mahesh guddeti  |  12-AUG-2013   | Initial Creation.                           *
********************************************************************************************************************/
--
/* $Header: XXRS_SC_INVOICE_WKST_INT_TBL.sql 1.0.0 12-AUG-2013 10:00:00 AM Mahesh Guddeti $ */

--ALTER TABLE xxrs.XXRS_SC_INVOICE_WKST_INT_TBL MODIFY description varchar2(240) ;

ALTER TABLE xxrs.XXRS_SC_INVOICE_WKST_INT_TBL ADD(file_name varchar2(240));


--ALTER TABLE XXRS.XXRS_SC_INVOICE_WKST_ARCH MODIFY (description varchar2(240));

ALTER TABLE XXRS.XXRS_SC_INVOICE_WKST_ARCH ADD (file_name varchar2(240));



--ALTER TABLE XXRS.XXRS_SC_INVOICE_WKST_STG_TBL MODIFY description varchar2(240) ;

ALTER TABLE XXRS.XXRS_SC_INVOICE_WKST_STG_TBL ADD (file_name varchar2(240));