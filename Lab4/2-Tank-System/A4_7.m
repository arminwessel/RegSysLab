%% Aufgabe 4.7 Trajektorienplanung
%
%  Berechnung der Änderungsraten
run A4_5

% gemessene Zeit für erste Änderungsrate
t1 = 344;      % in Sekunden
delta1 = 0.2;  % in Meter
%maximale mittler0e Änderungsrate berechnen
rate1 = delta1/t1;
parSys.rate_max = rate1;

% gemessene Zeit für zweite Änderungsrate
t2 = 167;     % in Sekunden
delta2 = -0.2;  % in Meter
%minimale mittlere Änderungsrate berechnen
rate2 = delta2/t2;
parSys.rate_min = rate2;