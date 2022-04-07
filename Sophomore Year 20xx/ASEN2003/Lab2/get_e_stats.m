function ret_struct = get_e_stats(input_struct)
% Find median, mean, and other stats given an input struct
% with a .e array inside. Stores results in input struct.

if (nargin ~= 1)
    warning('Please input a struct with a .e array');
end
    
ret_struct = input_struct;

ret_struct.median = median(ret_struct.e);
ret_struct.mean = mean(ret_struct.e);
ret_struct.std = std(ret_struct.e);
ret_struct.max = max(ret_struct.e);
ret_struct.min = min(ret_struct.e);
ret_struct.range = ret_struct.max - ret_struct.min;
end