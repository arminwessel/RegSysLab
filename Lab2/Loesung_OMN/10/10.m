%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Labor Regelungssysteme 1, WS 16/17
%
% Aufgabe 2.10: Zusatz Beobachterentwurf
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% aus LoadParameter.m �bernommen und angepasst
clear all
warning off
clc

% Obere oder untere Ruhelage (1-0)
obere_untere_Ruhelage = 1;
% Anfangsfehler
parDP.phi10_error = 0*0.1;
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

% Kalrman-Filter Entwurf
parKAL = Kalman_Entwurf(sysk, sysd, parKAL);
K = parKAL.KK

%% 2.10
% Das Gesamtsystem wird beim Ruhelagenwechsel mit gro�em Verfahrwegen
% instabil, da die Linearisierung nur bei kleinen Auslenkungen um die
% Ruhelage g�ltig ist.

% 3 Bedingungen f�r Kalman-Filter (RS1 S.59):
C = zeros(2,6);
C(1,5) = 1; % Schlittenposition
C(2,1) = 1; % Innerer Winkel phi1
O = obsv(parKAL.Asysd, C);
parDP.phi10_error=0;
Quantisierung=1;
Beobachter_Rueckfuehrung=1;
% 1)
obsv_sysd = rank(O) == 6;

% 2) (G = 0)
stab = rank(parKAL.Asysd) == 6;

% 3)
% HQH' + R muss positiv definit sein. Da H = 0 und R positiv definit ist,
% ist die Bedingung erf�llt

