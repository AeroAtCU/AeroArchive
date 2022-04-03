function output = findM(a, suppF, x)
beamLength = 0.9144;

if (x < a)
    output = -(x * -suppF);
elseif (x < (beamLength - a))    
    output = a * suppF;
elseif (x < 0.9144)
    output = ((beamLength - x) * suppF);
else
    output = nan;
end

end