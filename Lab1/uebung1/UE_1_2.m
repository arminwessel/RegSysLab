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

%Chrip-Signal
[u_ch,t_ch] = chripsig(U,ws,we,N,Ta);
figure(1)
stairs(t_ch,u_ch);
grid on;
title('Chirp Zeitverlauf');
ylabel('Amplitude U [V]');
xlabel('Zeit t [ms]');
axis padded;

%PRBS ohne Überabtastung
Pp=1;
[u_pr1,t_pr1] = PRBS(U,Pp,Ta);
figure(2)
stairs(t_pr1,u_pr1);
grid on;
title('PRBS Pp=1 Zeitverlauf');
ylabel('Amplitude U [V]');
xlabel('Zeit t [ms]');
axis padded;

%PRBS mit Überabtastung
Pp=4;
[u_pr4,t_pr4] = PRBS2(U,Pp,Ta);
figure(3)
stairs(t_pr4,u_pr4);
grid on;
title('PRBS Pp=4 Zeitverlauf');
ylabel('Amplitude U [V]');
xlabel('Zeit t [ms]');
axis padded;

% Amplitudenspektren
% FFT
u_ch_fft = fft(u_ch,length(u_ch));
u_pr4_fft = fft(u_pr4,length(u_pr4));
u_pr1_fft = fft(u_pr1,length(u_pr1));

% Amplitude in dB und Phase in ° der Signale
u_ch_ampl = 20*log10(abs(u_ch_fft));
u_ch_phase = unwrap(angle(u_ch_fft))*(180/pi);
u_pr4_ampl = 20*log10(abs(u_pr4_fft));
u_pr4_phase = unwrap(angle(u_pr4_fft))*(180/pi);
u_pr1_ampl = 20*log10(abs(u_pr1_fft));
u_pr1_phase = unwrap(angle(u_pr1_fft))*(180/pi);

% delta omega
dw_chirp = 2*pi/(N_chirp*Ta);
dw_prbs4 = 2*pi/(N_prbs4*Ta);
dw_prbs1 = 2*pi/(N_prbs1*Ta);

% omega max
w_max = pi/Ta;

% omega range
w_chirp = 0:dw_chirp:w_max-dw_chirp;
w_prbs4 = 0:dw_prbs4:w_max-dw_prbs4;
w_prbs1 = 0:dw_prbs1:w_max-dw_prbs1;


% BODE plot
figure(4)
subplot(2,1,1)
semilogx(w_chirp, u_ch_ampl(1:floor(N_chirp/2)));
hold on;
semilogx(w_prbs1, u_pr1_ampl(1:floor(N_prbs1/2)));
hold on;
semilogx(w_prbs4, u_pr4_ampl(1:floor(N_prbs4/2)));
grid on;
title('Amplitudengang');
ylabel('Amplitude [dB]');
xlabel('Frequenz [rad/s]');

legend('Chirp-Signal', 'PRBS, Pp = 1', 'PRBS, Pp = 4','Location','southwest');

subplot(2,1,2)
semilogx(w_chirp, u_ch_phase(1:floor(N_chirp/2)));
hold on;
semilogx(w_prbs1, u_pr1_phase(1:floor(N_prbs1/2)));
hold on;
semilogx(w_prbs4, u_pr4_phase(1:floor(N_prbs4/2)));
hold off;
grid on;
title('Phasengang');
ylabel('Phi [°]');
xlabel('Frequenz [rad/s]');
