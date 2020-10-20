function [u,t] = PRBS(U,Pp,Ta)
%Ordning Op = 10
%Uberabtastung Pp>=1

if Pp < 1
    Pp=1
end
    
n=(2^10-1); %2^(Op)-1

% Startwert nach Angabe
p=[0,0,0,0,0,0,0,0,0,1]; 

for i=10+1:n %Op+1
    pk = mod(1*p(i-7)+1*p(i-10),2);
    p=[p, pk]; % Anhängen
end

u = 2* U * p; %Aufskalieren auf Amplitude

% Überabtastung:
u = repelem(u,Pp); % Jedes Element Pp mal wiederholen

% Mittelwert abziehen
U0 = mean(u);
u = u- U0;

% Vektor der Zeitwerte über die Abtastungs skalieren
t = ((0:n*Pp-1).*Ta);
end

