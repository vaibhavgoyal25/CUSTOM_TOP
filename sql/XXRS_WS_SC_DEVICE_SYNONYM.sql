DROP SYNONYM apps.xxrs_ws_sc_device_mrr_type;
DROP SYNONYM apps.xxrs_ws_sc_device_mrr_tbl;
DROP SYNONYM apps.xxrs_ws_sc_devices_type;
DROP SYNONYM apps.xxrs_ws_sc_devices_tbl;
CREATE 
/*********************************************************************************************************
*                                                                                                        *
* NAME : XXRS_WS_SC_DEVICE_SYNONYM.sql                                                                   *
*                                                                                                        *
* DESCRIPTION : Script to create Synonym for types holding Customer Device MRR.                          *
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
/* $Header: XXRS_WS_SC_DEVICE_SYNONYM.sql 1.0.0 12/08/2011 10:00:00 AM Vaibhav Goyal $ */
SYNONYM apps.xxrs_ws_sc_device_mrr_type FOR xxrs.xxrs_ws_sc_device_mrr_type;
CREATE SYNONYM apps.xxrs_ws_sc_device_mrr_tbl FOR xxrs.xxrs_ws_sc_device_mrr_tbl;
CREATE SYNONYM apps.xxrs_ws_sc_devices_tbl FOR xxrs.xxrs_ws_sc_devices_tbl;
CREATE SYNONYM apps.xxrs_ws_sc_devices_type FOR xxrs.xxrs_ws_sc_devices_type;


