function [AccuracyTrain,RecallTrain,PrecisionTrain,FScoreTrain,...
    AccuracyTest,RecallTest,PrecisionTest,FScoreTest,...
    AccuracyAll_train, RecallAll_train,PrecisionAll_train, FScoreAll_train,...
    AccuracyAll_test, RecallAll_test,PrecisionAll_test, FScoreAll_test...
    ] = ANN(k,source,target,trainfn, jumlah_hidden, step,max,start)
    %shuffle data (no 3)
    shuffle = randperm(size(source, 2));
    source = source(:, shuffle);
    target = target(:, shuffle);

    %pembagian data (no 4)
    testIndicies = vec2ind(target);
    cv = cvpartition(testIndicies,"KFold",k);

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
    FScoreAll_train=[];

    AccuracyAll_test= [];
    RecallAll_test = [];
    PrecisionAll_test = [];
    FScoreAll_test=[];

    for s=1:1:size(trainfn,2)
        fprintf('=====================%s=====================\n',trainfn{s})
        for p=start:step:max
            if jumlah_hidden == 1
                net = patternnet(p,trainfn{s}); %ubah function di sini
            elseif jumlah_hidden == 2
                net = patternnet([p,p],trainfn{s}); %ubah function di sini
            elseif jumlah_hidden == 3
                net = patternnet([p,p,p],trainfn{s});
            end
            net.trainParam.showWindow = 0; %agar nntraintool tidak tampil
            for i=1:1:k
                fprintf("fold ke-%d (%d%%)\n",i,i/k*100)
            
                source_train = source(:,cv.training(i));
                source_test = source(:,cv.test(i));
                target_train = target(:,cv.training(i));
                target_test = target(:,cv.test(i));
                %training
                [net,tr] = train(net,source_train,target_train);
                prediction_test = net(source_test);
                testIndicies_test = vec2ind(prediction_test);
                prediction_train = net(source_train);
                testIndicies_train = vec2ind(prediction_train);
                [c_train,cm_train] = confusion(target_train,prediction_train);
                tp_m_train= diag(cm_train);
                for j = 1:size(cm_train,1)
                    TP_train = tp_m_train(j);
                    FP_train = sum(cm_train(:, j), 1) - TP_train;
                    FN_train = sum(cm_train(j, :), 2) - TP_train;
                    TN_train = sum(cm_train(:)) - TP_train - FP_train - FN_train;
            
                    %nomor 7
                    Accuracy_train(i,j) = (TP_train+TN_train)./(TP_train+FP_train+TN_train+FN_train);
                    Recall_train(i,j) = TP_train./(TP_train + FN_train);
                    Precision_train(i,j) = TP_train./ (TP_train + FP_train);
                    FScore_train(i,j) = (2*(Precision_train(i,j) * Recall_train(i,j))) / (Precision_train(i,j)+Recall_train(i,j));
                    
    %                 fprintf('Accuracy-%d  : %f%%\n',j, 100*Accuracy(i,j));
    %                 fprintf('Recall-%d  : %f%%\n',j, 100*Recall(i,j));
    %                 fprintf('Precision-%d  : %f%%\n',j, 100*Precision(i,j));
    %                 fprintf('F1-%d  : %f%%\n',j, 100*FScore(i,j));
    %                 disp(' ')
                end

                if size(cm_train,2) == 2
                meanAccuracy_train = Accuracy_train(i,1);
                meanRecall_train = Recall_train(i,1);
                meanPrecision_train = Precision_train(i,1);
                meanFScore_train = FScore_train(i,1);
                else
                meanAccuracy_train = mean(Accuracy_train);
                meanRecall_train = mean(Recall_train);
                meanPrecision_train = mean(Precision_train);
                meanFScore_train = mean(FScore_train);
                end
                

                [c_test,cm_test] = confusion(target_test,prediction_test);
                tp_m_test= diag(cm_test);
                for j = 1:size(cm_test,1)
                    TP_test = tp_m_test(j);
                    FP_test = sum(cm_test(:, j), 1) - TP_test;
                    FN_test = sum(cm_test(j, :), 2) - TP_test;
                    TN_test = sum(cm_test(:)) - TP_test - FP_test - FN_test;
            
                    %nomor 7
                    Accuracy_test(i,j) = (TP_test+TN_test)./(TP_test+FP_test+TN_test+FN_test);
                    Recall_test(i,j) = TP_test./(TP_test + FN_test);
                    Precision_test(i,j) = TP_test./ (TP_test + FP_test);
                    FScore_test(i,j) = (2*(Precision_test(i,j) * Recall_test(i,j))) / (Precision_test(i,j)+Recall_test(i,j));
                    
    %                 fprintf('Accuracy-%d  : %f%%\n',j, 100*Accuracy(i,j));
    %                 fprintf('Recall-%d  : %f%%\n',j, 100*Recall(i,j));
    %                 fprintf('Precision-%d  : %f%%\n',j, 100*Precision(i,j));
    %                 fprintf('F1-%d  : %f%%\n',j, 100*FScore(i,j));
    %                 disp(' ')
                end
               if size(cm_test,2) == 2
                meanAccuracy_test = Accuracy_test(i,1);
                meanRecall_test = Recall_test(i,1);
                meanPrecision_test = Precision_test(i,1);
                meanFScore_test = FScore_test(i,1);
                else
                meanAccuracy_test = mean(Accuracy_test);
                meanRecall_test = mean(Recall_test);
                meanPrecision_test = mean(Precision_test);
                meanFScore_test = mean(FScore_test);
                end
            end
            disp('Train')
            disp('Rata-Rata')
            for x = 1:size(meanAccuracy_train,2)
                fprintf('Accuracy-%d  : %f%%\n',x, 100*meanAccuracy_train(x));
                fprintf('Recall-%d  : %f%%\n',x, 100*meanRecall_train(x));
                fprintf('Precision-%d  : %f%%\n',x, 100*meanPrecision_train(x));
                fprintf('F1-%d  : %f%%\n',x, 100*meanFScore_train(x));
            end
            AccuracyAll_train(s,:) = meanAccuracy_train(:);
            RecallAll_train(s,:) = meanRecall_train(:);
            PrecisionAll_train(s,:) = meanPrecision_train(:);
            FScoreAll_train(s,:) = meanFScore_train(:);
            disp('Test')
            disp('Rata-Rata')
            for x = 1:size(meanAccuracy_test,2)
                fprintf('Accuracy-%d  : %f%%\n',x, 100*meanAccuracy_test(x));
                fprintf('Recall-%d  : %f%%\n',x, 100*meanRecall_test(x));
                fprintf('Precision-%d  : %f%%\n',x, 100*meanPrecision_test(x));
                fprintf('F1-%d  : %f%%\n',x, 100*meanFScore_test(x));
            end
            AccuracyAll_test(s,:) = meanAccuracy_test(:);
            RecallAll_test(s,:) = meanRecall_test(:);
            PrecisionAll_test(s,:) = meanPrecision_test(:);
            FScoreAll_test(s,:) = meanFScore_test(:);
        end
    end
end