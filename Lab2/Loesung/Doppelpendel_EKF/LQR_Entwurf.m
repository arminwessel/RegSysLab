function [ parLQR ] = LQR_Entwurf( sysd,parLQR )
%LQR Entwurf

%Um einen Integrator ereweiterte Modell
parLQR.Phi_I = [ sysd.A,zeros(size(sysd.A,1),1) ; -sysd.C,1 ];
parLQR.Gamma_I = [ sysd.B ; 0 ];
parLQR.Gamma_rI = [ zeros(size(sysd.A,1),1) ; 1 ];

%Rückführvektor
[kT,~,~] = dlqr(parLQR.Phi_I, parLQR.Gamma_I, parLQR.Q, parLQR.R, parLQR.N);

%Vorzeichen konvention von matlab korrigieren
parLQR.kx = -kT(1:6);
parLQR.kI = -kT(7);

end