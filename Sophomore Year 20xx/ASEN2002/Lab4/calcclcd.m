function data = calcclcd(data)
% Calcualte cl, cd from ca, cn using given equtions.

velocities = ["v_9"; "v_17"; "v_34"];

for i = 1:length(velocities)
    vname = velocities(i);
    data.(vname).cl = data.(vname).cn * cos(deg2rad(data.AOA(1))) - data.(vname).ca * sin(deg2rad(data.AOA(1)));
    data.(vname).cd = data.(vname).cn * sin(deg2rad(data.AOA(1))) + data.(vname).ca * cos(deg2rad(data.AOA(1))); 
end
end
