%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Labor Regelungssysteme 1, WS 16/17
%
% Aufgabe 1.11: Verfahren nach Clary
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;
clc;

%% 1.11.1

% Variablen:
% Masse m
% D�mpfung d
% Federsteifigkeit c
% Position sm                       = Ausgang y
% Geschwindigkeit wm = d/dt sm
% Kraft F                           = Stelleingang u
% �bertragungsfunktion Gs = y/u
% Abtastzeit Ta

% Werte:
m = 0.5;   % [kg]
d = 0.7;   % [Ns/m]
c = 100.0; % [N/m]
Ta = 25e-3;   % [s]

% System zeitkontinuierlich:
s = tf('s');
G_s = 1/(m*s^2 + d*s + c);
Ga_s = 10/s^2;
Gg_s = Ga_s*G_s;

Ga_z = c2d(Ga_s, Ta, 'zoh');

% Vorfilter
% zGa_z = Ga_z.num{1}
% nGa_z = Ga_z.denom{1}

n = 2;

z = tf('z');
% V1z = tf(zGa_z, [1, 0, 0], 'variable', 'z')
% V2z = tf(nGa_z, [1, 0 ,0], 'variable', 'z')



V1z = (0.003125*z + 0.003125)/z^2;
V2z = (z^2 - 2*z + 1)/z^2;


% System zeitdiskret:
Gg_z = c2d(Gg_s, Ta, 'zoh');


%% 1.11.2

% Parameter f�r Chirp- und PRBS-Signal:
N = 4096;
ws = 0.3*2*pi;    % [rad/s]
we = 10*2*pi; % [rad/s]
U = 10;
Ta = 25e-3;   % [s]

% Chirp Signal:
[ u_chirp, t_chirp ] = chirpsig( U, ws, we, N, Ta );


%% 1.3 ETFE

[Gg_z_mag,Gg_z_phase, Gg_z_w] = bode(Gg_z,{ws,we});
Gg_z_ampl = 20*log10(squeeze(Gg_z_mag(1,1,:)));
Gg_z_phase = squeeze(Gg_z_phase(1,1,:));

%% 1. Simulation

% Parameters
parSim.T_a=Ta;
parSim.Methode=0;
sim_time=Ta*(N-1);
parSim.xx0=[0,0];

% Simulation Chirp

parSim.t_in = t_chirp;
parSim.u_in = u_chirp;

sim('Einmassenschwinger', sim_time);

y_chirp_mr = sim_mit_rauschen;
y_chirp_kr = sim_kein_rauschen;

% 2. Sch�tzung der �bertragungsfunktion Chrip

N_chirp = length(u_chirp);

% Minimale Frequenz
dw_chirp = 2*pi/(N_chirp*Ta);

% Maximale Frequenz
w_max = pi/Ta;

% physikalisch sinnvoller Bereich
w_chirp = 0:dw_chirp:w_max-dw_chirp;


% Eingang
N_chirp = length(u_chirp);
u_chirp_fft = fft(u_chirp, N_chirp);

% FFT
y_chirp_kr_fft = fft(y_chirp_kr.signals.values,N_chirp);
y_chirp_mr_fft = fft(y_chirp_mr.signals.values,N_chirp);

G_chirp_kr_ampl = 20*log10(abs(y_chirp_kr_fft)./abs(u_chirp_fft));
G_chirp_kr_phase = unwrap(angle(y_chirp_kr_fft) - angle(u_chirp_fft))*180/pi;
G_chirp_mr_ampl = 20*log10(abs(y_chirp_mr_fft)./abs(u_chirp_fft));
G_chirp_mr_phase = unwrap(angle(y_chirp_mr_fft) - angle(u_chirp_fft))*180/pi;

% Signale mit Vorfilter:

u_chirp_v = lsim(V1z, u_chirp);
u_chirp_fft_v = fft(u_chirp_v, N_chirp);

y_chirp_kr_v = lsim(V2z, y_chirp_kr.signals.values);
y_chirp_mr_v = lsim(V2z, y_chirp_mr.signals.values);

y_chirp_kr_fft_v = fft(y_chirp_kr_v,N_chirp);
y_chirp_mr_fft_v = fft(y_chirp_mr_v,N_chirp);

G_chirp_kr_ampl_v = 20*log10(abs(y_chirp_kr_fft_v)./abs(u_chirp_fft_v));
G_chirp_kr_phase_v = unwrap(angle(y_chirp_kr_fft_v) - angle(u_chirp_fft_v))*180/pi;
G_chirp_mr_ampl_v = 20*log10(abs(y_chirp_mr_fft_v)./abs(u_chirp_fft_v));
G_chirp_mr_phase_v = unwrap(angle(y_chirp_mr_fft_v) - angle(u_chirp_fft_v))*180/pi;



figure(3)
subplot(2,1,1)
semilogx(w_chirp, G_chirp_kr_ampl(1:floor(N_chirp/2)));
hold on;
semilogx(w_chirp, G_chirp_kr_ampl_v(1:floor(N_chirp/2)));
hold on;
%semilogx(Gg_z_w, Gg_z_ampl);
grid on;
title('Amplitudengang ohne Vorfilter, ohne Rauschen');
ylabel('Amplitude [dB]');
xlabel('Frequenz [rad/s]');
legend('ohne VF', 'mit VF','Referenzmodell','Location','northwest');

subplot(2,1,2)
semilogx(w_chirp, G_chirp_kr_phase(1:floor(N_chirp/2)));
hold on;
semilogx(w_chirp, G_chirp_kr_phase_v(1:floor(N_chirp/2)));
hold on;
semilogx(Gg_z_w, Gg_z_phase);
hold off;
grid on;
title('Frequenzgang ohne Vorfilter, ohne Rauschen');
ylabel('Phase [�]');
xlabel('Frequenz [rad/s]');


%% 3. Sch�tzungen mit Messrauschen

figure(4)
subplot(2,1,1)
semilogx(w_chirp, G_chirp_mr_ampl(1:floor(N_chirp/2)));
hold on;
semilogx(w_chirp, G_chirp_mr_ampl_v(1:floor(N_chirp/2)));
hold on;
semilogx(Gg_z_w, Gg_z_ampl);
grid on;
title('Amplitudengang mit Rauschen');
ylabel('Amplitude [dB]');
xlabel('Frequenz [rad/s]');
legend('ohne VF', 'mit VF','Referenzmodell','Location','northwest');

subplot(2,1,2)
semilogx(w_chirp, G_chirp_mr_phase(1:floor(N_chirp/2)));
hold on;
semilogx(w_chirp, G_chirp_mr_phase_v(1:floor(N_chirp/2)));
hold on;
semilogx(Gg_z_w, Gg_z_phase);
hold off;
grid on;
title('Frequenzgang mit Rauschen');
ylabel('Phase [�]');
xlabel('Frequenz [rad/s]');
