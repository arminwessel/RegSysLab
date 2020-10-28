%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Labor Regelungssysteme 1, WS 16/17
%
% Aufgabe 2.6: Vorsteuerungsentwurf
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

%Parameter laden
run Parameter

%% 2.6.1 Funktion Vorsteuerung_Entwurf ausführen

[ sysk, sysd ] = DP_System( parDP );

parFF.aa = 0;

[ parFF ] = Vorsteuerung_Entwurf( sysk, parFF );

aa = parFF.aa
VVinv = parFF.VVinv
A_schlange = parFF.VV*sysk.A*parFF.VVinv
b_schlange = parFF.VV*sysk.b
