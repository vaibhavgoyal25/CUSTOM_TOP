/* $Header: create_missing_rct_events.sql 120.1 2008/11/13 01:35:15 samara noship $ */
REM/*============================================================================+
REM |  Copyright (c) 2000 Oracle Corporation Redwood Shores, California, USA     |
REM |                          All rights reserved.                              |
REM +============================================================================+
REM | File Name          create_missing_rct_events.sql 
REM |
REM | DESCRIPTION
REM |      
REM |      This srcipt checks FOR the event_id IN  CRH and RA
REM |      AND stamps the event_id IF it IS NULL AND there EXISTS an event
REM |      IN xla_events. Else, script creates a NEW RECORD IN xla_events AND stamps IN 
REM |	   CRH and RA.
REM |
REM |  USAGE
REM |      Supply the following when prompted:
REM |      1) org_id (REQUIRED)
REM |      2) cash_receipt_id (Enter 0 to fix all the receipts)
REM |      3) read_only_mode (OPTIONAL). Enter Y/N as input. This option is used
REM |         to provide a summary report of all errors that are reported by
REM |         fix_missing_event_trxn.sql. If the report IS run IN the 'Y' mode
REM |         the customer can the VIEW the customer_trx_id FOR which the UPDATE 
REM |         will be done.
REM |         
REM *============================================================================*/

spool create_missing_rct_events.log
set verify off
set linesize 200
set serveroutput on size 100000

DECLARE

l_org_id	  NUMBER := &enter_org_id;
l_cr_id	 Number  := &enter_cr_id;
l_read_only_mode   varchar2(1) := '&read_only_mode'||'';
l_start_gl_date  DATE  := to_date('&low_gl_date','DD-MON-YYYY');
l_end_gl_date    DATE  := to_date('&high_gl_date','DD-MON-YYYY');
l_xla_ev_rec      arp_xla_events.xla_events_type;


cursor crh_missing_event_rows IS
select DISTINCT  crh.cash_receipt_history_id cash_receipt_history_id, crh.cash_receipt_id cash_receipt_id
from ar_cash_receipt_history crh
where crh.posting_control_id = -3
AND crh.cash_receipt_id = DECODE(l_cr_id,0,crh.cash_receipt_id,l_cr_id)
and crh.gl_date between l_start_gl_date and l_end_gl_date
and crh.event_id is null
order by cash_receipt_id;


Cursor ra_missing_event_rows IS
select DISTINCT  ra.receivable_application_id receivable_application_id,
ra.cash_receipt_id cash_receipt_id
from ar_receivable_applications ra
where ra.posting_control_id = -3
and ra.cash_receipt_id is not null
AND ra.cash_receipt_id = DECODE(l_cr_id,0,ra.cash_receipt_id,l_cr_id)
and ra.gl_date between l_start_gl_date AND l_end_gl_date
and ra.event_id is null
order by cash_receipt_id;


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

	-- Org Setting 
	mo_global.init('AR');
	mo_global.set_policy_context('S',l_org_id); 

       debug('Missing events in ar_cash_receipt_history                 ');
       debug('Cash_Receipt_Id  '||' '||'Cash_Receipt_History_Id    ');
       debug('================='||' '||'===========================');

       
	For crh_cr IN crh_missing_event_rows LOOP

		debug(
		crh_cr.cash_receipt_id||
		print_spaces(17-length(crh_cr.cash_receipt_id))||
		crh_cr.cash_receipt_history_id||
		print_spaces(28-length(crh_cr.cash_receipt_history_id))
		);

		If  nvl(upper(l_read_only_mode),'Y') = 'N' 
		Then
		
      		   -- Calling Event Creation Routines

		   l_xla_ev_rec.xla_from_doc_id := crh_cr.cash_receipt_id;
		   l_xla_ev_rec.xla_to_doc_id   := crh_cr.cash_receipt_id;
		   l_xla_ev_rec.xla_mode        := 'O';
		   l_xla_ev_rec.xla_call        := 'B';
		   l_xla_ev_rec.xla_doc_table := 'CRH';
		   ARP_XLA_EVENTS.create_events(p_xla_ev_rec => l_xla_ev_rec);
			
		End If;

	END LOOP;

        debug('Missing events in ar_receivable_applications                 ');
        debug('Cash_Receipt_Id  '||' '||'Receivable_application_id  ');
        debug('================='||' '||'===========================');

       
	For app_ra IN ra_missing_event_rows LOOP

  		debug(
		app_ra.cash_receipt_id||
		print_spaces(17-length(app_ra.cash_receipt_id))||
		app_ra.receivable_application_id||		
		print_spaces(28-length(app_ra.receivable_application_id))
		);

		If  nvl(upper(l_read_only_mode),'Y') = 'N' 
		Then
	
			-- Calling Event Creation Routines
			l_xla_ev_rec.xla_from_doc_id := app_ra.receivable_application_id;
			l_xla_ev_rec.xla_to_doc_id   := app_ra.receivable_application_id;
		        l_xla_ev_rec.xla_mode        := 'O';
		        l_xla_ev_rec.xla_call        := 'B';
		        l_xla_ev_rec.xla_doc_table := 'APP';

		        ARP_XLA_EVENTS.create_events(p_xla_ev_rec => l_xla_ev_rec);

		End If;

 	 END LOOP;

EXCEPTION
   When others THEN
     debug ('Exception : ' || sqlerrm);    
     rollback; 
     raise;

END;

/

spool off

