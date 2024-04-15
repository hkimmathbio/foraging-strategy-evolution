function mdist = fn_Edist(m)
% mean of min dist between agent and m agents in rectangle

F1 = @(x) pi*x.^2;
F2 = @(x) pi*x.^2 + 2*sqrt(x.^2 - 1/4) - 4*(x.^2).*asin(sqrt(1-1./(4*x.^2)));

mdist = integral(@(x) (1-F1(x)).^m,0,1/2) ...
    + integral(@(x) (1-F2(x)).^m,1/2,1/sqrt(2));
end