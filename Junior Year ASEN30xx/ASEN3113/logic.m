A = [0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1]';
B = [0 0 0 0 1 1 1 1 0 0 0 0 1 1 1 1]';
C = [0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1]';
D = [0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1]';

S1 = double(~A&~B&~C | ~B&C&~D | A&~B&~C | ~A&B&C&~D);
S2 = double(~B&~(C&D) | C&~D&~(A&B))
T = S1 == S2

%S1 = double(A&B&C&D | (~A)&B | ~D)
%S2 = double(~D | xor(B,B&A&D&~C))
%T = S1 == S2

table(A,B,C,D,S1,S2,T)

%AOF_fun(A,O,F)

function S = AOF_fun(A,O,F)
    S = double(A&O | F);
end