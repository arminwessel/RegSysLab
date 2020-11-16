%% Uebung Regelungssysteme  
% Skript zur grafischen Darstellung der Simulationsergebnisse
%
% Ersteller:    MK, 09.11.2009
% Aenderungen:  BM, 10.10.2011
%               uknechte  2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
printResults = 1;
saveDir = './';

if printResults
    filename  = 'Roboter_PD_stoerung';
    %titlename = 'PD-Stoerung: Kp1=Kp2=14324, Kp3=20000, Kd1=Kd2=2500, Kd3=2000';
    titlename = 'CT-Stoerung: k01=k02=k03=100, k11=k12=k13=20, Gamma=0.05';
else
    titlename = 'PD-Stoerung: Kp1=Kp2=..., Kp3=..., Kd1=Kd2=..., Kd3=...';     % Ueberschrift des Plots
end

%% Lese Sim-Ergebnisse
t   = simout_rL.time;
rL  = simout_rL.signals.values;
rLs = simout_rLs.signals.values;
q   = simout_q.signals.values;
qs  = simout_qs.signals.values;
e   = q-qs;  

q(:,1:2)  = q(:,1:2)*180/pi;
qs(:,1:2) = qs(:,1:2)*180/pi;
e(:,1:2)  = e(:,1:2)*180/pi;

%% 3D plot
figure(1);
plot3(rLs(:,1),rLs(:,2),rLs(:,3),'r--');
hold on;
plot3(rL(:,1),rL(:,2),rL(:,3),'b');
grid on;
rotate3d on;

h=legend('Sollposition','Istposition');
set(h,'Fontsize',16)
title('Soll- und Istposition der Lastmasse','Fontsize',20)
xlabel('x','Fontsize',20);
ylabel('y','Fontsize',20);
zlabel('z','Fontsize',20);
set(gca,'Fontsize',16)
set(findobj('Type','line'),'Linewidth',2)

LSs = 'r--';
LS  = 'b';
%% 2D plot 
figure(2); clf
ax(1)=subplot(6,3,[1,4]);
plot(t,rL(:,1),LS,t,rLs(:,1),LSs); ylabel('xL_{soll}, xL in m'); legend('ist','soll'); set(gca,'XTickLabel',''); grid on;

ax(2)=subplot(6,3,[7,10]);
plot(t,rL(:,2),LS,t,rLs(:,2),LSs); ylabel('yL_{soll}, yL in m'); set(gca,'XTickLabel',''); grid on;

ax(3)=subplot(6,3,[13, 16]);
plot(t,rL(:,3),LS,t,rLs(:,3),LSs); ylabel('zL_{soll}, zL in m'); xlabel('t in s'); grid on;

ax(4)=subplot(6,3,[2,5]);
plot(t,q(:,1),LS,t,qs(:,1),LSs); ylabel('phi1_{soll}, phi1 in grad'); title(titlename,'fontsize',16); set(gca,'XTickLabel',''); grid on;

ax(5)=subplot(6,3,[8,11]);
plot(t,q(:,2),LS,t,qs(:,2),LSs); ylabel('phi2_{soll}, phi2 in grad'); set(gca,'XTickLabel',''); grid on;

ax(6)=subplot(6,3,[14,17]);
plot(t,q(:,3),LS,t,qs(:,3),LSs); ylabel('s_{soll}, s in m'); xlabel('t in s'); grid on;

ax(7)=subplot(6,3,[3,6]);
plot(t,e(:,1),LS); ylabel('phi1-phi1_{soll} in grad'); set(gca,'XTickLabel',''); grid on;

ax(8)=subplot(6,3,[9,12]);
plot(t,e(:,2),LS); ylabel('phi2-phi2_{soll} in grad'); set(gca,'XTickLabel',''); grid on;

ax(9)=subplot(6,3,[15,18]);
plot(t,e(:,3),LS); ylabel('s-s_{soll} in m'); xlabel('t in s'); grid on;

linkaxes(ax,'x');

%%
if printResults   
    set(findobj('Type','line'),'linewidth',2);


    set(gcf,'Units','centimeters','Position',[3.63 2.35 30 20]) % 'position', [left, bottom, width, height]

    set(gcf,'PaperPositionMode','auto')				% Damit beim anschl. print-Befehl die groesse der Grafik beruecksichtigt wird
    saveas(gcf, fullfile(saveDir,filename), 'fig')

    orient landscape                        % portrait = Hochformat, landscape = Querformat
    print(gcf,'-dpng','-r600',fullfile(saveDir,filename));  % erzeugt eine png-Datei, unter windows kann man
                                                            % mit -dmeta eine vektorgrafik im .emf format erzeugen
end