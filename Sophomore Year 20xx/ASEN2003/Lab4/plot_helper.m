function plot_helper(data, option)

switch option
    case "raw"
        
        figure; hold on;
        plot(data.t, data.theta)
        plot(data.t, data.omega)
        legend('Theta','Omega')
        title(strcat("Raw Data Input - ",data.name), 'Interpreter', 'none')
        xlabel('Time [s]')
        ylabel('Angle [rad] [rad/s]')
        hold off
        
    case "compare models"
        figure; hold on;
        
        try
            plot(data.theta, data.omega, '.', 'MarkerSize', 10)
            plot(data.theta, data.omega_model1, 'LineWidth', 1.5)
            plot(data.theta, data.omega_model2, 'LineWidth', 1.5)
            plot(data.theta, data.omega_model3, 'LineWidth', 1.5)
            plot(data.theta, data.omega_model4, 'LineWidth', 1.5)
            
        catch
            warning("Something went wrong- are all your models working?")
        end
        
        legend('Measured','Model1','Model2','Model3','Model4')
        title(strcat("Measured and Predicted Omega - ",data.name), 'Interpreter', 'none')
        xlabel('Theta [rad]')
        ylabel('Angular Veloctiy [rad/s]')
        hold off
        
    case "something else"
end