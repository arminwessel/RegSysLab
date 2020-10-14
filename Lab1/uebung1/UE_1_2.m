%%RegSys1 Ex1

%%Nicht-parametrische Identifikation
%%
%1.2
%1.2.1

N=4096;
ws=2*pi;
we=20*pi;

U=10;

Ta=1/40 % -> 25ms 

%Chrips-Signal
[u,t] = chripsig(U,ws,we,N,Ta);
figure(1)
stairs(t,u)
%PRBS ohne Überabtastung
Pp=1;
[u,t] = PRBS(U,Pp,Ta);
figure(2)
stairs(t,u)

%PRBS mit Überabtastung
Pp=4;
[u,t] = PRBS(U,Pp,Ta);
figure(3)
stairs(t,u)
