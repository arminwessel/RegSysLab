clc ;
clear all;
close;

%% Param
beta = 1;
gamma = 0.1;
delta = 0.01;
i_R = (1-gamma/beta)/(1+gamma/delta);
r_R = i_R*gamma/delta;
i_0 = 1e-3;
r_0 = 0;

% Par structure
parSys.beta=beta;
parSys.gamma = gamma;
parSys.delta=delta;
parSys.i_0=i_0;
parSys.r_0=r_0;

% Regler
parSys.k1 = 10;

%% Plot
% 3.3.1 

[X,Y] = meshgrid(0:0.03:1,0:0.03:1);

if (0)
    figure(1)
    U = beta*X.*(1-X-Y)-gamma*X;
    V = gamma*X-delta.*Y;
    U = U ./ sqrt(U.^2+V.^2);
    V = V ./ sqrt(U.^2+V.^2);
    quiver(X,Y,U,V,0.5);
    title('normalisiertes Vektorfeld für u=0');
    ylabel('dr (resistent)');
    xlabel('di (infected)');
    hold on;
    scatter(i_R,r_R,'fill');
    text(i_R+0.01,r_R+0.01,'x_R2','color','r');
    scatter(0,0,'fill');
    text(0.01,0.01,'x_R1','color','r');
end;



