/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_AR_LBX_SYNONYMS.sql                                                                                     *
*                                                                                                                     *
* DESCRIPTION :                                                                                                       *
* Script to create synonyms for Sequences                                             .                               *
*                                                                                                                     *
* AUTHOR       : Sai Manohar                                                                                          *
* DATE WRITTEN : 19-JAN-2012                                                                                          *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* VER #  |  TICKET #    | WHO             |  DATE       |  REMARKS                                                    *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0  | 111122-02448 | Sai Manohar     |  19-JAN-2012  | Initial built for R12 upgrade                             *
***********************************************************************************************************************/
/* $Header: XXRS_AR_LBX_SYNONYMS.sql 1.0.0 19-JAN-2012 10:00:00 AM Sai Manohar $ */
DROP SYNONYM apps.xxrs_ar_lbx_receipt_id_seq;
CREATE SYNONYM apps.xxrs_ar_lbx_receipt_id_seq FOR xxrs.xxrs_ar_lbx_receipt_id_seq;

DROP SYNONYM apps.xxrs_lbx_change_ref_id_seq;
CREATE SYNONYM apps.xxrs_lbx_change_ref_id_seq FOR xxrs.xxrs_lbx_change_ref_id_seq;
/

