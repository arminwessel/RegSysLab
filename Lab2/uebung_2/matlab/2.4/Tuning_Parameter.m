%% --- fill in the number of your group ---
warning('Labor Regelungssysteme 1 WS2020, Gruppe 10');

%% --- do not change the variable names below! ---

%% Gewichtung Regler
parLQR.Ta = parDP.Ta;
parKAL.Ta = parDP.Ta;
a1 = 0.1;
a2 = 0.1;
a3 = 0.1;
a4 = 0.1;
a5 = 0.1;
g = 20;

if obere_untere_Ruhelage==1 %obere
    
    %LQR-Gewichtung disk
    parLQR.Q = diag([a1, a2, a1, a2, a3, a4, a5]);
    parLQR.R = g; 
    parLQR.N = 0;

else %untere
     
    %LQR-Gewichtung disk
    parLQR.Q = diag([a1, a2, a1, a2, a3, a4, a5]);
    parLQR.R = g;
    parLQR.N = 0;
               
end

