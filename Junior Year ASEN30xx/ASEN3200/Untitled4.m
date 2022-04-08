close all
clear all
%% Given Constants

L = 12; %[in]
LE = 4.5; %[in]
LR = 5; %[in]
w = 1; %[in]
h = 1/8; %[in]
hE = 1/4; %[in]
hR = 0.040; %[in]
E = 10175000; %[psi]

rho = 0.0002505; %[lb-sec^2/in^4]
MT = 1.131 * rho; %[in^3 * rho]
ST = 0.5655 * rho; %[in^4 * rho]
IT = 23.124 * rho; %[in^5 * rho]

%% Create and fill in given matrices

%insert values into first part of M2

M2(1,:) = [19272 (1458*L) 5928 (-642*L) 0 0];
M2(2,:) = [(1458*L) (172*(L^2)) (642*L) (-73*(L^2)) 0 0];
M2(3,:) = [5928 (642*L) 38544 0 5928 (-642*L)];
M2(4,:) = [(-642*L) (-73*(L^2)) 0 (344*(L^2)) (642*L) (-73*(L^2))];
M2(5,:) = [0 0 5928 (642*L) 19272 (-1458*L)];
M2(6,:) = [0 0 (-642*L) (-73*(L^2)) (-1458*L) (172*(L^2))];


%given
A = w*h;
Izz = (w*(h^3))/12;
cM2 = (rho*A*L)/100800;
cK2 = (4*E*Izz)/(L^3);
M2 = M2*cM2;

%temporary matrix for second part
temp = zeros(6);
temp(5,5) = MT;
temp(5,6) = ST;
temp(6,5) = ST;
temp(6,6) = IT;
%combine
M2 = M2+temp;

%insert values for K2 matrix
K2(1,:) = [24 (6*L) -24 (6*L) 0 0];
K2(2,:) = [(6*L) (2*(L^2)) (-6*L) (L^2) 0 0];
K2(3,:) = [-24 (-6*L) 48 0 -24 (6*L)];
K2(4,:) = [(6*L) (L^2) 0 (4*(L^2)) (-6*L) (L^2)];
K2(5,:) = [0 0 -24 (-6*L) 24 (-6*L)];
K2(6,:) = [0 0 (6*L) (L^2) (-6*L) (2*(L^2))];



%fix M2 and K2

K2 = K2*cK2;

%create M^2 and K^2
colIndex2 = [3 4 5 6];
for index = 1:4
    Mhat2(index,:) = M2(index+2,colIndex2);
    Khat2(index,:) = K2(index+2,colIndex2);
end

%insert values into first part of M4
M4(1,:) = [77088 (2916*L) 23712 (-1284*L) 0 0 0 0 0 0];
M4(2,:) = [(2916*L) (172*(L^2)) (1284*L) (-73*(L^2)) 0 0 0 0 0 0];
M4(3,:) = [23712 (1284*L) 154176 0 23712 (-1284*L) 0 0 0 0];
M4(4,:) = [(-1284*L) (-73*(L^2)) 0 (344*(L^2)) (1284*L) (-73*(L^2)) 0 0 0 0];
M4(5,:) = [0 0 23712 (1284*L) 154176 0 23712 (-1284*L) 0 0];
M4(6,:) = [0 0 (-1284*L) (-73*(L^2)) 0 (344*(L^2)) (1284*L) (-73*(L^2)) 0 0];
M4(7,:) = [0 0 0 0 23712 (1284*L) 154176 0 23712 (-1284*L)];
M4(8,:) = [0 0 0 0 (-1284*L) (-73*(L^2)) 0 (344*(L^2)) (1284*L) (-73*(L^2))];
M4(9,:) = [0 0 0 0 0 0 23712 (1284*L) 77088 (-2916*L)];
M4(10,:) = [0 0 0 0 0 0 (-1284*L) (-73*(L^2)) (-2916*L) (172*(L^2))];

%given
cM4 = (rho*A*L)/806400;
cK4 = (8*E*Izz)/(L^3);
M4 = M4.*cM4;

%temporary matrix for second part to add to first part
temp = zeros(10);
temp(9,9) = MT;
temp(9,10) = ST;
temp(10,9) = ST;
temp(10,10) = IT;
%combine parts to get combined M4
M4 = M4 + temp;

%insert values for K4 matrix
K4(1,:) = [96 (12*L) -96 (12*L) 0 0 0 0 0 0];
K4(2,:) = [(12*L) (2*(L^2)) (-12*L) (L^2) 0 0 0 0 0 0];
K4(3,:) = [-96 (-12*L) 192 0 -96 (12*L) 0 0 0 0];
K4(4,:) = [(12*L) (L^2) 0 (4*(L^2)) (-12*L) (L^2) 0 0 0 0];
K4(5,:) = [0 0 -96 (-12*L) 192 0 -96 (12*L) 0 0];
K4(6,:) = [0 0 (12*L) (L^2) 0 (4*(L^2)) (-12*L) (L^2) 0 0];
K4(7,:) = [0 0 0 0 -96 (-12*L) 192 0 -96 (12*L)];
K4(8,:) = [0 0 0 0 (12*L) (L^2) 0 (4*(L^2)) (-12*L) (L^2)];
K4(9,:) = [0 0 0 0 0 0 -96 (-12*L) 96 (-12*L)];
K4(10,:) = [0 0 0 0 0 0 (12*L) (L^2) (-12*L) (2*(L^2))];



%Fix M4 and K4

K4 = K4.*cK4;

%create M^4 and K^4
colIndex = [3 4 5 6 7 8 9 10];
for index = 1:8
    Mhat4(index,:) = M4(index+2,colIndex);
    Khat4(index,:) = K4(index+2,colIndex);
end

%% Solve for Eigenvalues
%%%%%%%%%%%%%%
% Two Element Method
%%%%%%%%%%%%%%
K2Reduced = K2;
M2Reduced = M2;

% Remove rows 1 and 2, and columns 1 and 2, from both!
K2Reduced(1, :) = [];
K2Reduced(1, :) = [];

K2Reduced(:, 1) = [];
K2Reduced(:, 1) = [];

M2Reduced(1, :) = [];
M2Reduced(1, :) = [];

M2Reduced(:, 1) = [];
M2Reduced(:, 1) = [];

% Now, find frequencies and eigenvectors!
%
K2M2Combo = inv(M2Reduced)*K2Reduced;
%K2M2Combo = inv(Mhat2)*Khat2;
[u2,w2square] = eig(Khat2\Mhat2);
%[u2,w2square] = eig(K2M2Combo);
%wi2 = sqrt(w2square);
%SecondOrderfi = [wi2(2, 2)/(2*pi); wi2(3, 3)/(2*pi); wi2(4, 4)/(2*pi);];

syms w

TEMP = det(K2Reduced-w^2*M2Reduced);
W2 = solve(TEMP == 0, w);
SecondOrderfi2 = [double(W2(1))/(2*pi) double(W2(2))/(2*pi) double(W2(3))/(2*pi)];

for i =1:3
    figure(i)
    ev = [0;0;u2(:,i)];
    if i ==1 
        ev = -ev;
    end
    ne = 2;
    nsub = 100;
    scale = 1;
    ploteigenvector(L,ev,ne,nsub,scale)
    tempstring1 = sprintf('%.0f',i);
    tempstring2 = sprintf('%.2f',SecondOrderfi2(i));
    Title = strcat('Mode shape #',tempstring1,' at frequency = ',tempstring2,' Hz');
    title(Title)
    
end
%%%%%%%%%%%%%%
% Four Element Method
%%%%%%%%%%%%%%
K4Reduced = K4;
M4Reduced = M4;

% Remove rows 1 and 2, and columns 1 and 2, from both!
K4Reduced(1, :) = [];
K4Reduced(1, :) = [];

K4Reduced(:, 1) = [];
K4Reduced(:, 1) = [];

M4Reduced(1, :) = [];
M4Reduced(1, :) = [];

M4Reduced(:, 1) = [];
M4Reduced(:, 1) = [];

% Now, find frequencies and eigenvectors!

K4M4Combo = inv(M4Reduced)*K4Reduced;
[u4,w4square] = eig(K4M4Combo);
wi4 = sqrt(w4square);
FourthOrderfi = [wi4(6, 6)/(2*pi); wi4(7, 7)/(2*pi); wi4(8, 8)/(2*pi);];

TEMP = det(K4Reduced-w^2*M4Reduced);
W4 = solve(TEMP == 0, w);
SecondOrderfi4 = [double(W4(1))/(2*pi) double(W4(2))/(2*pi) double(W4(3))/(2*pi)];

for i =1:3
    figure()
    ev = [0;0;u4(:,i)];
    ne = 4;
    nsub = 100;
    scale = 1;
    ploteigenvector(L,ev,ne,nsub,scale)
    tempstring1 = sprintf('%.0f',i);
    tempstring2 = sprintf('%.2f',SecondOrderfi4(i));
    Title = strcat('Mode shape #',tempstring1,' at frequency = ',tempstring2,' Hz');
    title(Title)

end
