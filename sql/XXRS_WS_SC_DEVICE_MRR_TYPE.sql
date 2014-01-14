DROP TYPE xxrs.xxrs_ws_sc_device_mrr_tbl;
DROP TYPE xxrs.xxrs_ws_sc_device_mrr_type;

CREATE OR REPLACE TYPE XXRS.xxrs_ws_sc_device_mrr_type AS OBJECT
/*********************************************************************************************************
*                                                                                                        *
* NAME : XXRS_WS_SC_DEVICE_MRR_TYPE.sql                                                                  *
*                                                                                                        *
* DESCRIPTION :                                                                                          *
* Type to provide device MRR details to web service.                                                     *
*                                                                                                        *
* AUTHOR       : Vaibhav Goyal                                                                           *
* DATE WRITTEN : 08-DEC-2011                                                                             *
*                                                                                                        *
* CHANGE CONTROL :                                                                                       *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                        *
*--------------------------------------------------------------------------------------------------------*
* 1.0.0        |   111122-02448    | Vaibhav Goyal   | 12/08/2011     | Initial Creation                 *
*                                                                                                        *
**********************************************************************************************************/
/* $HEADER: XXRS_WS_SC_DEVICE_MRR_TYPE.sql 1.0.0 12/08/2011 10:00:00 AM Vaibhav Goyal $ */
  ( invoice_number    VARCHAR2(20)
  , device_number     VARCHAR2(40)
  , unit_of_measure   VARCHAR2(25)
  , quantity          NUMBER
  , org_id            NUMBER
  , currency_code     VARCHAR2(3)
  , extended_amount   NUMBER
  , prepay_flag       VARCHAR2(1)
  , prepay_period     VARCHAR2(150)
  , prepay_term       NUMBER
  );
/
CREATE OR REPLACE TYPE xxrs.xxrs_ws_sc_device_mrr_tbl AS TABLE OF xxrs.xxrs_ws_sc_device_mrr_type;
/

