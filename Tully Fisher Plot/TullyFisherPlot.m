
j = 1;
Arr = [21,38,46,48,53,54,58,60,65,68,69,72,75,76,78,80,81,86,90,91,104,110,111,118,160,165,167];
Tcc=[];
Arrx=[];
G = 4.301e-6

for i = 1:174

    %if(any(Arr == i))
    %    continue;
    %end

    filename = ['../Fig6plot/', num2str(i) '.txt'];
    E = load(filename);
    if(isempty(E))
    %    continue;
        Arrx = [Arrx; i];
        r0=0;
        M0=0;
    else 
        [aa,ab] = min(E(:,3));
        r0 = sqrt(E(ab,1));
        M0 = E(ab,2)*1e6;
    end 


    filename = ['../V_', num2str(i) '.txt'];
    D = load(filename);

    Tc = [D(end,1) (1e-9)*D(end,1).*D(end,2).^2/G  D(end,3)];

    
    Tcc=[Tcc;Tc];

end
%B=A(2:175);
%Tca = [B Tcc];

%delete abc.tex; file = fopen('abc.tex','w');fprintf(file,"%15s &  %4.2f  &  %4.2f  &  %4.2f  &  %4.2f  &  %4.2f  &  %4.2f \\ \n",Tca'); fclose(file);

%G = 4.301e-6

plot(log10(Tcc(:,2)/G),log10(Tcc(:,3)),'.')
