%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LoadParameter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
warning off
clc

% Obere oder Untere Ruhelage (1-0)
obere_untere_Ruhelage = 1;
% Anfangsfehler
parDP.phi10_error = 0*0.1;


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
%Kalman-Filter-Entwurf
[parKAL] = Kalman_Entwurf(sysk,sysd,parKAL);
%Vorsteuerungsentwurf
[parFF] = Vorsteuerung_Entwurf(sysk,parFF);
%Vorsteuerung Plotten
if(0)
    Vorsteuerung_Plotten(parFF)
end

if(1)
    disp('Simulations läuft...')
    open('Doppelpendel_EKF.slx')
    sim('Doppelpendel_EKF.slx')
end
