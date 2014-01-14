-- +=================================================================================================+
-- | NAME : XXRSAPINVP.ctl                                                                           |
-- |                                                                                                 |
-- | DESCRIPTION :                                                                                   |
-- | Control file to load all the records into XXRS.XXRS_AP_CREATE_INVOICE                           |
-- |                                                                                                 |
-- | AUTHOR         : Padmaja                                                                        |
-- | DATE WRITTEN   : 02-JAN-2012                                                                    |
-- |                                                                                                 |
-- | CHANGE CONTROL :                                                                                |
-- | SR#    VER#          REF#              WHO                DATE                   REMARKS        |
-- |  1     1.0.0       111122-02448       Padmaja         02-JAN-2012          Control File Creation|
-- +=================================================================================================+
OPTIONS (SKIP=1)
LOAD DATA
REPLACE
INTO TABLE xxrs.xxrs_ap_create_invoice
FIELDS TERMINATED BY "|" OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(vendor_number,
 invoice_number        "decode(:vendor_number, null, null, :invoice_number)",
 invoice_date          "decode(:vendor_number, null, null, :invoice_date)",
 description           "decode(:vendor_number, null, null, :description)",
 amount                "decode(:vendor_number, null, null, :amount)",
 rs_company            "decode(:vendor_number, null, null, :rs_company)",
 rs_location           "decode(:vendor_number, null, null, :rs_location)",
 rs_account            "decode(:vendor_number, null, null, :rs_account)",
 rs_team               "decode(:vendor_number, null, null, :rs_team)",
 rs_business_units     "decode(:vendor_number, null, null, :rs_business_units)",
 rs_departments        "decode(:vendor_number, null, null, :rs_departments)",
 rs_product            "decode(:vendor_number, null, null, :rs_product)",
 rs_future1            "decode(:vendor_number, null, null, :rs_future1)",
 conc_request_id       "decode(:vendor_number, null, null, :conc_request_id)",
 created_by            "decode(:vendor_number, null, null, :created_by)",
 creation_date         "decode(:vendor_number, null, null, SYSDATE)",
 last_update_login     "decode(:vendor_number, null, null, -1)",
 last_update_date      "decode(:vendor_number, null, null, SYSDATE)",
 last_updated_by       "decode(:vendor_number, null, null, :created_by)" ,
 record_id             "xxrs_ap_invoice_rec_id_s.nextval"
)