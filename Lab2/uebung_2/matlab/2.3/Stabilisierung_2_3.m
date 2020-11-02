clc
run LoadParameter
% LQR Entwurf
parLQR = LQR_Entwurf(sysd,parLQR);
parLQR

%% Notes
% Der PI-Zustandsregelr wird wie im Aut Skript entworfen
% dlqr gibt die Werte der optimalen Zustandsrückführung zurück