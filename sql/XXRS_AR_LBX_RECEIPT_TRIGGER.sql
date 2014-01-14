CREATE OR REPLACE TRIGGER apps.xxrs_ar_lbx_receipt_trigger
/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_AR_LBX_RECEIPT_TRIGGER.sql                                                                              *
*                                                                                                                     *
* DESCRIPTION :                                                                                                       *
* Trigger to Trap Changes on Columns of XXRS_AR_LBX_RECEIPT Table.                                                    *
*                                                                                                                     *
* AUTHOR       : Sai Manohar                                                                                          *
* DATE WRITTEN : 29-DEC-2011                                                                                          *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* VER #  |  TICKET #    | WHO             |  DATE       |  REMARKS                                                    *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0  | 111122-02448 | Sai Manohar     |  29-DEC-2011  | Initial built for R12 upgrade                             *
***********************************************************************************************************************/
/* $Header: XXRS_AR_LBX_RECEIPT_TRIGGER.sql 1.0.0 29-DEC-2011 10:00:00 AM Sai Manohar $ */
AFTER UPDATE OR DELETE
   ON xxrs.xxrs_ar_lockbox_receipts
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
DECLARE
   l_sysdate             DATE := SYSDATE;
   l_change              VARCHAR2 (1000) := NULL;
   l_lbx_change_ref_id   NUMBER := NULL;
   l_change_by           NUMBER;
BEGIN
   SELECT apps.fnd_profile.VALUE ('USER_ID')
     INTO l_change_by
     FROM DUAL;

   l_change := NULL;

   IF    NVL (:OLD.payment_number, 0) <> NVL (:NEW.payment_number, 0)
      OR NVL (:OLD.invoice_number, 0) <> NVL (:NEW.invoice_number, 0)
      OR NVL (:OLD.customer_number, 0) <> NVL (:NEW.customer_number, 0)
      OR NVL (:OLD.distribution_amount, 0) <> NVL (:NEW.distribution_amount, 0) THEN
      
      IF NVL (:OLD.payment_number, 0) <> NVL (:NEW.payment_number, 0) THEN
         IF l_change IS NULL THEN
            l_change := 'Check Number Change';
         ELSE
            l_change := l_change || ':Check Number Change';
         END IF;
      END IF;

      IF NVL (:OLD.invoice_number, 0) <> NVL (:NEW.invoice_number, 0) THEN
         IF l_change IS NULL THEN
            l_change := 'Invoice Number Change';
         ELSE
            l_change := l_change || ':Invoice Number Change';
         END IF;
      END IF;

      IF NVL (:OLD.customer_number, 0) <> NVL (:NEW.customer_number, 0) THEN
         IF l_change IS NULL THEN
            l_change := 'Customer Number Change';
         ELSE
            l_change := l_change || ':Customer Number Change';
         END IF;
      END IF;

      IF NVL (:OLD.distribution_amount, 0) <> NVL (:NEW.distribution_amount, 0) THEN
         IF l_change IS NULL THEN
            l_change := 'Distribution Amount Change';
         ELSE
            l_change := l_change || ':Distribution Amount Change';
         END IF;
      END IF;

      SELECT xxrs.xxrs_lbx_change_ref_id_seq.NEXTVAL
        INTO l_lbx_change_ref_id
        FROM DUAL;

      INSERT INTO xxrs.xxrs_ar_lockbox_receipts_track(  lbx_change_ref_id
      							,lbx_receipt_id
						   	,old_payment_number 
						   	,new_payment_number
						   	,old_invoice_number 
						   	,new_invoice_number
						   	,old_customer_number 
						   	,new_customer_number
						   	,old_distribution_amount
						   	,new_distribution_amount
						   	,change_description
						   	,creation_date
						   	,created_by
						   	,last_update_date
						   	,last_updated_by
						   	,last_update_login
						   	,batch_number
						     )
					      VALUES (	l_lbx_change_ref_id
					      		,:OLD.lbx_receipt_id
						   	,:OLD.payment_number 
						   	,:NEW.payment_number
						   	,:OLD.invoice_number 
						   	,:NEW.invoice_number
						   	,:OLD.customer_number 
						   	,:NEW.customer_number
						   	,:OLD.distribution_amount
						   	,:NEW.distribution_amount
						   	,l_change
						   	,SYSDATE
						   	,NVL (apps.fnd_profile.VALUE ('USER_ID'), -1)
						   	,SYSDATE
						   	,NVL (apps.fnd_profile.VALUE ('USER_ID'), -1)
						   	,NVL (apps.fnd_profile.VALUE ('USER_ID'), -1)
						   	,:OLD.batch_number
						      );
   END IF;
END;
/