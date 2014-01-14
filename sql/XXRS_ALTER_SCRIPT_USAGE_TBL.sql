ALTER TABLE 
  /******************************************************************************************************************
  *                                                                                                                 *
  * NAME : XXRS_SC_ACC_RES_TBL_ALTER.sql                                                                            *
  *                                                                                                                 *
  * DESCRIPTION : Script to PO_NUMBER column to table XXRS_SC_USAGE_DATA_TBL And XXRS_SC_USAGE_DATA_arch.           *
  *                                                                                                                 *
  * AUTHOR       : Pavan Amirineni                                                                                  *
  * DATE WRITTEN : 31-AUG-2013                                                                                      *
  *                                                                                                                 *
  * CHANGE CONTROL :                                                                                                *
  * Version#     | REF#             | WHO                | DATE              | REMARKS                              *
  *-----------------------------------------------------------------------------------------------------------------*
  * 1.0.0        | 130621-07223     | Pavan Amirineni    | 31-AUG-2013       | Initial Creation.                    *
  *******************************************************************************************************************/
  /* $HEADER: XXRS_SC_ACC_RES_TBL_ALTER.sql 1.0.0 31-AUG-2013 5:00:00 PM Pavan Amirineni $ */
XXRS.XXRS_SC_USAGE_DATA_TBL ADD (PO_NUMBER VARCHAR2(50));
ALTER TABLE XXRS.XXRS_SC_USAGE_DATA_arch ADD (PO_NUMBER VARCHAR2(50));
ALTER TABLE  XXRS.XXRS_SC_USAGE_DATA_PURG ADD(PO_NUMBER VARCHAR2(50));