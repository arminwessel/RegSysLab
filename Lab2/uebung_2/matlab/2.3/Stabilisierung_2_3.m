clc
run LoadParameter
% LQR Entwurf
parLQR = LQR_Entwurf(sysd,parLQR);
parLQR

%%
% TODO: AUT Skript PI-Zustandsregler
%       unterschied dlqr und acker