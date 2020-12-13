% Massen in kg:
p.m_Mast  =   0.661604830351762;
p.m_Arm   =   2.388517859057000;
p.m_AH    =   1.014597734609539;
p.m_RR    =   0.105913353249518;
p.m_RL    =   0.105913353249518;

% Abstände a_ij zwischen Koordinatensystem i und j, angegeben im
% Koordinatensystem i, sowie in m:
p.a01x    =     0;
p.a01y    =     0;
p.a01z    =     0;
p.a12x    =     0;
p.a12y    =     0;
p.a12z    =     0.401200000000000;
p.a23x    =     0.643300000000000;
p.a23y    =     0.085300000000000;
p.a23z    =     0;
p.a34x    =     0.177700000000000;
p.a34y    =     0;
p.a34z    =     0;
p.a35x    =     0.177700000000000;
p.a35y    =     0;
p.a35z    =     0;

% Massenträgheitstensoren in kgm²:
p.I_Mast  =   1.0e-003 *[0 0 0;0 0 0;0 0 0.506651629854281];
p.I_Arm   =   [0.001690300134652  -0.015435150902738  -0.004397154191646;  -0.015435150902738   0.230498614338468  -0.000413920522536;  -0.004397154191646  -0.000413920522536   0.231719591075445];
p.I_AH    =   [0.002309948654049                   0                   0;                   0   0.031684992287930                   0;             0                   0   0.031641273347001];
p.I_RR    =   1.0e-004 *[   0.446768408911236                   0                   0; 0   0.446768408911236                   0;   0                   0   0.235434798459118];
p.I_RL    =   1.0e-004 *[   0.446768408911236                   0                   0; 0   0.446768408911236                   0;   0                   0   0.235434798459118];

% Schwerpunktsabstände bezüglich des eigenen körperfesten
% Koordinatensystems in m: 
p.x_Mast  =     0;
p.y_Mast  =     0;
p.z_Mast  =     0.259285898858014;
p.x_Arm   =     0.313710798301621;
p.y_Arm   =    -0.005539747863152;
p.z_Arm   =     0.014050637835742;
p.x_AH    =     0;
p.y_AH    =     0;
p.z_AH    =     0;
p.x_RR    =     0;
p.y_RR    =     0;
p.z_RR    =    -0.006156926004888;
p.x_RL    =     0;
p.y_RL    =     0;
p.z_RL    =    -0.006156926004888;

% Parameter der elektrischen Teilsysteme der beiden Motoren, in
% SI-Einheiten: 
p.R_RR    =    0.830000000000000;
p.R_RL    =    0.830000000000000;
p.L_RR    =    6.300000000000000e-004;
p.L_RL    =    6.300000000000000e-004;
p.kM_RR   =    0.018000000000000;
p.kM_RL   =    0.018000000000000;
p.ku_RR   =    0.018000000000000;
p.ku_RL   =    0.018000000000000;

% Dämpfung der Motoren in SI-Einheiten:
p.da_RR   =    2.754502048170128e-005;
p.da_RL   =    2.825740066902684e-005;
p.dL_RR   =    9.395611783418437e-008;
p.dL_RL   =    9.594888964142192e-008;

% Reibparameter des Mastes, des Armes sowie der Aufhängung in SI-Einheiten:
p.da_Mast =    0.022000000000000;
p.rC_Mast =    0.005000000000000;
p.rH_Mast =    0.015000000000000;
p.v0_Mast =    10;
p.da_Arm  =    0.040000000000000;
p.rC_Arm  =    0;
p.rH_Arm  =    0;
p.v0_Arm  =    0.100000000000000;
p.da_AH   =    0.008000000000000;
p.rC_AH   =    1.000000000000000e-004;
p.rH_AH   =    0.002000000000000;
p.v0_AH   =    0.100000000000000;

% Gravitationskonstante in m/s²:
p.g       =    9.810000000000000;

% Winkelgeschwindigkeit-Kraft-Konstanten der Rotoren in SI-Einheiten:
p.kF_RL_up=     2.221122155051159e-006;
p.kF_RR_up=     2.221122155051159e-006;
p.kF_RL_down = -7.063360270844337e-007;
p.kF_RR_down = -7.063360270844337e-007;

parameters = p;

% Ruhelage des Armes in rad: 
q20     =  0.319187912478128;

% Zuweisung der Anfangsbedingungen:
initCond = [0,0,q20,0,0,0,0,0,0,0,0,0]';

