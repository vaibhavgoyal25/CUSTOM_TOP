/*============================================================================+
$Header: del_orphans_xla_120.sql 120.2 2009/07/27 14:48:41 samara noship $
============================================================================+*/

REM +================================================================================+
REM | File Name: del_orphans_xla_120.sql     			                    |
REM |										    |
REM | Data Bug   : 6850655 [R12]                                                    |
REM | Root Cause : 6450286                                                          |
REM |                                                                               |
REM | Issue: When a user creates a Receipt/Transaction from respective UI,          |
REM |        distributions are populated in XLA.  On deletion of Receipt/Transaction|
REM |        the respective distributions of XLA not get refreshed precisely.       |
REM |                                                                               |
REM | Fix Approach:								    |
REM |     1) Take a backup of orphan events and delete the events from xla_events   |
REM |                                                                               |
REM | USAGE                                                                         |
REM |      Supply the following when prompted:                                      |
REM |      1) The script should first be run with read_only_mode = Y to generate    |
REM |	      the listing of corrupted events detail. As a second step the          |
REM |         user should run this script with read_only_mode = N to fix the data.  |
REM |      2) l_start_gl_date (REQUIRED)                                            |
REM |      3) l_end_gl_date (REQUIRED)                                              |
REM |      4) l_ledger_id (REQUIRED)                                                |
REM |                               						    |
REM *================================================================================*/

spool del_orphans_xla_120.out
set serveroutput on size 1000000;
set verify off;
set lines 500;

declare
l_bug_number	   number := 6850655;  
l_read_only_mode   varchar2(1) := '&read_only_mode'||'';
l_ledger_id        number := &enter_ledger_id;
l_start_gl_date    date   := to_date('&start_gl_date','DD/MM/YYYY');
l_end_gl_date      date   := to_date('&end_gl_date','DD/MM/YYYY');
l_rule           number;
l_count          number;

cursor get_orphan_trx_events is
select xte.source_id_int_1, xte.entity_id, xe.event_id, xe.event_date, xe.event_type_code, xe.event_status_code
from xla_events xe, xla.xla_transaction_entities xte
where xte.entity_code = 'TRANSACTIONS'
and xte.entity_id = xe.entity_id
and xte.application_id = 222
and xte.ledger_id = l_ledger_id
and xe.event_date between l_start_gl_date and l_end_gl_date
and xe.application_id = 222
and xe.event_status_code <> 'P'
and not exists
(select 'x' from ra_cust_Trx_line_gl_dist_all
 where gl_date between l_start_gl_date and l_end_gl_date
 and   customer_trx_id = xte.source_id_int_1
 and   posting_control_id = -3
 and   event_id = xe.event_id
 union
 select 'x' from ar_receivable_applications_all
 where gl_date between l_start_gl_date and l_end_gl_date
 and   customer_trx_id = xte.source_id_int_1
 and   posting_control_id = -3
 and   event_id = xe.event_id
 union
 select 'x' from ar_receivable_applications_all
 where gl_date between l_start_gl_date and l_end_gl_date
 and   applied_customer_trx_id = xte.source_id_int_1
 and   posting_control_id = -3
 and   event_id = xe.event_id
 )
 order by xe.event_id;

cursor get_orphan_rct_events is
select xte.source_id_int_1, xte.entity_id, xe.event_id, xe.event_date, xe.event_type_code, xe.event_status_code
from xla.xla_events xe, xla.xla_transaction_entities xte
where xte.application_id = 222 
and xe.application_id= xte.application_id 
and xte.ledger_id = l_ledger_id 
and xe.entity_id = xte.entity_id 
and xte.entity_code='RECEIPTS' 
and xe.event_status_code <> 'P'
and xe.event_date between l_start_gl_date and l_end_gl_date
and not exists
(select 'x' from ar_distributions_all dis, ar_receivable_applications_all ra
 where ra.cash_receipt_id = xte.source_id_int_1
 and dis.source_table = 'RA'
 and dis.source_id = ra.receivable_application_id
 and ra.gl_date between l_start_gl_date and l_end_gl_date
 and ra.posting_control_id = -3 
 and ra.event_id = xe.event_id
 union
 select 'x' from ar_distributions_all dis, ar_cash_receipt_history_all crh
 where crh.cash_receipt_id = xte.source_id_int_1
 and dis.source_table = 'CRH'
 and dis.source_id = crh.cash_receipt_history_id
 and crh.gl_date between l_start_gl_date and l_end_gl_date
 and crh.posting_control_id = -3 
 and crh.event_id = xe.event_id
 union
 select 'x' from ar_distributions_all dis, ar_misc_cash_distributions_all mcd
 where mcd.cash_receipt_id = xte.source_id_int_1
 and   dis.source_table = 'MCD'
 and   dis.source_id = mcd.misc_cash_distribution_id
 and   mcd.gl_date between l_start_gl_date and l_end_gl_date
 and   mcd.posting_control_id = -3 
 and   mcd.event_id = xe.event_id 
 )
order by xe.event_id;

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

begin

	If  nvl(upper(l_read_only_mode),'Y') = 'N' then
		backup_table_xe;
	End if;

	debug('                                                                                                         ');
	debug('Entity Id        '||' '||'Customer Trx Id  '||' '||'Event Type Code    '||' '||'Event Date   '||' '||'Event Status Code '||' '||'Event Id           ');
	debug('================='||' '||'================='||' '||'==================='||' '||'============='||' '||'=================='||' '||'===================');
	debug('                                                                                                         ');

	For rec in get_orphan_trx_events
	Loop
	
	  l_rule := null;
	  l_count := 0;

    begin
        
        select invoicing_rule_id 
        into l_rule
        from ra_customer_trx_all
        where customer_trx_id = rec.source_id_int_1;
        
        select count(*) 
        into l_count
        from ra_cust_trx_line_gl_dist_all
        where customer_trx_id = rec.source_id_int_1
        and account_set_flag = 'N';
    
    exception
    When others 
    then
        l_rule := null;
    end;
        

    If ( l_rule is null or
         (l_rule is not null and l_count <> 0) ) then

		  If  nvl(upper(l_read_only_mode),'Y') = 'N' then

			   insert_into_backup_xe(rec.event_id);

			   delete from xla_distribution_links
			   where application_id = 222
			   and   ae_header_id in 
				 (SELECT h.ae_header_id
				  FROM  xla_ae_headers h
				  WHERE h.application_id   = 222
				  AND   h.event_id = rec.event_id
				  );

			   delete from xla_ae_lines
			   where application_id = 222
			   and   ae_header_id in 
				 (SELECT h.ae_header_id
				  FROM  xla_ae_headers h
				  WHERE h.application_id   = 222
				  AND   h.event_id = rec.event_id
				  );

			   delete from xla_ae_headers
			   where application_id = 222
			   and   event_id = rec.event_id;			   

			   delete from xla_events
			   where event_id = rec.event_id
			   and application_id = 222;

		  End If;


		  debug(rec.entity_id||
	 	        print_spaces(18-length(rec.entity_id))||
		        rec.source_id_int_1||
		        print_spaces(18-length(rec.source_id_int_1))||		  
		        rec.event_type_code||
		        print_spaces(20-length(rec.event_type_code))||
		        rec.event_date||
		        print_spaces(14-length(rec.event_date))||
		        rec.event_status_code||
		        print_spaces(19-length(rec.event_status_code))||
		        rec.event_id||
		        print_spaces(20-length(rec.event_id))
		        );
	
    End If;	
	
	End Loop;

	debug('                                                                                                         ');
	debug('Entity Id        '||' '||'Cash Receipt Id  '||' '||'Event Type Code    '||' '||'Event Date   '||' '||'Event Status Code '||' '||'Event Id           ');
	debug('================='||' '||'================='||' '||'==================='||' '||'============='||' '||'=================='||' '||'===================');
	debug('                                                                                                         ');


	For rec in get_orphan_rct_events
	Loop

		If  nvl(upper(l_read_only_mode),'Y') = 'N' then

			insert_into_backup_xe(rec.event_id);

			delete from xla_distribution_links
			where application_id = 222
			and   ae_header_id in 
				 (SELECT h.ae_header_id
				  FROM  xla_ae_headers h
				  WHERE h.application_id   = 222
				  AND   h.event_id = rec.event_id
				  );

			delete from xla_ae_lines
			where application_id = 222
			and   ae_header_id in 
				 (SELECT h.ae_header_id
				  FROM  xla_ae_headers h
				  WHERE h.application_id   = 222
				  AND   h.event_id = rec.event_id
				  );

			delete from xla_ae_headers
			where application_id = 222
			and   event_id = rec.event_id;	

			delete from xla_events
			where event_id = rec.event_id
			and application_id = 222;

		End If;


		debug(rec.entity_id||
	 	      print_spaces(18-length(rec.entity_id))||
		      rec.source_id_int_1||
		      print_spaces(18-length(rec.source_id_int_1))||		  
		      rec.event_type_code||
		      print_spaces(20-length(rec.event_type_code))||
		      rec.event_date||
		      print_spaces(14-length(rec.event_date))||
		      rec.event_status_code||
		      print_spaces(19-length(rec.event_status_code))||
		      rec.event_id||
		      print_spaces(20-length(rec.event_id))
		      );
	
	End Loop;

Exception 
 when others then
    debug ('Exception : '); 
    ROLLBACK;
    RAISE;
End; 
/

spool off
