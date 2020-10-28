%% Gewichtung Regler
parLQR.Ta = 0.1;

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

    %LQR-Gewichtung disk
    parLQR.Q = diag([alpha1 alpha2 alpha1 alpha2 alpha3 alpha4 alpha5]);
    parLQR.R = gamma;
    parLQR.N = zeros(7,1);

