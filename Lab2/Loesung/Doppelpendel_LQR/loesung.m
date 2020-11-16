%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     Gruppe 10           04.11.2020.                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Aufgabe 2.1 - Modellierung
% in Maple 

%% Aufgabe 2.2 - Linearisierung
% Punkt 1) - in Maple
% Punkt 2)
    % funktion DP_System 
    
    clc
    % untere Ruhelage
    obere_untere_Ruhelage = 0;
    run Parameter;
    [sysk_uR,sysd_uR] = DP_System(parDP);
    sysk_uR
    sysd_uR

    % obere Ruhelage
    obere_untere_Ruhelage = 1;
    run Parameter;
    [sysk_oR,sysd_oR] = DP_System(parDP);

% Punkt 3)
    
    pole_uR=pole(sysk_uR)
    zero_uR=zero(sysk_uR)

    pole_oR=pole(sysk_oR)
    zero_oR=zero(sysk_oR)


    % Minimalphasigkeit
    %MinPhase_uR = minreal(sysk_uR);
    %MinPhase_oR = minreal(sysk_oR);

    % Für beide Ruhelagen tritt eine Pol-Nullstellenkürzung auf -> Minreal
    % entfernt 4 Pole
    % Für die untere Ruhelage befinden sich alle Pole in der linken offenen
    % s-Halbene -> stabil

    % Für die obere Ruhelage befinden sich Pole in der rechten
    % s-Halbene -> instabil

    % Anm: Kürzung von instabilen Polstellen resultiert trotzdem in einem
    % instabilem System

% Punkt 4)
    % Erreichbarkeit (Controllability)

    Sysdim = size(sysd_uR,'order');
    if (Sysdim - rank(ctrb(sysd_uR))==0)
        disp('System um untere Ruhelage ist erreichbar')
    end

    Sysdim = size(sysd_oR,'order');
    if (Sysdim - rank(ctrb(sysd_oR))==0)
        disp('System um obere  Ruhelage ist erreichbar')
    end

    % Die Systeme sind vollständig erreichbar
    % Die Systemordnung ist gleich dem Rang der Erreichbarkeitsmatrix
    
%% Aufgabe 2.3 - Stabilisierung
    % in funktion LQR_Entwurf
    clc
    run LoadParameter % Tuning_Parameter wird mit ausgeführt
    % LQR Entwurf
    parLQR = LQR_Entwurf(sysd,parLQR);
    
%% Aufgabe 2.4 - PI-Zustandsregler
% Punkt 1)
    % in der embededded Matlab function im Simulink Modell
    % Arbeitspunktaufschaltung ist die Ruhelage um die linearisiert wurde
% Punkt 2)
    % TODO Beschreibung welcher Parameter was bewirkt
% Punkt 3)
    % im Block Einstellungen im Step Block einstellen
% Punkt 4)
    % TODO

    
    