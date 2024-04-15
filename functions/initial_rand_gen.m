function init = initial_rand_gen(nX,s_dom,a_dom,E0,nXr)
% generate initial conditions

init.X = rand(nX,2); init.theta = 2*pi*rand(nX,1);
init.s = (s_dom(2)-s_dom(1))*rand(nX,1) + s_dom(1);
init.a = (a_dom(2)-a_dom(1))*rand(nX,1) + a_dom(1);
init.E = E0*ones(nX,1);

init.gi = ones(nX,1); init.gi_max = 0;

init.Xr = fn_sample_resource(nXr);
end