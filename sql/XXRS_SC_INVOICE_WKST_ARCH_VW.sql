/********************************************************************************************************************
* NAME : XXRS_SC_INVOICE_WKST_ARCH_VW.sql                                                                           *
*                                                                                                                   *
* DESCRIPTION :                                                                                                     *
*   View developed for Invocie worksheet archive form                                                               *
*                                                                                                                   *
* AUTHOR       : Kalyan                                                                                             *
* DATE WRITTEN : 04-MAR-2012                                                                                        *
*                                                                                                                   *
* CHANGE CONTROL :                                                                                                  *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                                   *
*-------------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  111122-02448     | Kalyan          |  04-MAR-2012   | Initial Creation                            *
* 1.0.1        |  130617-06898     | Mahesh guddeti  |  02-SEP-2013   | Added file_name.                            *
********************************************************************************************************************/
--
/* $Header: XXRS_SC_INVOICE_WKST_ARCH_VW.sql 1.0.1 02-SEP-2013 11:00:00 AM Mahesh Guddeti $ */

DROP VIEW APPS.XXRS_SC_INVOICE_WKST_ARCH_VW;

CREATE OR REPLACE FORCE VIEW APPS.XXRS_SC_INVOICE_WKST_ARCH_VW
(ROW_ID, CREATED_BY_USER, SITE_NUM, ADDRESS, STATUS_MEANING, 
 INVOICE_WKST_SNID, CUST_ACCOUNT_ID, CUST_ACCT_SITE_ID, SITE_USE_ID, CURRENCY_CODE, 
 PERIOD_DATE, ACCOUNT_NUMBER, DEVICE_NUM, PRODUCT_DEF_SNID, RESOURCE_DEF_SNID, 
 INVOICED_QTY, UOM_CODE, PREPAY_TERM, UNIT_SELLING_PRICE, EXTENDED_SELLING_PRICE, 
 DESCRIPTION, PO_NUMBER, BUSINESS_UNIT_ACCT_SEG, SUPPORT_TEAM_ACCT_SEG, CUSTOMER_NAME, 
 BUSINESS_UNIT, SUPPORT_TEAM, PRODUCT_NAME, RESOURCE_NAME, ORG_ID, 
 LOCATION_CODE, LOCATION_MEANING, STATUS_CODE, PROCESS_STATUS, PROCESS_DATE, 
 CONC_REQ_ID, CREATION_DATE, CREATED_BY, LAST_UPDATED_BY, LAST_UPDATE_LOGIN, 
 LAST_UPDATE_DATE, SERVICE_ID, SERVICE_NAME, TRX_TYPE, INVOICE_NUMBER, 
 INV_LINE_NUM, CUSTOMER_TRX_LINE_ID, MEMO_LINE_ID,file_name)
AS 
SELECT iw.ROWID row_id
       , usr.user_name created_by_user
       , party_site.party_site_number site_num
       , cus.address1 || DECODE ( cus.address1, NULL, '', ', ' ) || cus.
         address2 || DECODE ( cus.address2, NULL, '', ', ' ) || cus.city ||
         DECODE (
         cus.city,
         NULL, '',
         ', '
                                                                           )
         || cus.state || DECODE ( cus.state, NULL, '', ', ' ) || cus.country
         || '-' || cus.postal_code
           address
       , flv.meaning status_meaning
       , iw.invoice_wkst_snid
       , iw.cust_account_id
       , iw.cust_acct_site_id
       , iw.site_use_id
       , iw.currency_code
       , iw.period_date
       , iw.account_number
       , iw.device_num
       , iw.product_def_snid
       , iw.resource_def_snid
       , iw.invoiced_qty
       , iw.uom_code
       , iw.prepay_term
       , iw.unit_selling_price
       , iw.extended_selling_price
       , iw.description
       , iw.po_number
       , iw.business_unit_acct_seg
       , iw.support_team_acct_seg
       , iw.customer_name
       , iw.business_unit
       , iw.support_team
       , iw.product_name
       , iw.resource_name
       , iw.org_id
       , iw.location_code
       , iw.location_meaning
       , iw.status_code
       , iw.process_status
       , iw.process_date
       , iw.conc_req_id
       , iw.creation_date
       , iw.created_by
       , iw.last_updated_by
       , iw.last_update_login
       , iw.last_update_date
       , iw.service_id                                      -- LY 110223-01761
       , iw.service_name                                    -- LY 110223-01761
       , iw.trx_type                                        -- LY 110223-01761
       , iw.invoice_number                                  -- LY 110223-01761
       , iw.inv_line_num                                    -- LY 110223-01761
       , iw.customer_trx_line_id                            -- LY 110223-01761
       , iw.memo_line_id                                    -- LY 110223-01761
       , iw.file_name  --Mahesh guddeti  -- 130617-06898  
    FROM xxrs_sc_invoice_wkst_arch iw
       , xxrs_sc_cust_bill_to_sites_vw cus
       , hz_party_sites party_site
       , fnd_user usr
       , fnd_lookup_values flv
       , fnd_lookup_types flt
   WHERE party_site.party_site_id = cus.party_site_id
     AND cus.cust_acct_site_id = iw.cust_acct_site_id
     AND iw.last_updated_by = usr.user_id(+)
     AND flt.lookup_type = 'XXRS_SC_CUSTOM_INVOICE_STATUS'
     AND flt.lookup_type = flv.lookup_type
     AND flv.lookup_code = iw.status_code
     AND flv.source_lang = USERENV ( 'LANG' )
     AND flt.view_application_id = flt.application_id
     AND flv.view_application_id = flt.application_id
     AND NVL ( iw.org_id
             , NVL ( TO_NUMBER ( DECODE ( SUBSTRB ( USERENV ( 'CLIENT_INFO' )
                                                  , 1
                                                  , 1
                                                   ),
                                          ' ', NULL,
                                          SUBSTRB ( USERENV ( 'CLIENT_INFO' )
                                                  , 1
                                                  , 10
                                                   )
                                         ) )
                   , -99
                    )
              ) =
           NVL ( TO_NUMBER ( DECODE ( SUBSTRB ( USERENV ( 'CLIENT_INFO' )
                                              , 1
                                              , 1
                                               ),
                                      ' ', NULL,
                                      SUBSTRB ( USERENV ( 'CLIENT_INFO' )
                                              , 1
                                              , 10
                                               )
                                     ) )
               , -99
                );


AUDIT GRANT ON APPS.XXRS_SC_INVOICE_WKST_ARCH_VW BY SESSION WHENEVER SUCCESSFUL;

AUDIT GRANT ON APPS.XXRS_SC_INVOICE_WKST_ARCH_VW BY SESSION WHENEVER NOT SUCCESSFUL;
