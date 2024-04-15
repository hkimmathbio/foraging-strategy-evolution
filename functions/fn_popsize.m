function sz = fn_popsize(T,stat)

szT = size(T,2);
sz = zeros(1,szT);

for n = 1:szT
    sz(n) = size(stat{n},1);
end

end