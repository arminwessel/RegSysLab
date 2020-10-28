%% Gewichtung Regler
parLQR.Ta = parDP.Ta;
parKAL.Ta = parDP.Ta;
if obere_untere_Ruhelage==1 %obere
    
    %LQR-Gewichtung disk
    %parLQR.QEd=...
    %parLQR.REd=...
    %parLQR.NEd=...

else %untere
     
    %LQR-Gewichtung disk
    %parLQR.QEd=...
    %parLQR.REd=...
    %parLQR.NEd=...
               
end

%% Gewichtung Beobachter
if obere_untere_Ruhelage==1 %obere
        
    %Kovarianzmatrizen
    %parKAL.Qn=...
    %parKAL.Rn=...

else %untere
         
    %Kovarianzmatrizen
    %parKAL.Qn=...
    %parKAL.Rn=...
           
end


