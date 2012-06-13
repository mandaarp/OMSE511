/*
 	Course: OMSE 531 (Software Requirements Engineering)
	Assignment No.: 2
	Term: Spring 2012
	Student Name: Mandar Patil
	Email: mandar@pdx.edu
	
	Objective:
	To build a framework for formal requirements that will generate natural
	language specification from a formal representation of finite state
	automata. Additionally, it should also display the errors in verification in natural language.

	Description:
	This file contains Prolog code to (1) validate each requirement adheres to
	the facts in ground.pl file and (2) Verify requirements present in req.pl against the facts.
*/

/*
	This rule checks for valid start state
*/

check_start_state(ReqId,StartState):-
	(state(StartState)-> true;
	 print('violation of definition: '),
	 print('Requirement '),	print(ReqId),
	 print(' start state: '),print(StartState),
	 print(' is not a member of set of states.'),nl,false).

/*
	This rule checks for valid event
*/
check_event(ReqId,Event):-
	(event(Event) -> true;
	 print('violation of definition: '),
	 print('Requirement '), print(ReqId),
	 print(' event: '), print(Event),
	 print(' is not a member of set of events.'),nl,false).

/*
	This rule checks for valid response
*/
check_response(ReqId,Response):-
	(response(Response) -> true;
	 print('violation of definition: '),
	 print('Requirement '), print(ReqId),
	 print(' response: '), print(Response),
	 print(' is not a member of set of responses.'),nl, false).

/*
	This rule checks for valid final state
*/
check_final_state(ReqId, FinalState):-
	(state(FinalState) -> true;
	 print('violation of definition: '),
	 print('Requirement '), print(ReqId),
	 print(' final state: '), print(FinalState),
	 print(' is not a member of set of states.'),nl, false).

/*
	This rule checks for valid requirement definition
*/
check_definition(ReqId,StartState,Event,ResponseToEvent,FinalState):- 
	(check_start_state(ReqId,StartState) -> false;
	 check_event(ReqId,Event) -> false;
	 check_response(ReqId,ResponseToEvent) -> false;
	 check_final_state(ReqId,FinalState) -> false;
	 true).

/*
	This rule checks for duplicate definition of initial
*/
check_duplicate_initial:-
	initial(X),
	initial(Y),
	(X \= Y -> print('violation of general rule: duplicate initial state definition detected'),nl,!),
	false.

/*
	This rule checks for invalid initial state
*/
check_invalid_initial:-
	initial(X),
	(not(state(X)) -> print('initial state: '), print(X), print(' is not a member of set of states.'),nl,!),
	false.

/*
	This rule checks for general rule 1: there is one and only one valid initial state definition and which must be a valid state
*/
check_general_rule_1:-
	print('Checking general rule 1 ...'), nl,
	not(check_invalid_initial),
	not(check_duplicate_initial).

/*
	This rule checks for valid state in requirement
*/
state_in_req(State) :-
	req(_,State,_,_,_) -> true;
	(req(_,_,_,_,State) -> true; false).

/*
	This rule iterates through all the states
*/
iterate_states :-
	state(X),
	(state_in_req(X) -> print('');print('state '), print(X), print(' is not present in any requirement'),nl,true),
	false.

/*
	This rule checks for general rule 2: All defined states must appear in at least one requirement
*/
check_general_rule_2 :-
	print('checking general rule 2 ...'), nl,
	not(iterate_states).

/*
	This rule checks for valid events in a requirement
*/
event_in_req(Event) :-
	req(_,_,Event,_,_) -> true;
	false.

/*
	This rule iterates through all the events
*/
iterate_events :-
	event(X),
	(event_in_req(X) -> print('');print('event '), print(X), print(' is not present in any requirement'),nl,true),
	false.

/*
	This rule checks for general rule 3: All defined events must appear in at least one requirement
*/
check_general_rule_3 :-
	print('checking general rule 3 ...'), nl,
	not(iterate_events).

/*
	This rule checks for response in requirement
*/
response_in_req(Response) :-
	req(_,_,_,Response,_) -> true;
	false.

/*
	This rule iterates through all the responses
*/
iterate_responses :-
	response(X),
	(response_in_req(X) -> print('');print('response '), print(X), print(' is not present in any requirement'),nl,true),
	false.

/*
	This rule checks for general rule 4: All defined responses must appear in at least one requirement
*/
check_general_rule_4 :-
	print('checking general rule 4 ...'), nl,
	not(iterate_responses).

/*
	This rule iterates through all of the given requirements
*/

iterate_reqs :-
	X = 0,
	req(ReqId1,_,_,_,_),
	req(ReqId1,_,_,_,_),
	req(ReqId1,S1,E1,R1,F1),
	req(ReqId1,S2,E2,R2,F2),
	(E1 == E2 -> false;(E1 \= E2 -> print(X),print(' duplicate found for '), print(ReqId1), nl,true; false)).
/*
	This rule checks for general rule 5: All defined requirement identifiers must be unique
*/
check_general_rule_5 :-
	print('NOT WORKING! checking general rule 5 ...'), nl,
	not(iterate_reqs).

/*
	This rule checks for general rule 6: all requirement identifiers must be unique
*/
check_general_rule_6 :-
	print('NOT IMPLEMENTED! checking general rule 6 ...'), nl.

/*
	This rule checks for all the valid parameters other than Requirement ID
*/
check_other_params(ReqId):-
	req(ReqId,StartState,Event,Response,FinalState),
	(not(state(StartState)) -> print('start state: '), print(StartState), print(' is not defined for req id: '), print(ReqId),nl;true),
	(not(event(Event)) -> print('event: '), print(Event), print(' is not defined for req id: '), print(ReqId),nl;true),
	(not(response(Response)) -> print('response: '), print(Response), print(' is not defined for req id: '), print(ReqId),nl;true),
	(not(state(FinalState)) -> print('final state: '), print(FinalState), print(' is not defined for req id: '), print(ReqId),nl;true).

/*
	This rule checks for all the requirements
*/
check_reqs:-
	req(ReqId,_,_,_,_),
	check_other_params(ReqId),
	false.

/*
	This rule checks for general rule 7: For each requirement, each state, event and response must be defined
*/
check_general_rule_7 :-
	print('checking general rule 7 ...'), nl,
	not(check_reqs).
/*
	This rule iterates through requirements for rule 1.1
*/
rule_1_1_iterate_reqs :-
	req(_,StartState,Event,_,FinalState1),
	req(_,StartState,Event,_,FinalState2),
	(FinalState1 \= FinalState2 -> print('violation of rule 1.1: more than one exit for start state: '),
	 print(StartState), print(' and event: '), print(Event), nl,!;false).

/*
	This rule checks for special rule 1.1: There must be only one exit for an event clause for a given event
*/
check_rule_1_1 :-
	print('checking rule 1.1 ...'),nl,
	rule_1_1_iterate_reqs.

/*
	This rule checks for reachability of target state from specified initial state
*/
check_reachability(InitialState,TargetState):-
	(req(ReqId,InitialState,_,_,X)->
	(X \= TargetState -> 
	check_reachability(X,TargetState); false);
	print('state: '), print(TargetState), print(' is not reachable '),nl,!).

/*
	This rule iterates through requirements for rule 1.2
*/
rule_1_2_iterate_reqs(InitialState) :-
	state(TargetState),
	(InitialState \= TargetState ->	check_reachability(InitialState,TargetState)),
	false.

/*
	This rule checks for special rule 1.2
*/
check_rule_1_2 :-
	print('checking rule 1.2 ...'), nl,
	initial(InitialState),
	not(rule_1_2_iterate_reqs(InitialState)).

/*
	This rule iterates through requirements for rule 1.3
*/
rule_1_3_iterate_reqs(HazardState,InitialState) :-
	(req(_,InitialState,_,_,X) -> 
	(not(safe(X)) -> rule_1_3_iterate_reqs(HazardState,X);false);
	 print('state: '), print(HazardState), print(' is not leading to a safe state.'),nl,!).

/*
	This rule checks for special rule 1.3
*/
rule_1_3_iterate_hazard_states :-
	print('checking rule 1.3 ...'), nl,
	hazard(HazardState),
	rule_1_3_iterate_reqs(HazardState,HazardState),
	false.

check_rule_1_3 :-
	not(rule_1_3_iterate_hazard_states).

rule_1_4_iterate(RecurrentState,InitialState):-
	(req(_,InitialState,_,_,X) ->
	(RecurrentState \= X -> rule_1_4_iterate(RecurrentState,X); false);
	print('state: '), print(RecurrentState), print(' is not a valid recurrent state.'),nl,!),
	false.

rule_1_4_iterate_reqs(RecurrentState,InitialState) :-
	req(_,InitialState,_,_,X),
	rule_1_4_iterate(RecurrentState,X).

check_rule_1_4 :-
	print('checking rule 1.4 ...'), nl,
	recurrent(RecurrentState),
	rule_1_4_iterate_reqs(RecurrentState,RecurrentState),
	false.
/*
	These are the test cases to be ran one at a time.
*/
list_violations:-
	check_general_rule_1,
	check_general_rule_2,
	check_general_rule_3,
	check_general_rule_4,
	check_general_rule_5,
	check_general_rule_6,
	check_general_rule_7,
	check_rule_1_1,
	check_rule_1_2,
	check_rule_1_3,
	check_rule_1_4,
%	testing,
	nl.
