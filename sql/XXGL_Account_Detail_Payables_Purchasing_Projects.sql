SELECT
/********************************************************************************************
*                                                                                           *
* NAME : XXGL_Account_Detail_Payables_Purchasing_Projects.sql                               *
*                                                                                           *
* DESCRIPTION : XXGL Account Detail Payables Purchasing Projects report                     *
*                                                                                           *
* AUTHOR       : Sudheer Guntu                                                              *
* DATE WRITTEN : 08-MAR-2012                                                                *
*                                                                                           *
* CHANGE CONTROL :                                                                          *
* Version# | Ticket #    | WHO             |   DATE       |   REMARKS                       *
*-------------------------------------------------------------------------------------------*
* 1.0.0   | 111122-02448 | Sudheer Guntu   | 08-MAR-2012  | Initial Creation                *
* 1.1.0   | 120518-07791 | Vinodh Bhasker  | 19-JUN-2012  | Added distinct to pull one      *
*         |              |                 |              | entry for GL JE Line            *
* 1.2.0   | 120803-04665 | Vinodh Bhasker  | 10-SEP-2012  | Added po_line_desc field        *
* 1.2.1   | 130611-03788 | Vaibhav Goyal   | 07-JUN-2013  | Pulling PO Details for Accruals *
*********************************************************************************************/
/* $Header: XXGL_Account_Detail_Payables_Purchasing_Projects.sql 1.2.1 07-JUN-2013 11:36:00AM Vaibhav Goyal $ */      
 distinct journal_line.je_header_id journal_entry_id   /* 120524-04698 added distinct */
     , journal_entry.name journal_entry_name
     , journal_line.code_combination_id 
     , journal_line.je_line_num journal_line_number 
     , journal_line.ledger_id /*set_of_books_id */
     , gll.name ledger_name /*set_of_books_name */
     , journal_entry.currency_code journal_currency_code
     , journal_entry.creation_date journal_creation_date
     , journal_entry.je_category category 
     , journal_entry.je_source source 
     , journal_entry.actual_flag balance_type 
     , journal_entry.description journal_entry_desc 
     , journal_entry.external_reference external_ref 
     , journal_line.code_combination_id account_id 
     , gcc.segment1 || '.' || gcc.segment2 || '.' || gcc.segment3 || '.' || gcc.segment4            || '.' || gcc.segment5 || '.' || gcc.segment6 || '.' || gcc.segment7 || '.' || gcc.segment8 account 
     , gcc.segment1 company 
     , gcc.segment2 loc 
     , gcc.segment3 acct 
     , ffvv.description account_description
     , gcc.segment4 team 
     , gcc.segment5 bu 
     , gcc.segment6 dept 
     , gcc.segment7 product 
     , gcc.segment8 future 
     , journal_line.period_name period_name 
     , journal_line.effective_date effective_date 
     , journal_line.entered_dr entered_dr 
     , journal_line.entered_cr entered_cr 
     , journal_line.accounted_dr converted_dr 
     , journal_line.accounted_cr converted_cr 
     , journal_line.description description 
     , journal_line.stat_amount stat_amount 
     , journal_line.subledger_doc_sequence_value subledger_document_number
     , CASE WHEN ((journal_entry.je_source = 'Purchasing') OR (journal_entry.je_source = 'Cost Management' AND journal_line.reference_1 = 'PO'))
            THEN apps.xxrs_disc_func_pkg.xxrspo_get_receipt_num_f(journal_line.reference_2,journal_line.reference_3)
            WHEN journal_entry.je_source = 'Payables'
            THEN apps.xxrs_disc_func_pkg.xxrsap_get_receipt_num_f(journal_line.reference_2, journal_line.reference_3)
            ELSE ''
       END receipt_num
     , CASE WHEN ((journal_entry.je_source = 'Purchasing') OR (journal_entry.je_source = 'Cost Management' AND journal_line.reference_1 = 'PO'))
            THEN apps.xxrs_disc_func_pkg.xxrspo_get_receipt_date_f(journal_line.reference_2,journal_line.reference_3)
            WHEN journal_entry.je_source = 'Payables'
            THEN apps.xxrs_disc_func_pkg.xxrsap_get_receipt_date_f(journal_line.reference_2, journal_line.reference_3)
            ELSE NULL
     END receipt_date
     /* 120803-04665 added the po_item_desc column */
     , CASE WHEN ((journal_entry.je_source = 'Purchasing') OR (journal_entry.je_source = 'Cost Management' AND journal_line.reference_1 = 'PO'))
            THEN apps.xxrs_disc_func_pkg.xxrspo_get_po_line_desc_f(journal_line.reference_2,journal_line.reference_3)
            WHEN journal_entry.je_source = 'Payables'
            THEN apps.xxrs_disc_func_pkg.xxrsap_get_po_line_desc_f(journal_line.reference_2, journal_line.reference_3)
            ELSE ''
     END po_item_desc
     , CASE WHEN journal_entry.je_source = 'Payables'
            THEN apps.xxrs_disc_func_pkg.xxrsap_get_po_number_f(journal_line.reference_2, journal_line.reference_3)
            ELSE ''
     END PO_NUM
     , CASE WHEN ((journal_entry.je_source = 'Purchasing') OR (journal_entry.je_source = 'Cost Management' AND journal_line.reference_1 = 'PO'))
            THEN apps.xxrs_disc_func_pkg.xxrspo_get_check_date_f(journal_line.reference_2, journal_line.reference_3)
            WHEN journal_entry.je_source = 'Payables'
            THEN apps.xxrs_disc_func_pkg.xxrsap_get_check_date_f(journal_line.reference_2)
            ELSE NULL
     END Check_date
     , CASE WHEN ((journal_entry.je_source = 'Purchasing') OR (journal_entry.je_source = 'Cost Management' AND journal_line.reference_1 = 'PO'))
            THEN apps.xxrs_disc_func_pkg.xxrspo_get_proj_number_f(journal_line.reference_2,journal_line.reference_3)
            WHEN journal_entry.je_source = 'Payables'
            THEN NVL((SELECT ppa1.segment1 proj_num
                        FROM apps.ap_invoices_all aia1
                           , apps.pa_projects_all ppa1
                       WHERE aia1.project_id = ppa1.project_id(+)
                         AND aia1.invoice_id = journal_line.reference_2), apps.xxrs_disc_func_pkg.xxrsap_get_proj_number_f(journal_line.reference_2,journal_line.code_combination_id, journal_line.reference_3))
            ELSE ''
     END project_num
     , (SELECT pv.vendor_name 
          FROM po.po_headers_all pha1
             , ap.ap_suppliers pv
         WHERE pha1.vendor_id = pv.vendor_id
           AND pha1.po_header_id = journal_line.reference_2
           AND ((journal_entry.je_source = 'Purchasing') 
                 OR (journal_entry.je_source = 'Cost Management' AND journal_line.reference_1 = 'PO'))) "Purchasing - Vendor"
     , (SELECT mc3.segment1 
          FROM po.po_distributions_all pda3
             , po.po_lines_all pla3
             , apps.mtl_categories mc3
         WHERE pda3.po_line_id = pla3.po_line_id
           AND pla3.category_id = mc3.category_id 
           AND ((journal_entry.je_source = 'Purchasing') 
                 OR (journal_entry.je_source = 'Cost Management' AND journal_line.reference_1 = 'PO'))
           AND pda3.po_header_id = journal_line.reference_2 
           AND gcc.segment3 = '149990' 
           AND pda3.po_distribution_id = journal_line.reference_3 ) item_category
     , CASE WHEN ((journal_entry.je_source = 'Purchasing') OR (journal_entry.je_source = 'Cost Management' AND journal_line.reference_1 = 'PO'))
            THEN ''
            WHEN (journal_entry.je_source = 'Project Accounting')
            THEN ''
            WHEN journal_entry.je_source = 'Payables'
            THEN journal_line.reference_1
            ELSE ''
     END "Payables - Vendor"
     , CASE WHEN ((journal_entry.je_source = 'Purchasing') OR (journal_entry.je_source = 'Cost Management' AND journal_line.reference_1 = 'PO'))
            THEN journal_line.reference_4
            WHEN (journal_entry.je_source = 'Project Accounting')
            THEN ''
            WHEN journal_entry.je_source = 'Payables'
            THEN ''
            ELSE ''
     END "Purchasing PO"
     , CASE WHEN ((journal_entry.je_source = 'Purchasing') OR (journal_entry.je_source = 'Cost Management' AND journal_line.reference_1 = 'PO'))
            THEN ''
            WHEN (journal_entry.je_source = 'Project Accounting')
            THEN ''
            WHEN journal_entry.je_source = 'Payables'
            THEN journal_line.reference_5
            ELSE ''
     END "Invoice No"
     , journal_line.reference_1 reference_1, journal_line.reference_2 reference_2, journal_line.reference_3 reference_3, journal_line.reference_4 reference_4 
     , journal_line.reference_5 reference_5, journal_line.reference_6 reference_6, journal_line.reference_7 reference_7, journal_line.reference_8 reference_8 
     , journal_line.reference_9 reference_9, journal_line.reference_10 reference_10 
     , journal_line.jgzz_recon_context_11i local_context_value 
     , journal_line.jgzz_recon_ref_11i local_recon_ref 
     , ffvv.description acct_description
     , journal_entry.status journal_status
  FROM gl.gl_ledgers gll
     , gl.gl_je_lines journal_line 
     , gl.gl_je_headers journal_entry 
     , gl.gl_code_combinations gcc 
     , apps.fnd_flex_values_vl ffvv
     , gl.gl_import_references gir
 WHERE journal_line.ledger_id = gll.ledger_id
   AND journal_line.je_header_id = journal_entry.je_header_id 
   AND journal_line.code_combination_id = gcc.code_combination_id
   AND gir.je_header_id(+)= journal_line.je_header_id
   AND gir.je_line_num(+) = journal_line.je_line_num
   AND ffvv.flex_value_set_id = '1009648'
   AND gcc.segment3 = ffvv.flex_value
   AND journal_entry.status = 'P' 
   AND journal_entry.je_category NOT IN 'Budget'
   AND NVL(gir.gl_sl_link_table, 'XXX') != 'XLAJEL'
UNION ALL
SELECT distinct journal_line.je_header_id journal_entry_id  /* 120524-04698 added distinct */
     , journal_entry.name journal_entry_name
     , journal_line.code_combination_id
     , journal_line.je_line_num journal_line_number
     , journal_line.ledger_id                                                                                                    /*set_of_books_id */
     , gll.name ledger_name                                                                                                    /*set_of_books_name */
     , journal_entry.currency_code journal_currency_code
     , journal_entry.creation_date journal_creation_date
     , journal_entry.je_category category
     , journal_entry.je_source source
     , journal_entry.actual_flag balance_type
     , journal_entry.description journal_entry_desc
     , journal_entry.external_reference external_ref
     , journal_line.code_combination_id account_id
     , gcc.segment1
       || '.'
       || gcc.segment2
       || '.'
       || gcc.segment3
       || '.'
       || gcc.segment4
       || '.'
       || gcc.segment5
       || '.'
       || gcc.segment6
       || '.'
       || gcc.segment7
       || '.'
       || gcc.segment8  account
     , gcc.segment1 company
     , gcc.segment2 loc
     , gcc.segment3 acct
     , ffvv.description account_description
     , gcc.segment4 team
     , gcc.segment5 bu
     , gcc.segment6 dept
     , gcc.segment7 product
     , gcc.segment8 future
     , journal_line.period_name period_name
     , journal_line.effective_date effective_date
     , journal_line.entered_dr entered_dr
     , journal_line.entered_cr entered_cr
     , journal_line.accounted_dr converted_dr
     , journal_line.accounted_cr converted_cr
     , journal_line.description description
     , journal_line.stat_amount stat_amount
     , journal_line.subledger_doc_sequence_value subledger_document_number
     , DECODE ( journal_entry.je_source
               , 'Cost Management', apps.xxrs_disc_func_pkg.xxrspo_get_receipt_num_xla_f (journal_entry.je_category, ent.source_id_int_1, ent.source_id_int_2) /*120803-04665 added source2*/
               , 'Payables', apps.xxrs_disc_func_pkg.xxrsap_get_receipt_num_xla_f ( journal_entry.je_category
                                                                               , journal_line.code_combination_id
                                                                               , xael.ae_header_id
                                                                               , xael.ae_line_num
                                                                               , ent.source_id_int_1 )
               , '' )
          receipt_num
     , DECODE ( journal_entry.je_source
               , 'Cost Management', apps.xxrs_disc_func_pkg.xxrspo_get_receipt_date_xla_f (journal_entry.je_category, ent.source_id_int_1, ent.source_id_int_2) /*120803-04665 added source2*/
               , 'Payables', apps.xxrs_disc_func_pkg.xxrsap_get_receipt_date_xla_f ( journal_entry.je_category
                                                                               , journal_line.code_combination_id
                                                                               , xael.ae_header_id
                                                                               , xael.ae_line_num
                                                                               , ent.source_id_int_1 )
               ,  '' )
          receipt_date
     /* 120803-04665 added the po_item_desc column */
     , DECODE ( journal_entry.je_source
               , 'Cost Management', apps.xxrs_disc_func_pkg.xxrspo_get_po_line_desc_xla_f (journal_entry.je_category, ent.source_id_int_2)
               , 'Payables', apps.xxrs_disc_func_pkg.xxrsap_get_po_line_desc_xla_f ( journal_entry.je_category
                                                                               , journal_line.code_combination_id
                                                                               , xael.ae_header_id
                                                                               , xael.ae_line_num
                                                                               , ent.source_id_int_1 )
               , '' )
       po_item_desc
     , CASE WHEN ((journal_entry.je_source = 'Cost Management' AND journal_entry.je_category IN ('Accrual', 'Receiving') /*130611-03788*/ AND NVL(ent.source_id_int_1, 0) > 0)) /*120803-04665 if there is a rcv txn*/
            THEN ( SELECT pha.segment1
                     FROM po.po_headers_all pha
                        , po.rcv_transactions rt
                    WHERE rt.transaction_id = ent.source_id_int_1
                      AND pha.po_header_id = rt.po_header_id )
            WHEN ((journal_entry.je_source = 'Cost Management' AND journal_entry.je_category IN ('Accrual', 'Receiving'))) /*130611-03788*//*120803-04665 query based on source2*/
            THEN ( SELECT pha.segment1
                     FROM po.rcv_accounting_events ra
                        , po.po_headers_all pha 
                    WHERE ra.accounting_event_id = ent.source_id_int_2
                      AND pha.po_header_id = ra.po_header_id ) 
            WHEN journal_entry.je_source = 'Payables'
            THEN apps.xxrs_disc_func_pkg.xxrsap_get_po_number_xla_f (journal_entry.je_category, journal_line.code_combination_id, xael.ae_header_id, xael.ae_line_num, ent.source_id_int_1)
            ELSE NULL
       END PO_NUM
     , CASE WHEN ((journal_entry.je_source = 'Purchasing') OR (journal_entry.je_source = 'Cost Management'))
            THEN apps.xxrs_disc_func_pkg.xxrspo_get_check_date_xla_f(journal_entry.je_category, ent.source_id_int_2) /*120803-04665 query based on source2*/
            WHEN journal_entry.je_source = 'Payables'
            THEN apps.xxrs_disc_func_pkg.xxrsap_get_check_date_xla_f(journal_entry.je_category, ent.source_id_int_1)
            ELSE NULL
     END Check_date 
     , CASE WHEN ((journal_entry.je_source = 'Purchasing') OR (journal_entry.je_source = 'Cost Management'))
            THEN apps.xxrs_disc_func_pkg.xxrspo_get_proj_number_xla_f(journal_entry.je_category, ent.source_id_int_2) /*120803-04665 query based on source2*/
            WHEN journal_entry.je_source = 'Payables'
            THEN NVL( apps.xxrs_disc_func_pkg.xxrsap_get_proj_num_inv_xla_f(journal_entry.je_category, ent.source_id_int_1), apps.xxrs_disc_func_pkg.xxrsap_get_proj_number_xla_f(journal_entry.je_category, xael.ae_header_id, journal_line.code_combination_id, xael.ae_line_num, ent.source_id_int_1))
            ELSE ''
     END project_num
     , ( SELECT pv.vendor_name /*120803-04665 query based on source2*/
           FROM po.po_headers_all pha1, ap.ap_suppliers pv, po.rcv_accounting_events ra
          WHERE pha1.vendor_id = pv.vendor_id AND pha1.po_header_id = ra.po_header_id AND ra.accounting_event_id = ent.source_id_int_2 AND journal_entry.je_source = 'Cost Management' AND journal_entry.je_category IN ('Accrual', 'Receiving') ) /*130611-03788*/
         "Purchasing - Vendor"
     , ( SELECT mc3.segment1 /*120803-04665 query based on source2*/
           FROM po.po_distributions_all pda3, po.po_lines_all pla3, apps.mtl_categories mc3, po.rcv_accounting_events ra
          WHERE pda3.po_line_id = pla3.po_line_id
            AND pla3.category_id = mc3.category_id
            AND journal_entry.je_source = 'Cost Management'
            AND journal_entry.je_category IN ('Accrual', 'Receiving') /*130611-03788*/
            AND pda3.po_header_id = ra.po_header_id
            AND ra.accounting_event_id = ent.source_id_int_2
            AND gcc.segment3 = '149990'
            AND pda3.po_distribution_id = ra.po_distribution_id )
          item_category
     , DECODE ( journal_entry.je_source,  'Payables', (SELECT pv.vendor_name
                                                         FROM ap.ap_suppliers pv
                                                        WHERE pv.vendor_id = xael.party_id
                                                          AND xael.party_type_code = 'S')
                                       ,  'Cost Management', ( '' ),  'Project Accounting', ( '' ),  '' )
          "Payables - Vendor"
     , DECODE ( journal_entry.je_source,  'Payables', ( '' ),  'Cost Management', ( SELECT pha.segment1 /*120803-04665 query based on source2*/
                                                                                      FROM po.po_headers_all pha
                                                                                         , po.rcv_accounting_events ra
                                                                                     WHERE ra.accounting_event_id = ent.source_id_int_2
                                                                                       AND pha.po_header_id = ra.po_header_id
                                                                                       AND journal_entry.je_category IN ('Accrual', 'Receiving') ) /*130611-03788*/
                                                            ,  'Project Accounting', ( '' ),  '' )
          "Purchasing PO"
     , CASE WHEN journal_entry.je_source = 'Payables'
            THEN SUBSTR(apps.xxrs_disc_func_pkg.xxrsap_get_inv_num_xla_f(journal_entry.je_category, ent.source_id_int_1), 1, 30)
            ELSE ''
       END  "Invoice No"
     , journal_line.reference_1 reference_1
     , journal_line.reference_2 reference_2
     , journal_line.reference_3 reference_3
     , journal_line.reference_4 reference_4
     , (SELECT hca.account_number
          FROM ar.hz_cust_accounts hca
         WHERE hca.cust_account_id = xael.party_id
           AND xael.party_type_code = 'C') reference_5
     , journal_line.reference_6 reference_6
     , journal_line.reference_7 reference_7
     , journal_line.reference_8 reference_8
     , journal_line.reference_9 reference_9
     , journal_line.reference_10 reference_10
     , journal_line.jgzz_recon_context_11i local_context_value
     , journal_line.jgzz_recon_ref_11i local_recon_ref
     , ffvv.description acct_description
     , journal_entry.status journal_status
  FROM gl.gl_ledgers gll
     , gl.gl_je_lines journal_line
     , gl.gl_je_headers journal_entry
     , gl.gl_code_combinations gcc
     , apps.fnd_flex_values_vl ffvv
     , gl.gl_import_references gir
     , xla.xla_ae_headers aeh
     , xla.xla_ae_lines xael
     , xla.xla_events xle
     , xla.xla_transaction_entities ent
 WHERE journal_line.ledger_id = gll.ledger_id
   AND journal_line.je_header_id = journal_entry.je_header_id
   AND journal_line.code_combination_id = gcc.code_combination_id
   AND ffvv.flex_value_set_id = '1009648'
   AND gcc.segment3 = ffvv.flex_value
   AND journal_entry.status = 'P'
   AND journal_entry.je_category NOT IN 'Budget'
   AND gir.je_header_id = journal_entry.je_header_id
   AND gir.je_line_num = journal_line.je_line_num
   AND gir.je_batch_id = journal_entry.je_batch_id
   AND gir.gl_sl_link_table = xael.gl_sl_link_table
   AND gir.gl_sl_link_id = xael.gl_sl_link_id
   AND journal_entry.je_from_sla_flag IN ('Y', 'U')
   AND xael.ae_header_id = aeh.ae_header_id
   AND xael.application_id = aeh.application_id
   AND xle.event_id = aeh.event_id
   AND xle.application_id = aeh.application_id
   AND ent.application_id = xle.application_id
   AND ent.entity_id = xle.entity_id
   AND gir.gl_sl_link_table = 'XLAJEL'

