%
%  States
%

state(initial).
state(startup).
state(over_temp).
state(operational).
state(under_temp).
state(overheat_shutdown).
state(sys_shutdown).
state(noheat_shutdown).
state(off).

%
%  Events
%

event(initiate).
event(overtemp).
event(undertemp).
event(not_cooling).
event(operator_shutdown).
event(not_heating).
event(safe_off).

%
%  Response
%

response(do_nothing).
response(operate).
response(start_pump).
response(stop_pump).
response(start_shutdown).
response(panic_hot).
response(panic_cold).

%
%  Requirements
%

req(id01, startup, init_complete, operation, operational).
req(id02, operational, overtemp, start_pump, over_temp).
req(id03, operational, undertemp, stop_pump, under_temp).
req(id04, over_temp, not_cooling, panic_hot, overheat_shutdown).
req(id05, operational, operator_shutdown, start_shutdown, sys_shutdown).
req(id06, under_temp, not_heating, panic_cold, noheat_shutdown).
req(id07, overheat_shutdown, safe_off, do_nothing, shutdown).
req(id08, sys_shutdown, safe_off, do_nothing, shutdown).
req(id09, noheat_shutdown, safe_off, do_nothing, shutdown).

%
%  rules
%

valid_req(Id, Start, Event, Response, Next) :-
	req(Id, Start, Event, Response, Next),
	state(Start),
	event(Event),
	response(Response),
	state(Next).

invalid_req(Id, Start, Event, Response, Next) :-
	not(valid_req(Id, Start, Event, Response, Next)).

valid(Id) :- req(Id, S, E, R, N), valid_req(Id, S, E, R, N).

invalid(Id) :- not(valid(Id)).

badstate(S) :- print('  ** Invalid state: '), write(S), nl, false.
badevent(E) :- print('  ** Invalid event: '), write(E), nl, false.
badresponse(R) :- print('  ** Invalid response: '), write(R), nl, false.
badnextstate(N) :- print('  ** Invalid next state: '), write(N), nl, false.

pp(Id) :- invalid(Id),
		      req(Id, S, E, R, N),
		      print('Problems with req '),
		      write(Id), print(': '), nl,
    (not(event(E)), badevent(E));
    (not(state(N)), badnextstate(N));
		      true.

check_reqs :- req(Id, _, _, _, _),
	      print('Checking requirement: '),
	      print(Id), nl,
	      invalid(Id),
	      print(' ***** Invalid requirment'),
	      write(Id), nl, false.
check_reqs :- true.

list_reqs :-  req(Id, _, _, _, _), print('Req: '), print(Id), nl, false.
list_reqs.

%list_reqs(Id) :- req(Id, -, -, -, -), print('Req: '), print(Id), nl.