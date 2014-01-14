/**********************************************************************************************************************
* NAME : XXRS_FND_REQ_SET_DELETE.sql                                                                                  *
* DESCRIPTION :                                                                                                       *
* Script to drop custom request sets                                                                                  *
*                                                                                                                     *
* AUTHOR       : Vinodh Bhasker                                                                                       *
* DATE WRITTEN : 21-NOV-2011                                                                                          *
*                                                                                                                     *
* CHANGE CONTROL :                                                                                                    *
* SR#             Ticket#          WHO                DATE                        REMARKS                             *
* 1.0.0           111122-02448     Vinodh Bhasker     21-NOV-2011                 Initial build                       *
***********************************************************************************************************************/
SET SERVEROUTPUT ON SIZE 1000000;
DECLARE
  CURSOR cur_xxrs_inactive_req_set
  IS
  SELECT req.user_request_set_name
       , req.description
       , req.request_set_name
       , app.application_name
       , app.application_short_name
       , app.application_id
       , req.request_set_id
    FROM fnd_request_sets_vl req
       , fnd_application_vl app
   WHERE app.application_id = req.application_id
     AND (UPPER(req.user_request_set_name) like 'RS%'
          OR UPPER(req.user_request_set_name) like 'RACK%'
          OR UPPER(req.user_request_set_name) like 'XXRS%'
          OR app.application_short_name = 'XXRS')
     AND NVL(end_date_active, SYSDATE) < SYSDATE;
--
  CURSOR cur_xxrs_active_req_set
  IS
  SELECT req.user_request_set_name
       , req.description
       , req.request_set_name
       , app.application_name
       , app.application_short_name
       , app.application_id
       , req.request_set_id
    FROM fnd_request_sets_vl req
       , fnd_application_vl app
   WHERE app.application_id = req.application_id
     AND (UPPER(req.user_request_set_name) like 'RS%'
          OR UPPER(req.user_request_set_name) like 'RACK%'
          OR UPPER(req.user_request_set_name) like 'XXRS%'
          OR app.application_short_name = 'XXRS');
--
  l_count   NUMBER         := 0;
  l_message VARCHAR2(255);
BEGIN
  DBMS_OUTPUT.PUT_LINE('STARTING to remove request sets');
  DBMS_OUTPUT.PUT_LINE('===============================');
--
  DBMS_OUTPUT.NEW_LINE;
  DBMS_OUTPUT.PUT_LINE('List of inactive custom request sets to be deleted:');
  DBMS_OUTPUT.PUT_LINE('---------------------------------------------------');
--
  l_count := 0;
--
  FOR rec_xxrs_inactive_req_set IN cur_xxrs_inactive_req_set
  LOOP
--
    l_count := l_count + 1;
    dbms_output.put(l_count||'. '||rec_xxrs_inactive_req_set.user_request_set_name||' ('||rec_xxrs_inactive_req_set.application_name||')');
--
    fnd_set.delete_set ( request_set => rec_xxrs_inactive_req_set.request_set_name
                       , application => rec_xxrs_inactive_req_set.application_short_name);
--
    l_message := SUBSTR(fnd_set.message, 1, 255);
--
    IF (l_message IS NULL)
    THEN
      dbms_output.put_line(' - Successful');
    ELSE
      dbms_output.put_line(' - Error Message : '||l_message);
    END IF;
  END LOOP;
--
  dbms_output.new_line;
  dbms_output.put_line('List of active custom request sets to be deleted:');
  dbms_output.put_line('--------------------------------------------------');
--
  l_count := 0;
--
  FOR rec_xxrs_active_req_set IN cur_xxrs_active_req_set
  LOOP
--
    l_count := l_count + 1;
    dbms_output.put(l_count||'. '||rec_xxrs_active_req_set.user_request_set_name||' ('||rec_xxrs_active_req_set.application_name||')');
--
    fnd_set.delete_set ( request_set => rec_xxrs_active_req_set.request_set_name
                       , application => rec_xxrs_active_req_set.application_short_name);
--
    l_message := SUBSTR(fnd_set.message, 1, 255);
--
    IF (l_message IS NULL)
    THEN
      dbms_output.put_line(' - Successful');
    ELSE
      dbms_output.put_line(' - Error Message : '||l_message);
    END IF;
  END LOOP;
--
END;
/