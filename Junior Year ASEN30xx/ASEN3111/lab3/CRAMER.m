function [X] = CRAMER(C, A, X, N, M)
CC = zeros(M+1,M+1);
DENOM = det(C);
for K = 1:N
    for I = 1:N
        for J = 1:N
            CC(I,J) = C(I,J);
        end
    end
    for I = 1:N
        CC(I,K) = A(I);
    end
    X(K) = det(CC) / DENOM;
end
end

function [c, a, x, n] = cramer(c, a, x, n, m)
cc    = zeros(m+1);
denom = det(c); % call MATLAB builtin for speed instead of the translated code

for k = 1:n
    for i = 1:n
        for j = 1:n
            cc(i, j) = c(i, j);
        end % j
    end % i
    
    for i = 1:n
        cc(i, k) = a(i);
    end % i
    x(k) = det(cc) / denom;
end % k
end % function cramer
