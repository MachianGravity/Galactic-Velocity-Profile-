fid = fopen('GamMatch.d','w'); 
for i =1:172
    filename = ['./V_' num2str(i) '.txt'];
    comp1 = load(filename);
    lencomp1 = comp1(end,1);
    for j = i+1:173
        filename = ['./V_' num2str(j) '.txt'];
        comp2 = load(filename);
        lencomp2 = comp2(end,1);
        S = 0;
        if lencomp1 < lencomp2
            yq = interp1(comp2(:,1), comp2(:,2), comp1(:,1));
            for k = 1: length(comp1(:,1))
                S = S + (yq(k) - comp1(k,2))^2;
            end
            S = S/length(comp1(:,1));
        else
            yq = interp1(comp1(:,1), comp1(:,2), comp2(:,1));
            for k = 1: length(comp2(:,1))
                S = S + (yq(k) - comp2(k,2))^2;
            end
            S = S/length(comp2(:,1));
        end
        if ~isnan(S)
            fprintf(fid,'%d %d %d %d %f\n',i,j,length(comp1(:,1)),length(comp2(:,1)),S);
        end
    end

end
fclose(fid);

function [mantissa, exponent] = log10_exp(x)
    exponent = floor(log10(abs(x)));
    mantissa = x / 10^exponent;
end

GamMatch = load('GamMatch.d');
GamMatch = sortrows(GamMatch,5);

GSD = load('GSddump.d');
for i=1:60
    figure;
    GamMatch(i,:)
    filename = ['./V_' num2str(GamMatch(i,1)) '.txt'];
    val = load(filename);
    plot(val(:,1),val(:,2),'Color', [0.87,0.33,0.00],'LineStyle', "--", 'Marker', "o", 'LineWidth', 2, 'MarkerFaceColor', [1,0.9098,0.3922]);
    hold on;
    errorbar(val(:,1),val(:,3),val(:,4),'Color', [0.87,0.33,0.00],'LineStyle', "-", 'Marker', "o", 'LineWidth', 2, 'MarkerFaceColor', [1,0.9098,0.3922]);
    filename = ['./V_' num2str(GamMatch(i,2)) '.txt'];
    val = load(filename);
    plot(val(:,1),val(:,2), 'Color', [0.2863,0.8588,0.2510], 'LineWidth', 2, 'Marker', "square", 'MarkerFaceColor', [1,1,0], 'LineStyle', "--", 'MarkerSize', 8);    
    hold on;
    errorbar(val(:,1),val(:,3),val(:,4), 'Color', [0.2863,0.8588,0.2510], 'LineWidth', 2, 'Marker', "square", 'MarkerFaceColor', [1,1,0], 'LineStyle', "-", 'MarkerSize', 8);

    xlabel("r ( kpc )")
    ylabel("V ( km / s )")

    hAxes = findobj(gcf,"Type","axes");
    hAxes.XGrid = "on";
    hAxes.YGrid = "on";
    hAxes.XMinorGrid = "on";
    hAxes.YMinorGrid = "on";
    hAxes.FontSize = 30;

    galname1 = A(GamMatch(i,1));
    galname2 = A(GamMatch(i,2));

    hABC = plot(nan, nan, 's', 'MarkerFaceColor', [0.87,0.33,0.00], 'MarkerEdgeColor', 'none', 'MarkerSize', 12);
    hold on
    hXYZ = plot(nan, nan, 's', 'MarkerFaceColor', [0.2863,0.8588,0.2510], 'MarkerEdgeColor', 'none', 'MarkerSize', 12);
    

    filename3 = ['./Fig6plot/MOND_a0/' num2str(GamMatch(i,1)) '.txt'];
    ZZZ = load(filename3);
    
    
    if(isempty(ZZZ))
        vbar1=1.2*1e-9;
    else
        [a,b]=min(ZZZ(:,2));
        vbar1=ZZZ(b,1)*1e-9;
    end

    filename3 = ['./Fig6plot/MOND_a0/' num2str(GamMatch(i,2)) '.txt'];
    ZZZ = load(filename3);


    if(isempty(ZZZ))
        vbar2=1.2*1e-9;
    else
        [a,b]=min(ZZZ(:,2));
        vbar2=ZZZ(b,1)*1e-9;
    end


    filename = ['Fig6plot/Two_Param_Mc_M_r/', num2str(GamMatch(i,1)) '.txt'];
    XXX = load(filename);
    if(isempty(XXX))
        acc1=1.2*1e-9;
    else
        [aa,ab] = min(XXX(:,3));
        XXX(ab,2) = XXX(ab,2)*1e6;
        acc1 = XXX(ab,2)./XXX(ab,1)*4.301e-17/(3.086);
    end


    filename = ['Fig6plot/Two_Param_Mc_M_r/', num2str(GamMatch(i,2)) '.txt'];
    XXX = load(filename);
    if(isempty(XXX))
        acc2=1.2*1e-9;
    else
        [aa,ab] = min(XXX(:,3));
        XXX(ab,2) = XXX(ab,2)*1e6;
        acc2 = XXX(ab,2)./XXX(ab,1)*4.301e-17/(3.086);
    end


    [m1,e1] = log10_exp(vbar1);
    [m2,e2] = log10_exp(acc1);
    galname1 = sprintf('%-10s ( a_0^{MOND} = %.2f ×10^{%d}, a_0^{MG} = %.2f ×10^{%d} )', galname1, m1, e1, m2, e2);
    [m1,e1] = log10_exp(vbar2);
    [m2,e2] = log10_exp(acc2);
    galname2 = sprintf('%-10s ( a_0^{MOND} = %.2f ×10^{%d}, a_0^{MG} = %.2f ×10^{%d} )', galname2, m1, e1, m2, e2);

    legend([hABC hXYZ], {galname1,galname2},'Location','southeast');

    filenamepng = ['Fig6plot/baryon_pair/', num2str(i) '.png'];
    filenamefig = ['Fig6plot/baryon_pair/', num2str(i) '.fig'];
    set(gcf, 'PaperSize', [48 28]); 
    filenamepdf = ['Fig6plot/baryon_pair/', num2str(i) '.pdf'];    
    
    saveas(gcf,filenamepng);
    saveas(gcf,filenamepdf);
    saveas(gcf,filenamefig);    
end
