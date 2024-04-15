function Xr = update_resource(Xr,Ir,lambda,dt)
% update resource location vector

Xr1 = Xr(:,1); Xr2 = Xr(:,2);
Xr1 = Xr1(Ir==0); Xr2 = Xr2(Ir==0); % choose resources that are not taken

% p_r = 1 - exp(-lambda*dt); % prob of generating resource
% if rand(1) <p_r
%     Xr = [[Xr1,Xr2]; sample_resource()];
% else
%     Xr = [Xr1,Xr2];
% end

nr = poissrnd(lambda*dt); % # or generating resource
Xr = [[Xr1,Xr2]; fn_sample_resource(nr)];
end