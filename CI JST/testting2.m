%# load sample dataset
%#   simpleclassInputs: 2x1000 matrix (1000 points of 2-dimensions)
%#   simpleclassTargets: 4x1000 matrix (4 possible classes)
load simpleclass_dataset

%# create ANN of one hidden layer with 7 nodes
net = patternnet(7);

%# set params
net.trainFcn = 'traingd';            %# training function
net.trainParam.epochs = 20;        %# max number of iterations
net.trainParam.lr = 0.05;            %# learning rate
net.performFcn = 'mse';              %# mean-squared error function
net.divideFcn = 'dividerand';        %# how to divide data
net.divideParam.trainRatio = 70/100; %# training set
net.divideParam.valRatio = 100;   %# validation set
net.divideParam.testRatio = 15/100;  %# testing set

%# training
net = init(net);
[net,tr] = train(net, simpleclassInputs, simpleclassTargets);

%# testing
y_hat = net(simpleclassInputs);
perf = perform(net, simpleclassTargets, y_hat);
err = gsubtract(simpleclassTargets, y_hat);

view(net)