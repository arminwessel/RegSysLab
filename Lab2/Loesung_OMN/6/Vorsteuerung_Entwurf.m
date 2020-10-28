function [ parFF ] = Vorsteuerung_Entwurf( sysk, parFF )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Labor Regelungssysteme 1, WS 16/17
%
% Aufgabe 2.6: Vorsteuerungsentwurf
% Funktion Vorsteuerung_Entwurf
%
% kontinuierliches, lineares Modell des Doppelpendels wird auf
% Regelungsnormalform transformiert  und der Koeffizientenvektor a wird
% berechnet
%
% Eingabe-Parameter:
% sysk  ... LTI-Objekt der kontinuierlichen Zustandsdarstellung
% parFF ... Parameterstruktur
%
% Ausgabe-Parameter:
% parFF ... Parameterstruktur mit
%           parFF.aa    ... Koeffizientenvektor
%           parFF.VVinv ... inverse Transformationsmatrix
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[A,b,~,~] = ssdata(sysk);   % Matrizen aus kontinuierlichem System

aa = fliplr(poly(A));       % Koeffizienten des char. Polynoms von A
aa = [aa(1:end-1),1]';      % letzter Wert = 1 und transponieren

Rinv = inv(ctrb(A,b));      % Inverse der Erreichbarkeitsmatrix
v1T = Rinv(end,:);          % letzte Zeile von Rinv
VV = obsv(A, v1T);          % umkehrbar eindeutige Zustandstransformation
VVinv = inv(VV);            % Inverse

% Rückgabewerte
parFF.aa = aa;
parFF.VV = VV;
parFF.VVinv = VVinv;

end

% Beobachtbarkeitsmatrix    vgl.Aut/S.194
% Steuerbarkeitsnormalform  vgl.Aut/S.208