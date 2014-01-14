/**************************************************************************************************************
* NAME : XXRS_FND_DISABLE_USER_RESP_131101-08933.sql                                                          *
*                                                                                                             *
* DESCRIPTION :                                                                                               *
*   Script to disable inactive users and their responsibilities                                               *
*                                                                                                             *
* AUTHOR       : Pavan Amirineni                                                                              *
* DATE WRITTEN : 12-NOV-2013                                                                                  *
*                                                                                                             *
* CHANGE CONTROL :                                                                                            *
* Version#     |  Racker Ticket #  | WHO             |  DATE          |   REMARKS                             *
*-------------------------------------------------------------------------------------------------------------*
* 1.0.0        |  131101-08933     | Pavan Amirineni |  12-NOV-2013   | Initial Creation.                     *
***************************************************************************************************************/
--
/* $Header: XXRS_FND_DISABLE_USER_RESP_131101-08933.sql 1.0.0 11/12/2013 10:46:24 AM Pavan Amirineni $ */
--
SET SERVEROUTPUT ON SIZE 1000000
SET LINESIZE 10000
SET LINES 4000
SET PAGESIZE 1000
SET COLSEP '|'
COL file_name NEW_VALUE spool_file_name NOPRINT
SELECT 'XXRS_FND_DISABEL_USER_RESP_131101-08933_'||TO_CHAR(SYSDATE,'YYYYMMDDHHMISS')||'.log' file_name
FROM DUAL;

SPOOL &spool_file_name   

SET SERVEROUTPUT ON
DECLARE

CURSOR cur_active_resp
IS
select count(*) count from (
SELECT SUBSTR(a.description,1,40)         "USER",
    SUBSTR(a.user_name,1,25)            "USER LOGIN",
    A.START_DATE "USER START DATE",
    A.END_DATE "USER END DATE",
    b.responsibility_name     "RESPONSIBILITY" ,
    c.description, 
    c.START_DATE "RESPONSIBILITY START DATE",
    c.END_DATE "RESPONSIBILITY END DATE",
    e.security_group_name
FROM applsys.fnd_user a,
       apps.fnd_responsibility_tl b,
       apps.fnd_user_resp_groups_indirect c,
       apps.fnd_responsibility d,
       apps.fnd_security_groups_tl e
WHERE 
a.user_id = c.user_id
  AND C.SECURITY_GROUP_ID = e.security_group_id
   AND b.responsibility_id = c.responsibility_id
   AND d.responsibility_id = c.responsibility_id
   AND d.application_id = c.responsibility_application_id
   AND d.version IN ('W','4','M')
     and (c.end_date is null or c.end_date > sysdate)
union all
SELECT SUBSTR(a.description,1,40)         "USER",
    SUBSTR(a.user_name,1,25)            "USER LOGIN",
    A.START_DATE "USER START DATE",
    A.END_DATE "USER END DATE",
    b.responsibility_name     "RESPONSIBILITY" ,
    c.description,
    c.START_DATE "RESPONSIBILITY START DATE",
    c.END_DATE "RESPONSIBILITY END DATE",
        e.security_group_name
FROM applsys.fnd_user a,
       apps.fnd_responsibility_tl b,
       apps.fnd_user_resp_groups_direct c,
       apps.fnd_responsibility d,
              apps.fnd_security_groups_tl e
WHERE 
a.user_id = c.user_id
  AND C.SECURITY_GROUP_ID = e.security_group_id
   AND b.responsibility_id = c.responsibility_id
   AND d.responsibility_id = c.responsibility_id
   AND d.application_id = c.responsibility_application_id
   AND d.version IN ('W','4','M')
     and (c.end_date is null or c.end_date > sysdate));

CURSOR cur_count_user_resp_to_disable
is
SELECT COUNT(*) count FROM
(
SELECT m1.user_id,
       m1.description,
       m1.user_name,
       m1.last_logon_date,
       responsibility_id,
       (SELECT responsibility_application_id FROM FND_USER_RESP_GROUPS_DIRECT fug WHERE fug.user_id = m1.user_id and fug.responsibility_id = m1.responsibility_id and rownum =1) responsibility_application_id ,
       m1.responsibility_name,
       m1.resp_start_date,
       m1.email_address,
       m1.user_resp_desc,
       m1.security_group_id
  FROM ( SELECT a.description,
               a.user_name,
               a.user_id,
               a.last_logon_date,
               b.responsibility_name,
               b.responsibility_id,
               d.start_date resp_start_date,
               a.email_address,
               d.version,
               c.end_date,
               c.description user_resp_desc,
               c.security_group_id
          FROM applsys.fnd_user a,
               apps.fnd_responsibility_tl b,
               apps.fnd_user_resp_groups_indirect c,
               apps.fnd_responsibility d,
               apps.fnd_security_groups_tl e
         WHERE     a.user_id = c.user_id
               AND C.SECURITY_GROUP_ID = e.security_group_id
               AND b.responsibility_id = c.responsibility_id
               AND d.responsibility_id = c.responsibility_id
               AND d.application_id = c.responsibility_application_id
        UNION
        SELECT a.description,
               a.user_name,
               a.user_id,
               a.last_logon_date,
               b.responsibility_name,
               b.responsibility_id,
               d.start_date resp_start_date,
               a.email_address,
               d.version,
               c.end_date,
               c.description user_resp_desc,
               c.security_group_id
          FROM applsys.fnd_user a,
               apps.fnd_responsibility_tl b,
               apps.fnd_user_resp_groups_indirect c,
               apps.fnd_responsibility d,
               apps.fnd_security_groups_tl e
         WHERE     a.user_id = c.user_id
               AND C.SECURITY_GROUP_ID = e.security_group_id
               AND b.responsibility_id = c.responsibility_id
               AND d.responsibility_id = c.responsibility_id
               AND d.application_id = c.responsibility_application_id
        UNION
        SELECT a.description,
               a.user_name,
               a.user_id,
               a.last_logon_date,
               b.responsibility_name,
               b.responsibility_id,
               d.start_date resp_start_date,
               a.email_address,
               d.version,
               c.end_date,
               c.description user_resp_desc,
               c.security_group_id
          FROM applsys.fnd_user a,
               apps.fnd_responsibility_tl b,
               apps.fnd_user_resp_groups_direct c,
               apps.fnd_responsibility d,
               apps.fnd_security_groups_tl e
         WHERE     a.user_id = c.user_id
               AND C.SECURITY_GROUP_ID = e.security_group_id
               AND b.responsibility_id = c.responsibility_id
               AND d.responsibility_id = c.responsibility_id
               AND d.application_id = c.responsibility_application_id )  m1
 WHERE     version IN ('W', '4', 'M')
       AND (end_date IS NULL OR end_date > SYSDATE)
       AND last_logon_date <= SYSDATE - 90
--       AND user_name = 'CHRIS.WINSTON'
       AND user_name NOT IN ('MOBADM',
                             'MOBDEV',
                             'DAPH5230',
                             'SUJATA.CHARY',
                             'LISA.MAIN')
       AND user_name NOT IN (SELECT USER_NAME
                               FROM (SELECT a.description,
                                            a.user_name,
                                            a.last_logon_date,
                                            b.responsibility_name,
                                            EMAIL_ADDRESS,
                                            d.version,
                                            c.end_date
                                       FROM applsys.fnd_user a,
                                            apps.fnd_responsibility_tl b,
                                            apps.fnd_user_resp_groups_indirect c,
                                            apps.fnd_responsibility d,
                                            apps.fnd_security_groups_tl e
                                      WHERE     a.user_id = c.user_id
                                            AND C.SECURITY_GROUP_ID =
                                                   e.security_group_id
                                            AND b.responsibility_id =
                                                   c.responsibility_id
                                            AND d.responsibility_id =
                                                   c.responsibility_id
                                            AND d.application_id =
                                                   c.responsibility_application_id
                                     UNION
                                     SELECT a.description,
                                            a.user_name,
                                            a.last_logon_date,
                                            b.responsibility_name,
                                            EMAIL_ADDRESS,
                                            d.version,
                                            c.end_date
                                       FROM applsys.fnd_user a,
                                            apps.fnd_responsibility_tl b,
                                            apps.fnd_user_resp_groups_direct c,
                                            apps.fnd_responsibility d,
                                            apps.fnd_security_groups_tl e
                                      WHERE     a.user_id = c.user_id
                                            AND C.SECURITY_GROUP_ID =
                                                   e.security_group_id
                                            AND b.responsibility_id =
                                                   c.responsibility_id
                                            AND d.responsibility_id =
                                                   c.responsibility_id
                                            AND d.application_id =
                                                   c.responsibility_application_id)
                              WHERE     (responsibility_name LIKE
                                            '%Approver%') -- #Remove Purchasing Approvers
                                    AND version IN ('W', '4', 'M')
                                    AND (   end_date IS NULL
                                         OR end_date > SYSDATE)
                                    AND last_logon_date <= SYSDATE - 90
                                    AND user_name NOT IN ('MOBADM',
                                                          'MOBDEV',
                                                          'DAPH5230',
                                                          'SUJATA.CHARY',
                                                          'LISA.MAIN'))
);

CURSOR cur_disable_user_resp
IS 
SELECT m1.user_id,
       m1.description,
       m1.user_name,
       m1.last_logon_date,
       responsibility_id,
       (SELECT responsibility_application_id FROM FND_USER_RESP_GROUPS_DIRECT fug WHERE fug.user_id = m1.user_id and fug.responsibility_id = m1.responsibility_id and rownum =1) responsibility_application_id ,
       m1.responsibility_name,
       m1.resp_start_date,
       m1.email_address,
       m1.user_resp_desc,
       m1.security_group_id
  FROM ( SELECT a.description,
               a.user_name,
               a.user_id,
               a.last_logon_date,
               b.responsibility_name,
               b.responsibility_id, 
               d.start_date resp_start_date,
               a.email_address,
               d.version,
               c.end_date,
               c.description user_resp_desc,  
               c.security_group_id
          FROM applsys.fnd_user a,
               apps.fnd_responsibility_tl b,
               apps.fnd_user_resp_groups_indirect c,
               apps.fnd_responsibility d,
               apps.fnd_security_groups_tl e
         WHERE     a.user_id = c.user_id
               AND C.SECURITY_GROUP_ID = e.security_group_id
               AND b.responsibility_id = c.responsibility_id
               AND d.responsibility_id = c.responsibility_id
               AND d.application_id = c.responsibility_application_id
        UNION
        SELECT a.description,
               a.user_name,
               a.user_id,
               a.last_logon_date,
               b.responsibility_name,
               b.responsibility_id, 
               d.start_date resp_start_date,
               a.email_address,
               d.version,
               c.end_date,
               c.description user_resp_desc, 
               c.security_group_id
          FROM applsys.fnd_user a,
               apps.fnd_responsibility_tl b,
               apps.fnd_user_resp_groups_direct c,
               apps.fnd_responsibility d,
               apps.fnd_security_groups_tl e
         WHERE     a.user_id = c.user_id
               AND C.SECURITY_GROUP_ID = e.security_group_id
               AND b.responsibility_id = c.responsibility_id
               AND d.responsibility_id = c.responsibility_id
               AND d.application_id = c.responsibility_application_id )  m1
 WHERE     version IN ('W', '4', 'M')
       AND (end_date IS NULL OR end_date > SYSDATE)
       AND last_logon_date <= SYSDATE - 90    
--       AND user_name = 'CHRIS.WINSTON'   
       AND user_name NOT IN ('MOBADM',
                             'MOBDEV',
                             'DAPH5230',
                             'SUJATA.CHARY',
                             'LISA.MAIN')
       AND user_name NOT IN (SELECT USER_NAME
                               FROM (SELECT a.description,
                                            a.user_name,
                                            a.last_logon_date,
                                            b.responsibility_name,
                                            EMAIL_ADDRESS,
                                            d.version,
                                            c.end_date
                                       FROM applsys.fnd_user a,
                                            apps.fnd_responsibility_tl b,
                                            apps.fnd_user_resp_groups_indirect c,
                                            apps.fnd_responsibility d,
                                            apps.fnd_security_groups_tl e
                                      WHERE     a.user_id = c.user_id
                                            AND C.SECURITY_GROUP_ID =
                                                   e.security_group_id
                                            AND b.responsibility_id =
                                                   c.responsibility_id
                                            AND d.responsibility_id =
                                                   c.responsibility_id
                                            AND d.application_id =
                                                   c.responsibility_application_id
                                     UNION
                                     SELECT a.description,
                                            a.user_name,
                                            a.last_logon_date,
                                            b.responsibility_name,
                                            EMAIL_ADDRESS,
                                            d.version,
                                            c.end_date
                                       FROM applsys.fnd_user a,
                                            apps.fnd_responsibility_tl b,
                                            apps.fnd_user_resp_groups_direct c,
                                            apps.fnd_responsibility d,
                                            apps.fnd_security_groups_tl e
                                      WHERE     a.user_id = c.user_id
                                            AND C.SECURITY_GROUP_ID =
                                                   e.security_group_id
                                            AND b.responsibility_id =
                                                   c.responsibility_id
                                            AND d.responsibility_id =
                                                   c.responsibility_id
                                            AND d.application_id =
                                                   c.responsibility_application_id)
                              WHERE     (responsibility_name LIKE
                                            '%Approver%') -- #Remove Purchasing Approvers
                                    AND version IN ('W', '4', 'M') 
                                    AND (   end_date IS NULL
                                         OR end_date > SYSDATE)
                                    AND last_logon_date <= SYSDATE - 90
                                    AND user_name NOT IN ('MOBADM',
                                                          'MOBDEV',
                                                          'DAPH5230',
                                                          'SUJATA.CHARY',
                                                          'LISA.MAIN'))                                                             
        ORDER BY 3,6        ;
        l_user_name fnd_user.user_name%TYPE := NULL;
        l_dis_usr  VARCHAR2(1);
        l_dis_resp VARCHAR2(1); 
        l_err_msg  VARCHAR2(8000);
BEGIN
  
	FOR rec_resp_to_disable IN cur_count_user_resp_to_disable
	LOOP
		DBMS_OUTPUT.PUT_LINE('Total responsibilities to disable: ' || rec_resp_to_disable.count);
	END LOOP;

	FOR rec_cur_active_resp IN cur_active_resp
	LOOP
		 DBMS_OUTPUT.PUT_LINE('Total responsibilities enabled: ' || rec_cur_active_resp.count);
	END LOOP;
 
	DBMS_OUTPUT.PUT_LINE( 'USER NAME|RESPONSIBILITY|START DATE|END DATE|Status');   
   
   FOR rec_disable_user_resp IN cur_disable_user_resp 
   LOOP
   -- Disabling User
      l_dis_usr  := NULL; 
      l_dis_resp := NULL;
      l_err_msg  := NULL;
   --    
      IF (NVL(l_user_name,'x!3r432$') != rec_disable_user_resp.user_name) THEN
      --
         BEGIN 
            l_user_name := rec_disable_user_resp.user_name; 
            fnd_user_pkg.disableuser(username  => rec_disable_user_resp.user_name); 
            l_dis_usr := 'Y';       
         EXCEPTION
           WHEN OTHERS THEN           
             l_err_msg := 'DIS_USR_ERR'||SQLERRM;
             l_dis_usr := 'N'; 
         END;
      ELSE 
         l_dis_usr := 'Y';                     
      END IF;  
    -- Disabling Responsibility
      BEGIN 
        fnd_user_resp_groups_api.update_assignment(user_id                         => rec_disable_user_resp.user_id
                                                  , responsibility_id              => rec_disable_user_resp.responsibility_id
                                                  , responsibility_application_id  => rec_disable_user_resp.responsibility_application_id   
                                                  , security_group_id              => rec_disable_user_resp.security_group_id                                                 
                                                  , start_date                     => rec_disable_user_resp.resp_start_date
                                                  , end_date                       => sysdate 
                                                  , description                    => rec_disable_user_resp.user_resp_desc||';131101-08933'
                                                  );                                                    
         l_dis_resp := 'Y'; 
      EXCEPTION
        WHEN OTHERS THEN
          l_err_msg := 'DIS_USR_RESP_ERR'||SQLERRM;
          l_dis_resp :='N';
      END;
    
      IF (l_dis_usr = 'Y' AND l_dis_resp = 'Y') THEN    
--        COMMIT; 
--        ROLLBACK; 
        DBMS_OUTPUT.PUT_LINE( rec_disable_user_resp.user_name ||'|'|| 
                            rec_disable_user_resp.responsibility_name ||'|'||
                            rec_disable_user_resp.resp_start_date ||'|'||
                            SYSDATE ||'|'||
                            'Success'
                          );        
      ELSE 
        ROLLBACK; 
        DBMS_OUTPUT.PUT_LINE( rec_disable_user_resp.user_name ||'|'|| 
                            rec_disable_user_resp.responsibility_name ||'|'||
                            rec_disable_user_resp.resp_start_date ||'|'||
                            SYSDATE ||'|'||
                            l_err_msg||' Error'
                          );
      END IF;  

   END LOOP; -- Loop end
  FOR rec_resp_to_disable IN cur_count_user_resp_to_disable
        LOOP
                DBMS_OUTPUT.PUT_LINE('After Total responsiblities to disable: ' || rec_resp_to_disable.count);
        END LOOP;

        FOR rec_cur_active_resp IN cur_active_resp
        LOOP
                 DBMS_OUTPUT.PUT_LINE('After total responsibilities enabled: ' || rec_cur_active_resp.count);
        END LOOP;

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error at main: '|| SQLERRM);
END;
/
