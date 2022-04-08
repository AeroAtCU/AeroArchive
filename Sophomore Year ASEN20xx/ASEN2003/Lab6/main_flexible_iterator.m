% Iterative approach to optimizing flexible arm.
clear all; close all;

K_1 = 60; % K_ptheta Proportional by theta
K_2 = 3;% K_pd      Proportional by displacement
K_3 = 3; % K_Dtheta Derivative by theta
K_4 = 0; % K_Dd     Derivative by displacement
theta_d = 0.5

[pos_rad, t_step] = model_flexible(K_1, K_2, K_3, K_4);
minvals = [K_1, K_2, K_3, K_4, get_overshoot(pos_rad, theta_d)];

for K_1_iterval = 0:100
    for K_3_iterval = 0:50
        K_1 = K_1_iterval;
        K_3 = K_3_iterval;
        [pos_rad, t_step] = model_flexible(K_1, K_2, K_3, K_4);
        overshoot_percent = get_overshoot(pos_rad, theta_d);
        if check_overshoot(overshoot_percent)
            disp("K_1=" + K_1 + ", K_2=" + K_2 + ", K_3=" + K_3 + ", K_4=" + K_4)
            disp("Overshoot = " + get_overshoot(pos_rad, theta_d) + "%")
            minvals = [K_1, K_2, K_3, K_4, overshoot_percent];
        end
        break; break;
    end
end

close all
plott(pos_rad, t_step, theta_d)


function overshoot_percent = get_overshoot(pos_rad, theta_d)
overshoot_val = max(pos_rad) - theta_d;
overshoot_percent = 100*overshoot_val / theta_d;
end

function pass = check_overshoot(overshoot_percent)
pass = false;
target_percent = 10;
if overshoot_percent <= target_percent && overshoot_percent > 0
    pass = true;
end
end

function pass = check_settling_time(pos_rad, t_step)

end

