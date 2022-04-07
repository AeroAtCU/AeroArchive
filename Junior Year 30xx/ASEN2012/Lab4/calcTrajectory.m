function results = calcTrajectory(c)
% icon short for "initial conditions"
% c short for "constants"

% -------------- Stage 1 ----------------- %
% -------------- Stage 1 ----------------- %
% -------------- Stage 1 ----------------- %

stage1.icon = [0; 0; c.stand_height; 0; c.vol_air; c.m_total];

[stage1.tData, stage1.results] = ode45( @(t, inputvec) phase1ODEFUN(inputvec, c), c.tspan, stage1.icon);

stage1.endPos = length(stage1.results);
stage1.volData = stage1.results(:,5);

% Clip data at point where thrust stops changing
for i = 1:(length(stage1.volData) - 1)
    if stage1.volData(i) >= c.vol_bottle
        stage1.endPos = i;
	break
    end
end

% Parse data into respective parts
stage1 = parseStates(stage1, stage1.endPos);
stage1.volData = stage1.results(1:stage1.endPos,5);
stage1.mData = stage1.results(1:stage1.endPos,6);

% Calculate thrust
stage1.pData = c.p_abs .* ((c.vol_air ./ stage1.volData) .^ c.gamma );
stage1.thrustData = 2 * c.discharge_coeff * c.A_t * (stage1.pData - c.p_atm);

% -------------- Stage 2 ----------------- %
% -------------- Stage 2 ----------------- %
% -------------- Stage 2 ----------------- %

stage2.icon = [stage1.pos.x(end); stage1.vel.x(end); stage1.pos.y(end); stage1.vel.y(end); c.m_air];

[stage2.tData, stage2.results] = ode45(@(t, inputvec) phase2ODEFUN(inputvec, c), c.tspan, stage2.icon);

stage2.endPos = length(stage2.results);
stage2.mData = stage2.results(:,5);

% Clip data at point where thrust stops changing
% for i = 1:(length(stage2.mData) - 1)
%     if (stage2.mData(i-1) - stage2.mData(i)) < 0.00001
%         stage2.endPos = i;
% 	break
%     end
% end 

% Parse data 
stage2 = parseStates(stage2, stage2.endPos);
stage2.mData = stage2.results(1:stage2.endPos,5); 
stage2.thrustData = calcPhase2Thrust(stage2.mData, c);

% -------------- Stage 3 ----------------- %
% -------------- Stage 3 ----------------- %
% -------------- Stage 3 ----------------- %

stage3.icon = [stage2.pos.x(end); stage2.vel.x(end); stage2.pos.y(end); stage2.vel.y(end)];

[stage3.tData, stage3.results] = ode45(@(t, inputvec) phase3ODEFUN(inputvec, c), c.tspan, stage3.icon);

stage3.endPos = length(stage3.results);

% Parse data
stage3 = parseStates(stage3, stage3.endPos);

% Return all gathered data
results.stage1 = stage1;
results.stage2 = stage2;
results.stage3 = stage3;
end
