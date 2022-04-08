function C_D = compute_C_D()
t = get_tempest_characteristics();
close all
% Compute necessary vars for C_D equation
s = 1 - (2 * (t.fuselage_diameter / t.b)^2);

e_0 = 1 / ((1 / (0.99 * s)) + 0.38 * t.C_D0 * pi * t.AR);

k_1 = 1 / (pi * e_0 * t.AR);

C_LminD = t.a * (t.alpha_wing_minD - t.alpha_L0);

C_Dmin = t.C_fe * (t.S_wet / t.S_ref);

% Compute C_D
C_D = C_Dmin + (k_1 * ((t.C_L - C_LminD).^2));
end