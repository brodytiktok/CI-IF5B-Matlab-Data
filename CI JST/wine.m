clear all
clc
warning 'off'

[x,t] = wine_dataset;
size(x)
size(t)
nodesInHL=7;

HLtranfer='tansig';
outputTranser='tansig';
trainFunc='traingd';

performanceFunc='mse';

net=newff(x,t,[nodesInHL],{HLtranfer,outputTranser},trainFunc,'learngd',performanceFunc);

net = init(net);
%setting parameters
%training
[net,tr] = train(net,x,t);
view(net)


nntraintool
plotperform(tr)
testX = x(:,tr.testInd);
testT = t(:,tr.testInd);

testY=net(testX);
testIndices = vec2ind(testY)
plotconfusion(testT,testY)

[c,cm] = confusion(testT,testY)

fprintf('Percentage Correct Classification   : %f%%\n', 100*(1-c));
fprintf('Percentage Incorrect Classification : %f%%\n', 100*c);
plotroc(testT,testY);