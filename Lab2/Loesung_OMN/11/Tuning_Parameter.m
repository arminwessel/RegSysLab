%% Gewichtung Regler
parLQR.Ta = parDP.Ta;
parKAL.Ta = parDP.Ta;

% Konstanten f�r Gewichtungsmatrix Q
% hohes alpha bewirkt
% *schnelles Abklingen dieses Zustandes gegen Null
% *st�rkere Sichtbarkeit des Quantisierungsrauschens am Ausgang
alpha1 = 0.1;   % f�r phi (1,2)
alpha2 = 0.1;   % f�r omega (1,2)
alpha3 = 0.1;   % f�r s
alpha4 = 0.1;   % f�r sp = w
alpha5 = 0.1;   % f�r spp = u

% Konstante f�r Gewichtungsmatrix R
% je gr��er gamma, desto kleiner wird die erforderliche Stellgr��e
gamma = 20; 

if obere_untere_Ruhelage==1 %obere
    
    %LQR-Gewichtung disk
    parLQR.QEd = diag([alpha1 alpha2 alpha1 alpha2 alpha3 alpha4 alpha5]);
    parLQR.REd = gamma;
    parLQR.NEd = zeros(7,1);

else %untere
     
    %LQR-Gewichtung disk
    parLQR.QEd = diag([alpha1 alpha2 alpha1 alpha2 alpha3 alpha4 alpha5]);
    parLQR.REd = gamma;
    parLQR.NEd = zeros(7,1);
               
end

% J
% *Die Gewichtungsmatrizen Q,R,N bilden die symmetrische, positiv
% semidefinite Matrix J = [ Q, NT ; N, R ].
% *Mit J kann das Verhalten des geschlossenen Regelkreises gezielt
% beeinflusst werden.
% J = summe(x'Qx + u'Ru + 2u'Nx) + x'Sx

% R
% Je gr��er R, desto kleiner werden die erforderlichen Stellgr��en.

% Q
% hohe Gewichtung eines bestimmten Zustandes in Q bewirkt im geschlossenen
% Kreis ein schnelles Abklingen dieses Zustandes gegen Null.
% Q beeinflusst also die Geschwindigkeit des Reglers

%% Gewichtung Beobachter

Qn = 1;
Rn = 1*eye(2);

if obere_untere_Ruhelage==1 %obere
        
    %Kovarianzmatrizen
    parKAL.Qn = Qn;
    parKAL.Rn = Rn;

else %untere
         
    %Kovarianzmatrizen
    parKAL.Qn = Qn;
    parKAL.Rn = Rn;
    
end

%% Anfangsbedingungen und Ruhelagen und Gewichtung

Q_ekf = 1*eye(6);
R_ekf = 1*eye(2);

if obere_untere_Ruhelage==1 %oberer
        
    %Kovarianzmatrizen
    parEKF.Qn = Q_ekf;
    parEKF.Rn = R_ekf;
    

else %untere
         
    %Kovarianzmatrizen
    parEKF.Qn = Q_ekf;
    parEKF.Rn = R_ekf;
           
end

%Anfangsbedingung der Sch�tzfehlerkovarianzmatrix (Diagonalelemente=delta)
parEKF.delta = 1e6;

%Anfangsbedingungen
parEKF.phi10=parDP.phi10;
parEKF.omega10=parDP.omega10;
parEKF.phi20=parDP.phi20;
parEKF.omega20=parDP.omega20;
parEKF.s0=parDP.s0;
parEKF.w0=parDP.w0;
