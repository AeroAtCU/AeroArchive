%{
Lab Group 2
    Ian Adler - 106505004
    Collin Kasunic - 109025542
    Dominic Plaia - 109194706
ASEN 3128 - Lab 3 - Quadcopter Control Lab
Prof. Brian Argrow
Start: 2/19/21    Due: 3/5/21
%}
%% Housekeeping
clear all; close all; clc;

%% Variables and Constants
global m r_cg k Ix Iy Iz v mu g
m = 0.068;          %Quadcopter Mass,       [kg]
r_cg = 0.06;        %Prop Distance to CG,   [m]
k = 0.0024;         %Control Moment Coeff,  [m]
%Ix = 6.8*10^(-5);   %Body MOI X,            [kg*m^2]
%Iy = 9.2*10^(-5);   %Body MOI Y,            [kg*m^2]
% iz = 1.35
Ix = 5.8*10^(-5);   %Body MOI X,            [kg*m^2]
Iy = 7.2*10^(-5);   %Body MOI Y,            [kg*m^2]
Iz = 1*10^(-4);  %Body MOI Z,            [kg*m^2]
v = 1*10^(-3);      %Aero Force Coeff,      [N/(m/s)^2]
mu = 2*10^(-6);     %Aero Moment Coeff,     [N*m/(rad/s)^2]
g = 9.81;           %Gravity lol            [m/s^2]

%% Problem 4
close all;
% DECLARE INITIAL CONDITIONS
xPos = 0; yPos = 0; zPos = -10;   %Intertial Positions,               [m]
phi = 0; theta = 0; psi = 0;    %Euler Angles,                      [rad]
U = 0; V = 0; W = 0;            %Intertial Velocity in Body Frame,  [m/s]
p = 0; q = 0; r = 0;            %Angular Velocity in Body Frame,    [rad/s]


controlVec = [-.068*g;0;0;0];

global control_law
control_law = 'Lc';

switch control_law
    case 'Lc'
        V = 0;
        U = 0;
    case 'Mc'
        V = 0;
        U = 0.44;
end

IC = [xPos,yPos,zPos,phi,theta,psi,U,V,W,p,q,r];

% SETUP AND EVALUATE ODE
% controlVec = [0;0;0;0];
timeSpan = [0 2.1];
[tout, state] = ode45(@(t,state) QuadEOMLinear(t,state,controlVec), timeSpan, IC);
indices = find(abs(state)<10^-9); % GET INDICES OF ALL SMALL VALUES
state(indices) = 0; % AND SET THEM TO ZERO (<nano-units)


% OTHER USEFUL PLOTS
switch control_law
    case 'Lc'
        figure;
        subplot(1,2,1)
        plot( tout, state(:,2)); title("Y Position vs Time")
        xlabel("Time [s]"); ylabel("Distance [m]");
        subplot(1,2,2)
        plot( tout, state(:,8)); title("Y Velocity vs Time")
        xlabel("Time [s]"); ylabel("Velocity [m/s]");
        %
        %         [~,idx] = min(abs(state(:,2)-1)); % target y position is 1
        %         yTargetValue = state(idx, 2);
        %         yTargetTime = tout(idx, 1);
        %         fprintf('Y TARGET: reached @ t=%.2f // (actual position = %.4f\n', yTargetTime, yTargetValue)
        %
    case 'Mc'
        figure;
        
        subplot(1,2,1)
        plot( tout, state(:,1)); title("X pos over time")
                xlabel("Time [s]"); ylabel("Distance [m]");

        subplot(1,2,2)
        plot( tout, state(:,7)); title("U vel over time")
                xlabel("Time [s]"); ylabel("Velocity [m/s]");

        
end

% PLOT IF YOU WANT
if true
    figure;
    prob3plotter(tout, state, "Control Law Implementation", true); %last entry is groundplane
    hold on
end

%% Functions
function motorForces = computeMotorForces(controlVec)
%% Declare Globals
global r_cg k
%% Begin Function
controlMatrix = [-1,-1,-1,-1;...
    -(r_cg/sqrt(2)),-(r_cg/sqrt(2)),(r_cg/sqrt(2)),(r_cg/sqrt(2));...
    (r_cg/sqrt(2)),-(r_cg/sqrt(2)),-(r_cg/sqrt(2)),(r_cg/sqrt(2));...
    k,-k,k,-k];

forcesVec = inv(controlMatrix)*controlVec;
F1 = forcesVec(1);
F2 = forcesVec(2);
F3 = forcesVec(3);
F4 = forcesVec(4);

motorForces = [F1;F2;F3;F4];
end
function [] = prob3plotter(tout, state, title_string, groundplane)
plot3(state(:,1), state(:,2), -1*state(:,3)); grid on
xlim_tmp = xlim; % TEMPORARILY STORE INTERNAL LIMITS
ylim_tmp = ylim; % TEMPORARILY STORE INTERNAL LIMITS
xlabel('X Position [m]'); ylabel('Y Position [m]'); zlabel('Z Position [m]');
title(title_string)
hold on
plot3(state(1,1), state(1,2), -1*state(1,3), '*g','LineWidth',2)
plot3(state(end,1), state(end,2), -1*state(end,3), '*r','LineWidth',2)

if groundplane
    patch([xlim_tmp(2) xlim_tmp(1) xlim_tmp(1) xlim_tmp(2)],...
        [ylim_tmp(2) ylim_tmp(2) ylim_tmp(1) ylim_tmp(1)],...
        [0 0 0 0]); % PLOT PLANE (btw can add colorspec as another array)
end
legend("Path", "Start Pos", "End Pos", "Ground Plane")
end
function dState = QuadEOMLinear(t, state, control)
% Declare Variables
global m r_cg k Ix Iy Iz v mu g control_law
% STATE
%Intertial Positions, [m]
xPos = state(1); yPos = state(2); zPos = state(3);
%Euler Angles, [rad]
phi = state(4); theta = state(5); psi = state(6);
%Intertial Velocity in Body Frame, [m/s]
U = state(7); V = state(8); W = state(9);

%Angular Velocity in Body Frame, [rad/s]
p = state(10); q = state(11); r = state(12);

%% Solve Linear action
xDot = U; yDot = V; zDot = W;
phiDot = p; thetaDot = q; psiDot = r;
uDot = -g*theta; vDot = g*phi; wDot = control(1)/m;

pDot = control(2)/Ix;
qDot = control(3)/Iy;
rDot = control(4)/Iz;

%Implement the control law
switch control_law
    case 'Lc'
        vr = -0.44;
        k1 = 0.0099;
        k2 = 0.0049;
        k3 = -0.0003;
        %delta_Lc = -0.004*p - 0.009*phi + 0.002*(vr- V);
        delta_Lc = -k1*p -k2*phi + k3*(vr - V);
        pDot = delta_Lc/Ix;
        
    case 'Mc'
        ur = 0;
        k1 = 0.0099;
        k2 = 0.0049;
        k3 = -0.0003;
        delta_Mc = -k1*q -k2*theta - k3*(ur - U); % yes, shoudld be inus k3
        qDot = delta_Mc/Iy;
end


dState = [xDot;yDot;zDot;phiDot;thetaDot;psiDot;uDot;vDot;wDot;pDot;qDot;rDot];
end

function dState = QuadEOMNonLinear(t, state, control)
% Declare Variables
global m r_cg k Ix Iy Iz v mu g
% STATE
%Intertial Positions, [m]
xPos = state(1); yPos = state(2); zPos = state(3);
%Euler Angles, [rad]
phi = state(4); theta = state(5); psi = state(6);
%Intertial Velocity in Body Frame, [m/s]
U = state(7); V = state(8); W = state(9);
vVec = [U;V;W];
V_a = norm(vVec,2);
%Angular Velocity in Body Frame, [rad/s]
p = state(10); q = state(11); r = state(12);
angVec = [p;q;r];

%% Solve Forces and Moments using Control Matrix
controlMatrix = [-1,-1,-1,-1;...
    -(r_cg/sqrt(2)),-(r_cg/sqrt(2)),(r_cg/sqrt(2)),(r_cg/sqrt(2));...
    (r_cg/sqrt(2)),-(r_cg/sqrt(2)),-(r_cg/sqrt(2)),(r_cg/sqrt(2));...
    k,-k,k,-k];

forcesVec = inv(controlMatrix)*control;
F1 = forcesVec(1);
F2 = forcesVec(2);
F3 = forcesVec(3);
F4 = forcesVec(4);

% -- FORCES --
F_Control = [0;0;-F1-F2-F3-F4];
F_Drag = -v*V_a*vVec;
F_g = [-m*g*sin(theta);m*g*cos(theta)*sin(phi);m*g*cos(theta)*cos(phi)];
F_tot = F_Control + F_Drag + F_g;

% -- MOMENTS --
M_Aero = -mu * norm(angVec,2) * angVec;
M_Control = [(r_cg/sqrt(2))*(-F1-F2+F3+F4);...
    (r_cg/sqrt(2))*(F1-F2-F3+F4);...
    k*(F1-F2+F3-F4)];
M_tot = M_Aero + M_Control;

%% Begin EOMs
%DotPos
DCM_POS = [cos(theta)*cos(psi), cos(theta)*sin(psi), -sin(theta);...
    sin(phi)*sin(theta)*cos(psi) - cos(phi)*sin(psi), sin(phi)*sin(theta)*sin(psi) + cos(phi)*cos(psi), sin(phi)*cos(theta);...
    cos(phi)*sin(theta)*cos(psi) + sin(phi)*sin(psi), cos(phi)*sin(theta)*sin(psi) - sin(phi)*cos(psi), cos(phi)*cos(theta)]';

dotPos = DCM_POS * vVec;
xDot = dotPos(1); yDot = dotPos(2); zDot = dotPos(3);
%DotAngles
DCM_ANG = [1 sin(phi)*tan(theta) cos(phi)*tan(theta);...
    0 cos(phi) -sin(phi);...
    0 sin(phi)*sec(theta) cos(phi)*sec(theta)];

angDot = DCM_ANG * angVec;
phiDot = angDot(1); thetaDot = angDot(2); psiDot = angDot(3);
%DotVels
dotVels = [r*V - q*W;p*W - r*U;q*U - p*V] + (F_tot/m);
uDot = dotVels(1); vDot = dotVels(2); wDot = dotVels(3);
%DotAngVels
MOIVec = [1/Ix, 1/Iy, 1/Iz]';
dotAngVels = [(Iy-Iz)*q*r/Ix; (Iz-Ix)*p*r/Iy; (Ix-Iy)*p*q/Iz]...
    + MOIVec .* M_tot;
% pDot = dotAngVels(1); % now control law
qDot = dotAngVels(2); rDot = dotAngVels(3);

vr = 0;
k1 = 0.0049;
k2 = 0.0099;
k3 = 0.0751;
delta_Lc = -k1*p - k2*phi + k3*(vr- V);
pDot = delta_Lc/Ix;
%fprintf('vr = %s\n', vr)
%dState Vec
dState = [xDot;yDot;zDot;phiDot;thetaDot;psiDot;uDot;vDot;wDot;pDot;qDot;rDot];
end