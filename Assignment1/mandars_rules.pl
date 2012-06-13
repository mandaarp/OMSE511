/*
 	Course: OMSE 531 (Software Requirements Engineering)
	Assignment No.: 1
	Term: Spring 2012
	Student Name: Mandar Patil
	Email: mandar@pdx.edu
	
	Objective:
	To build a framework for formal requirements that will generate natural
	language specification from a formal representation of finite state
	automata.

	Description:
	This file contains Prolog code to (1) validate each requirement adheres to
	the facts in ground.pl file and (2) generate natural language specification
	from the requirements.
*/

/*
	This rule validates each individual requirement's element - Start State, 
	Event, Response to Event, Final State separately and finally validates if
	the requirement is one of the facts from ground.pl or not. It also prints
	the message to the user accordingly.
*/
validate_requirement(ReqId,StartState,Event,ResponseToEvent,FinalState) :-
	(state(StartState),
	event(Event),
	response(ResponseToEvent),
	state(FinalState),
	req(ReqId,StartState,Event,ResponseToEvent,FinalState) ->
	print('Requirement: '), 
	print(ReqId), print(' is valid.'),nl,true;
	print('Requirement: '), print(ReqId), print(' is invalid!!!'),nl,false).

/*
	This rule extracts the parameter values for - Start State, Event, 
	Response To Event and Final State variables and passes it to the 
	validate_requirement rule.
*/	
validate_id(ReqId,_,_,_,_) :- 	
	req(ReqId, StartState, Event, ResponseToEvent, FinalState),
	validate_requirement(ReqId, StartState, Event, ResponseToEvent, FinalState).

/*
	This rule passes the requirement identifier to validate_id rule, for 
	validation.
*/
valid_req_spec(ReqId) :- validate_id(ReqId,_,_,_,_).

/*
	This rule converts a requirement into its equivalent natural language 
	specification and displays it to the user.
*/
convert_to_nl(ReqId, StartState, Event, ResponseToEvent, FinalState) :- 
	print('Req '), 
	print(ReqId), 
	print(': If the system is in a '), 
	print(StartState), 
	print(' state, and '), 
	print(Event), 
	print(' occurs, the system shall respond with '), 
	print(ResponseToEvent), 
	print(' and move to the '), 
	print(FinalState), 
	print(' state.'), 
	nl.

/*
	This rule extracts requirement parameter values from requirement facts
	loaded from req.pl file. Then it extracts other parameter values for 
	current requirement and passes it to convert_to_nl rule to generate its
	natural language specification.
*/
gen_nl_reqs :- 	
	req(ReqId, _, _, _, _),
	req(ReqId, StartState, Event, ResponseToEvent, FinalState),
	convert_to_nl(ReqId, StartState, Event, ResponseToEvent, FinalState), 
	false.
/*
	This rule is an additional work. I was not sure if the validation before
	natural language specification is expected or not. Hence, I have implemented
	this additional rule which generates natural language specification for all
	the requirements loaded from req.pl file only if its validation is successful.
*/
validate_and_gen_nl_reqs :- 	
	req(ReqId, _, _, _, _),
		(req(ReqId, StartState, Event, ResponseToEvent, FinalState) ->
			(validate_requirement(ReqId, StartState, Event, ResponseToEvent, FinalState) -> 
				convert_to_nl(ReqId, StartState, Event, ResponseToEvent, FinalState),true;
				false),
			true;false), 
		false.

