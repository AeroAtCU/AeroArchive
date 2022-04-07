function results = calcPhase2Thrust(input, c)
% Calculate thrust from phase 2 mass. For finding thrust outside of ODE45
% input = [p1, p1, ..., pn]]
m = input;
% Find pressure from mass
p = c.p_end .* (m ./ c.m_air).^c.gamma;

% Find density of compressed air
rho = m ./ c.vol_bottle;

% Find T in bottle (not Texit)
T = p ./ (rho .* c.R);

% Find critical pressure (to determine if flow choked)
p_crit = p .* (2./ (c.gamma + 1)) .^ (c.gamma ./ (c.gamma - 1));

% Determine if choked (pound is <= ?)
if (p_crit > c.p_atm)
    T_exit = (2 ./ (c.gamma +1)) .* T;
    V_exit = sqrt(c.gamma .* c.R .* T_exit);
    rho_exit = p_crit ./ (c.R .* T_exit);
    p_exit = p_crit;
else
    M_exit = sqrt((((p ./ c.p_atm) .^ ((c.gamma - 1) ./ c.gamma)) - 1) .* (2 ./ (c.gamma - 1)));
    T_exit = T .* ((1 + M_exit.^2 .* ((c.gamma - 1) ./ 2)).^(-1));
    V_exit = M_exit .* sqrt(c.gamma .* c.R .* T_exit);
    rho_exit = c.p_atm ./ (c.R .* T_exit);
    p_exit = c.p_atm;
end

% Find dm from rho, V exit
dm = - c.discharge_coeff .* rho_exit .* c.A_t .* V_exit;

% Find thrust 
f.Thrust = (- dm) .* V_exit + (p_exit - c.p_atm) .* c.A_t;

results = f.Thrust;
end
