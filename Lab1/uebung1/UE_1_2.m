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
[u_ch,t_ch] = chripsig(U,ws,we,N,Ta);
figure(1)
stairs(u_ch,t_ch);
%PRBS ohne Überabtastung
Pp=1;
[u_pr1,t_pr1] = PRBS(U,Pp,Ta);
figure(2)
stairs(u_pr1,t_pr1);

%PRBS mit Überabtastung
Pp=4;
[u_pr4,t_pr4] = PRBS2(U,Pp,Ta);
figure(3)
stairs(u_pr4,t_pr4);



% TODO Kommentare ändern
% TODO Kommentare ändern
% TODO Kommentare ändern
% TODO Kommentare ändern
% TODO Kommentare ändern
% TODO Kommentare ändern
% TODO Kommentare ändern



% Vergleich des Amplitudenspektrums
% FFT normiert auf Signallänge
N_chirp = length(u_ch);
N_prbs4 = length(u_pr4);
N_prbs1 = length(u_pr1);

u_ch_fft = fft(u_ch,N_chirp);
u_pr4_fft = fft(u_pr4,N_prbs4);
u_pr1_fft = fft(u_pr1,N_prbs1);

% Amplitude in dB und Phase in ° der Signale
u_ch_ampl = 20*log10(abs(u_ch_fft));
u_ch_phase = unwrap(angle(u_ch_fft))*(180/pi);
u_pr4_ampl = 20*log10(abs(u_pr4_fft));
u_pr4_phase = unwrap(angle(u_pr4_fft))*(180/pi);
u_pr1_ampl = 20*log10(abs(u_pr1_fft));
u_pr1_phase = unwrap(angle(u_pr1_fft))*(180/pi);

% Minimale Frequenz
dw_chirp = 2*pi/(N_chirp*Ta);
dw_prbs4 = 2*pi/(N_prbs4*Ta);
dw_prbs1 = 2*pi/(N_prbs1*Ta);

% Maximale Frequenz
w_max = pi/Ta;

% physikalisch sinnvoller Bereich
w_chirp = 0:dw_chirp:w_max-dw_chirp;
w_prbs4 = 0:dw_prbs4:w_max-dw_prbs4;
w_prbs1 = 0:dw_prbs1:w_max-dw_prbs1;

figure(4)
subplot(2,1,1)
semilogx(w_chirp, u_ch_ampl(1:floor(N_chirp/2)));
hold on;
plot(w_prbs4, u_pr4_ampl(1:floor(N_prbs4/2)));
hold on;
semilogx(w_prbs1, u_pr1_ampl(1:floor(N_prbs1/2)));
grid on;
title('Amplitudengang');
ylabel('Amplitude [dB]');
xlabel('Frequenz [rad/s]');
legend('Chirp-Signal', 'PRBS, Pp = 4', 'PRBS, Pp = 1','Location','southwest');

subplot(2,1,2)
semilogx(w_chirp, u_ch_phase(1:floor(N_chirp/2)));
hold on;
semilogx(w_prbs4, u_pr4_phase(1:floor(N_prbs4/2)));
hold on;
semilogx(w_prbs1, u_pr1_phase(1:floor(N_prbs1/2)));
hold off;
grid on;
title('Frequenzgang');
ylabel('Phase [°]');
xlabel('Frequenz [rad/s]');
