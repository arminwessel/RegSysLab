%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Labor Regelungssysteme 1, WS 16/17
%
% Aufgabe 2.9: Beobachterentwurf
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% aus LoadParameter.m �bernommen und angepasst
clear all
warning off
clc

% Obere oder untere Ruhelage (1-0)
obere_untere_Ruhelage = 0;
% Anfangsfehler
parDP.phi10_error = 1*0.1;
% Quantisierung ein/aus (1-0)
Quantisierung = 1;
%Beobachter R�ckf�hrung ein/aus (1-0)
Beobachter_Rueckfuehrung=1;

% Parameter laden
run Parameter
run Tuning_Parameter

% Berechnung der Systemmatrizen
[sysk, sysd] = DP_System(parDP);

% Erweiterung des Pendelmodells um einen Integratoranteil
% und Berechnung des R�ckf�hrungsvektors k
parLQR = LQR_Entwurf( sysd,parLQR );

parFF.aa = 0;
parFF = Vorsteuerung_Entwurf( sysk, parFF );

% Ausgabe des R�ckf�hrungsvektors k' = [kx' kI]
kx = parLQR.kx
kI = parLQR.kI


%% Aufgabe 2.9.1 Ausgangsmatrix

C = zeros(2,6);
C(1,5) = 1; % Schlittenposition
C(2,1) = 1; % Innerer Winkel phi1

parKAL = Kalman_Entwurf(sysk, sysd, parKAL);
K = parKAL.KK


