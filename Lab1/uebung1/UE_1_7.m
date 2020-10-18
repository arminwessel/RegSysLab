%% RegSys1 Ex1

%%parametrische Identifikation
%
%
%
%1.7
close all;

%% Matrizen
% Sinnvoller Bereich von Tf
Tf=1

A = [0 1 0; 0 0 1; -0.1e1 / Tf ^ 3 -3 / Tf ^ 2 -3 / Tf;];
B = [0;0;1];
C = [0.1e1 / Tf ^ 3 0 0; 0 0.1e1 / Tf ^ 3 0; 0 0 0.1e1 / Tf ^ 3;];