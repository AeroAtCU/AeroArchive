A = [0 0 0 0 1 1 1 1]';
O = [0 0 1 1 0 0 1 1]';
F = [0 1 0 1 0 1 0 1]';

S = AOF_fun(A,O,F);

table(A,O,F,S)

function S = AOF_fun(A,O,F)
    S = double(A&O | F);
end