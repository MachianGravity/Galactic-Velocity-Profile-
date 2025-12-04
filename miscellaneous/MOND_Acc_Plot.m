clear all;
XXX = load('GSddump.d');
for i=1: 173
    i
    filename3 = ['./Fig6plot/MOND_a0/' num2str(i) '.txt'];
    ZZZ = load(filename3);

    if (isempty(ZZZ))
        YYY(i,1)=999999; YYY(i,2)=999999; YYY(i,3)=999999;YYY(i,4)=1;
        continue;
    end

    %MOND
    [a,b]=min(ZZZ(:,2));
    vbar(i,1)=ZZZ(b,1)*1e-9;
    vbar(i,2)=XXX(i,11);
    
end




% 0000000000000000000000000000000000000000000000000000000000000000000000 %

YYY = XXX;
XXX=[];

for i = 1:173

    filename = ['Fig6plot/Two_Param_Mc_M_r/', num2str(i) '.txt'];
    XXX = load(filename);
    if(isempty(XXX))
        continue;
    end

    i
    [aa,ab] = min(XXX(:,3));


    XXX(ab,2) = XXX(ab,2)*1e6;
    acc(i,1) = XXX(ab,2)./XXX(ab,1)*4.301e-17/(3.086);
    acc(i,2)=XXX(ab,2);
    acc(i,3)=XXX(ab,1);

end

% 0000000000000000000000000000000000000000000000000000000000000000000000 %

subplot(2,1,1);
vbar = [vbar, acc];
vbar = sortrows(vbar, -1);
b = bar(vbar(:,1));

b.FaceColor = 'flat';
b.CData = min(max((log10(vbar(:,3))), -9), -6);
colormap("autumn");
cb = colorbar;

xlabel("Galaxy Number", 'Interpreter','latex','FontSize',18);
ylabel("$$a_0^{MOND} \;\;\mathrm{(cm/s^2)}$$", 'Interpreter','latex','FontSize',20);
ylabel(cb, '$$a_0^{MG} \;\;\mathrm{(cm/s^2)}$$', 'Interpreter','latex','FontSize',20);
set(gca, 'YScale', 'log');
set(gca,'FontSize',18);

grid on;

subplot(2,1,2);

vbar = [vbar, acc];
vbar = sortrows(vbar, -3);
bb = bar(vbar(:,3));

bb.FaceColor = 'flat';
bb.CData = min(max((log10(vbar(:,1))), -10), -7);
colormap("autumn");
cb = colorbar;

xlabel("Galaxy Number", 'Interpreter','latex','FontSize',18);
ylabel("$$a_0^{MG} \;\;\mathrm{(cm/s^2)}$$", 'Interpreter','latex','FontSize',20);
ylabel(cb, '$$a_0^{MOND} \;\;\mathrm{(cm/s^2)}$$', 'Interpreter','latex','FontSize',20);
set(gca, 'YScale', 'log');
set(gca,'FontSize',18);

grid on;
