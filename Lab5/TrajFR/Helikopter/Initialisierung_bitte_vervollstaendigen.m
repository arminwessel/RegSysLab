%% Parameterdatei Helikopter
%  Übung Regelungssysteme
%
%  Ersteller: T.Glück
%  Erstellt:  03.11.2009
%  Änderungen: Boeck, Okt. 2010
%
%%
clear all;
close all;
clc

s=tf('s');

%% Setzen der Systemparameter des vereinfachten und des vollständigen Modells

%Abtastzeit
Ta = 1e-3;
% Systemparameter des vereinfachten Modells
sysPar.a1 = -1.1713;
sysPar.a2 =  0.3946;
sysPar.a3 = -0.5326;

sysPar.b1 = -0.6354;
sysPar.b2 = -0.6523;
sysPar.b3 =  4.6276;

% Ruhelage für Integrator
sysPar.qR = [0,0,-atan(sysPar.a2/sysPar.a1),0,0,0]; 

% Systemparameter des vollständigen Modells
set_parameter_vollstaendigesModell;

%% Setzen der Reglerparameter - Bitte anpassen!

% Reglerparameter q1
regPar.k13 = 1;
regPar.k12 = 1;
regPar.k11 = 1;
regPar.k10 = 1;
regPar.k1I = 1;
% Reglerparameter q2
regPar.k21 = 1;
regPar.k20 = 1;
regPar.k2I = 1;

%test
a1 = poly(-1*ones(5,1));
a2 = poly(-1*ones(3,1));

% Reglerparameter q1
regPar.k13 = a1(2);
regPar.k12 = a1(3);
regPar.k11 = a1(4);
regPar.k10 = a1(5);
regPar.k1I = a1(6);
% Reglerparameter q2
regPar.k21 = a2(2);
regPar.k20 = a2(3);
regPar.k2I = a2(4);