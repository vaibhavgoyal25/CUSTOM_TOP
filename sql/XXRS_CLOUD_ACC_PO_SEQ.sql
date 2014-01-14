drop SEQUENCE xxrs.xxrs_cloud_acc_po_seq;
  /******************************************************************************************************************
  *                                                                                                                 *
  * NAME : XXRS_CLOUD_ACC_PO_SEQ.sql                                                                                *
  *                                                                                                                 *
  * DESCRIPTION : Sequence to generate id's for Rackspace Cloud Accounts.                                           *
  *                                                                                                                 *
  * AUTHOR       : Vaibhav                                                                                          *
  * DATE WRITTEN : 31-AUG-2013                                                                                      *
  *                                                                                                                 *
  * CHANGE CONTROL :                                                                                                *
  * Version#     | REF#             | WHO                | DATE              | REMARKS                              *
  *-----------------------------------------------------------------------------------------------------------------*
  * 1.0.0        | 130621-07223     | Vaibhav Goyal      | 31-AUG-2013       | Initial Creation.                    *
  *******************************************************************************************************************/
  /* $HEADER: XXRS_CLOUD_ACC_PO_SEQ.sql 1.0.0 31-AUG-2013 5:00:00 PM VAIBHAV $ */
CREATE SEQUENCE xxrs.xxrs_cloud_acc_po_seq
START WITH 1
INCREMENT BY 1
MINVALUE 0
NOCACHE 
NOCYCLE 
NOORDER;

DROP SYNONYM apps.xxrs_cloud_acc_po_seq;

CREATE SYNONYM apps.xxrs_cloud_acc_po_seq FOR xxrs.xxrs_cloud_acc_po_seq;