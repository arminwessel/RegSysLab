function [ ] = Vorsteuerung_Plotten( parFF )

% Schlittenversatz
s0 = 0;
sT = 0.5;
Te = 3; % Übergangszeit 3s

x0 = zeros(6,1);
x0(5) = s0;
xT = zeros(6,1);
xT(5) = sT;

VV=inv(parFF.VVinv)
z0 = VV*x0;
zT = VV*xT;

z0 = z0(1);
zT = zT(1);

% Berechnete Koeffizienten der Solltrajektorie aus Maple:

t = 0:0.01:Te;

beta7 = parFF.beta7/Te^7;
beta8 = parFF.beta8/Te^8;
beta9 = parFF.beta9/Te^9;
beta10 = parFF.beta10/Te^10;
beta11 = parFF.beta11/Te^11;
beta12 = parFF.beta12/Te^12;
beta13 = parFF.beta13/Te^13;

zT_z0 = zT - z0;

Delta_zd = z0 + zT_z0 * (beta7 * t.^ 7 + beta8 * t.^ 8 + beta9 * t.^ 9 + beta10 * t.^ 10 + beta11 * t.^ 11 + beta12 * t.^ 12 + beta13 * t.^ 13);
Delta_zd1 =  zT_z0 * (7 * beta7 * t.^ 6 + 8 * beta8 * t.^ 7 + 9 * beta9 * t.^ 8 + 10 * beta10 * t.^ 9 + 11 * beta11 * t.^ 10 + 12 * beta12 * t.^ 11 + 13 * beta13 * t.^ 12);
Delta_zd2 = zT_z0 * (42 * beta7 * t.^ 5 + 56 * beta8 * t.^ 6 + 72 * beta9 * t.^ 7 + 90 * beta10 * t.^ 8 + 110 * beta11 * t.^ 9 + 132 * beta12 * t.^ 10 + 156 * beta13 * t.^ 11);
Delta_zd3 = zT_z0 * (210 * beta7 * t.^ 4 + 336 * beta8 * t.^ 5 + 504 * beta9 * t.^ 6 + 720 * beta10 * t.^ 7 + 990 * beta11 * t.^ 8 + 1320 * beta12 * t.^ 9 + 1716 * beta13 * t.^ 10);
Delta_zd4 = zT_z0 * (840 * beta7 * t.^ 3 + 1680 * beta8 * t.^ 4 + 3024 * beta9 * t.^ 5 + 5040 * beta10 * t.^ 6 + 7920 * beta11 * t.^ 7 + 11880 * beta12 * t.^ 8 + 17160 * beta13 * t.^ 9);
Delta_zd5 = zT_z0 * (2520 * beta7 * t.^ 2 + 6720 * beta8 * t.^ 3 + 15120 * beta9 * t.^ 4 + 30240 * beta10 * t.^ 5 + 55440 * beta11 * t.^ 6 + 95040 * beta12 * t.^ 7 + 154440 * beta13 * t.^ 8);
Delta_zd6 = zT_z0 * (5040 * beta7 * t + 20160 * beta8 * t.^ 2 + 60480 * beta9 * t.^ 3 + 151200 * beta10 * t.^ 4 + 332640 * beta11 * t.^ 5 + 665280 * beta12 * t.^ 6 + 1235520 * beta13 * t.^ 7);

uFF = parFF.aa'*[Delta_zd; Delta_zd1; Delta_zd2; Delta_zd3; Delta_zd4; ...
    Delta_zd5; Delta_zd6];


%% Solltrajektorie und deren zeitliche Ableitungen plotten

figure(1)
subtitle('Solltrajektorien');
subplot(4,2,1);
plot(t, Delta_zd);
grid on;
title({'$ \Delta $z$^d $'}, 'Interpreter', 'Latex');

subplot(4,2,2);
plot(t, Delta_zd1);
grid on;
title({'$ \frac{d}{dt} \Delta $z$^d $'}, 'Interpreter', 'Latex');

subplot(4,2,3);
plot(t, Delta_zd2);
grid on;
title({'$ \frac{d^2}{dt^2} \Delta $z$^d $'}, 'Interpreter', 'Latex');

subplot(4,2,4);
plot(t, Delta_zd3);
grid on;
title({'$ \frac{d^3}{dt^3} \Delta $z$^d $'}, 'Interpreter', 'Latex');

subplot(4,2,5);
plot(t, Delta_zd4);
grid on;
title({'$ \frac{d^4}{dt^4} \Delta $z$^d $'}, 'Interpreter', 'Latex');

subplot(4,2,6);
plot(t, Delta_zd5);
grid on;
title({'$ \frac{d^5}{dt^5} \Delta $z$^d $'}, 'Interpreter', 'Latex');

subplot(4,2,7);
plot(t, Delta_zd6);
grid on;
title({'$ \frac{d^6}{dt^6} \Delta $z$^d $'}, 'Interpreter', 'Latex');

subplot(4,2,8);
plot(t, uFF);
grid on;
title({'uFF'}, 'Interpreter', 'Latex');


%% Zustandstrajektorien plotten:

xd = parFF.VVinv*[Delta_zd; Delta_zd1; Delta_zd2; Delta_zd3; Delta_zd4; ...
    Delta_zd5];

figure(2)
subtitle('Zustandstrajektorien');
subplot(3,2,1);
plot(t, xd(1,:));
grid on;
title({'$ \varphi_1 $'}, 'Interpreter', 'Latex');

subplot(3,2,2);
plot(t, xd(2,:));
grid on;
title({'$ \omega_1 $'}, 'Interpreter', 'Latex');

subplot(3,2,3);
plot(t, xd(3,:));
grid on;
title({'$ \varphi_2 $'}, 'Interpreter', 'Latex');

subplot(3,2,4);
plot(t, xd(4,:));
grid on;
title({'$ \omega_2 $'}, 'Interpreter', 'Latex');

subplot(3,2,5);
plot(t, xd(5,:));
grid on;
title({'$s$'}, 'Interpreter', 'Latex');

subplot(3,2,6);
plot(t, xd(6,:));
grid on;
title({'$ \dot{s} $'}, 'Interpreter', 'Latex');

end