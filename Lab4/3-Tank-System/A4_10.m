run set_parameter
% Aufgabe 4.4 Sollwertfilter
%parSys.deltah2 = 0.1;
% Pollage
% Zuflussbegrenzung = 0;

mitStabilisierung = 1;



if Zuflussbegrenzung == 1
    p1 = -0.014
    p2 = -0.014
    pR = -0.4;
else
    p1 = -0.014
    p2 = -0.014
    pR = -0.4;
    
end


%Filterkoeffizienten
ay1 = poly([p1 p1 p1]); 
% Filter
AFiltery1 = [0,1,0; 0,0,1; -ay1(4), -ay1(3), -ay1(2)];
BFiltery1 = [0; 0; 1];
CFiltery1 = ay1(4)*eye(3);
DFiltery1 = zeros(3,1);

SwFiltery1Kont = ss(AFiltery1,BFiltery1,CFiltery1,DFiltery1);
SwFiltery1Dis = c2d(SwFiltery1Kont, parSys.Ta);

parSys.Ay1Filter = SwFiltery1Dis.A;
parSys.By1Filter = SwFiltery1Dis.B;
parSys.Cy1Filter = SwFiltery1Dis.C;
parSys.Dy1Filter = SwFiltery1Dis.D;
parSys.Swy1FilterInit = [(parSys.h2_0/ay1(4)),0, 0];

%Filterkoeffizienten
ay2 = poly([p2 p2]); 
% Filter
AFiltery2 = [0,1; -ay2(3), -ay2(2)];
BFiltery2 = [0; 1];
CFiltery2 = ay2(3)*eye(2);
DFiltery2 = zeros(2,1);

SwFiltery2Kont = ss(AFiltery2,BFiltery2,CFiltery2,DFiltery2);
SwFiltery2Dis = c2d(SwFiltery2Kont, parSys.Ta);
parSys.Ay2Filter = SwFiltery2Dis.A;
parSys.By2Filter = SwFiltery2Dis.B;
parSys.Cy2Filter = SwFiltery2Dis.C;
parSys.Dy2Filter = SwFiltery2Dis.D;
parSys.Swy2FilterInit = [(parSys.h1_0 - parSys.h3_0)/ay2(3), 0];


if 0
pole(SwFiltery1Kont)
bode(SwFiltery1Kont)
pole(SwFiltery2Kont)
bode(SwFiltery2Kont)
end



%% Regelparameter

if mitStabilisierung ==1 
    a2Reglery2 = poly([pR]);
    parInit.y2a0 = a2Reglery2(2);
    a2Reglery1 = poly([pR, pR]);
    parInit.y1a0 = a2Reglery1(3);
    parInit.y1a1 = a2Reglery1(2);
    
    %integral Teil für Aufgabe 4.10 noch nicht dabei --> Null setzen
    parInit.y1aI = 0;
    parInit.y2aI = 0;
else
    parInit.y1a0=0;
    parInit.y1a1=0;
    parInit.y2a0=0;
    parInit.y1aI=0;
    parInit.y2aI=0;
end



