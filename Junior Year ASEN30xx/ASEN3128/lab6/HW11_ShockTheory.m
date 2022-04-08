E = 5; %deg
% case 2
% Notes: intro - Mr Trenches, has good ending part but not very vocal
% "low frequency" - liquid stanger exit the vault
alpha = deg2rad(5);  %rad

theta = 2*E; %deg

Minf = 2.5;

gamma = 1.4;

Beta=beta(Minf,theta,gamma,0); %for region 2 to 3 all in degrees

%solving diamond airfoil case 3, alpha = epsilon

%from region infinity to 1, expansion fan:

p1ratio = 1; %because p1 = pinfinity

[mach1, nu, mu] = flowprandtlmeyer(gamma, Minf) ; %this is correct for M = 2.5;

nuM2 = theta + nu;

[mach2, nu, mu] = flowprandtlmeyer(gamma, nuM2,'nu') ; %correct

%Now solve T2/T1.

T12_ratio = (1+((gamma-1)/2)*mach1^2) / (1+((gamma-1)/2)*mach2^2) ;

p2ratio = (T12_ratio)^(1.4/.4); % p2/pinfinity

%Now we have an oblique shock from region 2 to 3.


machNinf = Minf*sind(Beta);

[mach, T, p3ratio, rho, downstream_machN3, P0, P1] = flownormalshock(gamma, machNinf);

%Now region 3 to 4 is an expansion fan

mach3 = downstream_machN3/(sind(Beta-theta)) ;

[mach, nu3, mu] = flowprandtlmeyer(gamma, mach3) ; %correct

nuM4 = nu3+theta;

[mach4, nu, mu] = flowprandtlmeyer(gamma, nuM4,'nu') ; %correct

T43_ratio = (1+((gamma-1)/2)*mach3^2) / (1+((gamma-1)/2)*mach4^2) ;

p43_ratio = (T43_ratio)^(1.4/.4);

p4ratio = p43_ratio*p3ratio;

%cn, ca, cd, cl

cn = (1/(gamma*(Minf^2)))*(-p1ratio-p2ratio+p3ratio+p4ratio);
ca = (1/(gamma*(Minf^2)))*(p1ratio-p2ratio+p3ratio-p4ratio)*tand(E);

cl = cn*cos(alpha) - ca*sin(alpha)
cd = cn*sin(alpha) + ca*cos(alpha)