clc
[x,t] = wine_dataset;
%parameters
nodesInHL=7;
nodesInOutput=3;
iteration=10;
HLtranfer='tansig';
outputTranser='tansig';
trainFunc='traingd';
learnRate=0.05;
performanceFunc='mse';


%rand('seed',0);
%randn('seed',0);
rng('shuffle');

net=newff(x,t,[nodesInHL],{HLtranfer,outputTranser},trainFunc,'learngd',performanceFunc);
net=init(net);

%setting parameters
net.trainParam.epochs=iteration;
net.trainParam.lr=learnRate;

%training
[net,tr]=train(net,x,t);



