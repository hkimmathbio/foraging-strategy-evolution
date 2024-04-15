function E = update_metascore0(s,a,E,dt)
% update metabolic scores E when no resource

dE_n = fn_metacost(s,a)*dt; % metabolic cost by moving and detecting
E = E - dE_n; % update metabolic scores
end