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
Ix = 6.8*10^(-5);   %Body MOI X,            [kg*m^2]
Iy = 9.2*10^(-5);   %Body MOI Y,            [kg*m^2]
Iz = 1.35*10^(-4);  %Body MOI Z,            [kg*m^2]
v = 1*10^(-3);      %Aero Force Coeff,      [N/(m/s)^2]
mu = 2*10^(-6);     %Aero Moment Coeff,     [N*m/(rad/s)^2]
g = 9.81;           %Gravity lol            [m/s^2]

%% Problem 1
%
xPos = 0; yPos = 0; zPos = 0;   %Intertial Positions,               [m]
phi = 0; theta = 0; psi = 0;    %Euler Angles,                      [rad]
U = 0; V = 0; W = 0;            %Intertial Velocity in Body Frame,  [m/s]
p = 0; q = 0; r = 0;            %Angular Velocity in Body Frame,    [rad/s]

    
    controlVec = [-.068*g;0;0;0];
    colorVec = ["r","b","k","g","m","c"];
    
IC = [xPos,yPos,zPos,phi,theta,psi,U,V,W,p,q,r];
state = IC;

timeSpan = [0 5];
    [tout, state2b] = ode45(@(t,state) QuadEOM(t,state,controlVec), timeSpan, IC);
indices = find(abs(state2b)<10^-9); % GET INDICES OF ALL SMALL VALUES
state2b(indices) = 0; % AND SET THEM TO ZERO (<nano-units)
PlotAircraftSim(tout,state2b,ones(length(tout),4).*controlVec',colorVec)

%% Problem 2
motorForces = computeMotorForces(controlVec); %Works Great!
%
%% Problem 3
xPos = 0; yPos = 0; zPos = -10;   %Intertial Positions,               [m]
phi = 0; theta = 0; psi = 0;    %Euler Angles,                      [rad]
U = 0; V = 0; W = 0;            %Intertial Velocity in Body Frame,  [m/s]
p = 0; q = 0; r = 0;            %Angular Velocity in Body Frame,    [rad/s]

IC1 = [xPos,yPos,zPos,deg2rad(5),theta,psi,U,V,W,p,q,r];
IC2 = [xPos,yPos,zPos,phi,deg2rad(5),psi,U,V,W,p,q,r];
IC3 = [xPos,yPos,zPos,phi,theta,deg2rad(5),U,V,W,p,q,r];
IC4 = [xPos,yPos,zPos,phi,theta,psi,U,V,W,.1,q,r];
IC5 = [xPos,yPos,zPos,phi,theta,psi,U,V,W,p,.1,r];
IC6 = [xPos,yPos,zPos,phi,theta,psi,U,V,W,p,q,.1];
ICMat = [IC1;IC2;IC3;IC4;IC5;IC6];
controlVec = [-.068*g;0;0;0];
titString = ["Roll Deviation","Pitch Deviation","Yaw Deviation","Roll Rate Deviation","Pitch Rate Deviation","Yaw Rate Deviation"];

figure
for i = 1:6
    hold on
    timeSpan = [0 10];
    state = ICMat(i);
    [tout, state] = ode45(@(t,state) QuadEOM(t,state,controlVec), timeSpan, ICMat(i,:));
    indices = find(abs(state)<10^-9); % GET INDICES OF ALL SMALL VALUES
    state(indices) = 0; % AND SET THEM TO ZERO (<nano-units)
    subplot(2,3,i)
    prob3plotter(tout, state)
    xlim_tmp = xlim; % TEMPORARILY STORE INTERNAL LIMITS
    ylim_tmp = ylim; % TEMPORARILY STORE INTERNAL LIMITS
    patch([xlim_tmp(2) xlim_tmp(1) xlim_tmp(1) xlim_tmp(2)],...
          [ylim_tmp(2) ylim_tmp(2) ylim_tmp(1) ylim_tmp(1)],...
          [0 0 0 0]); % PLOT PLANE (btw can add colorspec as another array)  
    title(titString(i))
    hold on
end
sgtitle('[Q3] Non-linearized EOM Deviations (NO CONTROL)') 

%% Problem 4
figure
controlVec = [0;0;0;0];
for i = 1:6
    timeSpan = [0 10];
    state = ICMat(i);
    [tout, state] = ode45(@(t,state) QuadEOMLinear(t,state,controlVec), timeSpan, ICMat(i,:));
    indices = find(abs(state)<10^-9); % GET INDICES OF ALL SMALL VALUES
    state(indices) = 0; % AND SET THEM TO ZERO (<nano-units)
    subplot(2,3,i)
    prob3plotter(tout, state)
    xlim_tmp = xlim; % TEMPORARILY STORE INTERNAL LIMITS
    ylim_tmp = ylim; % TEMPORARILY STORE INTERNAL LIMITS
    patch([xlim_tmp(2) xlim_tmp(1) xlim_tmp(1) xlim_tmp(2)],...
          [ylim_tmp(2) ylim_tmp(2) ylim_tmp(1) ylim_tmp(1)],...
          [0 0 0 0]); % PLOT PLANE (btw can add colorspec as another array)  
    
    title(titString(i))
    hold on
end
sgtitle('[Q4] Linearized EOM Deviations (NO CONTROL)')

%% Problem 5


%% Functions
function [] = PlotAircraftSim(t,state_array,control_array,cVec)
    %% - Position Angles -
    LW = 2;
    figure
subplot(3,1,1); plot(t,state_array(:,1), cVec(1), "linewidth", LW); hold on; grid on
    xlabel('Time [s]'); ylabel('X Position [m]');
subplot(3,1,2); plot(t,state_array(:,2), cVec(1), "linewidth", LW); hold on; grid on
    xlabel('Time [s]'); ylabel('Y Position [m]');
subplot(3,1,3); plot(t,state_array(:,3), cVec(1), "linewidth", LW); hold on; grid on
    xlabel('Time [s]'); ylabel('Z Position [m]');
    sgtitle('Position vs Time');
    
    %% - Euler Angles -
    figure
subplot(3,1,1); plot(t,state_array(:,4), cVec(2), "linewidth", LW); hold on; grid on
    xlabel('Time [s]'); ylabel('Roll Angle [rad]');
subplot(3,1,2); plot(t,state_array(:,5), cVec(2), "linewidth", LW); hold on; grid on
    xlabel('Time [s]'); ylabel('Pitch Angle [rad]');
subplot(3,1,3); plot(t,state_array(:,6), cVec(2), "linewidth", LW); hold on; grid on
    xlabel('Time [s]'); ylabel('Yaw Angle [rad]');
    sgtitle('Euler Angles vs Time');

    %% - Inertial Velocity -
    figure
subplot(3,1,1); plot(t,state_array(:,7), cVec(3), "linewidth", LW); hold on; grid on
    xlabel('Time [s]'); ylabel('V in I_b [m/s]');
subplot(3,1,2); plot(t,state_array(:,8), cVec(3), "linewidth", LW); hold on; grid on
    xlabel('Time [s]'); ylabel('V in J_b [m/s]');
subplot(3,1,3); plot(t,state_array(:,9), cVec(3), "linewidth", LW); hold on; grid on
    xlabel('Time [s]'); ylabel('V in K_b [m/s]');
    sgtitle('Inertial Velocity vs Time');
    
        %% - Angular Velocity -
    figure
subplot(3,1,1); plot(t,state_array(:,10), cVec(4), "linewidth", LW); hold on; grid on
    xlabel('Time [s]'); ylabel('Roll Rate [rad/s]');
subplot(3,1,2); plot(t,state_array(:,11), cVec(4), "linewidth", LW); hold on; grid on
    xlabel('Time [s]'); ylabel('Pitch Rate [rad/s]');
subplot(3,1,3); plot(t,state_array(:,12), cVec(4), "linewidth", LW); hold on; grid on
    xlabel('Time [s]'); ylabel('Yaw Rate [rad/s]');
    sgtitle('Angular Velocity vs Time');

    %% - Control Vector - 
    figure
subplot(4,1,1); plot(t,control_array(:,1), cVec(5), "linewidth", LW); hold on; grid on
    xlabel('Time [s]'); ylabel('Control Force [N]');
subplot(4,1,2); plot(t,control_array(:,2), cVec(5), "linewidth", LW); hold on; grid on
    xlabel('Time [s]'); ylabel('L_c in I_b [Nm]');
subplot(4,1,3); plot(t,control_array(:,3), cVec(5), "linewidth", LW); hold on; grid on
    xlabel('Time [s]'); ylabel('M_c in J_b [Nm]');
subplot(4,1,4); plot(t,control_array(:,4), cVec(5), "linewidth", LW); hold on; grid on
    xlabel('Time [s]'); ylabel('N_c in K_b [Nm]');
    sgtitle('Control Inputs vs Time');
    
    %% - 3D Position Plot -
    figure
plot3(state_array(:,1), state_array(:,2), -1*state_array(:,3), cVec(6), "linewidth", LW); grid on
hold on; plot3(state_array(1,1), state_array(1,2), -1*state_array(1,3), '*r','LineWidth',2);
    xlabel('X Position [m]'); ylabel('Y Position [m]'); zlabel('Z Position [m]');
    title('3D Position Plot of Quadcopter')

end
function dState = QuadEOM(t, state, control)
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
                %[L/Ix;M/Iy;N/Iz] + [Lc/Ix;Mc/Iy;Nc/Iz];
pDot = dotAngVels(1); qDot = dotAngVels(2); rDot = dotAngVels(3);
    %dState Vec
    dState = [xDot;yDot;zDot;phiDot;thetaDot;psiDot;uDot;vDot;wDot;pDot;qDot;rDot];
end
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
function [] = prob3plotter(tout, state)
plot3(state(:,1), state(:,2), -1*state(:,3)); grid on
    xlabel('X Position [m]'); ylabel('Y Position [m]'); zlabel('Z Position [m]');
    hold on
plot3(state(1,1), state(1,2), -1*state(1,3), '*r','LineWidth',2)
end
function dState = QuadEOMLinear(t, state, control)
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
    
%% Solve Linear action
xDot = U; yDot = V; zDot = W;
phiDot = p; thetaDot = q; psiDot = r;
uDot = -g*theta; vDot = g*phi; wDot = control(1)/m;
pDot = control(2)/Ix; qDot = control(3)/Iy; rDot = control(4)/Iz;

    dState = [xDot;yDot;zDot;phiDot;thetaDot;psiDot;uDot;vDot;wDot;pDot;qDot;rDot];
end