GRANT
  /*********************************************************************************************************
  *                                                                                                        *
  * NAME : XXRS_WS_AR_INVOICE_GEN_GRANT1.sql                                                               *
  *                                                                                                        *
  * DESCRIPTION :                                                                                          *
  * Script to Provide Grant on Table to hold Invoice PDF.                                                  *
  *                                                                                                        *
  * AUTHOR       : VAIBHAV GOYAL                                                                           *
  * DATE WRITTEN : 27-JAN-2012                                                                             *
  *                                                                                                        *
  * CHANGE CONTROL :                                                                                       *
  * VERSION#     |  RACKER TICKET #  | WHO             |  DATE          |   REMARKS                        *
  *--------------------------------------------------------------------------------------------------------*
  * 1.0.0        |  111122-02448     | VAIBHAV GOYAL   | 01/27/2012     | initial creation                 *
  **********************************************************************************************************/
  /* $Header: XXRS_WS_AR_INVOICE_GEN_GRANT1.sql 1.0.0 01/26/2012 10:00:00 AM Vaibhav Goyal $ */
ALL ON xxrs.xxrs_ar_invoice_documents TO apps;
GRANT SELECT ON xxrs.xxrs_ar_invoice_documents to xxrscore;