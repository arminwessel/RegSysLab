run A4_4

%% A4.5 Relger mit Polvorgabe
parSys.deltah12 = 0.1e-3;
mitStabilisierung = 0;

if mitStabilisierung ==0
    % ohne Stabilisierung
    parSys.a0 = 0;
    parSys.a1 = 0;
else   
    % mit Stabilisierung
    p = -0.5e-1;
    a = poly([p p]);
    parSys.a0 = a(3);
    parSys.a1 = a(2);
end

%% Approximation
% Parameterübergabe
A_tank      = parSys.Atank;         % Grundfläche Tank
rho         = parSys.rho;           % Dichte Wasser
eta         = parSys.eta;           % Dynamische Viskosität Wasser
g           = parSys.g;             % Gravitationskonstante
alphaA1     = parSys.alphaA1;       % Kontraktionskoeffizient AV1
DA1         = parSys.DA1;           % Durchmesser AV1
alphaA2     = parSys.alphaA2;       % Kontraktionskoeffizient AV2
AA2         = parSys.A2;            % Querschnittsflaeche AV2
alphaA3     = parSys.alphaA3;       % Kontraktionskoeffizient AV3
DA3         = parSys.DA3;           % Durchmesser AV3
alpha120    = parSys.alpha12_0;     % Kontraktionskoeffizient ZV12
A12         = parSys.A12;           % Querschnittsflaeche ZV12
Dh12        = parSys.Dh12;          % hydraulischer Durchmesser
lambdac12   = parSys.lambdac12;     % kritische Fliesszahl ZV12


% Berechnung  
deltah12 = 0.1; %laut Angabe 
delta_h = -deltah12:0.01:deltah12;
%dq12/dh1
dq12_ddeltah12 = 0.2e1 * alpha120 * Dh12 * rho / eta * g / lambdac12 * (0.1e1 - tanh(0.2e1 * Dh12 * rho / eta * sqrt(0.2e1) * sqrt(g) * sqrt(deltah12) / lambdac12) ^ 2) * A12 + alpha120 * tanh(0.2e1 * Dh12 * rho / eta * sqrt(0.2e1) * sqrt(g) * sqrt(deltah12) / lambdac12) * A12 * sqrt(0.2e1) * sqrt(g) * deltah12 ^ (-0.1e1 / 0.2e1) / 0.2e1;
dq120 = 4 * alpha120 * A12 * Dh12 * rho * g / eta / lambdac12;
k = (dq12_ddeltah12-dq120)/deltah12;
dq12dh1 = k*abs(delta_h)+dq120;
dq12dh2 =-k*abs(delta_h)-dq120;

%% Exakt
delta_h1 = [-0.2:0.01:-0.0001,-0.0001,0.0001:0.01:0.2];
dq12_ddelta_h = 0.2e1 * alpha120 * Dh12 * rho / eta * g / lambdac12 * (0.1e1 - tanh(0.2e1 * Dh12 * rho / eta * sqrt(0.2e1) * sqrt(g) * sqrt(abs(delta_h1)) / lambdac12) .^ 2) * A12 + alpha120 * tanh(0.2e1 * Dh12 * rho / eta * sqrt(0.2e1) * sqrt(g) * sqrt(abs(delta_h1)) / lambdac12) * A12 * sqrt(0.2e1) * sqrt(g) .* abs(delta_h1) .^ (-0.1e1 / 0.2e1) / 0.2e1;

%% Plot
FigH=figure(1)

P1=subplot(2,1,1);
plot(delta_h,dq12dh1); % Verlauf
hold on;
plot(delta_h1,dq12_ddelta_h); % approx. Gerade
title('')
grid minor;

subplot(2,1,2);
plot(delta_h,dq12dh2);
hold on;
plot(delta_h1,-dq12_ddelta_h);
grid minor;

AxesH    = findobj(FigH, 'Type', 'Axes');
% YLabelHC = get(AxesH, 'YLabel');
% YLabelH  = [YLabelHC{1}];
% set(YLabelH, 'String', 'dq12 / dh2')
% YLabelH  = [YLabelHC{2}];
% set(YLabelH, 'String', 'dq12 / dh1')
TitleHC  = get(AxesH, 'Title');
TitleH   = [TitleHC{1}];
set(TitleH, 'String', 'dq12 / dh2');
TitleH   = [TitleHC{2}];
set(TitleH, 'String', 'dq12 / dh1');