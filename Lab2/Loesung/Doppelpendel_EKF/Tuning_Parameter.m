%% --- fill in the number of your group ---
warning('Labor Regelungssysteme 1 WS2017, Gruppe XX');

%% --- do not change the variable names below! ---

%% Gewichtung Regler
parLQR.Ta = parDP.Ta;
parKAL.Ta = parDP.Ta;

    % Konstanten für Gewichtungsmatrix Q
    % hohes alpha bewirkt
    % *schnelles Abklingen dieses Zustandes gegen Null
    % *stärkere Sichtbarkeit des Quantisierungsrauschens am Ausgang
    alpha1 = 0.1;   % für phi (1,2)
    alpha2 = 0.1;   % für omega (1,2)
    alpha3 = 0.1;   % für s
    alpha4 = 0.1;   % für sp = w
    alpha5 = 0.1;   % für spp = u
    
    % Konstante für Gewichtungsmatrix R
    % je größer gamma, desto kleiner wird die erforderliche Stellgröße
    gamma = 20; 

if obere_untere_Ruhelage==1 %oberer
    
    %LQR-Gewichtung disk
    parLQR.Q = diag([alpha1 alpha2 alpha1 alpha2 alpha3 alpha4 alpha5]);
    parLQR.R = gamma;
    parLQR.N = zeros(7,1);

else %untere
     
    %LQR-Gewichtung disk
    parLQR.Q = diag([alpha1 alpha2 alpha1 alpha2 alpha3 alpha4 alpha5]);
    parLQR.R = gamma;
    parLQR.N = zeros(7,1);
               
end
%% Gewichtung Beobachter
if obere_untere_Ruhelage==1 %obere
        
    %Kovarianzmatrizen
    parKAL.Qn=1;
    parKAL.Rn=eye(2);

else %untere
         
    %Kovarianzmatrizen
    parKAL.Qn=1;
    %Kovarianzmatrizen
    parKAL.Rn=eye(2);
           
end
%% Anfangsbedingungen und Ruhelagen und Gewichtung
if obere_untere_Ruhelage==1 %oberer
        
    %Kovarianzmatrizen
    parEKF.Qn=eye(6);
    parEKF.Rn=eye(2);
    

else %untere
         
    %Kovarianzmatrizen
    parEKF.Qn=eye(6);
    parEKF.Rn=eye(2);
           
end

%Anfangsbedingung der Schätzfehlerkovarianzmatrix (Diagonalelemente=delta)
parEKF.delta = 1e6;

%Anfangsbedingungen
parEKF.phi10=parDP.phi10;
parEKF.omega10=parDP.omega10;
parEKF.phi20=parDP.phi20;
parEKF.omega20=parDP.omega20;
parEKF.s0=parDP.s0;
parEKF.w0=parDP.w0;
