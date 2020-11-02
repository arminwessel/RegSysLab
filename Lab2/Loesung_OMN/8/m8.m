%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Labor Regelungssysteme 1, WS 16/17
%
% Aufgabe 2.8: Stabilisierung des Fehlersystems
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% aus LoadParameter.m übernommen und angepasst
clear all
warning off
clc

% Obere oder untere Ruhelage (1-0)
obere_untere_Ruhelage = 0;
% Anfangsfehler
parDP.phi10_error = 0*0.1;
% Quantisierung ein/aus (1-0)
Quantisierung = 0;
%Beobachter Rückführung ein/aus (1-0)
Beobachter_Rueckfuehrung=0;

% Parameter laden
run Parameter
run Tuning_Parameter

% Berechnung der Systemmatrizen
[sysk, sysd] = DP_System(parDP);

% Vorsteuerung
parFF.aa = 0;
[ parFF ] = Vorsteuerung_Entwurf( sysk, parFF );

% Erweiterung des Pendelmodells um einen Integratoranteil
% und Berechnung des Rückführungsvektors k
parLQR = LQR_Entwurf( sysd,parLQR );

% Ausgabe des Rückführungsvektors k' = [kx' kI]
kx = parLQR.kx
kI = parLQR.kI


%% Kalman

[ parKAL ] = Kalman_Entwurf ( sysk, sysd, parKAL );

