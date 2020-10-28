%% --- fill in the number of your group ---
warning('Labor Regelungssysteme 1 WS2017, Gruppe XX');

%% --- do not change the variable names below! ---

%% Gewichtung Regler
parLQR.Ta = parDP.Ta;
parKAL.Ta = parDP.Ta;
if obere_untere_Ruhelage==1 %oberer
    
    %LQR-Gewichtung disk
    parLQR.Q=
    parLQR.R=
    parLQR.N=

else %untere
     
    %LQR-Gewichtung disk
    parLQR.Q=
    parLQR.R=
    parLQR.N=
               
end
%% Gewichtung Beobachter
if obere_untere_Ruhelage==1 %obere
        
    %Kovarianzmatrizen
    parKAL.Qn=
    parKAL.Rn=

else %untere
         
    %Kovarianzmatrizen
    parKAL.Qn=
    %Kovarianzmatrizen
    parKAL.Rn=;
           
end
%% Anfangsbedingungen und Ruhelagen und Gewichtung
if obere_untere_Ruhelage==1 %oberer
        
    %Kovarianzmatrizen
    parEKF.Qn=
    parEKF.Rn=
    

else %untere
         
    %Kovarianzmatrizen
    parEKF.Qn=
    parEKF.Rn=
           
end

%Anfangsbedingung der Schätzfehlerkovarianzmatrix (Diagonalelemente=delta)
parEKF.delta = 

%Anfangsbedingungen
parEKF.phi10=parDP.phi10;
parEKF.omega10=parDP.omega10;
parEKF.phi20=parDP.phi20;
parEKF.omega20=parDP.omega20;
parEKF.s0=parDP.s0;
parEKF.w0=parDP.w0;
