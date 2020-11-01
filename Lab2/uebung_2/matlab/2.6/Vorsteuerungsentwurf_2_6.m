%% Parameter laden
clear all
warning off
clc

% Obere oder untere Ruhelage (1-0)
obere_untere_Ruhelage = 0;
% Anfangsfehler
parDP.phi10_error = 0*0.1;

%Parameter laden
run Parameter

%% 2.6.1 Vorsteuerung_Entwurf aufrufen

[sysk, sysd] = DP_System( parDP );

% initialisierung parFF structure
parFF.aa = 0;
parFF.VVinv = 0;

parFF = Vorsteuerung_Entwurf( sysk, parFF );

% Regelungsnormalform
aa = parFF.aa
VVinv = parFF.VVinv
VV = transpose(VVinv)
A_schlange = VV*sysk.A*VVinv
b_schlange = VV*sysk.b