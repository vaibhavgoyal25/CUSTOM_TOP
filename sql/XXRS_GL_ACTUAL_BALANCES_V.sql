/******************************************************************************************************
*                                                                                                     *
* NAME : XXRS_GL_ACTUAL_BALANCES_V.sql                                                                *
*                                                                                                     *
* DESCRIPTION :                                                                                       *
* Hyperion view to get the actual account balances with not including consolidated ledgers.           *
*                                                                                                     *
* AUTHOR       : Vinodh.Bhasker                                                                       *
* DATE WRITTEN : 12/22/2011                                                                           *
*                                                                                                     *
* CHANGE CONTROL :                                                                                    *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                     *
*-----------------------------------------------------------------------------------------------------*
* 1.0          |  111122-02448     | Vinodh.Bhasker  |  12/22/2011    | R12 Upgrade Project           *
*******************************************************************************************************/

/* $Header: XXRS_GL_ACTUAL_BALANCES_V.sql 1.0 12/22/2011 01:57:26 AM Vinodh.Bhasker $ */

CREATE OR REPLACE FORCE VIEW apps.xxrs_gl_actual_balances_v
(
  year
, period
, period_end_date
, entity
, account
, bu_dept
, amount
)
AS
    SELECT period_year
         , SUBSTR ( period_name
                  , 1
                  , 3
                   )
             period
         , CASE
             WHEN SUBSTR ( period_name
                         , 1
                         , 3
                          ) != 'ADJ'
             THEN
               LAST_DAY ( TO_DATE ( '01-' || period_name
                                  , 'DD-MON-RR'
                                   ) )
             ELSE
               NULL
           END
         , gcc.segment1 entity
         , gcc.segment3 account
         , gcc.segment5 || ':' || gcc.segment6 "BU_Dept"
         , SUM ( NVL ( period_net_cr, 0 ) - NVL ( period_net_dr, 0 ) ) amount
      FROM gl_balances gb
         , gl.gl_code_combinations gcc
         , gl.gl_ledgers gl
     WHERE 1 = 1
       AND gcc.chart_of_accounts_id = gl.chart_of_accounts_id --reporting only in the ledger associated chart of accounts
       AND gb.actual_flag = 'A'
       AND gb.ledger_id = gl.ledger_id
       AND gb.ledger_id NOT IN (2005, 3005, 3006, 1004) -- consolidated ledgers
       AND gb.currency_code = gl.currency_code --reporting only in functional currency
       AND gcc.template_id IS NULL
       AND NVL ( gb.translated_flag, 'X' ) IN ('Y', 'N', 'X')
       AND gcc.code_combination_id = gb.code_combination_id
       AND EXISTS (SELECT NULL
                     FROM gl_je_lines gjl
                        , gl_je_headers gjh
                    WHERE 1 = 1
                      AND gjh.je_header_id = gjl.je_header_id
                      AND gjh.je_category != 'Consolidation'
                      AND gjh.period_name = gb.period_name
                      AND gjl.period_name = gjh.period_name
                      AND gjl.code_combination_id = gb.code_combination_id
                      AND gjl.ledger_id = gb.ledger_id)
  GROUP BY period_year
         , period_name
         , period_num
         , gcc.segment1
         , gcc.segment3
         , gcc.segment5 || ':' || gcc.segment6
  ORDER BY period_year
         , period_num;
/