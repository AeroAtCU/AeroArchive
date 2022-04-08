function motor_forces = ComputeMotorForces(Zc, Lc, Mc, Nc, R, km)
% Ian Adler - ASEN3128
% Purpose: Convert commanded moments and forces to rotor forces

% THIS IS WRONG FIX IT NEED INVERSE
controls_vector = [Zc, Lc, Mc, Nc]';
thrust_matrix = ([-1, -1, -1, -1;...
                        -R/sqrt(2), -R/sqrt(2), R/sqrt(2), R/sqrt(2);...
                         R/sqrt(2), -R/sqrt(2), -R/sqrt(2), R/sqrt(2);...
                         km, -km, km, -km]);

motor_forces = thrust_matrix\controls_vector;
end