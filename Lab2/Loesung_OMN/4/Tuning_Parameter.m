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
alpha5 = 0.1;   % f�r int

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



