%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameterfile Doppelpendel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Abtastzeit
parDP.Ta  = 1e-3;
%Parameter
parDP.l1=0.419; %L‰nge inneres Pendel [m]
parDP.l2=0.484; %L‰nge ‰uﬂeres Pendel [m]
parDP.m1=0.9363; %Masse inneres Pendel [kg]
parDP.m2=0.5505; %Masse ‰uﬂeres Pendel [kg]
parDP.a1=0.2687; %Abstand Aufh‰ngung zu Schwerpunkt inneres Pendel [m]
parDP.a2=0.2256; %Abstand Aufh‰ngung zu Schwerpunkt ‰uﬂeres Pendel [m]
parDP.J1=0.0243; %Tr‰gheitsmoment inneres Pendel [Nms^2]
parDP.J2=0.0183; %Tr‰gheitsmoment ‰uﬂeres Pendel [Nms^2]
parDP.d1=0.0042; %D‰mpfungskonstante inneres Pendel [Nms]
parDP.d2=0.0003; %D‰mpfungskonstante ‰uﬂeres Pendel [Nms]
parDP.m=0.2;   %Masse Wagen [m]
parDP.g=9.81;   %Gravitationskonstante [m/s^2]

parDP.xlinks = -0.7;
parDP.xrechts = 0.7;
%% Inkrementalgeberausflˆsungen
Phiquantisierung = 1/2048*2*pi/4; %[rad/Flanken]
Wegquantisierung = 6.8359e-005; %[m/Flanken]
%% Filter zur Positionsdifferentiation
s = tf([1,0],1);
parFilter.Tv = 0.03;
parFilter.lambdak = -1/parFilter.Tv;
parFilter.lambdad = exp(parDP.Ta*parFilter.lambdak);
F_diff = s/(parFilter.Tv*s+1);
Fd_diff = c2d(F_diff,parDP.Ta);
%% Ruhelagen und Anfangsbedinungen
if obere_untere_Ruhelage==1
    disp('Obere Ruhelage')
    %Anfangsbedingungen
    parDP.phi10=0+parDP.phi10_error;
    parDP.omega10=0;
    parDP.phi20=0;
    parDP.omega20=0;
    parDP.s0=0;
    parDP.w0=0;
    %Ruhelagen
    parDP.phi1R=0;
    parDP.omega1R=0;
    parDP.phi2R=0;
    parDP.omega2R=0;
    parDP.sR=0;
    parDP.wR=0;
    parDP.uR=0;
else 
    %Anfangsbedingungen
    disp('Untere Ruhelage')
    parDP.phi10=pi+parDP.phi10_error;
    parDP.omega10=0;
    parDP.phi20=pi;
    parDP.omega20=0;
    parDP.s0=0;
    parDP.w0=0;
    %Ruhelagen
    parDP.phi1R=pi;
    parDP.omega1R=0;
    parDP.phi2R=pi;
    parDP.omega2R=0;
    parDP.sR=0;
    parDP.wR=0;
    parDP.uR=0;
end

parDP.IC = [parDP.phi10;parDP.omega10;parDP.phi20;parDP.omega20;parDP.s0;parDP.w0];
%% Parameter Vorsteuerung
% Parameter Solltrajektorie
parFF.Ta = parDP.Ta;
parFF.beta7 =
parFF.beta8 = 
parFF.beta9 =
parFF.beta10 = 
parFF.beta11 = 
parFF.beta12 = 
parFF.beta13 = 
%‹bergangszeit
parFF.Te=3;
%Anfangs- und Endwert
parFF.x0=0;
parFF.xT=0.1;







