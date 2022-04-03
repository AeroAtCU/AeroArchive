function omega_model = MODEL_3(theta, c)
% data: Holds the measured data
% c: hold all constants of the aparatus
% I don't know of a cleaner way to implement these
% massive eqautions.

% Numerator Additions
T1 = (c.m_d + c.m_supp) * c.g * theta * c.r_d * sin(c.beta);

T2 = c.m_p * c.g * (theta * c.r_d * sin(c.beta) + c.r_p * (cos(c.beta) - cos(c.beta + theta))) +...
    theta * c.M0;

% Denominators (added)
T3 = (c.m_d + c.m_p) * c.r_d^2 +...
    c.m_d * c.k^2 +...
    0.5 * c.m_p * c.r_of_p^2;

%    c.m_p * c.r_p^2 +...


%!!! ?
T4 = c.m_d * (c.r_p^2 + c.r_d^2 + 2 * c.r_p * c.r_d * cos(theta));

omega_model = sqrt((T1 + T2) ./ (0.5 * (T4 + T3)));

end
