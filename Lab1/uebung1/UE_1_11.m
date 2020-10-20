%% RegSys1 Ex1

%% parametrische Identifikation
%
%
%
% 1.11
clear all;
close all;


% Parameter:
p = 1;
q = 40;
mu_q = 0.02;


load("data_sinus.mat");
% Datenvektoren
dk = data.dk;
nk = data.nk;
time = data.time;

rk_est = zeros(length(dk), 1);
sk = zeros(q,1);
mu = 0;
l = 0;
p_j = zeros(q,1);

for k = q:length(dk)

    % erstellt Einträge für den sk Vektor aus der indirekten Messung der
    % Störung
    for i = 1:q
       sk(i) = nk(k-i+1); 
    end


    skT = sk';


    if k == q
       l = skT*sk;
    end

    mu = mu_q / l;


    l = l + mu_q * (skT * sk - l);
    p_j = p_j + mu*sk*(dk(k-p) - skT*p_j);
    rk_est(k-p) = dk(k-p) - skT * p_j;

end

% periodisches Nutzsignal
rk = sin(8e3*pi*time);

figure(1)
plot(time', dk);
title('Signal mit Störung');
grid on;

figure(2)
plot(time', rk_est);
title('Geschätztes periodisches Nutzsignal');
grid on;
hold on;
plot(time,rk);
hold off;


%% 1.10.2

% Je größer die Signalverzögerung p wird, desto schlechter wird das
% Signal durch die Schätzung rk_est dargestellt.

% Höhere Modellordnungen q bringen eine bessere Schätzung des Nutzsignals,
% die Rechenzeit steigt.
% Die Einschwingzeit steigt mit höherer Modellordnung q


%% 1.10.3

% Parameter:
p = 1;
q = 40;
mu_quer = 0.02;


[rk_est, dk, time, sampling_rate_fs] = Noisecancel(p,q,mu_q,'Audio/data_1.mat');
sound(rk_est, data.sampling_rate_fs);
pause(data.time(end));

% p=399;
% q=400;
% [rk_est, dk, time, sampling_rate_fs] = Noisecancel(p,q,mu_q,'Audio/data_1.mat');
% sound(rk_est, data.sampling_rate_fs);
% pause(data.time(end));
% 
% p=10;
% [rk_est, dk, time, sampling_rate_fs] = Noisecancel(p,q,mu_q,'Audio/data_1.mat');
% sound(rk_est, data.sampling_rate_fs);

figure(3)
plot(time', dk);
title('Signal mit Störung');
grid on;

figure(4)
plot(time', rk_est);
title('Geschätztes Audiosignal');
grid on;


l

%%
%Rauschunterdruekung wird schlechter wenn der Parameter p in die Nähe der
%Modellordnung q kommt
%Die Modellordnung q führt bei einer Erhöhung zu einem längeren
%Einschwingen bis das Rauschen unterdrückt wird. 

%%
function [rk_est, dk, time, sampling_rate_fs]=Noisecancel(p,q,mu_q,filename)
    
    load(filename);
    % Datenvektoren
    dk = data.dk;
    nk = data.nk;
    time = data.time;
    sampling_rate_fs=data.sampling_rate_fs;
    
    rk_est = zeros(length(dk), 1);
    sk = zeros(q,1);
    mu = 0;
    l = 0;
    p_j = zeros(q,1);

    for k = q:length(dk)

        % erstellt Einträge für den sk Vektor aus der indirekten Messung der
        % Störung
        for i = 1:q
           sk(i) = nk(k-i+1); 
        end


        skT = sk';


        if k == q
           l = skT*sk;
        end

        mu = mu_q / l;


        l = l + mu_q * (skT * sk - l);
        p_j = p_j + mu*sk*(dk(k-p) - skT*p_j);
        rk_est(k-p) = dk(k-p) - skT * p_j;

    end
end

