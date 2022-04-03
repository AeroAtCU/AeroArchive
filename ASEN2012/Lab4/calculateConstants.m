function c = calculateConstants(c)
% Upper case for single letter things
% 
c.g = 9.81;
c.discharge_coeff = 0.8;
c.rho_air = 0.961;
c.vol_bottle = 0.002;
c.p_atm = 12.1;
c.gamma = 1.4;
c.rho_water = 1000;
c.d_throat = 0.021;
c.d_bottle = 0.105;
c.R = 287;
c.m_bottle = 0.15;
c.drag_coeff_testcase = 0.5;
c.p_gage = 50;
c.T_air = 300;
c.stand_height = 0.25;
c.stand_length = 0.5;
c.ground_pos = 0;
c.p_burst = 1034213.594;
c.FOS = 1.5;
c.p_max_allow = c.p_burst / c.FOS;
c.p_tol = 1;

c.p_atm = c.p_atm * 6894.7572931783;

c.vol_air = c.vol_bottle - c.vol_water; % vol_water can be changed
c.m_air = c.p_abs * c.vol_air / (c.R * c.T_air);
c.m_total = c.rho_water * c.vol_water + c.m_bottle + c.m_air; % make sure to add air mass

c.A = pi * (c.d_bottle / 2)^2; % bottle area (needs to be changed)
c.A_t = pi * (c.d_throat / 2)^2; % throat area
c.W = c.m_bottle * c.g;

c.p_end = c.p_abs * (c.vol_air / c.vol_bottle)^c.gamma;
c.T_end = c.T_air * (c.vol_air / c.vol_bottle)^(c.gamma - 1);
end
