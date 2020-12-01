%% Setup
mitStabilisierung = 1;
activate_anti_windup = 0;
run A4_12

%% Parameter Nominell zurückstellen
parSys.DA1       = 15e-3;         % Durchmesser AV1
parSys.DA3       = 15e-3;         % Durchmesser AV3

%% Anti-Windup
parInit.windup=activate_anti_windup;
% Anti Windup in der embedded Matlab function

