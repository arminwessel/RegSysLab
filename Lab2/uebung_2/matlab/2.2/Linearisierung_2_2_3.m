
% Ruhelage auswählen:
% untere_ruhelage = 1 -> untere Ruhelage
% untere_ruhelage = 0 -> obere Ruhelage
untere_ruhelage = 1;
Parameter_Liste;
[sysk_uR,sysd_uR] = DP_System(parDP);

% obere Ruhelage
untere_ruhelage = 0;
Parameter_Liste;
[sysk_oR,sysd_oR] = DP_System(parDP);


pole_uR=pole(sysk_uR)
zero_uR=zero(sysk_uR)

pole_oR=pole(sysk_oR)
zero_oR=zero(sysk_oR)
%Interpretation der Null- und Polstellen fehlt noch


%% Erreichbarkeit (Controllability)

Sysdim = size(sysk_uR,'order');
Sysdim - rank(ctrb(sysk_uR))
Sysdim = size(sysd_uR,'order');
Sysdim - rank(ctrb(sysd_uR))

Sysdim = size(sysk_oR,'order');
Sysdim - rank(ctrb(sysk_oR))
Sysdim = size(sysd_oR,'order');
Sysdim - rank(ctrb(sysd_oR))

% alle Systeme sind vollständig Ereichbar!
% -> Systemordnung entspricht dem Rang der Erreichbarkeitsmatrix! 