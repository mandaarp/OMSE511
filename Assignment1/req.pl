%
% requirement
%

req(id_11, init, sys_start, raise_rods, cold).

req(id_21, cold, temp_normal, do_nothing, normal).
req(id_22, cold, sys_shutdown, lower_rods, shutdown).

req(id_31, normal, temp_low, raise_rods, cold).
req(id_32, normal, temp_high, lower_rods, hot).
req(id_33, normal, sys_shutdown, lower_rods, shutdown).

req(id_41, hot, temp_normal, do_nothing, normal).
req(id_42, hot, temp_crtitical, scram, scramed).
req(id_43, hot, sys_shutdown, lower_rods, shutdown).