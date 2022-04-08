  function [Alon, Blon,Mde] = lin_lon(input_vector,m,u0,theta0,Iy)
g = 9.81;

Xu = input_vector(1);
Xw = input_vector(2);
Xq = input_vector(3);
Xdu = input_vector(4);
Xdw = input_vector(5);
Zu = input_vector(6);
Zw = input_vector(7);
Zq = input_vector(8);
Zdu = input_vector(9);
Zdw = input_vector(10);
Mu = input_vector(11);
Mw = input_vector(12);
Mq = input_vector(13);
Mdu = input_vector(14);
Mdw = input_vector(15);



Alon = [Xu/m                                   , Xw/m                                   , 0                                               , -g*cos(theta0); ...
        Zu/(m - Zdw)                         , Zw/(m - Zdw)                             , (Zq + m*u0)/(m - Zdw)                           , (-m*g*sin(theta0))/(m - Zdw); ...
        (1/Iy)*(Mu + (Mdw*Zu)/(m - Zdw))   , (1/Iy)*(Mw + (Mdw*Zw)/(m - Zdw))          , (1/Iy)*(Mq + (Mdw*(Zq + m*u0))/(m - Zdw))       , (-Mdw*m*g*sin(theta0))/(Iy*(m-Zdw)); ...
        0                                      , 0                                      , 1                                               , 0 ];
    
S = 5500*(0.3048^2); 
u0 = 518*0.3048;
rho = 0.6601; %kg/m^3
c = 27.31*0.3048;

Xde = 0.5*rho*(u0^2)*S*-3.818*10^(-6)  
Zde = 0.5*rho*(u0^2)*S*-0.3648
Mde = 0.5*rho*(u0^2)*S*c*-1.444
    
Blon = [Xde/m; Zde/(m-Zdw); (Mde/Iy) + (Mdw*Zde)/(Iy*(m-Zdw)); 0];
end