run set_parameter

%% Aufgabe 4.4 - Sollwertfilter
parSys.deltah2 = 0.1;
Stellgroessebesch = 0;
if Stellgroessebesch == 0
    p = -1;
else
    p=-2.2e-2;
end
a = poly([p p p]); 
% Filterkoeffizienten a1 * x^3 + a2 * x^2 + a3 * x + a4

% Darstellung in Zustandsnormalform für den Zustandsfilter 
% vgl. Gleichung 4.18 aus Angabe
A = [0 1 0; 0 0 1; -a(4) -a(3) -a(2)];
b = [0;0;1];
C = a(4)*eye(3);
d = zeros(3,1);
sysk = ss(A,b,C,d);

% dsikretisierung des Systems
[sysd,G]=c2d(sysk,parSys.Ta,'zoh');
% G maps initial conditions to  the discrete time 

parSys.A=sysd.A;
parSys.b=sysd.B;
parSys.C=sysd.C;
parSys.d=sysd.D;

% Anfangsbedingungen im zeit diskreten berechnen
x0 = G*[parSys.h2_0/a(4);0;0;0];
parSys.x0 = x0(1:3);
