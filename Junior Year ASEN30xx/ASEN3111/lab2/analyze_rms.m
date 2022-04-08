function input_struct = analyze_rms(input_struct)
% Ian Adler
% This simply computes the root mean square of an array.
% it must be done twice due to matlabs implementation of rms.
input_struct.cp_rms = rms(rms(input_struct.cp_matrix));
input_struct.v_rms = rms(rms(input_struct.v_mag));
end