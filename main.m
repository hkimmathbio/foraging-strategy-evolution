%% main
clear; close all; clc; addpath('functions:')

% environmental parameters
Lambda = 2^9; % energy/time to the system
F = 2^2; % energy/resource

% numerical parameters
gmax = 10^3; % number of generations
M = 1; % number of Monte-Carlo simulations



% model parameters
para.eta = .0625; % average move length before switching [length]
[para.bf,para.df] = fn_bdrate(); % birth and death rate
para.sig_x = 2*10^-3; % offspring displacement variability [length]
para.sig_s = 3.75*10^-4; % speed mutation variability [length]
para.sig_a = 3.75*10^-4; % acuity mutation variability [length]
para.gamma = F; para.lambda = Lambda/F;

% numerical parameters
num_para.dt = .1; % time step [time]
num_para.gmax = gmax; 

% initial condition
nX0 = 10^4; % # agents
s0 = [0,.1]; % range of initial speed
a0 = [0,.1]; % range of initial acuity
E0 = 10; % given accumulated energy for each agent
nXr0 = ceil(para.lambda*num_para.dt);  % # resources

% MC simulations
Phi_t = cell(M,1); PopRes_t = cell(M,1); tic;
for kmc = 1:M
    init = initial_rand_gen(nX0,s0,a0,E0,nXr0);

    [phi_t,popres_t] = pop_dyn_genMCvid(init,para,num_para);

    phi_t{1,1} = [init.s,init.a];
    Phi_t{kmc,1} = phi_t;

    popres_t(1,:) = [nX0,nXr0];
    PopRes_t{kmc,1} = popres_t;
    toc;
end

% rearrange simulation results
Phi = cell(num_para.gmax,M);
PR = zeros(num_para.gmax,2,M);
for k = 1:M
    phi = Phi_t{k,1};
    PR(:,:,k) = PopRes_t{k,1};
    for j = 1:num_para.gmax
        Phi{j,k} = phi{j,1};
    end
end

save_file_name = 'result.mat';
save(save_file_name,'para','num_para','Phi','PR','Lambda',...
    '-v7.3');

