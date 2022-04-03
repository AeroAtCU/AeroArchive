function results = phase2ODEFUN(inputvec, c)
% Calculate states for gas phase
% inputvec = [xpos; xvel; ypos; yvel;]
vel.x = inputvec(2);
vel.y = inputvec(4);
m = inputvec(5);

% Find pressure from mass
p = c.p_end * (m / c.m_air)^c.gamma;

% Find density of compressed air
rho = m / c.vol_bottle;

% Find T in bottle (not Texit)
T = p / (rho * c.R);

% Find critical pressure (to determine if flow choked)
p_crit = p * (2/ (c.gamma + 1)) ^ (c.gamma / (c.gamma - 1));

% Determine if choked (pound is <= ?)
T_exit = nan;
V_exit = nan;
rho_exit = nan;
if (p_crit > c.p_atm)
    T_exit = (2 / (c.gamma +1)) * T;
    V_exit = sqrt(c.gamma * c.R * T_exit);
    rho_exit = p_crit / (c.R * T_exit);
    p_exit = p_crit;
else
    M_exit = sqrt((((p / c.p_atm) ^ ((c.gamma - 1) / c.gamma)) - 1) * (2 / (c.gamma - 1)));
    T_exit = T * ((1 + M_exit^2 * ((c.gamma - 1) / 2))^(-1));
    V_exit = M_exit * sqrt(c.gamma * c.R * T_exit);
    rho_exit = c.p_atm / (c.R * T_exit);
    p_exit = c.p_atm;
end

% Find dm from rho, V exit
dm = - c.discharge_coeff * rho_exit * c.A_t * V_exit;

% Find heading
theta = atan( vel.y / vel.x);

% Find thrust from dm
m_total = m + c.m_bottle;

% Find thrust 
f.Thrust = (- dm) * V_exit + (p_exit - c.p_atm) * c.A_t;
f.xThrust = f.Thrust * cos(theta);
f.yThrust = f.Thrust * sin(theta);
f.yGrav = c.g * m_total;

% Find drag forces
[f.xDrag, f.yDrag] = calcDrag([vel.x, vel.y, theta], c);

% Find sum of forces
f.xSum = f.xThrust - f.xDrag;
f.ySum = f.yThrust - f.yDrag - f.yGrav;

% Find accelerations
acc.x = f.xSum / m_total;
acc.y = f.ySum / m_total;

% Stop when bottle press == atm pressure (~0.0019 Pa)
if (p >= c.p_atm) 
    results = [vel.x; acc.x; vel.y; acc.y; dm];
else
    results = [0; 0; 0; 0; 0];
end
end
