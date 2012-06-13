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