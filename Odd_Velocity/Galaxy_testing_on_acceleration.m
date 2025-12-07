%clear all;
XXX = load('GSddump.d');

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
    acc(i,4)=i;
end

%   0000000000000000000000000000000000000000000000000000000000000000000   %

acc = sortrows(acc, -1);

for i=1:173
    
    if i>20 && i<150
        continue;
    end
    i
    filename = ['./V_' num2str(acc(i,4)) '.txt'];
    val = load(filename);

    figure;
    plot(val(:,1),val(:,2),'LineWidth',3,'Color','b');
    hold on;
    errorbar(val(:,1),val(:,3),val(:,4),'LineWidth',3,'Color','r');
    set(gca, 'FontSize', 40);   
    ylabel('V (km/s)', 'FontSize', 40);
    xlabel('r (kpc)', 'FontSize', 40);
    grid on

    galname = A(acc(i,4));
       % axis tick font size
    h = text(0.98, 0.02, galname, ...
         'Units', 'normalized', ...
         'HorizontalAlignment', 'right', ...
         'VerticalAlignment', 'bottom', ...
         'FontSize', 45,'EdgeColor','k','BackgroundColor','w');

    % Assuming your figure is the current figure (gcf)
    filename = ['./Fig6plot/VelocityOdds/' num2str(i)];
    
    % Save as MATLAB figure
    saveas(gcf, [filename, '.fig']);
    saveas(gcf, [filename, '.png']);
    % Save as PDF (vector graphics)
    set(gcf, 'PaperSize', [48 28]); 
    saveas(gcf, [filename, '.pdf']);
end
