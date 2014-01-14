/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_AR_TCA_API_INSERT_121211-08804.sql                                                                      *
*                                                                                                                     *
* DESCRIPTION :                                                                                                       *
* SR# 3-6571090651 error "TABLE ZX_PARTY_TAX_PROFILE NOT IN FND_OBJECTS TABLE" hz_classification_v2pub, Oracle        *
* provided data fix to insert this table so that it becomes available in LOV                                          *
*                                                                                                                     *
* AUTHOR       : Pavan Amirineni                                                                                      *
* DATE WRITTEN : 19-DEC-2012                                                                                          *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* SR#          |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                                     *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  121211-08804     | Pavan Amirineni |  19-DEC-2012   | Print Group Migration Script                  *
***********************************************************************************************************************/
/* $Header: XXRS_AR_TCA_API_INSERT_121211-08804.sql 1.0.0 19-DEC-2012 01:39:56 PM Pavan Amirineni $ */
col file_name   new_value   spool_file_name    noprint
SELECT 'XXRS_AR_TCA_API_INSERT_121211-08804_' ||TO_CHAR (SYSDATE, '_mmddyy_hhmiss')||'.log' file_name from dual ;
SPOOL &spool_file_name
INSERT INTO fnd_objects (OBJECT_ID,
                         OBJ_NAME,
                         APPLICATION_ID,
                         DATABASE_OBJECT_NAME,
                         PK1_COLUMN_NAME,
                         PK1_COLUMN_TYPE,
                         CREATED_BY,
                         CREATION_DATE,
                         LAST_UPDATED_BY,
                         LAST_UPDATE_DATE,
                         LAST_UPDATE_LOGIN
                        )
     VALUES (FND_OBJECTS_S.NEXTVAL,
             'ZX_PARTY_TAX_PROFILE',
             (SELECT APPLICATION_ID
                FROM fnd_application
               WHERE application_short_name = 'ZX'),
             'ZX_PARTY_TAX_PROFILE',
             'PARTY_TAX_PROFILE_ID',
             'INTEGER',
             -1,
             SYSDATE,
             -1,
             SYSDATE,
             -1);