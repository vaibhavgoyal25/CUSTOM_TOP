/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_AP_WKDY_EMP_EXP_SEQ.sql                                                                                 *
*                                                                                                                     *
* DESCRIPTION :                                                                                                       *
* Sequence to generate Unique Number for Employee Expense Records                                                     *
*                                                                                                                     *
* AUTHOR       : SUDHEER GUNTU                                                                                        *
* DATE WRITTEN : 29-DEC-11                                                                                            *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* Version#     |  TICKET          | WHO             |  DATE          |   REMARKS                                      *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  111122-02448    | SUDHEER GUNTU   |  29-DEC-11     |  Initial Build for R12 upgradation             *
**********************************************************************************************************************/

/* $Header: XXRS_AP_WKDY_EMP_EXP_SEQ.sql 1.0.0 29-DEC-11 10:14:52 AM SUDHEER GUNTU $ */

DROP SEQUENCE xxrs.xxrs_ap_wkdy_emp_exp_s;

CREATE SEQUENCE xxrs.xxrs_ap_wkdy_emp_exp_s
START WITH 1
INCREMENT BY 1
MINVALUE 1
NOCACHE 
NOORDER;

DROP SYNONYM apps.xxrs_ap_wkdy_emp_exp_s;

CREATE SYNONYM apps.xxrs_ap_wkdy_emp_exp_s FOR xxrs.xxrs_ap_wkdy_emp_exp_s;
/