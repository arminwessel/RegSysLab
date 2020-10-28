function [parLQR] = LQR_Entwurf(sysd,parLQR)


% extract Diskrete Systemmatrizen
[Phi,Gamma,cT,~] = ssdata(sysd);

% Erweiterung um Integrator
Phi_I = [ Phi,zeros(size(Phi,1),1) ; -cT,1 ];
Gamma_I = [ Gamma ; 0 ];
Gamma_rI = [ zeros(size(Phi,1),1) ; 1 ];

[K,S,e] = dlqr(Phi_I, Gamma_I, parLQR.Q, parLQR.R, parLQR.N);

% u[n]=−Kx[n] laut Matlab help funktion -> deswegen muss ein - eingefügt
% werden!
parLQR.kx = -K(1:6);
parLQR.kI = -K(7);

end

