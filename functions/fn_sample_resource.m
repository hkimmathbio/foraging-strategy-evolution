function Xr = fn_sample_resource(nr)
Xr = rand(nr,2); % uniform dist

% C = [.2; .8]; sig = .05;
% szC = size(C,1);
% sample_C = C(ceil(szC*rand(nr,1)));
% Xr = repmat(sample_C,[1,2]) + sig*randn(nr,2);
% Xr = mod(Xr,1);
end