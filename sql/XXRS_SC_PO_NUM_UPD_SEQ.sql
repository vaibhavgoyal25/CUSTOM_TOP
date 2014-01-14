/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_SC_PO_NUM_UPD_SEQ.sql                                                                                   *
*                                                                                                                     *
* DESCRIPTION :                                                                                                       *
* Sequence to generate Unique Number for SC Po Number Update.                                                         *
*                                                                                                                     *
* AUTHOR       : VAIBHAV GOYAL                                                                                        *
* DATE WRITTEN : 03-SEP-2013                                                                                          *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* Version#     |  TICKET          | WHO             |  DATE          |   REMARKS                                      *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  130621-07223    | VAIBHAV GOYAL   |  03-SEP-2013   |  Initial Build                                 *
**********************************************************************************************************************/

/* $Header: XXRS_SC_PO_NUM_UPD_SEQ.sql 1.0.0 12-SEP-2012 02:00:00 PM VAIBHAV GOYAL $ */

DROP SEQUENCE xxrs.xxrs_sc_po_num_upd_seq;

CREATE SEQUENCE xxrs.xxrs_sc_po_num_upd_seq
START WITH 1
INCREMENT BY 1
MINVALUE 1
NOCACHE 
NOORDER;

DROP SYNONYM apps.xxrs_sc_po_num_upd_seq;

CREATE SYNONYM apps.xxrs_sc_po_num_upd_seq FOR xxrs.xxrs_sc_po_num_upd_seq;