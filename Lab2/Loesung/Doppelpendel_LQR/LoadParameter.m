%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LoadParameter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
warning off
clc

% Obere oder untere Ruhelage (1-0)
obere_untere_Ruhelage = 1;
% Anfangsfehler
parDP.phi10_error = 0.1;
% Quantisierung ein/aus (1-0)
Quantisierung = 1;


%Parameter laden
run Parameter
%Systeme laden
[sysk,sysd] = DP_System(parDP);
%Eigenwerte berechnen
disp('Eigenwerte offener Kreis')
Eigenwerte=pole(sysk)
disp('Nullstellen offener Kreis')
Nullstellen=zero(sysk)

%Tuning Parameter laden
run Tuning_Parameter
%LQR-Entwurf
[parLQR] = LQR_Entwurf(sysd,parLQR);

if(1)
    disp('Simulations läuft...')
    open('Doppelpendel_LQR.slx')
    sim('Doppelpendel_LQR.slx')
end
