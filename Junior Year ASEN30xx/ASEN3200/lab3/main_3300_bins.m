close all;
v = 1.65.*sin(linspace(0, 2*pi, 1000))+1.65;

figure; hold on; title("Bin vs Voltage, 12 bit"); xlabel("Omega [rad]"); ylabel("Bins");
stairs(linspace(0, 2*pi, 1000), Voltage2Bin(0, 3.3, 12, v), "b")

figure; hold on; title("Bin vs Voltage, 12 bit"); xlabel("Array Index"); ylabel("Bins");
stairs(linspace(1, length(v), length(v)), Voltage2Bin(0, 3.3, 12, v), "b")

function [bins] = Voltage2Bin(min_voltage, max_voltage, bits, input_voltage)
bins = ceil(input_voltage ./ ((max_voltage - min_voltage) / 2^bits));
end