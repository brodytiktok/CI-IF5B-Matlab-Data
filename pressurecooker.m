clear all;

% membuat newfis dengan nama file "pressurecooker"
a=newfis('pressurecooker')

a=addvar(a, 'input', 'water' ,[0 2000]);
a=addmf(a, 'input', 1, 'sedikit', 'trapmf',[0 0 400 1000]);
%a=addmf(a, 'input', 1 , 'medium','trimf',[1000]);
%a=addmf(a, 'input', 1 , 'cukup banyak','trimf',[1350]);
%a=addmf(a, 'input', 1 , 'banyak','trimf',[1650]);
%a=addmf(a, 'input', 1 , 'terlalu banyak','trapmf',[2000]);

figure;plotmf(a,'input', 1);






