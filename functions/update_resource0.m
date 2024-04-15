function Xr = update_resource0(lambda,dt)
% update resource location vector

nr = poissrnd(lambda*dt); % # or generating resource
Xr = fn_sample_resource(nr);

end