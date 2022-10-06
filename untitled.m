clear all;

% membuat newfis dengan nama file "pressurecooker"
a=newfis('pressurecooker')
a=addvar(a, 'input', 'water' ,[0 2000]);
a=addmf(a, 'input', 1 , 'sedikit','trapmf',[]);
a=addmf(a, 'input', 1 , 'medium','trimf',[]);
a=addmf(a, 'input', 1 , 'cukup banyak','',[]);
a=addmf(a, 'input', 1 , 'banyak','',[]);
a=addmf(a, 'input', 1 , 'terlalu banyak','',[]);








