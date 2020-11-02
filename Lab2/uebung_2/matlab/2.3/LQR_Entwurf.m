function [parLQR] = LQR_Entwurf(sysd,parLQR)


% Systemmatrizen des Abtastsystems
[Phi,Gamma,cT,~] = ssdata(sysd);

% PI_Zustandsregler nach Aut Skript ohne den Störterm
Phi_I = [ Phi,zeros(size(Phi,1),1) ; -cT,1 ];
Gamma_I = [ Gamma ; 0 ];
Gamma_rI = [ zeros(size(Phi,1),1) ; 1 ];

[K,~,~] = dlqr(Phi_I, Gamma_I, parLQR.Q, parLQR.R, parLQR.N);
% K ist der Vektor der optimalen Zustandsrückführung
% Die Rückgabewerte S (Lösung der Ricatti Gl) und die Eigenwerte CLP werden
% verworfen

% Matlab gibt den negativen Wert der Parameter k zurück (wie bei acker),
% deshalb negatives VZ
parLQR.kx = -K(1:6); % für ursprüngliche Zustände
parLQR.kI = -K(7); % für Integralteil

end

