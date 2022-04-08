N_nominal = 55
% 55
storage_4412 =  zeros(length(AOA_to_test),2);
for i = 1:length(AOA_to_test)
    [x, y] = compute_NACA_points(4412, 1, N_nominal);
    [cl, ~, ~] = Vortex_Panel(x, y, nan, AOA_to_test(i));
    storage_4412(i,1) = AOA_to_test(i);
    storage_4412(i,2) = cl;
end
storage_2424 =  zeros(length(AOA_to_test),2);
for i = 1:length(AOA_to_test)
    [x, y] = compute_NACA_points(2424, 1, N_nominal);
    [cl, ~, ~] = Vortex_Panel(x, y, nan, AOA_to_test(i));
    storage_2424(i,1) = AOA_to_test(i);
    storage_2424(i,2) = cl;
end


disp("asdf")