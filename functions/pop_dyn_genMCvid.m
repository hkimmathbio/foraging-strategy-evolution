function [phi_t,PopRes] = pop_dyn_genMCvid(init,para,num_para)
% population dynamics. record statistics of s,a,E and agent labels (lb) 

% initial conditions
X = init.X; theta = init.theta; % location and swim angle
s = init.s; a = init.a; % speed and acuity
E = init.E; % metabolic score
gi = init.gi; gi_max = init.gi_max; % label for agents;

Xr = init.Xr; % resource location

% parameters
eta = para.eta; % average move length before switching
lambda = para.lambda; % food production rate

gamma = para.gamma; % energy gain/resource
% C = para.C; % metabolic cost function

bf = para.bf; df = para.df; % birth/death rate
sig_x = para.sig_x; sig_s = para.sig_s; sig_a = para.sig_a; % mutation rate 


% numerical parameters
dt = num_para.dt;
gmax = num_para.gmax;

% run time loop
nt = 0; gi_max_0 = gi_max;
szX = size(X,1); szXr = size(Xr,1);

phi_t = cell(gmax,1); PopRes = zeros(gmax,2);

while and(gi_max<gmax,szX>1)
    nt = nt + 1;

    if szXr == 0 % update when # resource =0
        % move agents
        [X1,theta1] = update_move0(X,theta,s,eta,dt);
    
        % update metabolic scores
        E1 = update_metascore0(s,a,E,dt);

        % update resource
        Xr = update_resource0(lambda,dt);

    else % update when # resource >0
        % move agents
        [X1,theta1,d_min,nr_min] = update_move(X,theta,s,a,Xr,eta,dt);
    
        % update metabolic scores
        [E1,Ir,~] = update_metascore(X,s,a,E,Xr,d_min,nr_min,gamma,dt);

        % update resource
        Xr = update_resource(Xr,Ir,lambda,dt);
    end

    % birth and death for agents (regardless of # resource)
    [X,theta,s,a,E,gi,gi_max] = ...
        update_population_gen(X1,theta1,s,a,E1,gi,gi_max,bf,df,sig_x,sig_s,sig_a,dt);
    
    szX = size(X,1); szXr = size(Xr,1); % count # agents and resource
    
    if gi_max > gi_max_0
        % gi_max
        phi_t{gi_max,1} = [s,a];
        PopRes(gi_max,:) = [szX,szXr];
    end
    gi_max_0 = gi_max;

    % clc;
    % disp(['|X|=',num2str(szX),', |Xr|=',num2str(szXr),...
    %     ', GenMax=',num2str(gi_max),', T=',num2str(nt*dt)]);
    
    % fig = figure(figure('Position', [10 10 10+500 10+200]));
    subplot(1,2,1);
    p1 = scatter(X(:,1),X(:,2),50,...
        'markeredgecolor','none','markerfacecolor','b',...
        'markerfacealpha',.25); hold on;
    p2 = scatter(Xr(:,1),Xr(:,2),25,'square',...
        'markeredgecolor','none','markerfacecolor','r',...
        'markerfacealpha',1);
    xlim([0,1]); ylim([0,1]); title('Omega')
    xlabel('x'); ylabel('y');
    
    subplot(1,2,2);
    p3 = scatter(s,a,50,...
        'markeredgecolor','none','markerfacecolor','b',...
        'markerfacealpha',.25);
    xlabel('speed'); ylabel('acuity');
    title(['t=',num2str(dt*nt)]);
    getframe(gca); delete(p1); delete(p2); delete(p3);

end

end