%
%  States
%
state(init).
state(startup).
state(over_temp).
state(operational).
state(under_temp).
state(overheat_shutdown).
state(sys_shutdown).
state(noheat_shutdown).
state(shutdown).
state(wayovertemp).	     % will appear as a hazardous state to test rule 1.3
state(unreachable).          % will appear in a requirement, but will be unreachable
state(solitary_state).       % does not appear in any requirements

%
%  State types
%

initial(init).
initial(operational).  % duplicate initial state
initial(omnomnomnom).  % duplicate initial state non-existant

safe(startup).
safe(operational).
safe(under_temp).
safe(overheat_shutdown).
safe(sys_shutdown).
safe(noheat_shutdown).
safe(off).

hazard(over_temp).
hazard(wayovertemp).	     % will be used to test rule 1.3

recurrent(operational).
recurrent(noheat_shutdown).  % violates rule 1.4

%
%  Events
%

event(initiate).
event(init_complete).
event(overtemp).
event(undertemp).
event(operatingtemp).
event(not_cooling).
event(operator_shutdown).
event(not_heating).
event(safe_off).
event(solitary_event).       % does not appear in any requirements
event(wayway_overtemp).	     % will be used to test rule 1.3

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
response(solitary_response). % does not appear in any requirements

%
%  Pathological facts
%


