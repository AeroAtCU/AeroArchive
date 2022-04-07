function x = interpolate_findx(p1, p2, yval)
    % return the interpolated x value given a y input
    m = (p2(2) - p1(2)) / (p2(1) - p1(1)); % get slope
    b = p1(2) - (m * p1(1));
    x = (yval - b) / m;
end