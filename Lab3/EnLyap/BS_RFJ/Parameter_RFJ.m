%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameterdatei fuer Backstepping am Rotary Flexible Joint
%
% Autor:    Baumgart Michael/Michel Alexander
% Datum:    01.08.2011
% Projekt:  Uebung Regelungssysteme
%
% Aenderungen: 01.08.2011 Baumgart
%              04.11.2014 Schausberger
%              14.10.2020 Knechtelsdorfer
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc; clear all;
%% Parameter des Systems
parSys.I_a = 2.773278e-3;      %kgm^2
parSys.d_a = 6.5407e-04;       %Nms/rad
parSys.c_0 = 0.9898;           %Nm/rad
parSys.phit_0 = 0;
parSys.phia_0 = 0;
parSys.omega_0= 0;


%% Soll-Parameter des Impedanz-Systems
par_imp.d = 10e-3;              %Nms/rad - par_imp(1);
par_imp.M_max = 0.2;            %Nm - par_imp(2);
par_imp.c = 0.7;                %Nm/rad - par_imp(3); 

par_reg.k0 = 50;
par_reg.k1 = 80;
par_reg.gamma1 = 1e10;
par_reg.Ts = 1e-3;
