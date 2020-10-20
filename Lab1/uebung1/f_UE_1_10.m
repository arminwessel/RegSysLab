%% RegSys1 Ex1

%% parametrische Identifikation
%
%
%
% 1.10
close all;
clear all;

%% Paramter
m=0.5;
d=0.7;
c=100;
Ta=0.025;

%% Modell
s=tf('s');
G1 =  1 / (m*s^2+d*s+c);    %"unbekannt"
G2 = 10/s^2;                 %bekannte Teil
Sys_Gg=G1*G2;
Sys_Gg_z = c2d(Sys_Gg,Ta,'zoh');
Sys_z = c2d(G1,Ta,'zoh');
%% Chirp 
N=4096;
ws=0.3*2*pi;
we=20*pi;
U=10;

%Chirp-Signal
[u_ch,t_ch] = chirpsig(U,ws,we,N,Ta);

%% Simulation
parSim.u_in= u_ch;
parSim.t_in= t_ch;
parSim.T_a=Ta;
parSim.Methode=3;
sim_time=Ta*(N-1);
parSim.xx0=[0,0];

sim('Einmassenschwinger', sim_time);

y_ch_n = sim_mit_rauschen;
y_ch = sim_kein_rauschen;


w_max = pi/Ta;
dw_ch = 2*pi/(length(u_ch)*Ta);
w_ch = 0:dw_ch:w_max-dw_ch;


% FFT of chirp signal
u_ch_fft = fft(u_ch,length(u_ch));


y_ch_fft = fft(y_ch.signals.values,length(u_ch));
y_ch_n_fft = fft(y_ch_n.signals.values,length(u_ch));

G_ch_ampl = 20*log10(abs(y_ch_fft)./abs(u_ch_fft'));
G_ch_phase = unwrap(angle(y_ch_fft) - angle(u_ch_fft'))*180/pi;
G_ch_n_ampl = 20*log10(abs(y_ch_n_fft)./abs(u_ch_fft'));
G_ch_n_phase = unwrap(angle(y_ch_n_fft) - angle(u_ch_fft'))*180/pi;


%% Gz reference
[Sys_z_mag,Sys_z_phase, Sys_z_w] = bode(Sys_z,{ws,we});
Sys_z_ampl = 20*log10(squeeze(Sys_z_mag(1,1,:)));
Sys_z_phase = squeeze(Sys_z_phase(1,1,:));




%% Vorfilter
z=tf('z');
G2_z=c2d(G2,Ta,'zoh');
%Gleichungen aus Skriptum

[num den]=tfdata(G2_z)
cell2mat(num)
V1 = tf(num,1,Ta)/z^2
V2 = tf(den,1,Ta)/z^2

u_ch_v = lsim(V1, u_ch);
u_ch_fft_v = fft(u_ch_v, length(u_ch));

y_ch_v = lsim(V2, y_ch.signals.values);
y_ch_n_v = lsim(V2, y_ch_n.signals.values);

y_ch_fft_v = fft(y_ch_v,length(u_ch));
y_ch_n_fft_v = fft(y_ch_n_v,length(u_ch));

G_ch_ampl_v = 20*log10(abs(y_ch_fft_v)./abs(u_ch_fft_v));
G_ch_phase_v = unwrap(angle(y_ch_fft_v) - angle(u_ch_fft_v))*180/pi;
G_ch_n_ampl_v = 20*log10(abs(y_ch_n_fft_v)./abs(u_ch_fft_v));
G_ch_n_phase_v = unwrap(angle(y_ch_n_fft_v) - angle(u_ch_fft_v))*180/pi;

%% kein Rauschen

figure(2)
subplot(2,1,1)
semilogx(w_ch, G_ch_ampl(1:floor(length(u_ch)/2)));
hold on;
semilogx(w_ch, G_ch_ampl_v(1:floor(length(u_ch)/2)));
hold on;
semilogx(Sys_z_w, Sys_z_ampl);
grid on;
title('Amplitudengang ohne Vorfilter, ohne Rauschen');
ylabel('Amplitude [dB]');
xlabel('Frequenz [rad/s]');
legend('ohne VF', 'mit VF','Referenzmodell','Location','northwest');

subplot(2,1,2)
semilogx(w_ch, G_ch_phase(1:floor(length(u_ch)/2)));
hold on;
semilogx(w_ch, G_ch_phase_v(1:floor(length(u_ch)/2)));
hold on;
semilogx(Sys_z_w, Sys_z_phase);
hold off;
grid on;
title('Frequenzgang ohne Vorfilter, ohne Rauschen');
ylabel('Phase [°]');
xlabel('Frequenz [rad/s]');


%% Rauschen

figure(3)
subplot(2,1,1)
semilogx(w_ch, G_ch_n_ampl(1:floor(length(u_ch)/2)));
hold on;
semilogx(w_ch, G_ch_n_ampl_v(1:floor(length(u_ch)/2)));
hold on;
semilogx(Sys_z_w, Sys_z_ampl);
grid on;
title('Amplitudengang mit Rauschen');
ylabel('Amplitude [dB]');
xlabel('Frequenz [rad/s]');
legend('ohne VF', 'mit VF','Referenzmodell','Location','northwest');

subplot(2,1,2)
semilogx(w_ch, G_ch_n_phase(1:floor(length(u_ch)/2)));
hold on;
semilogx(w_ch, G_ch_n_phase_v(1:floor(length(u_ch)/2)));
hold on;
semilogx(Sys_z_w, Sys_z_phase);
hold off;
grid on;
title('Frequenzgang mit Rauschen');
ylabel('Phase [°]');
xlabel('Frequenz [rad/s]');
