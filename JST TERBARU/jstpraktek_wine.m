clear all
clc
warning 'off'

%inisialisasi data (no 1)
[x_crab,t_crab] = wine_dataset;
wine_target= t_crab;
wine_source = x_crab;

%parameter (no 2)
jumlah_hidden = 1; %max 3
step = 5;
start = 5;
max = 15;

trainFn ={'trainbr','trainlm','trainbfg','traincgb','traincgf','traincgp','traingd','traingda','traingdm',...
        'traingdx','trainoss','trainrp','trainscg','trainb'};
%jumlah cross validation yang akan dilakukan
k = 10;

[AccuracyTrain,RecallTrain,PrecisionTrain,FScoreTrain,...
    AccuracyTest,RecallTest,PrecisionTest,FScoreTest,...
    AccuracyAll_train, RecallAll_train,PrecisionAll_train, FScoreAll_train,...
    AccuracyAll_test, RecallAll_test,PrecisionAll_test, FScoreAll_test,...
    ] = ANN(k,wine_source,wine_target,trainFn,jumlah_hidden,step,max,start);