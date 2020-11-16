%% Uebung Regelungssysteme  
% Parameterdatei zur Simulation des RRP-Roboters
%
% Ersteller:    MK, 09.11.2009
% Aenderungen:  BM, AB,  2011
%               uknechte 2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
clc

% Soll-Trajektorie:
parReg.traj_fKreis     = 0.05;
parReg.traj_fz         = 2;
parReg.traj_phi10      = -pi/2; 
parReg.traj_phi20      = 0;
parReg.traj_s0         = 0.5;

% Roboter:
parSys.m1   = 20;
parSys.m2   = 20;
parSys.m3   = 20;
parSys.mL   = 25;
parSys.l1   = 1;
parSys.l2   = 1;
parSys.l3   = 1;
parSys.Ixx1 = 1.7;
parSys.Iyy1 = 1.7;
parSys.Izz1 = 7e-2;
parSys.Ixx2 = 1.7;
parSys.Iyy2 = 7e-2;
parSys.Izz2 = 1.7;
parSys.Ixx3 = 1.7;
parSys.Iyy3 = 7e-2;
parSys.Izz3 = 1.7;
parSys.d1   = 1;
parSys.d2   = 1;
parSys.d3   = 10;
parSys.delta_phi10 = 0;    %pi/4;
parSys.delta_phi20 = 0;    %pi/4;
parSys.delta_s0    = 0;    %0.25;
parSys.phi10 = parReg.traj_phi10 + parSys.delta_phi10;
parSys.phi20 = parReg.traj_phi20 + parSys.delta_phi20; 
parSys.s0    = parReg.traj_s0    + parSys.delta_s0; 
parSys.phi1p0 = 0;
parSys.phi2p0 = 0; 
parSys.sp0    = 0; 
parSys.g     = 9.81;

% Reglerparameter
% nominelle Streckenparameter
parReg.parSys = parSys;
parReg.parSys.mL = 20; % nominelle Lastmasse

% PD-Regler:
parReg.PD.Ts  = 0.005;

%Kp Matrixeintraege
parReg.PD.kp1 = 14324;
parReg.PD.kp2 = 14324;
parReg.PD.kp3 = 20000;

%KD Matrixeintraege
parReg.PD.kd1 = 2500;
parReg.PD.kd2 = 2500;
parReg.PD.kd3 = 2000;


% Computed-Torque-Regler:
% Pole Fehlersystem bei (s+10)^2 = s^2 + 20s + 100
parReg.CT.Ts  = 0.005;

%K0 Matrix eintraege
parReg.CT.k01 = 100;
parReg.CT.k02 = 100;
parReg.CT.k03 = 100;

%K1 Matrix eintraege
parReg.CT.k11 = 20;
parReg.CT.k12 = 20;
parReg.CT.k13 = 20;

% Computed-Torque-Regler mit Adaptionsregelgesetz:
parReg.CTA.Ts  = 0.001;
K0 = diag([parReg.CT.k01,parReg.CT.k02,parReg.CT.k03]);
K1 = diag([parReg.CT.k11,parReg.CT.k12,parReg.CT.k13]);
% Für die Bestimmung von P muss die Lyapunovgleichung für ein pos def Qquer 
%und der Matrix A (Gleichung 5.117) Skriptum S.121 gelöst werden
% AT*P+P*A+Qquer = 0 
% Dies kann durch den Befehlt lyap(A,Qquer) erfolgen (für Qquer wurde E
% gewählt
A = [zeros(3,3),eye(3);-K0,-K1];
Qquer = eye(6);
parReg.CTA.P = lyap(A,Qquer);
% Matrix B siehe Gleichung 5.117
parReg.CTA.B = [zeros(3,3);eye(3)];
parReg.CTA.Gamma = 5e-2;


% Sollwertfilter:
parReg.nennerpolynom = conv(conv([1/100 1],[1/100 1]),[1/100 1]);
parReg.par_filt_a0   = parReg.nennerpolynom(4)/parReg.nennerpolynom(1);
parReg.par_filt_a1   = parReg.nennerpolynom(3)/parReg.nennerpolynom(1);
parReg.par_filt_a2   = parReg.nennerpolynom(2)/parReg.nennerpolynom(1);
parReg.par_filt_V    = 1/parReg.nennerpolynom(1);