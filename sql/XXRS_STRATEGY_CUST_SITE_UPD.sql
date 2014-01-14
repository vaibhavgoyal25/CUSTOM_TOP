DECLARE 
/**************************************************************************************************
*                                                                                                 *
* NAME : XXRS_STRATEGY_CUST_SITE_UPD.sql                                                          *
*                                                                                                 *
* DESCRIPTION :                                                                                   *
* Script To update Strategy Segment at Customer Sites.                                            *
*                                                                                                 *
* AUTHOR       : Vaibhav Goyal                                                                    *
*                                                                                                 *
* CHANGE CONTROL :                                                                                *
* VER #  |  TICKET #    | WHO             |  DATE         |  REMARKS                              *
*-------------------------------------------------------------------------------------------------*
* 1.0.0  | 130514-01651 | Vaibhav Goyal   |  15-MAY-2013  | Initial Creation                      *
**************************************************************************************************/
/* $Header: IEX_F_STRATEGY_VIEWS.sql 1.0.0 15-MAY-2013 10:00:00 AM Vaibhav Goyal $ */
cursor c1 is
SELECT hcasa.cust_account_id,
       hcasa.cust_acct_site_id,
       hcasa.org_id,
       x.ACCOUNT_NUMBER,
       x.PARTY_SITE_NUMBER,
       x.ORGANIZATION,
       x.ATTRIBUTE2,
       x.PARENT
  FROM XXRS.XXRS_CUST_SITE_STRATEGY_TMP x,
       ar.hz_cust_accounts hca,
       ar.hz_party_sites hps,
       ar.hz_cust_acct_sites_all hcasa
 WHERE     x.account_number = hca.account_number
       AND HCA.CUST_ACCOUNT_ID = hcasa.cust_account_id
       AND hcasa.party_site_id = hps.party_site_id
       AND x.party_site_number = hps.party_site_number;
  
  BEGIN

  UPDATE ar.hz_cust_acct_sites_all
     SET ATTRIBUTE5 = NULL;
  
  for i in c1
  LOOP
  
    UPDATE ar.HZ_CUST_ACCT_SITES_ALL
       SET ATTRIBUTE5 = i.parent
     WHERE cust_acct_site_id = i.cust_acct_site_id;  
  
  END LOOP;

commit;
  
  END;
/

