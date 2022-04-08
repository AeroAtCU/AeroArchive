close all; clear all;
Ix = 5.8*10^-5;
N = 100;
k1_vector = linspace(-.01,.01,N);
k2_vector = linspace(0,.01,N);

value_matrix_k1k2 = nan(N^2,6);
% tau1, tau2, k1, k2
idx = 1;
for i = 1:N
    for j = 1:N
        %A = [0 1;
        %    -k1_vector(i)/Ix -k2_vector(j)/Ix];
        A = [0 1;
            -k2_vector(j)/Ix -k1_vector(i)/Ix];
        [~,D] = eig(A);
        value_matrix_k1k2(idx,1) = -1/D(1,1); % Time constants
        value_matrix_k1k2(idx,2) = -1/D(2,2);
        value_matrix_k1k2(idx,3) = k1_vector(i); % K values
        value_matrix_k1k2(idx,4) = k2_vector(j);
        value_matrix_k1k2(idx,5) = D(1,1); %eigenvalues
        value_matrix_k1k2(idx,6) = D(2,2);
        idx = idx + 1;
    end
end

%figure;
%plot(value_matrix_k1k2(:,3), value_matrix_k1k2(:,1), '*', 'linewidth', 2);
%xlabel('k1');  ylabel('tau [s]')

% figure;
% plot(value_matrix_k1k2(:,4), value_matrix_k1k2(:,1), '*', 'linewidth', 2);
% xlabel('k2'); ylabel('tau [s]')

[minValue,idx_k1k2] = min(abs(value_matrix_k1k2(:,1)-2))
value_matrix_k1k2(idx_k1k2, :)

%%

close all
Ix = 5.8*10^-5;
N = 5000;
        k1 = 0.0099;
k2 = 0.0049;
k3_vector = linspace(-0.1,.1,N);
g = 9.81;

value_matrix_k3 = nan(N,3);
% tau1, tau2, tau3, k3

for i = 1:N
    A = [0 g 0;
        0 0 1;
        -k3_vector(i)/Ix -k2/Ix  -k1/Ix ];
    
    
    [~,D] = eig(A);
    value_matrix_k3(i,1) = (-1/D(3,3)); % tau
    value_matrix_k3(i,2) = k3_vector(i);
    value_matrix_k3(i,3) = D(3,3);
end

%figure; hold on; title("adf")
%plot(value_matrix_k3(:,2), value_matrix_k3(:,1))
%xlabel('k3'); ylabel('tau [s]')
%legend("tau3");

[minValue,idx_k3] = min(abs(value_matrix_k3(:,1)-1.25))
value_matrix_k3(idx_k3, :)


%%
% Plotting
figure; hold on; title("Eigenvalue Locus");
xlabel("Real"); ylabel("Imaginary");
% Plot k locii
plot(value_matrix_k1k2(:,5), 'r.', 'markersize', 0.5)
plot(value_matrix_k1k2(:,6), 'g.', 'markersize', 0.5)
plot(value_matrix_k3(:,3), 'b.', 'markersize', 0.5)

% plot actual values
plot(complex(value_matrix_k1k2(idx_k1k2,5)), 'rx', 'markersize', 17)
plot(complex(value_matrix_k1k2(idx_k1k2,6)), 'gx', 'markersize', 17)
plot(complex(value_matrix_k1k2(idx_k3,3)), 'bx', 'markersize', 17)
xlim([-200 30])

legend("Tested Lambda 1", "Tested Lambda 2", "Tested Lambda 3", "Chosen Lambda 1", "Chosen Lambda 2", "Chosen Lambda 3")