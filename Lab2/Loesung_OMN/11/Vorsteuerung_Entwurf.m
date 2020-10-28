function [ parFF ] = Vorsteuerung_Entwurf( sysk, parFF )

[A,b,~,~] = ssdata(sysk);   % Matrizen aus kontinuierlichem System

aa = fliplr(poly(A));       % Koeffizienten des char. Polynoms von A
aa = [aa(1:end-1),1]';      % letzter Wert = 1 und transponieren

Rinv = inv(ctrb(A,b));      % Inverse der Erreichbarkeitsmatrix
v1T = Rinv(end,:);          % letzte Zeile von Rinv
VV = obsv(A, v1T);          % umkehrbar eindeutige Zustandstransformation
VVinv = inv(VV);            % Inverse

% R�ckgabewerte
parFF.aa = aa;
parFF.VV = VV;
parFF.VVinv = VVinv;

end

% Beobachtbarkeitsmatrix    vgl.Aut/S.194
% Steuerbarkeitsnormalform  vgl.Aut/S.208