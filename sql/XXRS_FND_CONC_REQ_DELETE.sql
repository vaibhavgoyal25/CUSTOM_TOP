/**********************************************************************************************************************
* NAME : XXRS_FND_CONC_REQ_DELETE.sql                                                                                 *
* DESCRIPTION :                                                                                                       *
* Script to drop custom concurrent request                                                                            *
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
  CURSOR cur_xxrs_inactive_req
  IS
  SELECT req.user_concurrent_program_name
       , req.description
       , req.concurrent_program_name
       , app.application_name
       , app.application_short_name
       , exe.user_executable_name
       , exe.executable_name
       , exe.description exe_description
       , req.concurrent_program_id
       , app.application_id
       , exe.executable_id
       , exe_app.application_id exe_application_id
    FROM fnd_concurrent_programs_vl req
       , fnd_executables_vl exe
       , fnd_application_vl app
       , fnd_application_vl exe_app
   WHERE app.application_id = req.application_id
     AND (UPPER(req.user_concurrent_program_name) like 'RS%'
          OR UPPER(req.user_concurrent_program_name) like 'RACK%'
          OR UPPER(req.user_concurrent_program_name) like 'XXRS%')
     AND exe_app.application_id = exe.application_id
     AND exe.executable_id = req.executable_id
     AND exe.application_id = req.executable_application_id
     AND req.enabled_flag = 'N';
--
  CURSOR cur_xxrs_active_req
  IS
  SELECT req.user_concurrent_program_name
       , req.description
       , req.concurrent_program_name
       , app.application_name
       , app.application_short_name
       , exe.user_executable_name
       , exe.executable_name
       , exe.description exe_description
       , req.concurrent_program_id
       , app.application_id
       , exe.executable_id
       , exe_app.application_id exe_application_id
    FROM fnd_concurrent_programs_vl req
       , fnd_executables_vl exe
       , fnd_application_vl app
       , fnd_application_vl exe_app
   WHERE app.application_id = req.application_id
     AND (UPPER(req.user_concurrent_program_name) like 'RS%'
          OR UPPER(req.user_concurrent_program_name) like 'RACK%'
          OR UPPER(req.user_concurrent_program_name) like 'XXRS%')
     AND exe_app.application_id = exe.application_id
     AND exe.executable_id = req.executable_id
     AND exe.application_id = req.executable_application_id
     AND app.application_short_name = 'XXRS'
     AND req.enabled_flag = 'Y';
--
  l_count   NUMBER         := 0;
  l_message VARCHAR2(255);
BEGIN
  DBMS_OUTPUT.PUT_LINE('STARTING to remove concurrent programs');
  DBMS_OUTPUT.PUT_LINE('======================================');
--
  DBMS_OUTPUT.NEW_LINE;
  DBMS_OUTPUT.PUT_LINE('List of inactive custom programs to be deleted:');
  DBMS_OUTPUT.PUT_LINE('---------------------------------------------------');
--
  l_count := 0;
--
  FOR rec_xxrs_inactive_req IN cur_xxrs_inactive_req
  LOOP
--
    l_count := l_count + 1;
--
    dbms_output.put(l_count||'. '||rec_xxrs_inactive_req.user_concurrent_program_name||' ('||rec_xxrs_inactive_req.application_name||')');
--
    fnd_program.delete_program ( program_short_name => rec_xxrs_inactive_req.concurrent_program_name
                               , application        => rec_xxrs_inactive_req.application_short_name);
--
    l_message := SUBSTR(fnd_program.message, 1, 255);
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
  dbms_output.put_line('List of active custom programs to be deleted:');
  dbms_output.put_line('--------------------------------------------------');
--
  l_count := 0;
--
  FOR rec_xxrs_active_req IN cur_xxrs_active_req
  LOOP
--
    l_count := l_count + 1;
--
    dbms_output.put(l_count||'. '||rec_xxrs_active_req.user_concurrent_program_name||' ('||rec_xxrs_active_req.application_name||')');
--
    fnd_program.delete_program ( program_short_name => rec_xxrs_active_req.concurrent_program_name
                               , application        => rec_xxrs_active_req.application_short_name);
--
    l_message := SUBSTR(fnd_program.message, 1, 255);
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