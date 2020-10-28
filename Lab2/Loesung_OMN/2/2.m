%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Labor Regelungssysteme 1, WS 16/17
%
% Aufgabe 2.2: Linearisierung
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

%Parameter laden
run Parameter

%% 2.2.2 LTI-Objekte aus Funktion
% LTI-Objekt sysk in kontinuierlicher Zustandsdarstellung S.23/(2.11)
% LTI-Objekt sysd in diskreter Zustandsdarstellung S.23/(2.12)

% Systeme laden für untere Ruhelage
[sysk_uR,sysd_uR] = DP_System(parDP);

%% 2.2.3 Eigenwerte und Nullstellen des linearisierten Systems

% Eigenwerte berechnen
Eigenwerte_uR = pole(sysk_uR)
Nullstellen_uR = zero(sysk_uR)

% Parameter laden für obere Ruhelage
obere_untere_Ruhelage = 1;
run Parameter

% Systeme laden für obere Ruhelage
[sysk_oR,sysd_oR] = DP_System(parDP);
% Eigenwerte berechnen
Eigenwerte_oR = pole(sysk_oR)
Nullstellen_oR = zero(sysk_oR)

% Minimalphasigkeit
MinPhase_uR = minreal(sysk_uR);
MinPhase_oR = minreal(sysk_oR);

% keine phasenminimale Übertragungsfunktion G(s)
% G(s) ist phasenminimal wenn alle Pole und Nullstellen in der
% linken offenen s-Halbebene liegen (vgl.Aut/S.80)

% Das System hat 6 Polstellen und 4 Nullstellen und es kommt zur
% Pol-Nullstellenkürzung

% Alle Nullstellen der unteren Ruhelage sind stabil, die der oberen
% Ruhelage nicht -> obere Ruhelage ist instabil

%% 2.2.4 Erreichbarkeit

% Das System ist genau dann vollständig erreichbar, wenn die
% Erreichbarkeitsmatrix R den Rang n hat vgl.Aut/S.187/(7.11)
% mit der (nxn)-Matrix A (n...Systemordnung)
R = ctrb(sysd_uR);
Rang_R = rank(R)
Systemordnung = size(sysd_uR,'order')



