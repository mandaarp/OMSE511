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

