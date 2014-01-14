CREATE OR REPLACE FORCE VIEW apps.xxrs_gl_actual_balances_rec_v
/******************************************************************************************************
*                                                                                                     *
* NAME : XXRS_GL_ACTUAL_BALANCES_REC_V.sql                                                            *
*                                                                                                     *
* DESCRIPTION :                                                                                       *
* Hyperion view to get the actual account balances                                                    *
*                                                                                                     *
* AUTHOR       : Vinodh.Bhasker                                                                       *
* DATE WRITTEN : 12/22/2011                                                                           *
*                                                                                                     *
* CHANGE CONTROL :                                                                                    *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                     *
*-----------------------------------------------------------------------------------------------------*
* 1.0          |  111122-02448     | Vinodh.Bhasker  |  12/22/2011    | R12 Upgrade Project           *
*******************************************************************************************************/
/* $Header: XXRS_GL_ACTUAL_BALANCES_REC_V.sql 1.0 12/22/2011 01:57:26 AM Vinodh.Bhasker $ */
(
  year
, period
, period_end_date
, entity
, location
, account
, team  
, bu_dept
, product   
, currency_code
, translated_flag
, set_of_books_name
, set_of_books_id
, amount
, begin_balance
, end_balance
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
         , gcc.segment2 location    
         , gcc.segment3 account
         , gcc.segment4 team        
         , gcc.segment5 || ':' || gcc.segment6 "BU_Dept"
         , gcc.segment7 product     
         , gb.currency_code
         , gb.translated_flag
         , gl.name
         , gl.ledger_id
         , SUM ( NVL ( period_net_cr, 0 ) - NVL ( period_net_dr, 0 ) ) amount
         , SUM ( NVL ( begin_balance_cr, 0 ) - NVL ( begin_balance_dr, 0 ) )
         , SUM(NVL ( period_net_cr, 0 ) - NVL ( period_net_dr, 0 ) + NVL (
               begin_balance_cr
                                                                         ,0
                                                                          )
               - NVL ( begin_balance_dr
                     ,0
                      ))
      FROM gl_balances gb
         , gl.gl_code_combinations gcc
         , gl.gl_ledgers gl
     WHERE 1 = 1
       AND gcc.chart_of_accounts_id = gl.chart_of_accounts_id --reporting only in the chart of accounts associated to the ledger
       AND gb.actual_flag = 'A'
       AND gb.ledger_id = gl.ledger_id
       AND gcc.template_id IS NULL
       AND gcc.code_combination_id = gb.code_combination_id
  GROUP BY period_year
         , period_name
         , period_num
         , gcc.segment1
         , gcc.segment2         
         , gcc.segment3 
         , gcc.segment4         
         , gcc.segment5 || ':' || gcc.segment6
         , gcc.segment7         
         , gb.currency_code
         , translated_flag
         , gl.name
         , gl.ledger_id
  ORDER BY period_year
         , period_num;