/*============================================================================+
$Header$
============================================================================+*/

REM +================================================================================+
REM | # Bug No : 9879794                                                            |
REM |                                                                               |
REM | # RCA Bug :                                                                   |
REM |                                                                               |
REM | # Issue : User is not able to close the AR period                             |
REM |                                                                               |
REM | # Symptoms :  Checked out the data for the receipt applications and found     |
REM |               that                                                            |
REM |               the UNAPP record is not having the same event as its            |
REM |               application_id and application is already posted to GL.         |
REM |                                                                               |
REM | # Fix Approach :  Correct event_id,pcid,gl_posted_date has to be stamped for  |
REM |                   the                                                         |
REM |                   receipt applications.                                       |
REM |                                                                               |
REM | # Usage : Customer                                                            |
REM |                                                                               |
REM | # Category : Receipts                                                         |
REM |                                                                               |
REM *================================================================================*/

spool b9506486.log
set verify off
set linesize 200
set serveroutput on size 1000000

DECLARE

l_bug_number     number := 9506486;
l_org_id          NUMBER := &enter_org_id;
l_read_only_mode   varchar2(1) := '&read_only_mode'||'';
l_cash_receipt_id number := nvl('&cash_receipt_id',0);
l_gl_start_date   DATE := TO_DATE('&gl_start_date','DD-MM-YYYY');
l_gl_end_date     DATE := TO_DATE('&gl_end_date','DD-MM-YYYY');

cursor c_rec_id is
 select distinct ra.cash_receipt_id cash_receipt_id , ra.receivable_application_id receivable_application_id,
        ra_unapp.receivable_application_id un_receivable_application_id , 
        ra_unapp.event_id unapp_event_id , ra.event_id event_id , ra.posting_control_id posting_control_id
        , ra.gl_posted_date gl_posted_date
 from  ar_receivable_applications ra_unapp,
       ar_receivable_applications ra, 
      ar_distributions ard_unapp
 where  ra_unapp.gl_date between l_gl_start_date and l_gl_end_date
 and   ra_unapp.status = 'UNAPP'
 and   ra_unapp.cash_receipt_id = ra.cash_receipt_id
 and   ra.status <> 'UNAPP'
 and   ra_unapp.event_id <> ra.event_id
 and   ra_unapp.gl_date = ra.gl_date
 and   ra.posting_control_id <> -3 
 and   ra_unapp.posting_control_id = -3 
 and   ra_unapp.receivable_application_id = ard_unapp.source_id
 and   ard_unapp.source_table = 'RA'
 and   ard_unapp.source_id_secondary = ra.receivable_application_id ;
 

--procedures for RA records backup begin----------------------------
PROCEDURE create_bkp_table_ra is
l_create_bk_ra varchar2(500);
BEGIN
    l_create_bk_ra := ' CREATE TABLE ra_backup_'||l_bug_number||
                       ' AS SELECT * FROM AR_RECEIVABLE_APPLICATIONS_ALL WHERE 1<>1';
    EXECUTE IMMEDIATE l_create_bk_ra;
    EXCEPTION
    WHEN OTHERS THEN
       IF sqlcode = -955 then
          null;
       ELSE
          raise;
       END IF;
END;

--backup records based on ra_id
PROCEDURE insert_bkp_table_ra(ra_id NUMBER) IS
l_insert_ra  varchar2(500);
BEGIN
  l_insert_ra := 'INSERT INTO ra_backup_'||l_bug_number||
                  '( SELECT * FROM AR_RECEIVABLE_APPLICATIONS_ALL '||
                  '  WHERE RECEIVABLE_APPLICATION_ID  = '||ra_id||')';
  EXECUTE IMMEDIATE l_insert_ra;
END;
--procedures for RA records backup end ----------------------------


PROCEDURE backup_table_xe is
l_create_bk_table varchar2(500);
BEGIN
l_create_bk_table := 'create table xla_events_bk_'||l_bug_number||'  as
                      select * from xla_events
                      where 1=2';
EXECUTE IMMEDIATE l_create_bk_table;
EXCEPTION
When others then
  IF sqlcode = -955 then
  null;
  ELSE
   raise;
  END IF;
END backup_table_xe;

PROCEDURE insert_into_backup_xe(l_event_id number) IS
l_insert_events  varchar2(500);
BEGIN
l_insert_events := 'insert into xla_events_bk_'||l_bug_number||
                '( select * from xla_events
                   where event_id = '||l_event_id||')';
EXECUTE IMMEDIATE l_insert_events;
END;


PROCEDURE debug(s varchar2) is 
BEGIN
  dbms_output.put_line(s);
END debug;

FUNCTION print_spaces(n IN number) RETURN Varchar2 IS
   l_return_string varchar2(100);
Begin
   select substr('                                                   ',1,n)
   into l_return_String
   from dual;
     return(l_return_String);
End print_spaces;



BEGIN

        mo_global.init('AR');
        mo_global.set_policy_context('S',l_org_id);

        If  nvl(upper(l_read_only_mode),'Y') = 'N' 
        Then
          create_bkp_table_ra;
	  backup_table_xe;
        end if;       

        debug('                                                                                                         ');
        debug('Cash_receipt_id'||' '||'Un_Receivable_application_id'|| ' '||'Receivable_application_id');
        debug('==============='||' '||'========================='||' '||'=============================');

        For rec in c_rec_id loop

		debug(rec.cash_receipt_id||
		      print_spaces(16-length(rec.cash_receipt_id))||
		      rec.un_receivable_application_id||
		      print_spaces(26-length(rec.un_receivable_application_id))||
          rec.receivable_application_id||
		      print_spaces(26-length(rec.receivable_application_id))
		     );

		If  nvl(upper(l_read_only_mode),'Y') = 'N' 
		Then

			insert_bkp_table_ra(rec.receivable_application_id);

			update  ar_receivable_applications
			set event_id = rec.event_id,
			posting_control_id = rec.posting_control_id,
			gl_posted_date = rec.gl_posted_date
			where receivable_application_id = rec.un_receivable_application_id
      and  cash_receipt_id = rec.cash_receipt_id
      and  posting_control_id = -3 
      and  status = 'UNAPP'; 

			

		END IF;

        END LOOP;

EXCEPTION
when others then
  dbms_output.put_line(sqlerrm);
END;
/
