theta = deg2rad(0); % x axis
phi = deg2rad(0); % y axis
psi = deg2rad(45); % z axis
V_EE = [20; 10; 0]

L_EB = [cos(theta)*cos(psi), sin(phi)*sin(theta)*cos(psi) - cos(phi)*sin(psi), cos(phi)*sin(theta)*cos(psi)+sin(phi)*sin(psi);
        cos(theta)*sin(psi), sin(phi)*sin(theta)*sin(psi) + cos(phi)*cos(psi), cos(phi)*sin(theta)*sin(psi)-sin(phi)*cos(psi);
        -sin(theta)        , sin(phi)*cos(theta)                             , cos(phi)*cos(theta) ];


% V_EE = L_EB * V_BE
V_BE = L_EB' * V_EE