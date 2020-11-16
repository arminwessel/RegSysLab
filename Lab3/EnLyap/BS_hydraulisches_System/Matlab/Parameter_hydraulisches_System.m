%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameterdatei für einfaches hydraulisches System für Backstepping
%
% Autor:    Kemmetmueller Wolfgang
% Datum:    01.10.2008
% Projekt:  Uebung Regelungssysteme
%
% Aenderungen: 01.08.2011 Baumgart
%              12.10.2020 Knechelsdorfer
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all
clc

s=tf('s');

%% Parameter des Systems

%Zylinder
parSys.Dk = 40e-3;    %Kolbendurchmesser
parSys.Ds = 20e-3;    %Stangendurchmesser
parSys.Aa = parSys.Dk^2*pi/4; %Kolbenfläche
parSys.Ab = parSys.Aa-parSys.Ds^2*pi/4;   %Flaeche Stangenseite
parSys.V0a = 0.7e-3;  %Offsetvolumen Kolbenseite für sk=0

%Öl
parSys.beta = 1.6e9;  %Kompressionsmodul Oel

%Lastmasse
parSys.m = 500;       %Masse des Systems
parSys.dk = 800;      %Daempfung des Kolbens

%Vorspanndruck Stangenseite
parSys.pb = 150e5;    %Vorspanndruck Stangenseite

%Nominelle Leckage
parSys.klecknom = 1/60e3/100e5;  %1l/min bei 100 bar Druckdifferenz

%% Anfangsbedingungen
parSys.sk0 = 0;
parSys.wk0 = 0;


%% Sollimpedanzsystem

%Federcharakterisitiken
parImp.c1I = 5e3/0.1;    
parImp.c3I = 10e3/0.1^3;
parImp.c0I = 50e3; 
parImp.skImax = 0.5;

%Daempfungscharakteristiken
parImp.d1I = 2.5e3;

%Gewaehlte Federcharakteristik
parImp.numFeder = 1;      %1..linear, 2..kubisch, 3..tan

%Bestimmung der Federkraft in der Anfangslage
if parImp.numFeder<1.5
    FcI0 = parImp.c1I*parSys.sk0;      %lineare Feder
elseif parImp.numFeder<2.5
    FcI0 = parImp.c1I*parSys.sk0+parImp.c3I*parSys.sk0^3; % kubische Feder
else
    FcI0 = parImp.c0I*2*parImp.skImax/pi*tan(pi*parSys.sk0/2/parImp.skImax); % tan Feder
end

%% Anfangsbedingungen fuer Druck
parSys.pa0 = (parSys.pb*parSys.Ab-FcI0)/parSys.Aa;

%% Filter zur Bestimmung der Geschwindigkeit
parMess.Tdiff = 5e-3;
parMess.Gdiffsk = s/(s*parMess.Tdiff+1);

%% Reglerparameter ohne Adaption
parRegoA.k1 = 1e2*20; 
parRegoA.gamma = 1;%1e6;


%% Reglerparameter mit Adaption
parRegA.k1 = 1e2;
% parRegA.k0 = 1e-28;
parRegA.k0 = 1e-29;
parRegA.gamma = 1;%1e6;
parRegA.Ts = 0.002; 


