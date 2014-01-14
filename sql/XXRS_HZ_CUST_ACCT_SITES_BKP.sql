CREATE
/**************************************************************************************************
*                                                                                                 *
* NAME : XXRS_HZ_CUST_ACCT_SITES_BKP.sql                                                          *
*                                                                                                 *
* DESCRIPTION :                                                                                   *
* Script To Backup the hz_cust_acct_sites_all Table.                                              *
*                                                                                                 *
* AUTHOR       : Vaibhav Goyal                                                                    *
*                                                                                                 *
* CHANGE CONTROL :                                                                                *
* VER #  |  TICKET #    | WHO             |  DATE         |  REMARKS                              *
*-------------------------------------------------------------------------------------------------*
* 1.0.0  | 130514-01651 | Vaibhav Goyal   |  15-MAY-2013  | Initial Creation                      *
**************************************************************************************************/
/* $Header: IEX_F_STRATEGY_VIEWS.sql 1.0.0 15-MAY-2013 10:00:00 AM Vaibhav Goyal $ */
TABLE xxrs.xxrs_hz_cust_acct_sites_bkp as select * from hz_cust_acct_sites_all;