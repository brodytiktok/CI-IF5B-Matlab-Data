clear all;

% membuat newfis dengan nama file "pressurecooker"
a=newfis('pressurecooker')

a=addvar(a, 'input', 'water' ,[0 2000]);
a=addmf(a, 'input', 1, 'terlalu sedikit', 'trapmf',[0 0 200 400]);
a=addmf(a, 'input', 1 , 'sedikit','trimf',[400 600 800]);
a=addmf(a, 'input', 1 , 'medium','trimf',[800 1000 1200]);
a=addmf(a, 'input', 1 , 'banyak','trimf',[1200 1400 1600]);
a=addmf(a, 'input', 1 , 'terlalu banyak','trapmf',[800 1800 2000 2000]);

figure;plotmf(a,'input', 1);







