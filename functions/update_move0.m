function  [X,theta] = update_move0(X,theta,s,eta,dt)
% update (X,theta) by the agent move rule when no resource

fr = s/eta; % switching rate

szX = size(X,1);

dvec = [cos(theta),sin(theta)]; % directional vector
X = X + repmat(s*dt,[1,2]).*dvec; % update agent location
X = mod(X,1); % apply periodic bdc

p_sw = 1-exp(-fr*dt); sw = (rand(szX,1)<p_sw); % whether switch or not
theta = (1-sw).*theta + 2*pi.*sw.*rand(szX,1); % update angle
end