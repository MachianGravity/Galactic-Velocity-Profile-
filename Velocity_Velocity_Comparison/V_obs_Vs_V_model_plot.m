i = 19

filename0 = ['./Fig6plot/NFW/bestfit.txt'];
WWW = load(filename0);
for i=103: 175
    galname = A(i);
i
filename = ['./Fig6plot/Two_Param_Mc_M_r/' num2str(i) '.txt'];
filename2 = ['./V_' num2str(i) '.txt'];
filename3 = ['./Fig6plot/MOND_a0/' num2str(i) '.txt'];

XXX = load(filename);
YYY = load(filename2);
ZZZ = load(filename3);

if (isempty(XXX))
    print("It is empty")
    continue;
end

% Measured Velocity

[Mea_r, Mea_v, Mea_verr] = deal(YYY(:,1), YYY(:,3), YYY(:,4));


% Machian Gravity
[a,b]=min(XXX(:,3));
lambda = 1./sqrt(XXX(b,1));
a
Kk = XXX(b,2);
Ma = YYY(:,1).*YYY(:,2).^2/ 4.302;
RealV = sqrt( (4.302*Ma./YYY(:,1)).*(1 + (1 - exp(-lambda*YYY(:,1)).*(1 + lambda*YYY(:,1) )).*(sqrt(Kk./Ma) - 1)));


%MOND
[a,b]=min(ZZZ(:,2));
a
anot = ZZZ(b,1);

MONDM =  Ma / 1000;
acc = (4.302*1.e-8/3.086) * MONDM./Mea_r.^2;
anots = anot*1.e-9;
aobs = acc./ (1-exp(-sqrt(acc./anots)));
MONDV = sqrt(aobs.*  Mea_r * 3.086e11 );


%NFW
r_s = WWW(i,3);
rho_s = WWW(i,2);
x = Mea_r / r_s;
G = 4.302e-6;
m_over_r = (4 * pi * rho_s* r_s^3)* (log(1 + x) - x./(1 + x))./ Mea_r;
NFWv2 = sqrt(G * m_over_r);
NFWTotv= sqrt(YYY(:,2).^2 + NFWv2.^2);
fclose all;
figure;
plot(Mea_v,RealV,'color',[0.87,0.33,0.00],'LineWidth',2.0,'Marker','o','MarkerSize',6,'MarkerFaceColor',[0.67,0.27,0.01]);
hold on;
plot(Mea_v,MONDV,'color',[0.29,0.86,0.25],'LineWidth',2.0,'Marker','o','MarkerSize',6,'MarkerFaceColor',[0.23,0.67,0.20]);
plot(Mea_v,NFWTotv,'color',[0.15,0.55,0.87],'LineWidth',2.0,'Marker','o','MarkerSize',6,'MarkerFaceColor',[0.07,0.44,0.75]);



% ---- Diagonal line ----
p = max([Mea_v(:); RealV(:); NFWTotv(:); MONDV(:)]);   % maximum of all arrays
q = min([Mea_v(:); RealV(:); NFWTotv(:); MONDV(:)]);

plot([q p], [q p], '-.','color',[0.65,0.65,0.65], 'LineWidth', 1.0, 'HandleVisibility','off');           % diagonal reference line

h = legend({'Machian Gravity','MOND','NFW Profile'}, ...
       'Location','northwest', ...
       'FontSize', 25);


pos = h.Position;       % [x y width height]

% Shift legend slightly to the right and down
pos(1) = pos(1) + 0.08;   % move right (increase x)
pos(2) = pos(2) - 0.01;   % move down  (decrease y)

h.Position = pos;

% ---- Axis and labels ----
xlabel('Observed Velocity (km/s)', 'FontSize', 30);
ylabel('Model Velocity (km/s)', 'FontSize', 30);

set(gca, 'FontSize', 25);          % axis tick font size
axis equal                        % ensures 1:1 aspect ratio
xlim([q p]);
ylim([q p]);

% Round limits to nearest 10
start_tick = ceil(q/10)*10;   % first tick >= q
end_tick   = floor(p/10)*10;  % last tick <= p

% Set ticks every 10 km/s
xticks(start_tick:10:end_tick);
yticks(start_tick:10:end_tick);

h = text(0.98, 0.02, galname, ...
     'Units', 'normalized', ...
     'HorizontalAlignment', 'right', ...
     'VerticalAlignment', 'bottom', ...
     'FontSize', 25);

pos = h.Position;       % [x y width height]

% Shift legend slightly to the right and down
pos(1) = pos(1) - 0.08;   % move right (increase x)
pos(2) = pos(2) + 0.04;   % move down  (decrease y)

h.Position = pos;

grid on;

% Assuming your figure is the current figure (gcf)
filename = ['./Fig6plot/V_vs_V_Plot/' num2str(i)];

% Save as MATLAB figure
saveas(gcf, [filename, '.fig']);

% Save as PDF (vector graphics)
set(gcf, 'PaperSize', [30 25]); 
saveas(gcf, [filename, '.pdf']);
end
