i = 19

filename0 = ['./Fig6plot/NFW/bestfit.txt'];
WWW = load(filename0);
for i=1: 173
    galname = A(i);
i
filename = ['./Fig6plot/Two_Param_Mc_M_r/' num2str(i) '.txt'];
filename2 = ['./V_' num2str(i) '.txt'];
filename3 = ['./Fig6plot/MOND_a0/' num2str(i) '.txt'];

XXX = load(filename);
ZZZ = load(filename3);

nn = length(load(filename2));

if (isempty(XXX) || isempty(ZZZ))
    YYY(i,1)=999999; YYY(i,2)=999999; YYY(i,3)=999999;YYY(i,4)=1;
    continue;
end


[a,b]=min(XXX(:,3));
lambda = 1./sqrt(XXX(b,1));
YYY(i,1)  = 4+2*a;

%MOND
[a,b]=min(ZZZ(:,2));
YYY(i,2) = 2+2*a;

%NFW
YYY(i,3) = 4+2*WWW(i,4);

YYY(i,4) = nn;
end

YYY = YYY(YYY(:,1) <= 999998, :);
YYY(:,5) = YYY(:,2)-YYY(:,1);
YYY(:,6) = YYY(:,3)-YYY(:,1);

YYY(:,7) = YYY(:,5);%./YYY(:,4);
YYY(:,8) = YYY(:,6);%./YYY(:,4);

YYY = sortrows(YYY, -8);
alp = 10;
b = bar(alp*tanh((YYY(:,7))/alp));
b.FaceColor = 'flat';

b.CData = alp*tanh(YYY(:,8)/alp); 
colormap("nebula");
colorbar;

% ------------ Formatting ---------------
set(gca, 'FontSize', 20, ...         % axis numbers
         'LineWidth', 1.5, ...
         'FontName', 'Times');       % optional

xlabel('Galaxy Index', 'FontSize', 22);
ylabel('Scaled AIC', 'FontSize', 22);


hold on;
yline( 2, 'LineStyle',':', 'LineWidth', 3,'Color',':');   % +2 threshold
yline(-2, 'LineStyle',':', 'LineWidth', 3,'Color',':');   % -2 threshold


aic = YYY(:,8);

idx_pos = find(aic >  2);
idx_neg = find(aic < -2);
if ~isempty(idx_pos)
    %xline(idx_pos(1),  '--r', 'LineWidth', 1.5);              % first >2
    xline(idx_pos(end), 'LineStyle',':','LineWidth', 3,'Color',':');             % last >2
end

if ~isempty(idx_neg)
    xline(idx_neg(1),  'LineStyle',':', 'LineWidth', 3,'Color',':');              % first < -2
    %xline(idx_neg(end), '--b', 'LineWidth', 1.5);             % last < -2
end