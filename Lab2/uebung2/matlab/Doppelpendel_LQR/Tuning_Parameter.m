%% --- fill in the number of your group ---
warning('Labor Regelungssysteme 1 WS2018, Gruppe XX');

%% --- do not change the variable names below! ---

%% Gewichtung Regler
parLQR.Ta = parDP.Ta;
parKAL.Ta = parDP.Ta;
if obere_untere_Ruhelage==1 %obere
    
    %LQR-Gewichtung disk
    parLQR.Q=...
    parLQR.R=...
    parLQR.N=...

else %untere
     
    %LQR-Gewichtung disk
    parLQR.Q=...
    parLQR.R=...
    parLQR.N=...
               
end


