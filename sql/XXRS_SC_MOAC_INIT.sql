  /**********************************************************************************************************************
  *                                                                                                                     *
  * NAME : XXRS_SC_MOAC_INIT.sql                                                                                        *
  *                                                                                                                     *
  * DESCRIPTION :                                                                                                       *
  * Initialize MOAC for Custom Service Contract Module.                                                                 *
  *                                                                                                                     *
  * AUTHOR       : Vinodh Bhasker                                                                                       *
  * DATE WRITTEN : 17-FEB-2012                                                                                          *
  *                                                                                                                     *
  * CHANGE CONTROL :                                                                                                    *
  * SR#          |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                                     *
  *---------------------------------------------------------------------------------------------------------------------*
  * 1.0          | 111122-02448      | Vinodh Bhasker  | 02/17/2012     | Initial Creation for R12                      *
  ***********************************************************************************************************************/

DECLARE
v_status   applsys.fnd_mo_product_init.status%TYPE;
BEGIN
  SELECT status
    INTO v_status
    FROM applsys.fnd_mo_product_init
   WHERE application_short_name = 'XXRS';
--
  IF (NVL(v_status, 'Y') <> 'N')
  THEN
    FND_MO_PRODUCT_INIT_PKG.register_application('XXRS','SEED','N');
  END IF;
EXCEPTION
  WHEN NO_DATA_FOUND
  THEN
    FND_MO_PRODUCT_INIT_PKG.register_application('XXRS','SEED','N');
END;
/