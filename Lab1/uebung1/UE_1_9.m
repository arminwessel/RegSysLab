%% RegSys1 Ex1

%% parametrische Identifikation
%
%
%
% 1.9
close all;
clear all;
%Parameter

Ta=0.025;
sim_time = 100;
Pp=40;
U=10;


[u_pr4,t_pr4] = PRBS(U,Pp,Ta);

parSim.t_in = t_pr4;
parSim.u_in = u_pr4;

parSim.T_a=Ta;
parSim.Methode=2;
parSim.xx0=[0,0];

% Anfangswerte:
rls=struct;
parRLS=struct;

parRLS.T_a = Ta;
RLSq = 0.99; %sinnvoller Bereich 0.9 < q < 0.995
parRLS.q=RLSq;
RLSalpha = 1;
parRLS.alpha = RLSalpha;

sim('Einmassenschwinger', sim_time);

%Federsteifigkeit und Filter können im Simulink auf oberster Ebene
%geschalten werden
