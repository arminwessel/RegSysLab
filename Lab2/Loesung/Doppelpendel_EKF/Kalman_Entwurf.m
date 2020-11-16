function [ parKAL ] = Kalman_Entwurf( sysk, sysd, parKAL )


%Ausgangsmatrix
sysk.C = [0,0,0,0,1,0;1,0,0,0,0,0]; % -> x_mess = [s,phi1]'

parKAL.H=zeros(2,1);
parKAL.G=zeros(6,1);

[~, parKAL.KK,~] = kalmd(sysk,parKAL.Qn,parKAL.Rn,parKAL.Ta);

% H = 0 weil kein Prozessrauschen auf die Messgrößen wirkt
% G = 0 weil das Prozessrauschen nicht gekoppelt mit dem Prozess ist

%Diskreten Systemmatrizen
parKAL.Asysd = sysd.A;
parKAL.bsysd = sysd.B;

end

