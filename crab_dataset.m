[x,t] = crab_dataset;
size(x)
size(t)
setdemorandstream(491218382)
net = patternnet(10);
view(net)
nntraintool
plotperform(tr)
testX = x(:,tr.testInd);
testT = t(:,tr.testInd);

testY = net(testX);
testIndices = vec2ind(testY)
plotconfusion(testT,testY)
[c,cm] = confusion(testT,testY);

fprintf('Percentage Correct Classification   : %f%%\n', 100*(1-c));
fprintf('Precentage Incorrect Classification : %f%%\n', 100*c);