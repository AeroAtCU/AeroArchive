function E_n1 = SolveKepler(M,e)
% Get initial guess
E_n = M + e * sin(M);

% Run until E_n+1 is within 1% of E_n
for i = 1:100
    E_n1 = M - e * sin(E_n);
end
disp(strcat("E = ", num2str(E_n1)))
end