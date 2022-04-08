function derivatives = transform(zeta, Xu, Xw, Xq, Zu, Zw, Zq, Zdw, Mu, Mw, Mq, Mdw)


% problem 2
%zeta = -6.8; % degree
% part a
dXu = Xu*(cosd(zeta))^2 - (Xw + Zu)*sind(zeta)*cosd(zeta) + Zw*(sind(zeta))^2;
dXw = Xw*(cosd(zeta))^2 + (Xu - Zw)*sind(zeta)*cosd(zeta) - Zu*(sind(zeta))^2;
dXq = Xq*cosd(zeta) - Zq*sind(zeta);
dXdu = Zdw*(sind(zeta))^2;
dXdw = -Zdw*sind(zeta)*cosd(zeta); %had a (1) by it
dZu = Zu*(cosd(zeta))^2 - (Zw - Xu)*sind(zeta)*cosd(zeta) - Xw*(sind(zeta))^2;
dZw = Zw*(cosd(zeta))^2 + (Zu + Xw)*sind(zeta)*cosd(zeta) + Xu*(sind(zeta))^2;
dZq = Zq*cosd(zeta) + Xq*sind(zeta);
dZdu = -Zdw*sind(zeta)*cosd(zeta); %had a (1) by it
dZdw = Zdw*(cosd(zeta))^2;
dMu = Mu*cosd(zeta) - Mw*sind(zeta);
dMw = Mw*cosd(zeta) + Mu*sind(zeta);
dMq = Mq;
dMdu = -Mdw*sind(zeta);
dMdw = Mdw*cosd(zeta);

derivatives = [dXu, dXw, dXq, dXdu, dXdw, dZu, dZw, dZq, dZdu, dZdw, dMu, dMw, dMq, dMdu, dMdw];