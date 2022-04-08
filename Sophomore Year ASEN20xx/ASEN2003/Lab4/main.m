% Main
%close all; clear all; clc;

% Import the data and necessary constants
b1 = import_data("unbalanced_1")
c = import_data("constants")
c.M0 = -0.9
c.beta = 0.093
c.g = 9.81
c.r_p = 0.178;
c.r_of_p = 0.019;
c.pp = 0.019;
c.k = 0.203;
c.m_d = 11.7;
c.m_s = 0.7;
c.m_p = 3.4;

% Run all models (defined below)
b1 = run_models(b1, c);


% Use plot tool
plot_helper(b1, "compare models")

% It's only cause we haven't made all the models yet
disp("ignore the warnings")

disp("MODEL_3(pi,c):")
MODEL_3(pi,c)

%% Functions that don't need their own file
function [data] = run_models(data, c)

data.omega_model1 = MODEL_1(data.theta, c);
data.omega_model2 = MODEL_2(data.theta, c);
data.omega_model3 = MODEL_3(data.theta, c);
data.omega_model4 = MODEL_4(data.theta, c);

end