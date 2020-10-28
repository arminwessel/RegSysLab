%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Labor Regelungssysteme 1, WS 16/17
%
% Aufgabe 2.4: Zustandsregler mit Integralanteil
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% aus LoadParameter.m �bernommen und angepasst
clear all
warning off
clc

% Obere oder untere Ruhelage (1-0)
obere_untere_Ruhelage = 1;
% Anfangsfehler f�r Aufgabe 2.4.2
parDP.phi10_error = 1*0.1;
% Quantisierung ein/aus (1-0) - f�gt Quantisierungsrauschen hinzu
Quantisierung = 1;
%Beobachter R�ckf�hrung ein/aus (1-0)
Beobachter_Rueckfuehrung=0;

% Parameter laden
run Parameter
run Tuning_Parameter

% Berechnung der Systemmatrizen
[sysk, sysd] = DP_System(parDP);

% Erweiterung des Pendelmodells um einen Integratoranteil
% und Berechnung des R�ckf�hrungsvektors k
parLQR = LQR_Entwurf( sysd,parLQR );

% Ausgabe des R�ckf�hrungsvektors k' = [kx' kI]
kx = parLQR.kx;
kI = parLQR.kI;

