function data = calccacn(data)
% Calculate ca, cn from given struct data

% Declare constants of the wing
delta_y = [0.1841; 0.07105; .0742; .014; -.0126; -.0371; -.05705; -.1645; -.21875; 0; 0; 0; 0; 0.0014; 0.0161; .02135; 0.03885] * 0.0254;
delta_x = [0.175; 0.175; 0.35; 0.35; 0.35; 0.35; 0.35; 0.7; 0.7; -0.7; -0.7; -0.7; -0.35; -0.35; -0.35; -0.35; -0.175] * 0.0254;
velocities = ["v_9"; "v_17"; "v_34"];
c = 3.5 * 0.0254;

for i = 1:length(velocities) % Loop through velocities
    vname = velocities(i);
    partial_sums_ca = nan(16,1);
    partial_sums_cn = nan(16,1);
    
    for j = 1:16 % Loop through ports
        cp1_name = strcat('cp',num2str(j));
        cp2_name = strcat('cp',num2str(j+1));
        
        cp1_val = mean(data.(vname).(cp1_name));
        cp2_val = mean(data.(vname).(cp2_name));
        
        partial_sums_ca(j) = (cp1_val + cp2_val) * delta_y(j) / (2*c); % Equation from lab document
        partial_sums_cn(j) = (cp1_val + cp2_val) * delta_x(j) / (2*c);
    end
    data.(vname).ca = 1 * sum(partial_sums_ca);
    data.(vname).cn = -1 * sum(partial_sums_cn);
end
end
