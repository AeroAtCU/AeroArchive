function Mfail = calcMfail(bending)
% only for breaking at bending

Mfail = nan(length(bending.d_f),1);

for i = 1:length(bending.d_f)
    if (bending.d_f(i) <= bending.a(i))
        Mfail(i) = bending.d_f(i) .* bending.suppF(i);
    elseif (bending.d_f(i) > bending.a(i))
        Mfail(i) = bending.a(i) .* bending.suppF(i);
    end
end
end