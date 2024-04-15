function [X,theta,s,a,E,gi,gi_max] = ...
    update_population_gen(X,theta,s,a,E,gi,gi_max,bf,df,sig_x,sig_s,sig_a,dt)
% update agents' location matrix X, phenotypes (s,a), and meta score E by birth and death process

% initialize some variables
szX = size(X,1); X1 = X(:,1); X2 = X(:,2);

% compute birth and death rate
rb = bf(E); rd = df(E); r = rb + rd;

% prob matrix, 1st col: any birth or death event, 2nd col: birth event
P = [1-exp(-r*dt),rb./r];
I_P = (rand(szX,2)<P); % event vector

% no birth and death
I0 = I_P(:,1)==0;
X0 = [X1(I0),X2(I0)];
theta0 = theta(I0);
E0 = E(I0);
s0 = s(I0); a0 = a(I0); 
gi0 = gi(I0);

% birth, update X and E
I11 = (1-I0)&(I_P(:,2)==1); % index, birth
Eb = E(I11); % corresponding E
E = [E0; repmat(Eb,[2,1])/2]; % halve meta scores
Xb = [X1(I11),X2(I11)]; % corresponding X
szXb = size(Xb,1);
Xb_eps = mod(Xb + sig_x*randn(szXb,2),1);
X = [X0; Xb; Xb_eps]; % duplicate location

% birth, update theta similar to X
thetab = theta(I11);
szthb = size(thetab,1);
% theta = [theta0; repmat(thetab,[2,1])]; % offspring with same angle
theta = [theta0; thetab; 2*pi*rand(szthb,1)]; % offspring with different angle

% birth, update s by mutation
szb = size(Eb,1); % # agents of giving birth
sb = s(I11);
sb_eps = sb + sig_s*randn(szb,1); % gaussian mutation
sb_eps = sb_eps.*(sb_eps>0); % truncate negative speed
s = [s0; sb; sb_eps];

% birth, similarly update a by mutation
ab = a(I11);
ab_eps = ab + sig_a*randn(szb,1); 
ab_eps = ab_eps.*(ab_eps>0);
a = [a0; ab; ab_eps];

% birth, update generation index and generation count
gib = gi(I11);
gi = [gi0; gib; gib+1]; % next gen = current gen + 1
gi_max = max(gi_max,max(gi)); % choose max count

% % birth, update label and label count
% lbb = lb(I11); sz_lbb = size(lbb,1);
% lb = [lb0; lbb; (lb_count + (1:sz_lbb))'];
% lb_count = lb_count + sz_lbb;
end