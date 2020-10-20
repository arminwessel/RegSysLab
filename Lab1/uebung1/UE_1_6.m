%%RegSys1 Ex1
clear all;
%% Parametrische Identifikation
%
%   
%
% 1.6 Numerische Diskretisierung



%% Simulationswerte

Pp=4;
sim_time = 100; 

U=10;
Ta=1/40; % -> 25ms 

%% Simulation
parSim.T_a=Ta;
parSim.Methode=0;
parSim.xx0=[0,0];

[u_pr4,t_pr4] = PRBS(U,Pp,Ta);

parSim.t_in = t_pr4;
parSim.u_in = u_pr4;

sim('Einmassenschwinger', sim_time);

%% Least Square
start=10;

% yk = sim_kein_rauschen.signals.values(start:end);
% yk1 = sim_kein_rauschen.signals.values(start-1:end-1);
% yk2 = sim_kein_rauschen.signals.values(start-2:end-2);

yk = sim_mit_rauschen.signals.values(start:end);
yk1 = sim_mit_rauschen.signals.values(start-1:end-1);
yk2 = sim_mit_rauschen.signals.values(start-2:end-2);

u = sim_eingang.signals.values;
u_quer = u(start:end) + 2*u(start-1:end-1) + u(start-2:end-2);

S = [-yk1, -yk2, u_quer];
p_gesch = (S'*S)\S'*yk; % Backslash Operator

% Aus Maple
par.m = (-1/16)*Ta^2*(p_gesch(1)-p_gesch(2)-1)/p_gesch(3);
par.d = (-1/4)*Ta*(p_gesch(2)-1)/p_gesch(3);
par.c = (1/4)*(p_gesch(1) + p_gesch(2) +1)/p_gesch(3);

par.t = sim_time;
par.Pp=Pp

%% Punkt 1.6.3

% Die Überabtastung des PRBS bewirkt das die Pulse des Signals länger
% konstant bleiben. Dadurch hat das System mehr Zeit zum Einschwingen,
% wodurch sich die geschätzten Parameter verbessern. Am meisten Unterschied
% kann beim Faktor d beobachtet werden.

% Durch das Erhöhen des Pp-Wert wird die Anzahl der Messpunkte erhöht

% Eine längere Simulationsdauer bewirkt ebenfalls mehr Messpunkte. Das
% Rauschen wird dadurch rausgemittelt

%% Punkt 1.6.4
% Für eine längere Messdauer sinkt der Einfluss des Rauschens, denn der
% Fehler wird über die vielen Messwerte ausgemittelt

%% Punkt 1.6.5
% Das Rauschen wirkt direkt auf den verallgemeinerten Gleichungsfehler e,
% über dessen Minimierung die Least-Squares Methode funktioniert
