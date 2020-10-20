%%RegSys1 Ex1

%%Nicht-parametrische Identifikation
%%
%1.2
%1.2.1
close all;

%Parameter laut Angabe
N=4096;
ws=2*pi;
we=20*pi;

U=10;

Ta=0.025;

%Chrip-Signal
[u_ch,t_ch] = chirpsig(U,ws,we,N,Ta);
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
[u_pr4,t_pr4] = PRBS(U,Pp,Ta);
figure(3)
stairs(t_pr4,u_pr4);
grid on;
title('PRBS Pp=4 Zeitverlauf');
ylabel('Amplitude U [V]');
xlabel('Zeit t [ms]');
axis padded;

% Amplitudenspektren der Signale
% FFT 
u_ch_fft = fft(u_ch,length(u_ch));
u_pr4_fft = fft(u_pr4,length(u_pr4));
u_pr1_fft = fft(u_pr1,length(u_pr1));

% Amplitude in dB und Phase in ° umwandeln
u_ch_ampl = 20*log10(abs(u_ch_fft));
u_ch_phase = unwrap(angle(u_ch_fft))*(180/pi);
u_pr4_ampl = 20*log10(abs(u_pr4_fft));
u_pr4_phase = unwrap(angle(u_pr4_fft))*(180/pi);
u_pr1_ampl = 20*log10(abs(u_pr1_fft));
u_pr1_phase = unwrap(angle(u_pr1_fft))*(180/pi);

% delta omega berechnen
dw_ch = 2*pi/(length(u_ch)*Ta);
dw_pr4 = 2*pi/(length(u_pr4)*Ta);
dw_pr1 = 2*pi/(length(u_pr1)*Ta);

% omega max
w_max = pi/Ta;

% omega range
w_ch = 0:dw_ch:w_max-dw_ch;
w_pr4 = 0:dw_pr4:w_max-dw_pr4;
w_pr1 = 0:dw_pr1:w_max-dw_pr1;


% BODE plot der einelnen Signale
% Amplitudengang
figure(4)
subplot(2,1,1)
semilogx(w_ch, u_ch_ampl(1:floor(length(u_ch)/2)));
hold on;
semilogx(w_pr1, u_pr1_ampl(1:floor(length(u_pr1)/2)));
hold on;
semilogx(w_pr4, u_pr4_ampl(1:floor(length(u_pr4)/2)));
grid on;
title('Amplitudengang');
ylabel('Amplitude [dB]');
xlabel('Frequenz [rad/s]');

legend('Chirp-Signal', 'PRBS, Pp = 1', 'PRBS, Pp = 4','Location','southwest');

% Phasengang
subplot(2,1,2)
semilogx(w_ch, u_ch_phase(1:floor(length(u_ch)/2)));
hold on;
semilogx(w_pr1, u_pr1_phase(1:floor(length(u_pr1)/2)));
hold on;
semilogx(w_pr4, u_pr4_phase(1:floor(length(u_pr4)/2)));
hold off;
grid on;
title('Phasengang');
ylabel('Phi [°]');
xlabel('Frequenz [rad/s]');
