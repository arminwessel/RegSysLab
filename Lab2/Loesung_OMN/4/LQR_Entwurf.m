function [ parLQR ] = LQR_Entwurf( sysd,parLQR )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Labor Regelungssysteme 1, WS 16/17
%
% Funktion LQR_Entwurf
% Eingänge: 
%     parLQR      Parameterstruktur
%     sysd        LTI Objekt diskrete Zustandsdarstellung
% Ausgang:
%     parLQR      Parameterstruktur, erweitert um optimale
%                 Zustandsrückführung
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 2.3.1 Erweiterung des Pendelmodells um einen Integrator

% Zugriff auf die Matrizen des Zustandsmodells (2.13)
[Phi,Gamma,cT,~] = ssdata(sysd); % ~ für unused

% Matrizen für das erweiterte Pendelmodell (2.16)
Phi_I = [ Phi,zeros(size(Phi,1),1) ; -cT,1 ];
Gamma_I = [ Gamma ; 0 ];
Gamma_rI = [ zeros(size(Phi,1),1) ; 1 ];

%% 2.3.2 Berechnung des Rückführvektors kT

% Gewichtungsmatrizen Q(7x7), R(1x1), N(7x1) in "Parameter.m" definiert
[kT,~,~] = dlqr(Phi_I, Gamma_I, parLQR.QEd, parLQR.REd, parLQR.NEd);

% minius vor kT, wegen Vorzeichenkonvention des Matlabbefehls dlqr():
% laut Matlab-Hilfe "state-feedback law u[n] = -Kx[n]"
parLQR.kx = -kT(1:6); %p eigentlich kxT
parLQR.kI = -kT(7);

end

