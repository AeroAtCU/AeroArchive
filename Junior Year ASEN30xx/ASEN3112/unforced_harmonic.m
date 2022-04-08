clc;
syms w lambda J2 K1
syms lambda
% lambda = w^2

M_mat = [2, 0; 0, 1]

K_mat = [4, -2; -2, 2]

D_w = K_mat - M_mat*w^2;
char_eqn = det(D_w);
char_eqn_lambda = subs(char_eqn, w, sqrt(lambda))
% root_values = double(solve(char_eqn_lambda))
root_values = double(solve(char_eqn_lambda, lambda))
wn = sqrt(root_values)

U1 = double(subs(D_w, w^2, root_values(1)));
U2 = double(subs(D_w, w^2, root_values(2)));


phi = [.709, .707; 1, 1]

inv(phi)*M_mat*phi

phi'*M_mat*phi

phi1 = [-.707; 1];
phi2 = [0.709; 1];
phi1' * M_mat * phi1

phi2' * M_mat * phi2