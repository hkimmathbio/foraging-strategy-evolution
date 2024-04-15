function C = fn_metacost(s,a)
% metabolic cost (E/time) 

% C = 2*((s/.1).^2 + (a/1));

e_s = 160; % .1 = 16000/400^2 -> 16000 (length scale) -> 16000/100 (E norm)
% e_a = .4; % .1 = 40/400 -> 40 = 40/1 (length scale) -> 40/100 (E norm)
e_a = 4;
C = e_s*s.^2 + e_a*a;
end