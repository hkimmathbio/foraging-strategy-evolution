function [E,Ir,Ix] = update_metascore(X,s,a,E,Xr,d_min,nr_min,Er,dt)
% update metabolic scores E and determine which resources are taken, Ir
% assume that agents split resource if their arrival time < dt
szX = size(X,1); szXr = size(Xr,1);

Idt = sparse(d_min < s*dt); % agent who can reach resource in dt
% size(Idt) [pop,1]
Ixr = repmat(Idt,[1,szXr]).*sparse(nr_min == (1:szXr)); % index, who get which resource
% size(Ixr) [pop,resource]

% % share resource evenly
% Ir = sum(Ixr,1);
% Ir_deno = Ir + (Ir == 0);
% Exr = Ixr./repmat(Ir_deno,[szX,1]); % resouce energy split to agent
% Ir = (Ir>0)'; % save as vector form

% resource taken by a single agent
szIxr = size(Ixr); Exr = zeros(szIxr); % define Exr
[~, row_indices] = max(Ixr, [], 1); % pick who get resource (by the old?)
Exr(sub2ind(szIxr, row_indices, 1:szIxr(2))) = 1;
Exr = Exr.*Ixr; % remove redundant 1s
Ir = sum(Exr,1); % index for resource taken by agents

Ix = sum(Exr,2); % # resource taken by agents
dE_p = Er*Ix; % gain energy taken by agents
dE_n = fn_metacost(s,a)*dt; % metabolic cost by moving and detecting
E = E + dE_p - dE_n; % update metabolic scores
end