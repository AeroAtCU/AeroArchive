function speed = calc_speed(h)
    % Does not handle negative heights
    speed = sqrt(2 * 9.81 * (125 - h));