function sigmaFail = calcSigmaFail(bending)
    I_b = (3.01*10^-7) * bending.w; % m^4?
    E_f = 0.035483; %GPa
    E_b = 3.2953; %GPa
    I_f = 1.563313606*10^-8 * bending.w; % m^4? WIP
    c = 0.40625 * bending.w;
    
    sigmaFail = - (c .* bending.MFail ./ (I_b + (I_f .* (E_f / E_b)))); %GPa (?)
end