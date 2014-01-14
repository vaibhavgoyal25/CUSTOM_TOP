UPDATE 
  /**************************************************************************************************
  *                                                                                                 *
  * NAME : XXRS_AP_INV_REJ_UPD.sql                                                                  *
  *                                                                                                 *
  * DESCRIPTION :                                                                                   *
  * Secript to update date_last_checked for an Alert                                                *
  *                                                                                                 *
  * AUTHOR       : VAIBHAV GOYAL                                                                    *
  * DATE WRITTEN : 05-JAN-2011                                                                      *
  *                                                                                                 *
  * CHANGE CONTROL :                                                                                *
  * SR#    VER        REF#           WHO            DATE            REMARKS                         *
  *  1     1.0.0   111122-02448   VAIBHAV GOYAL   01/05/2011     Initial Creation                   *
  ***************************************************************************************************/
alr_alerts
   SET date_last_checked      =
         ( SELECT MAX ( end_date )
             FROM applsys.wf_notifications
            WHERE message_name = 'XXRS_REJ_MSG' )
 WHERE alert_name = 'Rackspace Payables Invoice Rejection Alert';

COMMIT;