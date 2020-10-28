function [ parKAL ] = Kalman_Entwurf( sysk, sysd, parKAL )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Labor Regelungssysteme 1, WS 16/17
%
% Funktion Kalman_Entwurf
% Eingänge:
%     sysk        LTI Objekt kontinuierliche Zustandsdarstellung
%     sysd        LTI Objekt diskrete Zustandsdarstellung
%     parLQR      Parameterstruktur
% Ausgang:
%     parKAL      Parameterstruktur
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Ausgangsmatrix
sysk.C = zeros(2,6);
% Schlittenposition
sysk.C(1,5) = 1;
% Innerer Winkel phi1
sysk.C(2,1) = 1;

% Prozessrauschen wirkt nicht auf die Messgrößen => H = 0
% Prozessrauschen nicht gekoppelt mit dem Prozess => G = 0

% Diskreter Kalman-Filter
[~, parKAL.KK,~] = kalmd(sysk,parKAL.Qn,parKAL.Rn,parKAL.Ta);


% Diskreten Systemmatrizen
parKAL.Asysd = sysd.A;
parKAL.bsysd = sysd.B;

end

