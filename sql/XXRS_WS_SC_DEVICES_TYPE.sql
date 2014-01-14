DROP TYPE xxrs.xxrs_ws_sc_devices_tbl;
DROP TYPE xxrs.xxrs_ws_sc_devices_type;

CREATE OR REPLACE TYPE XXRS.xxrs_ws_sc_devices_type AS OBJECT
/*********************************************************************************************************
*                                                                                                        *
* NAME : XXRS_WS_SC_DEVICES_TYPE.sql                                                                     *
*                                                                                                        *
* DESCRIPTION :                                                                                          *
* Type to hold device numbers for web service.                                                           *
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
/* $HEADER: XXRS_WS_SC_DEVICES_TYPE.sql 1.0.0 12/08/2011 10:00:00 AM Vaibhav Goyal $ */
(
  DEVICE_NUMBER VARCHAR2(40)
);
/
CREATE OR REPLACE TYPE xxrs.xxrs_ws_sc_devices_tbl AS TABLE OF xxrs.xxrs_ws_sc_devices_type;
/

