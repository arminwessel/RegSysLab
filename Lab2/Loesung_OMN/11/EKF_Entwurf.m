%% Anfangsbedingungen und Ruhelagen und Gewichtung

Q_ekf = 10*eye(6);    %0.01
R_ekf = 0.1*eye(2);     %100

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