plot([0 0.25 0.75 1 1.5 1.75 2 2.25 2.5 2.75 3 3.25], Voltage2Bin(0, 3.3, 8, [0 0.25 0.75 1 1.5 1.75 2 2.25 2.5 2.75 3 3.25]))


function [bins] = Voltage2Bin(min_voltage, max_voltage, bits, input_voltage)
bins = ceil(input_voltage ./ ((max_voltage - min_voltage) / 2^bits));
end





%{
vrange = max_voltage - min_voltage;
LSB = vrange / 2^bits;

bins = ceil(input_voltage / LSB)
%}