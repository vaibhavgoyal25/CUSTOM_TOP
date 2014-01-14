ALTER TABLE 
  /******************************************************************************************************************
  *                                                                                                                 *
  * NAME : XXRS_SC_ACC_RES_TBL_ALTER.sql                                                                            *
  *                                                                                                                 *
  * DESCRIPTION : Script to Add column to table XXRS_SC_ACCOUNT_RESOURCE_TBL.                                       *
  *                                                                                                                 *
  * AUTHOR       : Vaibhav                                                                                          *
  * DATE WRITTEN : 31-AUG-2013                                                                                      *
  *                                                                                                                 *
  * CHANGE CONTROL :                                                                                                *
  * Version#     | REF#             | WHO                | DATE              | REMARKS                              *
  *-----------------------------------------------------------------------------------------------------------------*
  * 1.0.0        | 130621-07223     | Vaibhav Goyal      | 31-AUG-2013       | Initial Creation.                    *
  *******************************************************************************************************************/
  /* $HEADER: XXRS_SC_ACC_RES_TBL_ALTER.sql 1.0.0 31-AUG-2013 5:00:00 PM VAIBHAV $ */
XXRS.XXRS_SC_ACCOUNT_RESOURCE_TBL ADD (PO_NUMBER VARCHAR2(50 BYTE));