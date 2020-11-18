function [sysk,sysd] = DP_System(parDP)
%
%

%% Parameter aus der Angabe
Ta=parDP.Ta;

l1=parDP.l1;
l2=parDP.l2;
m1=parDP.m1;
m2=parDP.m2;
a1=parDP.a1;
a2=parDP.a2;
J1=parDP.J1;
J2=parDP.J2;
d1=parDP.d1;
d2=parDP.d2;
m=parDP.m;
g=parDP.g;

%% Ruhelage
phi1R = parDP.phi1R;
omega1R = parDP.omega1R;
phi2R = parDP.phi2R;
omega2R = parDP.omega2R;
sR = parDP.sR;
wR = parDP.wR;
uR = parDP.uR;

%% Matrizen aus Maple
%  file "Doppelpendel.mw" unterpunkt Linearisierung
A = [0 1 0 0 0 0; (-0.2e1 * a2 ^ 2 * l1 ^ 2 * m2 ^ 2 * omega1R ^ 2 * cos((2 * phi1R - 2 * phi2R)) + 0.2e1 * m2 * a2 * d2 * l1 * (omega1R - omega2R) * sin((phi1R - phi2R)) - 0.2e1 * m2 * omega2R ^ 2 * a2 * l1 * (a2 ^ 2 * m2 + J2) * cos((phi1R - phi2R)) + a2 ^ 2 * l1 * m2 ^ 2 * uR * sin((phi1R - 2 * phi2R)) + a2 ^ 2 * g * l1 * m2 ^ 2 * cos((phi1R - 2 * phi2R)) - 0.2e1 * (m2 ^ 2 * a2 ^ 2 * l1 / 0.2e1 + (a1 * a2 ^ 2 * m1 + J2 * l1) * m2 + m1 * J2 * a1) * uR * sin(phi1R) + 0.2e1 * g * (m2 ^ 2 * a2 ^ 2 * l1 / 0.2e1 + (a1 * a2 ^ 2 * m1 + J2 * l1) * m2 + m1 * J2 * a1) * cos(phi1R)) / (-a2 ^ 2 * l1 ^ 2 * m2 ^ 2 * cos((2 * phi1R - 2 * phi2R)) + a2 ^ 2 * l1 ^ 2 * m2 ^ 2 + ((0.2e1 * a1 ^ 2 * m1 + (2 * J1)) * a2 ^ 2 + 0.2e1 * J2 * l1 ^ 2) * m2 + 0.2e1 * J2 * (a1 ^ 2 * m1 + J1)) - 0.2e1 * (-a2 ^ 2 * l1 ^ 2 * m2 ^ 2 * omega1R ^ 2 * sin((2 * phi1R - 2 * phi2R)) - 0.2e1 * m2 * a2 * d2 * l1 * (omega1R - omega2R) * cos((phi1R - phi2R)) - 0.2e1 * m2 * omega2R ^ 2 * a2 * l1 * (a2 ^ 2 * m2 + J2) * sin((phi1R - phi2R)) - a2 ^ 2 * l1 * m2 ^ 2 * uR * cos((phi1R - 2 * phi2R)) + a2 ^ 2 * g * l1 * m2 ^ 2 * sin((phi1R - 2 * phi2R)) + 0.2e1 * (m2 ^ 2 * a2 ^ 2 * l1 / 0.2e1 + (a1 * a2 ^ 2 * m1 + J2 * l1) * m2 + m1 * J2 * a1) * uR * cos(phi1R) + 0.2e1 * g * (m2 ^ 2 * a2 ^ 2 * l1 / 0.2e1 + (a1 * a2 ^ 2 * m1 + J2 * l1) * m2 + m1 * J2 * a1) * sin(phi1R) - 0.2e1 * (omega1R * (d1 + d2) - d2 * omega2R) * (a2 ^ 2 * m2 + J2)) / (-a2 ^ 2 * l1 ^ 2 * m2 ^ 2 * cos((2 * phi1R - 2 * phi2R)) + a2 ^ 2 * l1 ^ 2 * m2 ^ 2 + ((0.2e1 * a1 ^ 2 * m1 + (2 * J1)) * a2 ^ 2 + 0.2e1 * J2 * l1 ^ 2) * m2 + 0.2e1 * J2 * (a1 ^ 2 * m1 + J1)) ^ 2 * a2 ^ 2 * l1 ^ 2 * m2 ^ 2 * sin((2 * phi1R - 2 * phi2R)) (-0.2e1 * a2 ^ 2 * l1 ^ 2 * m2 ^ 2 * omega1R * sin((2 * phi1R - 2 * phi2R)) - 0.2e1 * m2 * a2 * d2 * l1 * cos((phi1R - phi2R)) - 0.2e1 * (d1 + d2) * (a2 ^ 2 * m2 + J2)) / (-a2 ^ 2 * l1 ^ 2 * m2 ^ 2 * cos((2 * phi1R - 2 * phi2R)) + a2 ^ 2 * l1 ^ 2 * m2 ^ 2 + ((0.2e1 * a1 ^ 2 * m1 + (2 * J1)) * a2 ^ 2 + 0.2e1 * J2 * l1 ^ 2) * m2 + 0.2e1 * J2 * (a1 ^ 2 * m1 + J1)) (0.2e1 * a2 ^ 2 * l1 ^ 2 * m2 ^ 2 * omega1R ^ 2 * cos((2 * phi1R - 2 * phi2R)) - 0.2e1 * m2 * a2 * d2 * l1 * (omega1R - omega2R) * sin((phi1R - phi2R)) + 0.2e1 * m2 * omega2R ^ 2 * a2 * l1 * (a2 ^ 2 * m2 + J2) * cos((phi1R - phi2R)) - 0.2e1 * a2 ^ 2 * l1 * m2 ^ 2 * uR * sin((phi1R - 2 * phi2R)) - 0.2e1 * a2 ^ 2 * g * l1 * m2 ^ 2 * cos((phi1R - 2 * phi2R))) / (-a2 ^ 2 * l1 ^ 2 * m2 ^ 2 * cos((2 * phi1R - 2 * phi2R)) + a2 ^ 2 * l1 ^ 2 * m2 ^ 2 + ((0.2e1 * a1 ^ 2 * m1 + (2 * J1)) * a2 ^ 2 + 0.2e1 * J2 * l1 ^ 2) * m2 + 0.2e1 * J2 * (a1 ^ 2 * m1 + J1)) + 0.2e1 * (-a2 ^ 2 * l1 ^ 2 * m2 ^ 2 * omega1R ^ 2 * sin((2 * phi1R - 2 * phi2R)) - 0.2e1 * m2 * a2 * d2 * l1 * (omega1R - omega2R) * cos((phi1R - phi2R)) - 0.2e1 * m2 * omega2R ^ 2 * a2 * l1 * (a2 ^ 2 * m2 + J2) * sin((phi1R - phi2R)) - a2 ^ 2 * l1 * m2 ^ 2 * uR * cos((phi1R - 2 * phi2R)) + a2 ^ 2 * g * l1 * m2 ^ 2 * sin((phi1R - 2 * phi2R)) + 0.2e1 * (m2 ^ 2 * a2 ^ 2 * l1 / 0.2e1 + (a1 * a2 ^ 2 * m1 + J2 * l1) * m2 + m1 * J2 * a1) * uR * cos(phi1R) + 0.2e1 * g * (m2 ^ 2 * a2 ^ 2 * l1 / 0.2e1 + (a1 * a2 ^ 2 * m1 + J2 * l1) * m2 + m1 * J2 * a1) * sin(phi1R) - 0.2e1 * (omega1R * (d1 + d2) - d2 * omega2R) * (a2 ^ 2 * m2 + J2)) / (-a2 ^ 2 * l1 ^ 2 * m2 ^ 2 * cos((2 * phi1R - 2 * phi2R)) + a2 ^ 2 * l1 ^ 2 * m2 ^ 2 + ((0.2e1 * a1 ^ 2 * m1 + (2 * J1)) * a2 ^ 2 + 0.2e1 * J2 * l1 ^ 2) * m2 + 0.2e1 * J2 * (a1 ^ 2 * m1 + J1)) ^ 2 * a2 ^ 2 * l1 ^ 2 * m2 ^ 2 * sin((2 * phi1R - 2 * phi2R)) (0.2e1 * m2 * a2 * d2 * l1 * cos((phi1R - phi2R)) - 0.4e1 * m2 * omega2R * a2 * l1 * (a2 ^ 2 * m2 + J2) * sin((phi1R - phi2R)) + 0.2e1 * d2 * (a2 ^ 2 * m2 + J2)) / (-a2 ^ 2 * l1 ^ 2 * m2 ^ 2 * cos((2 * phi1R - 2 * phi2R)) + a2 ^ 2 * l1 ^ 2 * m2 ^ 2 + ((0.2e1 * a1 ^ 2 * m1 + (2 * J1)) * a2 ^ 2 + 0.2e1 * J2 * l1 ^ 2) * m2 + 0.2e1 * J2 * (a1 ^ 2 * m1 + J1)) 0 0; 0 0 0 1 0 0; (0.2e1 * m2 * uR * a2 * l1 * (a1 * m1 + l1 * m2) * sin((-phi2R + 2 * phi1R)) - 0.2e1 * g * m2 * a2 * l1 * (a1 * m1 + l1 * m2) * cos((-phi2R + 2 * phi1R)) + 0.2e1 * a2 ^ 2 * l1 ^ 2 * m2 ^ 2 * omega2R ^ 2 * cos((2 * phi1R - 2 * phi2R)) - 0.2e1 * l1 * (omega1R * (d1 + d2) - d2 * omega2R) * a2 * m2 * sin((phi1R - phi2R)) + 0.2e1 * m2 * omega1R ^ 2 * a2 * l1 * (a1 ^ 2 * m1 + m2 * l1 ^ 2 + J1) * cos((phi1R - phi2R))) / (-a2 ^ 2 * l1 ^ 2 * m2 ^ 2 * cos((2 * phi1R - 2 * phi2R)) + a2 ^ 2 * l1 ^ 2 * m2 ^ 2 + ((0.2e1 * a1 ^ 2 * m1 + (2 * J1)) * a2 ^ 2 + 0.2e1 * J2 * l1 ^ 2) * m2 + 0.2e1 * J2 * (a1 ^ 2 * m1 + J1)) - 0.2e1 * (-m2 * uR * a2 * l1 * (a1 * m1 + l1 * m2) * cos((-phi2R + 2 * phi1R)) - g * m2 * a2 * l1 * (a1 * m1 + l1 * m2) * sin((-phi2R + 2 * phi1R)) + a2 ^ 2 * l1 ^ 2 * m2 ^ 2 * omega2R ^ 2 * sin((2 * phi1R - 2 * phi2R)) + 0.2e1 * l1 * (omega1R * (d1 + d2) - d2 * omega2R) * a2 * m2 * cos((phi1R - phi2R)) + 0.2e1 * m2 * omega1R ^ 2 * a2 * l1 * (a1 ^ 2 * m1 + m2 * l1 ^ 2 + J1) * sin((phi1R - phi2R)) + 0.2e1 * a2 * m2 * uR * (a1 ^ 2 * m1 - m1 * a1 * l1 / 0.2e1 + m2 * l1 ^ 2 / 0.2e1 + J1) * cos(phi2R) + 0.2e1 * g * a2 * m2 * (a1 ^ 2 * m1 - m1 * a1 * l1 / 0.2e1 + m2 * l1 ^ 2 / 0.2e1 + J1) * sin(phi2R) + 0.2e1 * d2 * (omega1R - omega2R) * (a1 ^ 2 * m1 + m2 * l1 ^ 2 + J1)) / (-a2 ^ 2 * l1 ^ 2 * m2 ^ 2 * cos((2 * phi1R - 2 * phi2R)) + a2 ^ 2 * l1 ^ 2 * m2 ^ 2 + ((0.2e1 * a1 ^ 2 * m1 + (2 * J1)) * a2 ^ 2 + 0.2e1 * J2 * l1 ^ 2) * m2 + 0.2e1 * J2 * (a1 ^ 2 * m1 + J1)) ^ 2 * a2 ^ 2 * l1 ^ 2 * m2 ^ 2 * sin((2 * phi1R - 2 * phi2R)) (0.2e1 * l1 * (d1 + d2) * a2 * m2 * cos((phi1R - phi2R)) + 0.4e1 * m2 * omega1R * a2 * l1 * (a1 ^ 2 * m1 + m2 * l1 ^ 2 + J1) * sin((phi1R - phi2R)) + 0.2e1 * d2 * (a1 ^ 2 * m1 + m2 * l1 ^ 2 + J1)) / (-a2 ^ 2 * l1 ^ 2 * m2 ^ 2 * cos((2 * phi1R - 2 * phi2R)) + a2 ^ 2 * l1 ^ 2 * m2 ^ 2 + ((0.2e1 * a1 ^ 2 * m1 + (2 * J1)) * a2 ^ 2 + 0.2e1 * J2 * l1 ^ 2) * m2 + 0.2e1 * J2 * (a1 ^ 2 * m1 + J1)) (-m2 * uR * a2 * l1 * (a1 * m1 + l1 * m2) * sin((-phi2R + 2 * phi1R)) + g * m2 * a2 * l1 * (a1 * m1 + l1 * m2) * cos((-phi2R + 2 * phi1R)) - 0.2e1 * a2 ^ 2 * l1 ^ 2 * m2 ^ 2 * omega2R ^ 2 * cos((2 * phi1R - 2 * phi2R)) + 0.2e1 * l1 * (omega1R * (d1 + d2) - d2 * omega2R) * a2 * m2 * sin((phi1R - phi2R)) - 0.2e1 * m2 * omega1R ^ 2 * a2 * l1 * (a1 ^ 2 * m1 + m2 * l1 ^ 2 + J1) * cos((phi1R - phi2R)) - 0.2e1 * a2 * m2 * uR * (a1 ^ 2 * m1 - m1 * a1 * l1 / 0.2e1 + m2 * l1 ^ 2 / 0.2e1 + J1) * sin(phi2R) + 0.2e1 * g * a2 * m2 * (a1 ^ 2 * m1 - m1 * a1 * l1 / 0.2e1 + m2 * l1 ^ 2 / 0.2e1 + J1) * cos(phi2R)) / (-a2 ^ 2 * l1 ^ 2 * m2 ^ 2 * cos((2 * phi1R - 2 * phi2R)) + a2 ^ 2 * l1 ^ 2 * m2 ^ 2 + ((0.2e1 * a1 ^ 2 * m1 + (2 * J1)) * a2 ^ 2 + 0.2e1 * J2 * l1 ^ 2) * m2 + 0.2e1 * J2 * (a1 ^ 2 * m1 + J1)) + 0.2e1 * (-m2 * uR * a2 * l1 * (a1 * m1 + l1 * m2) * cos((-phi2R + 2 * phi1R)) - g * m2 * a2 * l1 * (a1 * m1 + l1 * m2) * sin((-phi2R + 2 * phi1R)) + a2 ^ 2 * l1 ^ 2 * m2 ^ 2 * omega2R ^ 2 * sin((2 * phi1R - 2 * phi2R)) + 0.2e1 * l1 * (omega1R * (d1 + d2) - d2 * omega2R) * a2 * m2 * cos((phi1R - phi2R)) + 0.2e1 * m2 * omega1R ^ 2 * a2 * l1 * (a1 ^ 2 * m1 + m2 * l1 ^ 2 + J1) * sin((phi1R - phi2R)) + 0.2e1 * a2 * m2 * uR * (a1 ^ 2 * m1 - m1 * a1 * l1 / 0.2e1 + m2 * l1 ^ 2 / 0.2e1 + J1) * cos(phi2R) + 0.2e1 * g * a2 * m2 * (a1 ^ 2 * m1 - m1 * a1 * l1 / 0.2e1 + m2 * l1 ^ 2 / 0.2e1 + J1) * sin(phi2R) + 0.2e1 * d2 * (omega1R - omega2R) * (a1 ^ 2 * m1 + m2 * l1 ^ 2 + J1)) / (-a2 ^ 2 * l1 ^ 2 * m2 ^ 2 * cos((2 * phi1R - 2 * phi2R)) + a2 ^ 2 * l1 ^ 2 * m2 ^ 2 + ((0.2e1 * a1 ^ 2 * m1 + (2 * J1)) * a2 ^ 2 + 0.2e1 * J2 * l1 ^ 2) * m2 + 0.2e1 * J2 * (a1 ^ 2 * m1 + J1)) ^ 2 * a2 ^ 2 * l1 ^ 2 * m2 ^ 2 * sin((2 * phi1R - 2 * phi2R)) (0.2e1 * a2 ^ 2 * l1 ^ 2 * m2 ^ 2 * omega2R * sin((2 * phi1R - 2 * phi2R)) - 0.2e1 * m2 * a2 * d2 * l1 * cos((phi1R - phi2R)) - 0.2e1 * d2 * (a1 ^ 2 * m1 + m2 * l1 ^ 2 + J1)) / (-a2 ^ 2 * l1 ^ 2 * m2 ^ 2 * cos((2 * phi1R - 2 * phi2R)) + a2 ^ 2 * l1 ^ 2 * m2 ^ 2 + ((0.2e1 * a1 ^ 2 * m1 + (2 * J1)) * a2 ^ 2 + 0.2e1 * J2 * l1 ^ 2) * m2 + 0.2e1 * J2 * (a1 ^ 2 * m1 + J1)) 0 0; 0 0 0 0 0 1; 0 0 0 0 0 0;];
B = [0; (-a2 ^ 2 * l1 * m2 ^ 2 * cos((phi1R - 2 * phi2R)) + 0.2e1 * (m2 ^ 2 * a2 ^ 2 * l1 / 0.2e1 + (a1 * a2 ^ 2 * m1 + J2 * l1) * m2 + m1 * J2 * a1) * cos(phi1R)) / (-a2 ^ 2 * l1 ^ 2 * m2 ^ 2 * cos((2 * phi1R - 2 * phi2R)) + a2 ^ 2 * l1 ^ 2 * m2 ^ 2 + ((0.2e1 * a1 ^ 2 * m1 + (2 * J1)) * a2 ^ 2 + 0.2e1 * J2 * l1 ^ 2) * m2 + 0.2e1 * J2 * (a1 ^ 2 * m1 + J1)); 0; (-m2 * a2 * l1 * (a1 * m1 + l1 * m2) * cos((-phi2R + 2 * phi1R)) + 0.2e1 * a2 * m2 * (a1 ^ 2 * m1 - m1 * a1 * l1 / 0.2e1 + m2 * l1 ^ 2 / 0.2e1 + J1) * cos(phi2R)) / (-a2 ^ 2 * l1 ^ 2 * m2 ^ 2 * cos((2 * phi1R - 2 * phi2R)) + a2 ^ 2 * l1 ^ 2 * m2 ^ 2 + ((0.2e1 * a1 ^ 2 * m1 + (2 * J1)) * a2 ^ 2 + 0.2e1 * J2 * l1 ^ 2) * m2 + 0.2e1 * J2 * (a1 ^ 2 * m1 + J1)); 0; 1;];
C = [0 0 0 0 1 0];
D = [0];
% erzeuge kontinuierliches System aus den Systemmatrizen
sysk = ss(A,B,C,D);
% diskretisiere das System
sysd = c2d(sysk, Ta, 'zoh');

parDP.sysdim = length(A);
end
