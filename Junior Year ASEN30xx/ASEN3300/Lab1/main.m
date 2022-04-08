%Main
%0.25A, 0.5 freq
%0.5A, 0.2 freq

example_data = IMPORTDATA(".\real_data\G10_Unit05_MEMSMOTOR_RUN1");


example_data.input_rads = -1 * convangvel(example_data.input_rpm, "rpm", 'rad/s');
close all
hold on
plot(example_data.t, example_data.input_rads);
plot(example_data.t, example_data.gyro_output);
legend("input rpm", "gyro output")
ylabel("rad/s")
xlabel("time (s)")
title("ex plot")