function [CL, CP, V] = Vortex_Panel(XB, YB, V_inf, ALPHA)
%{
Ian Adler / March 25 2021
Purpose: Compute sectional lift coefficient and coefficient of pressure
using translated Kuthe and Chow (~1970s) FORTRAN code.

Params:
    x: vector of coordinates describing airfoil geometry
    y: vector of coordinates describing airfoil geometry
    V_inf: freestream velocity
    alpha: angle of attack

Output:
    c_l: non-dimensionalized lift coefficient
    C_p: dimensionalized
%}
M = length(XB) - 1;
[X, Y, S, SINE, COSINE, THETA, V, CP, GAMA, RHS] = deal(zeros(1,M));
[CN1, CN2, CT1, CT2] = deal(zeros(M,M));
AN = zeros(M+1,M+1);
AT = zeros(M,M+1);

MP1 = M+1;
PI = pi;

for I = 1:M
    IP1 = I + 1;
    X(I)      = 0.5*(XB(I) + XB(IP1));
    Y(I)      = 0.5*(YB(I) + YB(IP1));
    S(I)      = sqrt( (XB(IP1) - XB(I))^2 + (YB(IP1) - YB(I))^2 );
    THETA(I)  = atan2( (YB(IP1) - YB(I)), (XB(IP1) - XB(I)) );
    SINE(I)   = sin(THETA(I));
    COSINE(I) = cos(THETA(I));
    RHS(I)    = sin(THETA(I) - ALPHA);
end


for I = 1:M
    for J = 1:M
        if (I == J)
            CN1(I,J) = -1;
            CN2(I,J) = 1;
            CT1(I,J) = 0.5*PI;
            CT2(I,J) = 0.5*PI;
        else
            A = -(X(I)-XB(J))*COSINE(J) - (Y(I)-YB(J))*SINE(J);
            B = (X(I)-XB(J))^2 + (Y(I)-YB(J))^2;
            C = sin( THETA(I)-THETA(J) );
            D = cos( THETA(I)-THETA(J) );
            E = (X(I)-XB(J))*SINE(J) - (Y(I)-YB(J))*COSINE(J);
            F = log( 1 + S(J)*(S(J)+2.*A)/B);
            G = atan2( E*S(J), B+A*S(J) );
            P = (X(I) - XB(J)) * sin(THETA(I)-2.*THETA(J))...
                + (Y(I) - YB(J)) * cos(THETA(I)-2.*THETA(J));
            
            Q = (X(I) - XB(J)) * cos(THETA(I)-2.*THETA(J))...
                - (Y(I) - YB(J)) * sin(THETA(I)-2.*THETA(J));
            CN2(I,J) = D + 0.5*Q*F/S(J) - (A*C+D*E)*G/S(J);
            CN1(I,J) = 0.5*D*F + C*G - CN2(I,J);
            CT2(I,J) = C + 0.5*P*F/S(J) + (A*D-C*E)*G/S(J);
            CT1(I,J) = 0.5*C*F - D*G - CT2(I,J);
        end
    end
end


for I = 1:M
    AN(I,1) = CN1(I,1);
    AN(I,MP1) = CN2(I,M);
    AT(I,1) = CT1(I,1);
    AT(I,MP1) = CT2(I,M);
    for J = 2:M
        AN(I,J) = CN1(I,J) + CN2(I,J-1);
        AT(I,J) = CT1(I,J) + CT2(I,J-1);
    end
end
AN(MP1,1) = 1;
AN(MP1,MP1) = 1;
for J = 2:M
    AN(MP1,J) = 0;
end
RHS(MP1) = 0.0;

% Kuth's CRAMER operates on GAMA so that must be out output.
[GAMA] = CRAMER(AN, RHS, GAMA, MP1, M);

for I = 1:M
    V(I) = cos( THETA(I) - ALPHA );
    for J = 1:MP1
        V(I) = V(I) + AT(I,J)*GAMA(J);
        CP(I) = 1 - V(I)^2;
    end
end

% cl = 2*gamma
CP = real(CP);
CL = -real((2*sum(V.*S)));
end
