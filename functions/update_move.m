function  [X,theta,d_min,nr_min] = update_move(X,theta,s,a,Xr,eta,dt)
% update (X,theta) by the agent move rule

fr = s/eta; % switching rate

szX = size(X,1); szXr = size(Xr,1);

% find distance and directional vector between X agents and Xr resources
d = zeros(szX,szXr); % define distance matrix
Dr1 = d; Dr2 = d; % define 1st- & 2nd-comp of directional vect
for nvar = 1:szXr
    % move all agents to center (.5,.5)
    dx = .5*ones(szX,2) - X;
    dy = mod(repmat(Xr(nvar,:),[szX,1]) + dx,1); % move resources as well
    dvecp = dy - .5*ones(szX,2); % directional vec with periodic condition
    d(:,nvar) = sqrt(sum(dvecp.^2,2)); % distance btw agent and resource
    Dr1(:,nvar) = dvecp(:,1)./d(:,nvar); % 1st-comp of directional vect
    Dr2(:,nvar) = dvecp(:,2)./d(:,nvar); % 2st-comp of directional vect
end

[d_min,nr_min] = min(d,[],2); % find closest resource from each agent 
Ia = (d_min<a); % whether the closet resource is in their acuity

% find directional vector toward closest resource
mat_index = szX*(nr_min-1) + (1:szX)'; % (,) -> ()
dvecc = [Dr1(mat_index),Dr2(mat_index)];

% determine directional vector by agent move rule
II = repmat(Ia,[1,2]); 
% size(Ia)
% size(II)
% size(dvecc)
dvec = (1-II).*[cos(theta),sin(theta)] + II.*dvecc;

X = X + repmat(s*dt,[1,2]).*dvec; % update agent location
X = mod(X,1); % apply periodic bdc

p_sw = 1-exp(-fr*dt); sw = (rand(szX,1)<p_sw); % whether switch or not
theta = (1-sw).*theta + 2*pi.*sw.*rand(szX,1); % update angle
end