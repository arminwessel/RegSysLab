% Zusatzaufgabe für Übungstermin Flachheit: Flexibler Roboterarm
% M. Egretzberger, November 2009
% C. Hartl, Jänner 2018
% Ausgabe-Dateien für Studenten im Ordner "flexRobot4students"
% (Simulink Model File + m-File mit Parametern + mex-File des Modells)
%% Modellparameter
%Mit diesen Parametern werden die Regler entworfen.
c=10;
d__1=0.5;
d__2=0.5;
m=1;
g=9.81;
l=0.5;
I__1=1;
I__2=1;
x__0=[-pi/2,-pi/2,0,0];

%% Parameter für den Regler
param_controller=[c,d__1,d__2,m,g,l,I__1,I__2];

%% Parameter für das nominelle System
param_system=[c,d__1,d__2,m,g,l,I__1,I__2];

%% Parameter für die veränderten/gestörten Systeme
param_system_altered1=[c*1.1,d__1,d__2,m,g,l,I__1,I__2];
param_system_altered2=[c*0.6,d__1,d__2,m,g,l,I__1,I__2];

%% Trajektoriengenerator aus Versuch Laborhelikopter übernommen
% (basiert auf polynomialer Darstellung ohne Normierung)
% Parameter für Solltrajektorie:
%   Dauer der Transition T=10s,
%   Start bei stab. Ruhelage phi__2=-pi/2
%   Ende bei instab. Ruhelage phi__2=pi/2
param_trajectory=[10,-pi/2,pi/2];

%% P-Regler Parameter
% k=-0.1*180/pi;
% nach rlocus stabil für k in [4.91,10.8]
parReg.k=5;