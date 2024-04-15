function [bf,df] = fn_bdrate()
alpha = 4; beta = 1; delta = 1; Kb = 10; Kd = 1; c = .005;

bf_pos = @(E) beta*(E.^alpha)./(E.^alpha + Kb^alpha); % birth rate
df_pos = @(E) delta*(Kd^alpha)./(E.^alpha + Kd^alpha); % death rate

bf = @(E) (E>=0).*bf_pos(E);
df = @(E) (E>=0).*df_pos(E) + (E<0) + c;
end