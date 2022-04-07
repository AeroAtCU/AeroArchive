function [theta_exp, w_exp, v_exp] = LCSDATA(filename)

exp_data = IMPORTDATA(filename, true);

start_deg = rem(exp_data.wheel_pos,360);
start_deg = start_deg(1);

offset = exp_data.wheel_pos(1) - start_deg;

theta_exp = exp_data.wheel_pos - offset;
w_exp = exp_data.wheel_speed;
v_exp = exp_data.slide_speed;

end