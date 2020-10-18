%%RegSys1 Ex1

%%Nicht-parametrische Identifikation
%
%   IMPORTANT: REQUIRES "UE_1_1.m" and "UE_1_2.m" to be executed beforehand
%
%1.3
% ETFE (empirical transfer function estimate)
close all;

%% Simulationswerte

parSim.T_a=Ta;
parSim.Methode=0;
%Anfangsbedingungen als Zeilenvektor
parSim.xx0=[0,0];
sim_time = Ta*(N-1); 

%% Chirp simulation

parSim.u_in= u_ch;
parSim.t_in= t_ch;

sim('Einmassenschwinger', sim_time);

y_ch_n = sim_mit_rauschen;
y_ch = sim_kein_rauschen;

%%PRBS (Pp=4) simulation

parSim.u_in= u_pr4;
parSim.t_in= t_pr4';


sim('Einmassenschwinger', sim_time);

y_pr4_n = sim_mit_rauschen;
y_pr4 = sim_kein_rauschen;


%% FFT of chirp signal
y_ch_fft = fft(y_ch.signals.values,length(u_ch));
y_ch_n_fft = fft(y_ch_n.signals.values,length(u_ch));

G_ch_ampl = 20*log10(abs(y_ch_fft)./abs(u_ch_fft));
G_ch_phase = unwrap(angle(y_ch_fft) - angle(u_ch_fft))*180/pi;
G_ch_n_ampl = 20*log10(abs(y_ch_n_fft)./abs(u_ch_fft));
G_ch_n_phase = unwrap(angle(y_ch_n_fft) - angle(u_ch_fft))*180/pi;


%% FFT of PRBS signal
y_pr4_fft = fft(y_pr4.signals.values,length(u_pr4));
y_pr4_n_fft = fft(y_pr4_n.signals.values,length(u_pr4));

G_pr4_ampl = 20*log10(abs(y_pr4_fft)./abs(u_pr4_fft));
G_pr4_phase = unwrap(angle(y_pr4_fft) - angle(u_pr4_fft))*180/pi;
G_pr4_n_ampl = 20*log10(abs(y_pr4_n_fft)./abs(u_pr4_fft));
G_pr4_n_phase = unwrap(angle(y_pr4_n_fft) - angle(u_pr4_fft))*180/pi;

%% extract amplitude and phase from System (Sys_z) from point 1.1

[Sys_z_mag,Sys_z_phase, Sys_z_w] = bode(Sys_z,{2*pi/(N*Ta),w_max});
Sys_z_ampl = 20*log10(squeeze(Sys_z_mag(1,1,:)));
Sys_z_phase = squeeze(Sys_z_phase(1,1,:));


%% Plot ohne Rauschen

figure(1)
title('Ohne Rauschen');
subplot(2,1,1)
semilogx(w_ch, G_ch_ampl(1:floor(length(u_ch)/2)));
hold on;
semilogx(w_pr4, G_pr4_ampl(1:floor(length(u_pr4)/2)));
hold on;
semilogx(Sys_z_w, Sys_z_ampl);
grid on;
title('Amplitudengang ohne Rauschen');
ylabel('Amplitude [dB]');
xlabel('Frequenz [rad/s]');
legend('Chirp-Signal', 'PRBS, Pp = 4','Modell','Location','northwest');

subplot(2,1,2)
semilogx(w_ch, G_ch_phase(1:floor(length(u_ch)/2)));
hold on;
semilogx(w_pr4, G_pr4_phase(1:floor(length(u_pr4)/2)));
hold on;
semilogx(Sys_z_w, Sys_z_phase);
hold off;
grid on;
title('Frequenzgang ohne Rauschen');
ylabel('Phase [°]');
xlabel('Frequenz [rad/s]');


%% Plot mit Rauschen

figure(2)
subplot(2,1,1)
semilogx(w_ch, G_ch_n_ampl(1:floor(length(u_ch)/2)));
hold on;
semilogx(w_pr4, G_pr4_n_ampl(1:floor(length(u_pr4)/2)));
hold on;
semilogx(Sys_z_w, Sys_z_ampl);
grid on;
title('Amplitudengang mit Rauschen');
ylabel('Amplitude [dB]');
xlabel('Frequenz [rad/s]');
legend('Chirp-Signal', 'PRBS, Pp = 4','Modell','Location','northwest');

subplot(2,1,2)
semilogx(w_ch, G_ch_n_phase(1:floor(length(u_ch)/2)));
hold on;
semilogx(w_pr4, G_pr4_n_phase(1:floor(length(u_pr4)/2)));
hold on;
semilogx(Sys_z_w, Sys_z_phase);
hold off;
grid on;
title('Frequenzgang mit Rauschen');
ylabel('Phase [°]');
xlabel('Frequenz [rad/s]');


