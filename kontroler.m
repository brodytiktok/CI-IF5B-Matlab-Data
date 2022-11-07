clear all;

a=newfis('kontroler');

%Input ke 1 Kecepatan

a=addvar(a, 'input', 'Speed Differnce' , [0 255]);
a=addmf(a, 'input', 1, 'N', 'trapmf' ,[0 0 95 127]);
a=addmf(a, 'input', 1, 'ZE', 'trimf', [95 127 159]);
a=addmf(a, 'input', 1, 'P', 'trapmf', [127 159 255 255]);

figure;plotmf(a, 'input', 1);

%Input ke 2 

a=addvar(a, 'input', 'Acceleration', [0 255]);
a=addmf(a, 'input', 2, 'N', 'trapmf',[0 0 95 127]);
a=addmf(a, 'input', 2, 'ZE', 'trimf', [95 127 159]);
a=addmf(a, 'input', 2, 'P', 'trapmf', [127 159 255 255]);

figure;plotmf(a,'input',2);
%output 
a=addvar(a, 'output', 'Throttle Control', [0 255]);
a=addmf(a, 'output', 1, 'N', 'trapmf', [0 0 95 127]);
a=addmf(a, 'output', 1, 'ZE', 'trimf', [95 127 159]);
a=addmf(a, 'output', 1, 'P', 'trapmf', [127 159 255 255]);

figure;plotmf(a,'output',1);
%a= addvar(a, 'output', 'Thorttle Control', [0 255]);

% [- - - 1 1 ] = Or & [- - - 1 2 ] = And
rules = [1 1 1 1 2; 2 1 3 1 2; 3 1 3 1 2; 1 2 3 1 2;
    1 3 3 1 2; 2 2 2 1 2; 2 3 3 1 2; 3 3 3 1 2];

a=addrule(a,rules);



