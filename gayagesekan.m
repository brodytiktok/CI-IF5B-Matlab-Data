clear all;

a=newfis('gayagesekan')

%input ke-1 Koefisien gesekan statis;
a=addvar(a, 'input', 'Koefisien Gesek Statis', [0 1.5]);
a=addmf(a, 'input', 1, 'very small','trapmf' ,[0 0 0.1 0.3]);
a=addmf(a, 'input', 1, 'small', 'trapmf', [0.1 0.3 0.5 0.7]);
a=addmf(a, 'input', 1, 'medium', 'trapmf', [0.5 0.7 0.9 1.1]);
a=addmf(a, 'input', 1, 'big', 'trapmf', [0.9 1.1 1.3 1.5]);

figure;plotmf(a,'input',1);

%input ke-2 gaya (F)
a=addvar(a, 'input', 'Gaya Normal', [0 1100]);
a=addmf(a, 'input', 2, 'small', 'trapmf', [0 0 100 300]);
a=addmf(a, 'input', 2, 'medium', 'trapmf', [100 300 500 700]);
a =addmf(a, 'input', 2, 'big', 'trapmf', [500 700 900 1100]);

figure;plotmf(a,'input',2);
%output Gesekan Static
a=addvar(a, 'output', 'Gerakan Statis', [0 1650]);
a=addmf(a, 'output', 1, 'very small', 'trapmf', [0 0 165 330]);
a=addmf(a, 'output', 1, 'small', 'trapmf', [165 330 495 660]);
a=addmf(a, 'output', 1, 'medium', 'trapmf', [495 660 825 990]);
a=addmf(a, 'output', 1, 'big', 'trapmf', [825 990 1155 1320]);
a=addmf(a, 'output', 1, 'over', 'trapmf', [1155 1320 1485 1650]);

figure;plotmf(a,'output',1)
