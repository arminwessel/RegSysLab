%% RegSys1 Ex1

%% parametrische Identifikation
%
%
%
% 1.7 und 1.8
close all;

%% Matrizen
% Sinnvoller Bereich von Tf
Tf=0.1;

A = [0 1 0; 0 0 1; -0.1e1 / Tf ^ 3 -3 / Tf ^ 2 -3 / Tf;];
B = [0;0;1];
C = [0.1e1 / Tf ^ 3 0 0; 0 0.1e1 / Tf ^ 3 0; 0 0 0.1e1 / Tf ^ 3;];

Sys=ss(A,B,C,[0]);


%% Diskretisierung

Ta_zvf = Tf/100; %beim Setzen auf Tf/10 verschlechtert sich die Schaetzug

ZVFz=c2d(Sys,Ta_zvf);

Ta=0.025;
sim_time = 0.5;

%% generate PRBS

Pp=4;
U=10;

[u_pr4,t_pr4] = PRBS(U,Pp,Ta);

parSim.t_in = t_pr4;
parSim.u_in = u_pr4;

%% Simulation
parSim.T_a=Ta;
parSim.Methode=1;
parSim.xx0=[0,0];
sim('Einmassenschwinger', sim_time);

%ohne Rauschen
y = sim_ZVF_y.signals.values(:,1);
y_p = sim_ZVF_y.signals.values(:,2);
y_pp = sim_ZVF_y.signals.values(:,3);

u=sim_ZVF_u.signals.values(:,1);

S = [-y, -y_p, u];
p_gesch = (S'*S)\S'*y_pp;

par.m = 1/p_gesch(3);
par.d = p_gesch(2)*par.m;
par.c = p_gesch(1)*par.m;
par.t = sim_time;
par.Pp=Pp

%mit Rauschenkatastrophe

y_r = sim_ZVF_y_rausch.signals.values(:,1);
y_p_r = sim_ZVF_y_rausch.signals.values(:,2);
y_pp_r = sim_ZVF_y_rausch.signals.values(:,3);

u_r=sim_ZVF_u.signals.values(:,1);

S_r = [-y_r, -y_p_r, u_r];
p_gesch_r = (S_r'*S_r)\S_r'*y_pp_r;

par_r.m = 1/p_gesch_r(3);
par_r.d = p_gesch_r(2)*par_r.m;
par_r.c = p_gesch_r(1)*par_r.m;
par_r.t = sim_time;
par_r.Pp=Pp

% Die Parameterschaetzung wird durch das Rauschen fast nicht verschlechtert
% solange die Simulationszeit (sim_time) nicht zu nahe an der
% Filterzeitkonstante (Tf) liegt.
% sim_time = 0.5 geht noch gut
% sim_time = 0.1 fehlerhaft
REK

