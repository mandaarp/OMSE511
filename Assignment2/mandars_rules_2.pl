check_start_state(ReqId,StartState):-
	(state(StartState)-> true;
	 print('violation of definition: '),
	 print('Requirement '),	print(ReqId),
	 print(' start state: '),print(StartState),
	 print(' is not a member of set of states.'),nl,false).

check_event(ReqId,Event):-
	(event(Event) -> true;
	 print('violation of definition: '),
	 print('Requirement '), print(ReqId),
	 print(' event: '), print(Event),
	 print(' is not a member of set of events.'),nl,false).

check_response(ReqId,Response):-
	(response(Response) -> true;
	 print('violation of definition: '),
	 print('Requirement '), print(ReqId),
	 print(' response: '), print(Response),
	 print(' is not a member of set of responses.'),nl, false).

check_final_state(ReqId, FinalState):-
	(state(FinalState) -> true;
	 print('violation of definition: '),
	 print('Requirement '), print(ReqId),
	 print(' final state: '), print(FinalState),
	 print(' is not a member of set of states.'),nl, false).

check_definition(ReqId,StartState,Event,ResponseToEvent,FinalState):- 
	(check_start_state(ReqId,StartState) -> false;
	 check_event(ReqId,Event) -> false;
	 check_response(ReqId,ResponseToEvent) -> false;
	 check_final_state(ReqId,FinalState) -> false;
	 true).

check_duplicate_initial:-
	initial(X),
	initial(Y),
	(X \= Y -> print('violation of general rule: duplicate initial state definition detected'),nl,!),
	false.

check_invalid_initial:-
	initial(X),
	(not(state(X)) -> print('initial state: '), print(X), print(' is not a member of set of states.'),nl,!),
	false.

check_general_rule_1:-
	print('Checking general rule 1 ...'), nl,
%	(initial(X) -> 	(state(X) -> 	true;
%					print('violatin of general rule: '), 
%					print(' Initial State: '), print(X), 
%					print(' is not a member of set of states.'),nl,false);
%			print('violation of general rule: '),
%			print('Initial state is not defined.'),nl,
%			
%			false),
	not(check_invalid_initial),
	not(check_duplicate_initial).

state_in_req(State) :-
	req(_,State,_,_,_) -> true;
	(req(_,_,_,_,State) -> true; false).

iterate_states :-
	state(X),
%	print('Checking state: '), print(X),nl,
	(state_in_req(X) -> print('');print('state '), print(X), print(' is not present in any requirement'),nl,true),
	false.

check_general_rule_2 :-
	print('checking general rule 2 ...'), nl,
	not(iterate_states).

event_in_req(Event) :-
	req(_,_,Event,_,_) -> true;
	false.

iterate_events :-
	event(X),
%	print('Checking event: '), print(X),nl,
	(event_in_req(X) -> print('');print('event '), print(X), print(' is not present in any requirement'),nl,true),
	false.

check_general_rule_3 :-
	print('checking general rule 3 ...'), nl,
	not(iterate_events).

response_in_req(Response) :-
	req(_,_,_,Response,_) -> true;
	false.

iterate_responses :-
	response(X),
%	print('Checking response: '), print(X),nl,
	(response_in_req(X) -> print('');print('response '), print(X), print(' is not present in any requirement'),nl,true),
	false.

check_general_rule_4 :-
	print('checking general rule 4 ...'), nl,
	not(iterate_responses).

iterate_reqs :-
	req(ReqId,_,_,_,_),
%	print('finding duplicate for '), print(ReqId), nl,
	req(ReqIdNext,_,_,_,_),
	(ReqId == ReqIdNext -> print('duplicate '), print(ReqId), print(' found'),nl, false; true),
	false.

check_general_rule_5 :-
	print('NOT WORKING! checking general rule 5 ...'), nl,
	not(iterate_reqs).

check_general_rule_6 :-
	print('NOT IMPLEMENTED! checking general rule 6 ...'), nl.

check_other_params(ReqId):-
	req(ReqId,StartState,Event,Response,FinalState),
	(not(state(StartState)) -> print('start state: '), print(StartState), print(' is not defined for req id: '), print(ReqId),nl;true),
	(not(event(Event)) -> print('event: '), print(Event), print(' is not defined for req id: '), print(ReqId),nl;true),
	(not(response(Response)) -> print('response: '), print(Response), print(' is not defined for req id: '), print(ReqId),nl;true),
	(not(state(FinalState)) -> print('final state: '), print(FinalState), print(' is not defined for req id: '), print(ReqId),nl;true).

check_reqs:-
	req(ReqId,_,_,_,_),
	check_other_params(ReqId),
	false.
	
check_general_rule_7 :-
	print('checking general rule 7 ...'), nl,
	not(check_reqs).

test:-
%	check_general_rule_1,
%	check_general_rule_2,
%	check_general_rule_3,
%	check_general_rule_4,
%	check_general_rule_5,
%	check_general_rule_6,
	check_general_rule_7,
%	testing,
	nl.
