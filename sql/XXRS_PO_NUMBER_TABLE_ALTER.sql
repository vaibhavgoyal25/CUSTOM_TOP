/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_PO_NUMBER_TABLE_ALTER.sql                                                                               *
*                                                                                                                     *
* DESCRIPTION :                                                                                                       *
* Tables having incorrect attribute lengths and incorrect po number length                                            *
*                                                                                                                     *
* AUTHOR       : Rahul Boddireddy                                                                                     *
* DATE WRITTEN : 13-DEC-2013                                                                                          *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* Version#     |  TICKET          | WHO             |  DATE          |   REMARKS                                      *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  131209-05870    | RAHUL B         |  13-DEC-2013   |  Initial Build                                 *
**********************************************************************************************************************/

/* $Header: XXRS_PO_NUMBER_TABLE_ALTER.sql 1.0.0 13-DEC-2013 02:00:00 PM RAHUL B $ */

ALTER TABLE
   XXRS.XXRS_SC_RA_INTERFACE_DISTS_ALL
MODIFY
   (
   INTERFACE_LINE_ATTRIBUTE1        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE2        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE3        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE4        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE5        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE6        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE7        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE8        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE9        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE10       VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE11       VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE12       VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE13       VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE14       VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE15       VARCHAR2 (150 Byte)
   );

ALTER TABLE
   XXRS.XXRS_SC_RA_INTERFACE_LINES_ALL
MODIFY
   (
   INTERFACE_LINE_ATTRIBUTE1        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE2        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE3        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE4        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE5        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE6        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE7        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE8        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE9        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE10       VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE11       VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE12       VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE13       VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE14       VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE15       VARCHAR2 (150 Byte)
   );

ALTER TABLE
   XXRS.XXRS_SC_RILA_ARCH_SC_DATA_TBL
MODIFY
   (
   INTERFACE_LINE_ATTRIBUTE1        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE2        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE3        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE4        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE5        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE6        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE7        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE8        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE9        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE10       VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE11       VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE12       VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE13       VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE14       VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE15       VARCHAR2 (150 Byte)
   );

ALTER TABLE
   XXRS.XXRS_SC_RIDA_ARCH_SC_DATA_TBL
MODIFY
   (
   INTERFACE_LINE_ATTRIBUTE1        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE2        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE3        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE4        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE5        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE6        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE7        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE8        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE9        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE10       VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE11       VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE12       VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE13       VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE14       VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE15       VARCHAR2 (150 Byte)
   );

ALTER TABLE
    XXRS.XXRS_SC_BILLING_DATA_HST
MODIFY
    (
    PO_NUMBER                       VARCHAR2 (50 Byte)
    );
    
ALTER TABLE
    XXRS.XXRS_SC_CONTRACT_TBL
MODIFY
    (
    PO_NUMBER                       VARCHAR2 (50 Byte)
    );

ALTER TABLE
    XXRS.XXRS_SC_BILLING_DATA_TBL
MODIFY
    (
    PO_NUMBER                       VARCHAR2 (50 Byte)
    );

ALTER TABLE
    XXRS.XXRS_SC_ACCOUNT_PRODUCT_TBL
MODIFY
    (
    PO_NUMBER                       VARCHAR2 (50 Byte)
    );

ALTER TABLE
    XXRS.XXRS_SC_USAGE_VIEW_IM_TBL
MODIFY
    (
    PO_NUMBER                       VARCHAR2 (50 Byte)
    );

ALTER TABLE
    XXRS.XXRS_SC_CI_DEV_PROD_VW_TBL
MODIFY
    (
    PO_NUMBER                       VARCHAR2 (50 Byte)
    );

ALTER TABLE
    XXRS.XXRS_SC_CI_ACT_PROD_VW_TBL
MODIFY
    (
    PO_NUMBER                       VARCHAR2 (50 Byte)
    );

ALTER TABLE
   XXRS.XXRS_SC_RILA_ERR_PURGE_ARCHBKP
MODIFY
   (
   INTERFACE_LINE_ATTRIBUTE1        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE2        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE3        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE4        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE5        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE6        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE7        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE8        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE9        VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE10       VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE11       VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE12       VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE13       VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE14       VARCHAR2 (150 Byte),
   INTERFACE_LINE_ATTRIBUTE15       VARCHAR2 (150 Byte)
   );