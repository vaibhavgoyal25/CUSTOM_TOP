/**********************************************************************************************************************
* NAME : XXRS_FND_EXE_DELETE.sql                                                                                      *
* DESCRIPTION :                                                                                                       *
* Script to drop custom executables                                                                                   *
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
  CURSOR cur_xxrs_executable
  IS
  SELECT exe.user_executable_name
       , exe.executable_name
       , exe.description exe_description
       , exe_app.application_name
       , exe_app.application_short_name
       , exe.executable_id
       , exe_app.application_id exe_application_id
    FROM fnd_executables_vl exe
       , fnd_application_vl exe_app
   WHERE 1 = 1
     AND (UPPER(exe.executable_name) like 'RS%'
          OR UPPER(exe.executable_name) like 'RACK%'
          OR UPPER(exe.executable_name) like 'XXRS%')
     AND exe_app.application_id = exe.application_id
     AND exe.executable_name NOT IN ('XXRSINVLOADTRX', 'XXRSFNDINOUT', 'XXRSFNDSTSPAP')
   ORDER BY exe.creation_date;
--
  l_count   NUMBER         := 0;
  l_message VARCHAR2(255);
BEGIN
  DBMS_OUTPUT.PUT_LINE('STARTING to remove executables');
  DBMS_OUTPUT.PUT_LINE('======================================');
--
  l_count := 0;
--
  FOR rec_xxrs_executable IN cur_xxrs_executable
  LOOP
--
    l_count := l_count + 1;
--
    dbms_output.put(l_count||'. '||rec_xxrs_executable.user_executable_name||' ('||rec_xxrs_executable.application_name||')');
--
    fnd_program.delete_executable ( executable_short_name => rec_xxrs_executable.executable_name
                                  , application           => rec_xxrs_executable.application_short_name);
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