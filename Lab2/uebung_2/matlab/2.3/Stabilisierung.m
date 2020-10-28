
% Ruhelage auswählen:
% untere_ruhelage = 1 -> untere Ruhelage
% untere_ruhelage = 0 -> obere Ruhelage
% obere Ruhelage
untere_ruhelage = 0;

% Parameter laden
Parameter_Liste;
Tuning_Parameter;

%Systeme erzeugen wird gebraucht für die LQR_Entwurf Funktion
[sysk,sysd] = DP_System(parDP);

% LQR Entwurf
parLQR = LQR_Entwurf(sysd_oR,parLQR);