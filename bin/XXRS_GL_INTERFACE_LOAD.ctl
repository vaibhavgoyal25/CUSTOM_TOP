-- /**********************************************************************************************************************
-- *                                                                                                                     *
-- * NAME : XXRS_GL_INTERFACE_LOAD.ctl                                                                                   *
-- *                                                                                                                     *
-- * DESCRIPTION :                                                                                                       *
-- * Load data into the GL interface table.                                                                              *
-- *                                                                                                                     *
-- * AUTHOR       : Padmaja P                                                                                            *
-- * DATE WRITTEN : 12/20/2011                                                                                           *
-- *                                                                                                                     *
-- * CHANGE CONTROL :                                                                                                    *
-- * Version#     |  Ticket Number     | WHO             |  DATE          |   REMARKS                                    *
-- *---------------------------------------------------------------------------------------------------------------------*
-- * 1.0.0        |  111122-02448      | Padmaja P       |  12/20/2011        | Initial Creation                         *
-- ***********************************************************************************************************************/
OPTIONS (SKIP=0)
LOAD DATA
APPEND
INTO TABLE gl.gl_interface
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
( user_je_category_name "TRIM(:user_je_category_name)",
  user_je_source_name   "NVL(TRIM(:user_je_source_name),'Workday')",
  accounting_date       "TO_DATE(NVL(:accounting_date,TO_CHAR(SYSDATE,'DD-MON-RR')), 'DD-MON-RR')",
  reference10           "TRIM(substr(:reference10,1,240))",
  currency_code         "TRIM(:currency_code)",
  segment1              "TRIM(:segment1)",
  segment2              "TRIM(:segment2)",
  segment3              "TRIM(:segment3)",
  segment4              "TRIM(:segment4)",
  segment5              "TRIM(:segment5)",
  segment6              "TRIM(:segment6)",
  segment7              "TRIM(:segment7)",
  segment8              "NVL(TRIM(:segment8),'0000')",
  entered_dr            "DECODE(TRIM(:entered_dr),0,NULL,TRIM(:entered_dr))",
  entered_cr            "DECODE(TRIM(:entered_cr),0,NULL,TRIM(:entered_cr))", 
  group_id              "TRIM(:group_id)",
  request_id            "TRIM(:request_id)",
  created_by            "TRIM(:created_by)",
  reference1            "TRIM(:reference1)",
  reference2            "TRIM(NVL(TRIM(:user_je_source_name),'Workday')||'-'||TRIM(:user_je_category_name))",
  status                CONSTANT "NEW",
  actual_flag           CONSTANT "A",
  ledger_id             "xxrs_gl_interface_pkg.get_sob_id(:segment1)",
  date_created          SYSDATE
)
