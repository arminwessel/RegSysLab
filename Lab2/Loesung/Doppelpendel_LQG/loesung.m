%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     Gruppe 10           04.11.2020.                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
run LoadParameter
%% Aufgabe 2.5 - Flachheit
    % in Maple

%% Aufgabe 2.6 - Vorsteuerungsentwurf
    % in Vorsteuerung_Entwurf
%% Aufagbe 2.7 - Trajektorienplanung
% Punkt 1)
    % Randbedingungen für die Solltrajektorie in den Zuständen x:
    % Zur Anfangszeit t=0: Ruhelage mit Schlittenposition s=s0
        % x0 = [0,0,0,0,s0,0]
    % Zur Endzeit t=T: Ruhelage mit Schlittenposition s=sT
        % xT = [0,0,0,0,sT,0]
    % Zustandstrensformation:
        % Durch die Transformationen
            % z0 = VV*x0 
            % zT = VV*xT;
        % erhält man die Anfangswerte der z Zustände
        % Nach Gl. 2.23a (3) und Gl. 2.23b (3) folgen die Parameter für
        % das Polynom in Gl. 2.24 als der erste Eintrag der Vektoren
            % z0 = z0(1);
            % zT = zT(1);
% Punkt 2)
    % Berechnung der Koeffizienten beta in Maple
    % Numerische Werte werden in Parameter.m in den Struct parFF
    % gespeichert
% Punkt 3)
    % in function Vorsteuerung_Plotten
    % Anfangs und Endbedingung:
        % Durch die Transformationen
        % z0 = VV*x0 
        % zT = VV*xT;
% Punkt 4)
    % in Simulink
    % Arbeitspunkt ist die Ruhelage
% Punkt 5)
    % in Simulink

%% Aufgabe 2.8 - Stabilisierung des Fehlersystems
% Punkt 1)
    % Fehlersystem: Abweichung zwischen zur Solltrajektorie berechnetem
    % Zustand und dem wahren Zustand
    
    %Dynamikmatrix:
    disp('Dynamikmatrix Phi_I:')
    disp(parLQR.Phi_I)
% Punkt 2)
    % in embedded Matlab function
% Punkt 3)
    % LQR_Entwurf(sysd,parLQR) wird in LoadParameter ausgeführt

%% Aufgabe 2.9 - Beobachterentwurf für obere Ruhelage
    % stationärer Kalman-Filter
% Punkt 1)
    % Matrix C: mit y=Cx, sodass nur s und phi1 messbar sind
    % x = [phi1, omega1, phi2, omega2, s, w]'
    % Matrix C
    %    1     0     0     0     0     0
    %    0     0     0     0     1     0
% Punkt 2)
    % in Kalman_Entwurf
    % H und G sind Null, da kein Rauschen auf die Messgrößen wirkt
    % Kovarianzmatrizen Q und R werden in Tuning_Parameter festgelegt
% Punkt 3)
    % in embedded Matlab function
% Punkt 4)
    % TODO Werte experimentell
% Punkt 5)
    % Beobachter Rückführung ein/aus (1-0)
    % in LoadParameter einstellen
% Punkt 6)
    % Quantisierung ein/aus (1-0)
    % in LoadParameter einstellen
%% Aufgabe 2.10 - Beobachterentwurf für untere Ruhelage
    %
    
    