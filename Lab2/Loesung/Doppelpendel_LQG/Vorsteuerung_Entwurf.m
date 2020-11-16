function [parFF] = Vorsteuerung_Entwurf(sysk,parFF)
% Transformieren des linearen Modells auf Regelungsnormalform

[A,B,C,D] = ssdata(sysk);

% Koeffizienten
aa = fliplr(poly(A));       % Koeffizienten des char. Polynoms von A
aa = [aa(1:end-1),1]';      % letzter Wert = 1 und transponieren

% Transformationsmatrix
Rinv = inv(ctrb(A,B));      % Inverse der Erreichbarkeitsmatrix
v1T = Rinv(end,:);          % letzte Zeile von Rinv
VV = obsv(A, v1T);          % umkehrbar eindeutige Zustandstransformation
VVinv = inv(VV);            % Inverse


% Rückgabewerte
parFF.aa = aa;
parFF.VVinv = VVinv;

end

