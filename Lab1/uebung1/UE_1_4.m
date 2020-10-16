%%RegSys1 Ex1

%% Parametrische Identifikation
%
%   IMPORTANT: REQUIRES "UE_1_1.m" to be executed beforehand
%
% 1.4 Numerische Diskretisierung

z = tf('z');
syms s z 
%% Euler Verfahren
% approximation mit s = (z-1)/Ta)
Sys_eul = subs(1/(m*s^2 + d*s + c),s,(z-1)/Ta)
% extract numerator and denominator
[Sys_eul_numerator, Sys_eul_denominator] = numden(Sys_eul)
% generate polynom form
Sys_eul = tf(sym2poly(Sys_eul_numerator), sym2poly(Sys_eul_denominator), Ta)

%% Trapezregel
% approximation mit s = 2/Ta*(z-1)/(z+1)
Sys_trap =  subs(1/(m*s^2 + d*s + c),s,2/Ta*(z-1)/(z+1));
% extract numerator and denominator
[Sys_trap_numerator, Sys_trap_denominator] = numden(Sys_trap)
% generate polynom form
Sys_trap = tf(sym2poly(Sys_trap_numerator), sym2poly(Sys_trap_denominator), Ta)

%% Plot

figure(1)
subplot(1,3,1);
bode(Sys_z)
hold on;
bode(Sys_eul);
bode(Sys_trap);
hold off;
title('Bode-Diagramm kontinuierliches System');
grid on;
legend('G(z) original', 'G(z) Euler','G(z) Trapezregel','Location','northeast');

% Pole und Nullstellen
subplot(1,3,2);
pzplot(Sys_z);
hold on;
pzplot(Sys_eul);
pzplot(Sys_trap);
hold off;
title('Pol-Nullstellen-Diagramm');
grid on;
  
% Sprungantworten
zeitdauer = 2;

subplot(1,3,3);
step(Sys_z,zeitdauer);
hold on;
step(Sys_eul,zeitdauer);
step(Sys_trap,zeitdauer);
hold off;


