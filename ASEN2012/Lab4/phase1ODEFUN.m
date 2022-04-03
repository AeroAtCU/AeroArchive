function results = phase1ODEFUN(inputvec, c)
% Calculate states for water phase
% inputvec = [pos.x; vel.x; pos.y; vel.y; m]
v = inputvec(5);

% First check if the water has been expelled
if (v >= c.vol_bottle)
    results = [0; 0; 0; 0; 0; 0];
else    
    pos.x = inputvec(1);
    vel.x = inputvec(2);
    pos.y = inputvec(3);
    vel.y = inputvec(4);
    m = inputvec(6);
     
    % If on stand, heading is stand heading. If not, calculate it.
    if (pos.x <= (c.stand_length * cos(c.theta_i)))
        theta = c.theta_i;
    else
        theta = atan( vel.y / vel.x);
    end
    
    % Find dv/dt
    dv = (c.discharge_coeff * c.A_t * ...
        sqrt( (2 / c.rho_water) * (c.p_abs * (c.vol_air / v)^(c.gamma) - c.p_atm)));
    
    % Find p (pressure in bottle)
    p = c.p_abs * ((c.vol_air / v) ^ c.gamma );
    
    % Find thrusts from p
    f.xThrust = (2 * c.discharge_coeff * c.A_t * (p - c.p_atm)) * cos(theta);
    f.yThrust = (2 * c.discharge_coeff * c.A_t * (p - c.p_atm)) * sin(theta);
         
    % Find dm/dt
    dm = - c.discharge_coeff * c.A_t * sqrt(2 * c.rho_water * (p - c.p_atm) );
     
    % Find drag components
    [f.xDrag, f.yDrag] = calcDrag([vel.x, vel.y, theta], c);
    
    % Find gravity component
    f.yGrav = c.g * m;
    
    % Find sum of forces
    f.xSum = f.xThrust - f.xDrag;
    f.ySum = f.yThrust - f.yDrag - f.yGrav;
    
    % Find sum of accelerations
    acc.x = f.xSum / m;
    acc.y = f.ySum / m;
    
    results = [vel.x; acc.x; vel.y; acc.y; dv; dm];
end
end
