GRANT
  /*********************************************************************************************************
  *                                                                                                        *
  * NAME : XXRS_WS_GL_DETAILS_GRANT2.sql                                                                   *
  *                                                                                                        *
  * DESCRIPTION :                                                                                          *
  * Script to Provide Grant on Package to report Currency Conversion Details.                              *
  *                                                                                                        *
  * AUTHOR       : VAIBHAV GOYAL                                                                           *
  * DATE WRITTEN : 14-NOV-2011                                                                             *
  *                                                                                                        *
  * CHANGE CONTROL :                                                                                       *
  * VERSION#     |  RACKER TICKET #  | WHO             |  DATE          |   REMARKS                        *
  *--------------------------------------------------------------------------------------------------------*
  * 1.0.0        |  111122-02448     | VAIBHAV GOYAL   | 11/14/2011     | initial creation for R12         *
  **********************************************************************************************************/
  /* $Header: XXRS_WS_GL_DETAILS_GRANT2.sql 1.0.0 11/14/2011 10:00:00 AM Vaibhav Goyal $ */
EXECUTE ON apps.XXRS_WS_GL_DETAILS_PKG to xxrscore;