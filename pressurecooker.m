clear all;

% membuat newfis dengan nama file "pressurecooker"
a=newfis('pressurecooker')

% input 2- Water Level-Fuzzification
a=addvar(a, 'input', 'Water Level (ml)', [0 2000]);
a=addmf(a, 'input', 1, 'terlalu Sedikit', 'trapmf', [0 0 100 400]);
a=addmf(a, 'input', 1, 'sedikit', 'trapmf', [100 400 600 800]);
a=addmf(a, 'input', 1, 'medium', 'trapmf', [600 800 1000 1200]);
a=addmf(a, 'input', 1, 'banyak', 'trapmf', [1000 1200 1400 1600]);
a=addmf(a, 'input', 1, 'terlalu banyak', 'trapmf', [1400 1600 2000 2000]);

figure;plotmf(a,'input', 1);

% input 2- temperature-Fuzzification
a=addvar(a, 'input', 'temperature (degree celsius)', [-40 56]);
a=addmf(a, 'input', 2, 'beku', 'trapmf',[-40 -40 -25 -20]);
a=addmf(a, 'input', 2 , 'dingin','trapmf',[-25 -20 -15 -10]);
a=addmf(a, 'input', 2 , 'sedikit dingin','trapmf',[ -15 -10 -5 0 ]);
a=addmf(a, 'input', 2 , 'normal', 'trapmf' , [-5 0 10 16]);
a=addmf(a, 'input', 2 , 'hangat','trapmf',[ 10 16 26 36]);
a=addmf(a, 'input', 2 , 'panas','trapmf',[ 26 36 46 56]);
figure;plotmf(a,'input', 2);


a=addvar(a, 'input', 'Pressure (kpa)', [-25 30]);
a=addmf(a, 'input', 3, 'terlalu rendah','trapmf',[-25 -25 -20 -10]);
a=addmf(a, 'input', 3, 'rendah','trapmf',[-20 -10 -5 0]);
a=addmf(a, 'input', 3, 'no pressure','trimf',[-5 0 5]);
a=addmf(a, 'input', 3, 'sedikit','trapmf',[0 5 10 15]);
a=addmf(a, 'input', 3, 'tinggi','trapmf',[10 15 20 25]);
a=addmf(a, 'input', 3, 'terlalu tinggi','trapmf',[20 25 30 30]);
figure;plotmf(a,'input', 3);

%output 1-cooking  time
a=addvar(a, 'output','time (minutes)', [0 24]);
a=addmf(a, 'output', 1, 'terlalu cepat', 'trapmf',[0 0 2 4]);
a=addmf(a, 'output', 1 , 'sangat cepat','trapmf',[2 4 6 8]);
a=addmf(a, 'output', 1 , 'cepat','trapmf',[ 6 8 10 12 ]);
a=addmf(a, 'output', 1 , 'medium', 'trapmf' , [10 12 14 16]);
a=addmf(a, 'output', 1 , 'lambat','trapmf',[ 14 16 18 20]);
a=addmf(a, 'output', 1 , 'sangat Lambat','trapmf',[ 18 20 22 24]);
figure;plotmf(a,'output', 1);


rule = [5 2 1 6 1 2; 2 5 3 1 1 2; 2 2 4 5 1 2; 3 5 5 2 1 2; 5 1 1 6 1 2; 1 6 6 1 1 2; 5 6 6 1 1 2; 1 1 1 6 1 2;];


a=addrule(a, rule);

%ax=setfis(a, 'Defuzzmethod', 'centroid')
%ax=setfis(a, 'Defuzzmethod', 'mom')
%ax=setfis(a, 'Defuzzmethod', 'lom')
%ax=setfis(a, 'Defuzzmethod', 'bisector')
ax=setfis(a, 'Defuzzmethod', 'som')
time1=evalfis([1500 10 -25], ax)
time2=evalfis([750 25 -10], ax)
time3=evalfis([500 10 15], ax) 
time4=evalfis([1000 20 20], ax) 
time5=evalfis([800 20 15], ax) 








