function LCS_plot(data, plot_title, x_var)
% Purpose: plot any dataset from 0-6 seconds

% Find the degree after 6 revolutions (doesn't start at 0)
rev_6_deg = data.wheel_pos(1) + 360*6;

% Find the index where it reaches 6 revolutions
rev_6_idx = interp1(data.wheel_pos,1:length(data.wheel_pos),rev_6_deg,'nearest');

% Plot by theta
if (x_var == "theta")
    figure; hold on;
    plot(data.actual_wheel_pos(1:rev_6_idx), data.slide_speed(1:rev_6_idx))
    plot(data.actual_wheel_pos(1:rev_6_idx), data.slide_speed_model(1:rev_6_idx))
    plot(data.actual_wheel_pos(1:rev_6_idx), data.residuals(1:rev_6_idx))
    legend('Measured','Model','Residuals')
    title(strcat("Predicted Slide Velocity by Theta, ", plot_title))
    xlabel('Theta [deg]')
    ylabel('Slide Speed [cm/s]')
    hold off
end

% Plot by time
if (x_var == "residuals")
    figure; hold on;
    plot(data.t(1:rev_6_idx), data.residuals(1:rev_6_idx))
    legend('Residuals')
    title(strcat("Slide Velocity Difference By Time, ", plot_title))
    xlabel('Time [s]')
    ylabel('Slide Speed Difference [cm/s]')
    hold off
end
end