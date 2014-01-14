-- /**********************************************************************************************************************
-- *                                                                                                                     *
-- * NAME : XXRS_AR_LOAD_LOCKBOX_DATA.ctl                                                                                *
-- *                                                                                                                     *
-- * DESCRIPTION :                                                                                                       *
-- * Control file to load all the records into XXRS.XXRS_AR_LOCKBOX_RECEIPTS                                             *
-- *                                                                                                                     *
-- * AUTHOR       : Sai Manohar                                                                                          *
-- * DATE WRITTEN : 29-DEC-2011                                                                                          *
-- *                                                                                                                     *
-- * CHANGE CONTROL :                                                                                                    *
-- * Ver#  | TICKET #     | WHO             | DATE        |   REMARKS                                                    *
-- *---------------------------------------------------------------------------------------------------------------------*
-- * 1.0.0 |111122-02448  | Sai Manohar     | 29-DEC-2011 | Initial Creation                                             *
-- ***********************************************************************************************************************/
OPTIONS (SKIP=1)
LOAD DATA
INFILE *
APPEND
INTO TABLE xxrs.xxrs_ar_lockbox_receipts
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(credit_date             "to_date(:credit_date,'MM/DD/RRRR')",
 process_date            "to_date(:process_date,'MM/DD/RRRR')",
 site                    "ltrim(rtrim(:site))",
 lockbox                 "ltrim(rtrim(:lockbox))",
 batch                   "ltrim(rtrim(:batch))",
 item                    "ltrim(rtrim(:item))",
 seq                     "ltrim(rtrim(:seq))",
 deposit_dda             "ltrim(rtrim(:deposit_dda))",
 remitter                "ltrim(rtrim(:remitter))",
 rt_number               "ltrim(rtrim(:rt_number))",
 dda                     "ltrim(rtrim(:dda))",
 payment_number          "ltrim(rtrim(:payment_number))",
 remit_date              "to_date(:remit_date,'MM/DD/RRRR')",
 type                    "ltrim(rtrim(:type))",
 currency                "ltrim(rtrim(:currency))",
 amount                  "ltrim(rtrim(round(:amount,2)))",
 invoice_number          "ltrim(rtrim(:invoice_number))",
 invoice_amount          "ltrim(rtrim(round(:invoice_amount,2)))",
 customer_number         "ltrim(rtrim(:customer_number))",
 conc_request_id         ":conc_request_id",
 created_by              ":created_by",
 process_status          constant "R",
 creation_date           sysdate,
 last_update_login       constant "-1",
 last_update_date        sysdate,
 last_updated_by         ":created_by",
 distribution_amount     "ltrim(rtrim(round(:invoice_amount,2)))",
 lbx_receipt_id          "xxrs_ar_lbx_receipt_id_seq.nextval"
)