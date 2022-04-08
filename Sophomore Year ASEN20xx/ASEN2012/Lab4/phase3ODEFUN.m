function results = phase3ODEFUN(inputvec, c)
% Calculate ballistics phase. input format
% inputvec = [pos.x; vel.x; pos.y; vel.y]

vel.x = inputvec(2);
pos.y = inputvec(3);
vel.y = inputvec(4);

% If pos.yition falls below the ground (0)
% Then the object has no acceleration or velocity
if (pos.y <= c.ground_pos)
    results = [0; 0; 0; 0];
else
    % Find heading 
    theta = atan( vel.y / vel.x);
    
    % Find  components of drag
    [f.xDrag, f.yDrag] = calcDrag([vel.x, vel.y, theta], c);
    
    % Find force of gravity on bottle
    f.yGrav = c.g * c.m_bottle;
    
    % Calculate sum of forces
    % If bottle going down (v<0) drag is agianst velocity
    if (vel.y <= 0)
        f.ySum = -f.yGrav + f.yDrag;
    else
        f.ySum = -f.yGrav - f.yDrag;
    end
    
    % Only x force is drag
    f.xSum = -f.xDrag;
    
    % Sum of accelerations from dividng by mass (now constant)
    acc.x = f.xSum / c.m_bottle;
    acc.y = f.ySum / c.m_bottle;
    
    % Format what to return
    results = [vel.x; acc.x; vel.y; acc.y;];
end
end
