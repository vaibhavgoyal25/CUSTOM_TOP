/**********************************************************************************************************************
*                                                                                                                     *
* NAME : XXRS_CREATE_INV_OBJECTS.sql                                                                                  *
*                                                                                                                     *
* DESCRIPTION :                                                                                                       *
* The creates the required DB objects for the inventory simplification process.                                       *
*                                                                                                                     *
* AUTHOR       : Vinodh.Bhasker                                                                                       *
* DATE WRITTEN : 12/14/2011                                                                                           *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                                     *
*---------------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  111122-02448     | Vinodh.Bhasker  |  12/14/2011    | Initial Creation                              *
***********************************************************************************************************************/

CREATE SYNONYM xxrs_inv_standard_configs FOR xxrs.xxrs_inv_standard_configs;

CREATE SYNONYM xxrs_inv_config_details FOR xxrs.xxrs_inv_config_details;

CREATE SYNONYM xxrs_inv_standard_configs_s FOR xxrs.xxrs_inv_standard_configs_s;

CREATE SYNONYM xxrs_inv_config_details_s FOR xxrs.xxrs_inv_config_details_s;