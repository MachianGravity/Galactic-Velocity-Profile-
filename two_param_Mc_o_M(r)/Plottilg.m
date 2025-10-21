
i = 19

% 68, 52, 51, 33, 16, 10

for i=151: 174 %174
i
filename = ['./' num2str(i) '.txt'];
filename2 = ['../V_' num2str(i) '.txt'];

%load -ascii 19.txt
%XXX = X19;

XXX = load(filename);
YYY = load(filename2);
%s = XXX(:,3)>25;
%XXX(s,:)=[];

if (isempty(XXX))
    continue;
end
%if (min(XXX(:,3))<5)
%    continue;
%end

%subplot(2,3,1);
%hist(sqrt(XXX(:,1)),20);
%subplot(2,3,2);
%hist(XXX(:,2),20);
%subplot(2,3,3);
%plot(XXX(:,2),XXX(:,1),'.');
%subplot(2,3,4);
%plot(sqrt(XXX(:,1)),XXX(:,3),'.');
%subplot(2,3,5);
%plot(XXX(:,2),XXX(:,3),'.');
%subplot(2,3,6);
%plot(XXX(:,2).*XXX(:,1)*(4.3)/(3.086*10^16),XXX(:,3),'.');


XXX(:,2) = XXX(:,2)*1e6;





set(0,'DefaultFigureWindowStyle','docked')

%figure1 = figure;
figure1 = figure('PaperUnits','inches','PaperSize',[18 11]);

% Create subplot
subplot1 = subplot(2,3,1,'Parent',figure1);

% Create patch
histogram(sqrt(XXX(:,1)),'NumBins',20,'LineWidth',1.5,...
    'FaceColor',[0.301960796117783 0.745098054409027 0.933333337306976],...
    'EdgeColor',[0 0.447058826684952 0.74117648601532]);

% Create xlabel
xlabel('$$\lambda^{-1}$$','Interpreter','latex');

box(subplot1,'on');
% Set the remaining axes properties
set(subplot1,'CLim',[1 2],'FontSize',24,'XGrid','on','XMinorGrid','on','XMinorTick','on',...
    'YGrid','on','YMinorGrid','on','YMinorTick','on');
% Create subplot
subplot2 = subplot(2,3,2,'Parent',figure1);

% Create patch
histogram(XXX(:,2),'NumBins',20,'LineWidth',1.5,...
    'FaceColor',[0.301960796117783 0.745098054409027 0.933333337306976],...
    'EdgeColor',[0 0.447058826684952 0.74117648601532]);

% Create xlabel
xlabel('$$M_c$$','Interpreter','latex');

box(subplot2,'on');
% Set the remaining axes properties
set(subplot2,'CLim',[1 2],'FontSize',24,'XGrid','on','XMinorGrid','on','XMinorTick','on',...
    'YGrid','on','YMinorGrid','on','YMinorTick','on');
% Create subplot
mytitle = [A(i+1), '( R_{max} = ', num2str(YYY(end,1)),  'kpc )'];
mytitle = strcat(A(i+1), ' ( R_{max} = ', num2str(YYY(end,1)),  'kpc )');
title(mytitle)
subplot3 = subplot(2,3,3,'Parent',figure1);
hold(subplot3,'on');

% Create plot
plot(XXX(:,2),XXX(:,1),'MarkerSize',3,'Marker','.','LineStyle','none',...
    'Color',[0 0.447058826684952 0.74117648601532]);

minxxx3 = min(XXX(:,3))
maxxxx3 = min(max(XXX(:,3),minxxx3+10))

% Create ylabel
ylabel('$$\lambda^{-2}$$','Interpreter','latex');

% Create xlabel
xlabel('$$M_c$$','Interpreter','latex');

box(subplot3,'on');
hold(subplot3,'off');
% Set the remaining axes properties
set(subplot3,'FontSize',24,'XGrid','on','XMinorGrid','on','XMinorTick','on',...
    'YGrid','on','YMinorGrid','on','YMinorTick','on');
% Create subplot
subplot4 = subplot(2,3,4,'Parent',figure1);
hold(subplot4,'on');

% Create plot
plot(sqrt(XXX(:,1)),XXX(:,3),'Parent',subplot4,'MarkerSize',3,'Marker','.','LineStyle','none',...
    'Color',[0 0.447058826684952 0.74117648601532]);

ylim([minxxx3 maxxxx3])
% Create ylabel
ylabel('\chi^2');

% Create xlabel
xlabel('\lambda^{-1}');

box(subplot4,'on');
hold(subplot4,'off');
% Set the remaining axes properties
set(subplot4,'FontSize',24,'XGrid','on','XMinorGrid','on','XMinorTick','on',...
    'YGrid','on','YMinorGrid','on','YMinorTick','on');
% Create subplot
subplot5 = subplot(2,3,5,'Parent',figure1);
hold(subplot5,'on');

% Create plot
plot(XXX(:,2),XXX(:,3),'Parent',subplot5,'MarkerSize',3,'Marker','.','LineStyle','none',...
    'Color',[0 0.447058826684952 0.74117648601532]);

ylim([minxxx3 maxxxx3])
% Create ylabel
ylabel('\chi^2');

% Create xlabel
xlabel('$$M_c$$','Interpreter','latex');

box(subplot5,'on');
hold(subplot5,'off');
% Set the remaining axes properties
set(subplot5,'FontSize',24,'XGrid','on','XMinorGrid','on','XMinorTick','on',...
    'YGrid','on','YMinorGrid','on','YMinorTick','on');
% Create subplot
subplot6 = subplot(2,3,6,'Parent',figure1);
hold(subplot6,'on');

% Create plot
plot(XXX(:,2)./XXX(:,1)*(1e5)*4.301e-6/(3.086*10^16),XXX(:,3),'Parent',subplot6,'MarkerSize',3,'Marker','.','LineStyle','none',...
    'Color',[0 0.447058826684952 0.74117648601532]);


ylim([minxxx3 maxxxx3])
% Create ylabel*(1e9)/(3.086e+16)*1e5
ylabel('\chi^2');

% Create xlabel
xlabel('$$\frac{GM_c}{\lambda^{-2}}$$','Interpreter','latex');

box(subplot6,'on');
hold(subplot6,'off');
% Set the remaining axes properties
set(subplot6,'FontSize',24,'XGrid','on','XMinorGrid','on','XMinorTick','on',...
    'YGrid','on','YMinorGrid','on','YMinorTick','on');

end