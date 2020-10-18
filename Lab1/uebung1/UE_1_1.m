%%RegSys1 Ex1

%% Nicht-parametrische Identifikation
%%
%1.1


%% Paramter
m=0.5
d=0.7
c=100

numerator = 1
denominator = [m,d,c];
%% continuierliches Modell
Sys=tf(numerator,denominator)

%% discretes Modell
ts = 1/40; %25ms
s=tf('s')
Sys_z=c2d(Sys,ts,'zoh')
bode(Sys)


syms w
w0=solve(0.5*w^2==100,w)
%w0=14.1421

f0=w0/(2*pi)
%f0=2,2508

%%
domega=2*pi/ts
df=1/ts

omegamsx=pi/ts
fmax=1/(2*ts)