%
%  Requirements
%

req(id01, init, initiate, do_nothing, startup).
req(id02, startup, init_complete, operate, operational).
req(id03, operational, overtemp, start_pump, over_temp).
req(id04, operational, undertemp, stop_pump, under_temp).
req(id05, over_temp, not_cooling, panic_hot, overheat_shutdown).
req(id06, operational, operator_shutdown, start_shutdown, sys_shutdown).
req(id07, under_temp, not_heating, panic_cold, noheat_shutdown).
req(id08, overheat_shutdown, safe_off, do_nothing, shutdown).
req(id09, overheat_shutdown, safe_off, do_nothing, shutdown).
req(id10, noheat_shutdown, safe_off, do_nothing, shutdown).
req(id11, over_temp, operatingtemp, operate, operational).
req(id12, under_temp, operatingtemp, operate, operational).

%
%  Pathological requirements
%

req(id09, noheat_shutdown, safe_off, do_nothing, shutdown).     % duplicate id
req(id20, no_state, safe_off, do_nothing, shutdown).            % nonexistant initial state
req(id21, noheat_shutdown, no_event, do_nothing, shutdown).     % nonexistant event
req(id22, noheat_shutdown, safe_off, no_response, shutdown).    % nonexistant response
req(id23, noheat_shutdown, safe_off, do_nothing, no_state).     % nonexistant next state

req(id24, noheat_shutdown, safe_off, do_nothing, operational).  % violates rule 1.1 - see id09
req(id25, unreachable, safe_off, do_nothing, operational).      % violates rule 1.2
req(id26, over_temp, safe_off, do_nothing, operational).        % violates rule 1.2
req(id27, over_temp, wayway_overtemp, do_nothing, wayovertemp). % violates rule 1.3


