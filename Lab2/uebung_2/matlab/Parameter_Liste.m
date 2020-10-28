%% Parameter

%allgemein
parDP.l1=0.419; %Laenge inneres Pendel
parDP.l2=0.484; %Laenge aeußeres Pendel
parDP.m1=0.9363; %Masse inneres Pendel
parDP.m2=0.5505; %Masse aeußeres Pendel
parDP.a1=0.2687; %Abstand Aufhaengung zu Schwerpunkt inneres Pendel
parDP.a2=0.2256; %Abstand Aufhaengung zu Schwerpunkt aeußeres Pendel
parDP.J1=0.0243; %Traegheitsmoment inneres Pendel
parDP.J2=0.0183; %Traegheitsmoment aeußeres Pendel
parDP.d1=0.0042; %Daempfungskonstante inneres Pendel
parDP.d2=0.0003; %Daempfungskonstante aeußeres Pendel
parDP.m=0.2;     %Masse Wagen [m]
parDP.g=9.81;   %Gravitationskonstante

parDP.sysdim = 0
%% Ruhlagen
    
if untere_ruhelage==0
    % untere Ruhelage
    parDP.phi1R=0;
    parDP.omega1R=0;
    parDP.phi2R=0;
    parDP.omega2R=0;
    parDP.sR=0;
    parDP.wR=0;
    parDP.uR=0;
else
    % obere Ruhelage
    parDP.phi1R=pi;
    parDP.omega1R=0;
    parDP.phi2R=pi;
    parDP.omega2R=0;
    parDP.sR=0;
    parDP.wR=0;
    parDP.uR=0;
end



