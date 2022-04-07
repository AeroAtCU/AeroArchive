function v_x = extrapPort11(v_x)
% Linearly extrapolate theoretical port 11 Pressure and CP value.
% Could be optimized if manually calculated mx+b
% Or if polyval works with arrays.
for i = 1:20
    p_arr_top = [v_x.p10(i), v_x.p9(i)]; % two points of top pressure data
    p_arr_bottom = [v_x.p12(i), v_x.p13(i)];
    
    coeffs_top = polyfit([2.8, 2.1], p_arr_top, 1); % Hard coding distances not a great idea, but works.
    coeffs_bottom = polyfit([2.8, 2.1], p_arr_bottom, 1);
    
    extrap_top = coeffs_top(1) * 3.5 + coeffs_top(2); 
    extrap_bottom = coeffs_bottom(1) * 3.5 + coeffs_bottom(2);
    
    v_x.p11(i) = mean([extrap_top, extrap_bottom]); % average two extrapolated values
end
end