%% Übung Regelungssysteme  
% Parameterdatei und Berechnungsdatei zur Simulation des Riementriebs
%
% Ersteller:    WK, 01.11.2009
% Änderungen:   FM, 02.11.2010
%               FM, 12.07.2011
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;
clc;
s=tf('s');

%% Parameter des Systems Riementrieb
parSys.Il  = 4e-5;     %Trägheitsmoment Last
parSys.cr1 = 10;       %lineare Steifigkeit Riemen
parSys.cr3 = 1e6;      %kubische Steifigkeit Riemen (1e6)
parSys.dl  = 0.001;    %visk. Dämpfung Last
parSys.rl  = 0.05;     %Radius Riemenscheibe Last
parSys.Im  = 0.5e-5;   %Trägheitsmoment Motor
parSys.dm  = 0.01;     %viskose Dämpfung Motor
parSys.rm  = 0.025;    %Radius Riemenscheibe Motor
parSys.Rm  = 1.388;    %Widerstand PSM
parSys.Lm  = 1.475e-3; %Induktivität PSM
parSys.p   = 2.0;      %Polpaarzahl PSM
parSys.Phi = 2.715e-2; %Fluss Permanentmagnet PSM

% Abtastzeit der internen Dynamik
parSys.TsID = 0.1e-3;

%% Anfangsbedingungen des Systems Riementrieb
parSys.omegam_0  = 0;  %AB omegam
parSys.iq_0      = 0;  %AB iq
parSys.id_0      = 0;  %AB id
parSys.epsilon_0 = 0;  %AB epsilon
parSys.omegal_0  = 0;  %AB omegal
% Zusammenfassung der Parameter in einen Vektor
parSys.x0  = [parSys.omegam_0;parSys.iq_0;parSys.id_0;parSys.epsilon_0;parSys.omegal_0];

%% Anfangsbedingungen der Internen Dynamik
parSys.eta_1_0  = 0;  %AB eta_1
parSys.eta_2_0  = 0;  %AB eta_2

%% Parameter des Sollwertfilters omegam
parReg.ppSFc    = [-10,-12,-14]*10;
parReg.cpolySFc = poly(parReg.ppSFc);
parReg.AASF = [0,1,0;
               0,0,1;
               -parReg.cpolySFc(4),-parReg.cpolySFc(3),-parReg.cpolySFc(2)];
parReg.BBSF = [0;0;parReg.cpolySFc(4)];
parReg.CCSF = eye(3);
parReg.DDSF = zeros(3,1);
parReg.ssSF = ss(parReg.AASF,parReg.BBSF,parReg.CCSF,parReg.DDSF);
parReg.ratelim = 1000;     %maximale Änderung

%% Parameter des Sollwertfilters id
parReg.ppSFci    = [-10,-15];
parReg.cpolySFci = poly(parReg.ppSFci);
parReg.AASFi = [0,1;
                -parReg.cpolySFci(3),-parReg.cpolySFci(2)];
parReg.BBSFi = [0;parReg.cpolySFci(3)];
parReg.CCSFi = eye(2);
parReg.DDSFi = zeros(2,1);
parReg.ssSFi = ss(parReg.AASFi,parReg.BBSFi,parReg.CCSFi,parReg.DDSFi);

%% Regler
% Parameter
Il = parSys.Il;
cr1= parSys.cr1;
cr3= parSys.cr3;
dl = parSys.dl;
rl = parSys.rl;
I_m = parSys.Im;
dm = parSys.dm;
rm = parSys.rm;
Rm = parSys.Rm;
Lm = parSys.Lm;
p  = parSys.p;
Phi= parSys.Phi;

% Frei vorgebbar: omega_m_d,  i_d_d
wmd = 0;
idd = 0;

% Zu berechnen i_q_d,   omega_l_d,   epsilon_d (implizit)
iqd = 0.2e1 / 0.3e1 * wmd * (dl * rm ^ 2 + dm * rl ^ 2) / Phi / p / rl ^ 2;
wld = rm * wmd / rl;
% 
syms cg;
assume(cg,'real')
epsd_fun = @(cg)(2 * cr3 * rl ^ 2 * cg ^ 3 + 2 * cr1 * rl ^ 2 * cg + dl * rm * wmd);
epsd = fzero(epsd_fun,0);


% Matrizen
A = [-dm / I_m 0.3e1 / 0.2e1 * p * Phi / I_m 0 0.2e1 * (3 * cr3 * epsd ^ 2 + cr1) * rm / I_m 0; p * ((3 * Lm * idd) - 0.2e1 * Phi) / Lm / 0.3e1 -0.2e1 / 0.3e1 * Rm / Lm wmd * p 0 0; -iqd * p -wmd * p -0.2e1 / 0.3e1 * Rm / Lm 0 0; -rm 0 0 0 rl; 0 0 0 -2 * rl * (3 * cr3 * epsd ^ 2 + cr1) / Il -dl / Il;];
B = [0 0; 0.2e1 / 0.3e1 / Lm 0; 0 0.2e1 / 0.3e1 / Lm; 0 0; 0 0;];
C = [1 0 0 0 0; 0 0 1 0 0;];
D = 0;

% System
Ta = 0.1e-3; % 0.1 ms
sysc = ss(A,B,C,0);
sysd = c2d(sysc,Ta,'zoh');          
Gz = tf(sysd);
display(Gz);
% figure()
% pzmap(Gz);
% grid minor;

% Reglerparameter
parSys.Ta=Ta;
% für Ausgang uq
parSys.kp_uq = 2;
parSys.kI_uq = 10;

% für Ausgang uq
parSys.kp_ud = 40;
parSys.kI_ud = 100;