function plott(pos_rad, t_step, theta_d)
figure; hold on;
plot(t_step, pos_rad)
%plot((sym_t(1001:2001)-1), (sym_theta(1001:2001) + 0.25))
plot(0,0)
title({"Flexible Arm Step Response";})
xlabel("Time [s]")
ylabel("Theta [rad]")

% Plot some guides
plot(linspace(1,1,10),linspace(theta_d-theta_d*.1,theta_d+theta_d*.1,10),'markerfacecolor','r');

plot(linspace(0.5-1*.2,1+1*.2,10),linspace(theta_d+theta_d*0.1,theta_d+theta_d*0.1,10),'k');
plot(linspace(0.5-1*.2,1+1*.2,10),linspace(theta_d-theta_d*0.1,theta_d-theta_d*0.1,10),'k');
legend("Model Angle", "Experimental Angle","t = 1s","theta = +/- 10%",'Location','se')
end