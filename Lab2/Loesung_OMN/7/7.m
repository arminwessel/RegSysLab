%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Labor Regelungssysteme 1, WS 16/17
%
% Aufgabe 2.7: Trajektorienplanung
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
run Tuning_Parameter

%% 2.6.1 Funktion Vorsteuerung_Entwurf ausführen und plotten

[ sysk, sysd ] = DP_System( parDP );
parFF.aa = 0;

[ parFF ] = Vorsteuerung_Entwurf( sysk, parFF );

Vorsteuerung_Plotten( parFF );

%% LQR

[ parLQR ] = LQR_Entwurf ( sysd, parLQR );

%% Kalman

[ parKAL ] = Kalman_Entwurf ( sysk, sysd, parKAL );

