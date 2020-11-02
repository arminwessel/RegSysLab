%% untere Ruhelage
obere_untere_Ruhelage = 0;
run Parameter;
[sysk_uR,sysd_uR] = DP_System(parDP);
sysk_uR
sysd_uR

%% obere Ruhelage
obere_untere_Ruhelage = 1;
run Parameter;
[sysk_oR,sysd_oR] = DP_System(parDP);


%%

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

%% Erreichbarkeit (Controllability)

Sysdim = size(sysd_uR,'order');
if (Sysdim - rank(ctrb(sysd_uR))==0)
    disp('sysd_uR erreichbar')
end

Sysdim = size(sysd_oR,'order');
if (Sysdim - rank(ctrb(sysd_oR))==0)
    disp('sysd_oR erreichbar')
end

% alle Systeme sind vollständig Ereichbar!
% -> Systemordnung entspricht dem Rang der Erreichbarkeitsmatrix! 