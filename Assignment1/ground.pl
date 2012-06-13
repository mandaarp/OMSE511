%
% States
%

state(init).
state(normal).
state(hot).
state(cold).
state(shutdown).
state(scramed).

%
% Events
%

event(sys_start).
event(sys_shutdown).
event(temp_low).
event(temp_high).
event(temp_normal).
event(temp_critical).
event(sys_init).

%
% Responses
%

response(do_nothing).
response(lower_rods).
response(raise_rods).
response(scram).
