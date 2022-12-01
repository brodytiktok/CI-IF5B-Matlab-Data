clear all
clc
warning 'off'

% 1. Crab Dataset
[x,t] = crab_dataset;

% 2. Menentukan neuron pada hidden layer (1 hidden layer)
net = patternnet(10, 'trainscg');

% 3. Mengacak dataset
acak = randperm(size(x, 2));
x = x(:, acak);
t = t(:, acak);

% 4. Split dan K-Fold Cross Validation
k = 10;
indexTest = vec2ind(t);
cv = cvpartition(indexTest, "KFold", k);

AccuracyTrain = [];
RecallTrain = [];
PrecisionTrain = [];
FScoreTrain = [];   

AccuracyTest = [];
RecallTest = [];
PrecisionTest = [];
FScoreTest = [];

AccuracyAll_train= [];
RecallAll_train = [];
PrecisionAll_train = [];
FScoreAll_train= [];

AccuracyAll_test= [];
RecallAll_test = [];
PrecisionAll_test = [];
FScoreAll_test= [];

for i = 1:1:k
    fprintf("fold ke-%d (%d%%)\n", i, i/k*100)
    
    % Splitting
    x_train = x(:, cv.training(i));
    x_test = x(:, cv.test(i));
    t_train = t(:, cv.training(i));
    t_test = t(:, cv.test(i));

    % Training
    [net,tr] = train(net, x_train, t_train);
    predict_test = net(x_test);
    index_predict_test = vec2ind(predict_test);
    predict_train = net(x_train);
    index_predict_train = vec2ind(predict_train);
    
    [c_train,cm_train] = confusion(t_train, predict_train);
    tp_m_train= diag(cm_train);
    for j = 1:size(cm_train,1)
        TP_train = tp_m_train(j);
        FP_train = sum(cm_train(:, j), 1) - TP_train;
        FN_train = sum(cm_train(j, :), 2) - TP_train;
        TN_train = sum(cm_train(:)) - TP_train - FP_train - FN_train;

        % 7. Untuk Data Training
        AccuracyTrain(i) = (TP_train + TN_train)./(TP_train + FP_train + TN_train + FN_train);
        RecallTrain(i) = TP_train./(TP_train + FN_train);
        PrecisionTrain(i) = TP_train./ (TP_train + FP_train);
        FScoreTrain(i) = (2*(PrecisionTrain(i) * RecallTrain(i))) / (PrecisionTrain(i) + RecallTrain(i));
                    
    %    fprintf('Accuracy-%d  : %f%%\n',j, 100*Accuracy(i,p));
    %    fprintf('Recall-%d  : %f%%\n',j, 100*Recall(i,p));
    %    fprintf('Precision-%d  : %f%%\n',j, 100*Precision(i,p));
    %    fprintf('F1-%d  : %f%%\n',j, 100*FScore(i,p));
    %    disp(' ')
    end

    meanAccuracy_train = mean(AccuracyTrain);
    meanRecall_train = mean(RecallTrain);
    meanPrecision_train = mean(PrecisionTrain);
    meanFScore_train = mean(FScoreTrain);

    [c_test,cm_test] = confusion(t_test,predict_test);
    tp_m_test= diag(cm_test);
    for j = 1:size(cm_test,1)
        TP_test = tp_m_test(j);
        FP_test = sum(cm_test(:, j), 1) - TP_test;
        FN_test = sum(cm_test(j, :), 2) - TP_test;
        TN_test = sum(cm_test(:)) - TP_test - FP_test - FN_test;

        % 7. Untuk Data Testing
        AccuracyTest(i) = (TP_test + TN_test)./(TP_test + FP_test + TN_test + FN_test);
        RecallTest(i) = TP_test./(TP_test + FN_test);
        PrecisionTest(i) = TP_test./ (TP_test + FP_test);
        FScoreTest(i) = (2*(PrecisionTest(i) * RecallTest(i))) / (PrecisionTest(i) + RecallTest(i));
        
        % fprintf('Accuracy-%d  : %f%%\n',j, 100*Accuracy(i,p));
        % fprintf('Recall-%d  : %f%%\n',j, 100*Recall(i,p));
        % fprintf('Precision-%d  : %f%%\n',j, 100*Precision(i,p));
        % fprintf('F1-%d  : %f%%\n',j, 100*FScore(i,p));
        % disp(' ')
    end
    meanAccuracy_test = mean(AccuracyTest);
    meanRecall_test = mean(RecallTest);
    meanPrecision_test = mean(PrecisionTest);
    meanFScore_test = mean(FScoreTest);

end

disp('Train')
disp('Rata-Rata')
for x = 1:size(meanAccuracy_train,2)
    fprintf('Accuracy-%d  : %f%%\n',x, 100*meanAccuracy_train(x));
    fprintf('Recall-%d  : %f%%\n',x, 100*meanRecall_train(x));
    fprintf('Precision-%d  : %f%%\n',x, 100*meanPrecision_train(x));
    fprintf('F1-%d  : %f%%\n',x, 100*meanFScore_train(x));
    AccuracyAll_train(x) = meanAccuracy_train(x);
    RecallAll_train(x) = meanRecall_train(x);
    PrecisionAll_train(x) = meanPrecision_train(x);
    FScoreAll_train(x) = meanFScore_train(x);
end

disp('Test')
disp('Rata-Rata')
for x = 1:size(meanAccuracy_test,2)
    fprintf('Accuracy-%d  : %f%%\n',x, 100*meanAccuracy_test(x));
    fprintf('Recall-%d  : %f%%\n',x, 100*meanRecall_test(x));
    fprintf('Precision-%d  : %f%%\n',x, 100*meanPrecision_test(x));
    fprintf('F1-%d  : %f%%\n',x, 100*meanFScore_test(x));
    AccuracyAll_test(x) = meanAccuracy_test(x);
    RecallAll_test(x) = meanRecall_test(x);
    PrecisionAll_test(x) = meanPrecision_test(x);
    FScoreAll_test(x) = meanFScore_test(x);
end
