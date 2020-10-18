Pp=4;
sim_time = 100; 

U=10;
Ta=1/40 % -> 25ms 

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

yk = sim_kein_rauschen.signals.values(start:end);
yk1 = sim_kein_rauschen.signals.values(start-1:end-1);
yk2 = sim_kein_rauschen.signals.values(start-2:end-2);

u = sim_eingang.signals.values;
u_quer = u(start:end) + 2*u(start-1:end-1) + u(start-2:end-2);

S = [-yk1, -yk2, u_quer];
p_gesch = (S'*S)\S'*yk;

par.m = (-1/16)*Ta^2*(p_gesch(1)-p_gesch(2)-1)/p_gesch(3);
par.d = (-1/4)*Ta*(p_gesch(2)-1)/p_gesch(3);
par.c = (1/4)*(p_gesch(1) + p_gesch(2) +1)/p_gesch(3);
par.t = sim_time;
par.Pp=Pp