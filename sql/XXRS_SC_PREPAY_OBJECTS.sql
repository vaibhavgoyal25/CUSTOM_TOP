  /**********************************************************************************************************************
  *                                                                                                                     *
  * NAME : XXRS_SC_PREPAY_OBJECTS.sql                                                                                   *
  *                                                                                                                     *
  * DESCRIPTION :                                                                                                       *
  * Modify the table objects to create columns for storing prepay information.                                          *
  *                                                                                                                     *
  * AUTHOR       : Vinodh Bhasker                                                                                       *
  * DATE WRITTEN : 17-FEB-2012                                                                                          *
  *                                                                                                                     *
  * CHANGE CONTROL :                                                                                                    *
  * SR#          |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                                     *
  *---------------------------------------------------------------------------------------------------------------------*
  * 1.0          | 111122-02448      | Vinodh Bhasker  | 02/17/2012     | Initial Creation for R12                      *
  ***********************************************************************************************************************/

ALTER TABLE XXRS.XXRS_SC_DEVICE_RESOURCE_TBL ADD (PREPAY_START_DATE DATE);
ALTER TABLE XXRS.XXRS_SC_DEVICE_RESOURCE_TBL ADD (PREPAY_END_DATE DATE);
ALTER TABLE XXRS.XXRS_SC_ACCOUNT_RESOURCE_TBL ADD (PREPAY_START_DATE DATE);
ALTER TABLE XXRS.XXRS_SC_ACCOUNT_RESOURCE_TBL ADD (PREPAY_END_DATE DATE);

ALTER TABLE XXRS.XXRS_SC_DEVICE_PRODUCT_TBL ADD (FREE_TIME_FLAG VARCHAR2(1));
ALTER TABLE XXRS.XXRS_SC_PRODUCT_DEF_TBL ADD (DEFAULT_FLAG VARCHAR2(1));

ALTER TABLE XXRS.XXRS_SC_RESOURCE_DEF_TBL ADD (PREPAY_FLAG VARCHAR2(1));

UPDATE XXRS.XXRS_SC_RESOURCE_DEF_TBL
   SET prepay_flag = 'N';
   
UPDATE XXRS.XXRS_SC_RESOURCE_DEF_TBL
   SET prepay_flag = 'Y'
 WHERE UPPER(resource_name) like 'PREPAY%'