%% --- fill in the number of your group ---
warning('Labor Regelungssysteme 1 WS2018, Gruppe XX');

%% --- do not change the variable names below! ---

%% Gewichtung Regler
parLQR.Ta = parDP.Ta;
parKAL.Ta = parDP.Ta;
if obere_untere_Ruhelage==1 %obere
    
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
    
    %LQR-Gewichtung disk
    parLQR.Q = diag([alpha1 alpha2 alpha1 alpha2 alpha3 alpha4 alpha5]);
    parLQR.R = gamma;
    parLQR.N = zeros(7,1);
    
else %untere
    
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
    
    %LQR-Gewichtung disk
    parLQR.Q = diag([alpha1 alpha2 alpha1 alpha2 alpha3 alpha4 alpha5]);
    parLQR.R = gamma;
    parLQR.N = zeros(7,1);
end

%% Gewichtung Beobachter
if obere_untere_Ruhelage==1 %obere
        
    %Kovarianzmatrizen
    parKAL.Qn=1;        % Eindimensionale Störung
    parKAL.Rn=1*eye(2); %2 Dimensionaler Ausgang (phi1, s)

else %untere
         
    parKAL.Qn=1;
    parKAL.Rn=1*eye(2);
           
end


