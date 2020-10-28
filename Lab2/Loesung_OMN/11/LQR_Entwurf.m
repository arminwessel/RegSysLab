function [ parLQR ] = LQR_Entwurf( sysd,parLQR )
% Zugriff auf die Matrizen des Zustandsmodells (2.13)
[Phi,Gamma,cT,~] = ssdata(sysd); % ~ f�r unused

% Matrizen f�r das erweiterte Pendelmodell (2.16)
Phi_I = [ Phi,zeros(size(Phi,1),1) ; -cT,1 ];
Gamma_I = [ Gamma ; 0 ];
Gamma_rI = [ zeros(size(Phi,1),1) ; 1 ];

%% 2.3.2 Berechnung des R�ckf�hrvektors kT

% Gewichtungsmatrizen Q(7x7), R(1x1), N(7x1) in "Parameter.m" definiert
[kT,~,~] = dlqr(Phi_I, Gamma_I, parLQR.QEd, parLQR.REd, parLQR.NEd);

% minius vor kT, wegen Vorzeichenkonvention des Matlabbefehls dlqr():
% laut Matlab-Hilfe "state-feedback law u[n] = -Kx[n]"
parLQR.kx = -kT(1:6); %p eigentlich kxT
parLQR.kI = -kT(7);

end

