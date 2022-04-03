function omega_model = MODEL_2(theta, c)
% data: Holds the measured data
% c: hold all constants of the aparatus
% I don't know of a cleaner way to implement these
% massive eqautions.

omega_model = sqrt(...
    (2 * (theta * c.r_d * sin(c.beta))* c.g * (c.m_d + c.m_supp) + ...
    theta * c.M0 - theta(1) * c.M0) ./ ...
    ((c.m_d + c.m_supp) * c.r_d^2 + c.m_d * c.k^2) );

end