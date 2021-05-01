% clearvars;
foot_data = load('./10subject_MocapData/Ytest_Test_on_7_kPa.mat').Y;
load('./10subject_MocapData/footmask/Mask.mat');
labels = load('poseLabels.mat').idxKmeans;
size_m = size(foot_data);
% Creating training matrix
train_mat = zeros(60,42,1,size_m(1));
for i=1:size_m(1)
    train_mat(:,:,1,i) = squeeze(foot_data(i,:,:)).*Mask(:,:);
end
train_labels = labels;
%% guided class-based split (not using it for final sub)
% splitRatio = 0.80; trainSize = ceil(size_m(1)*splitRatio); train_mat =
% zeros(60,42,1,trainSize); test_mat = zeros(60,42,1,1-trainSize);
% train_labels = []; test_labels = []; total_train = 0; total_test = 0; for
% i=1:24
%     temp_idx = labels(:)==i; catcount = sum(temp_idx); trainCount =
%     ceil(catcount*splitRatio); testCount = catcount - trainCount;
%     [~,order] = sort(temp_idx,'descend'); temp_mat =
%     data_mat(:,:,:,order);
%     train_mat(:,:,:,total_train+1:total_train+trainCount) =
%     temp_mat(:,:,:,1:trainCount);
%     train_labels(total_train+1:total_train+trainCount) =
%     repmat(i,1,trainCount);
%     test_mat(:,:,:,total_test+1:total_test+testCount) =
%     temp_mat(:,:,:,trainCount+1:trainCount+testCount);
%     test_labels(total_test+1:total_test+testCount) =
%     repmat(i,1,testCount); total_train = total_train + trainCount;
%     total_test = total_test + testCount;
% end

%% CNN
rng('default');
% getting random 5000 samples for testing
idx = randperm(size(train_mat,4),1000);
test_mat = train_mat(:,:,:,idx);
train_mat(:,:,:,idx) = [];
test_labels = train_labels(idx);
train_labels(idx) = [];
% getting random 1000 samples for validation
idx = randperm(size(train_mat,4),1000);
validation_mat = train_mat(:,:,:,idx);
train_mat(:,:,:,idx) = [];
validation_labels = train_labels(idx);
train_labels(idx) = [];

layers = [
    imageInputLayer([60 42 1])
    convolution2dLayer(5,60,'Padding',[0 0],'Stride', [1,1])
    batchNormalizationLayer
    fullyConnectedLayer(24)
    dropoutLayer(.25); % Dropout layer
    softmaxLayer
    classificationLayer];
options = trainingOptions('sgdm', ...
    'InitialLearnRate',0.001, ...
    'MaxEpochs',10, ...
    'ValidationData',{validation_mat,categorical(validation_labels)}, ...
    'ValidationFrequency',30, ...
    'Shuffle','every-epoch', ...
    'Verbose',true, ...
    'Plots','training-progress');
[net, info] = trainNetwork(train_mat,categorical(train_labels),layers,options);
% Test on the Testing data
YTest = classify(net,test_mat);
test_acc = mean(YTest==categorical(test_labels)) 
figure;
confusionchart(categorical(test_labels),YTest,'ColumnSummary',"column-normalized");
title('{\bf Test Confusion Chart}');

%% tsne plots
conv1activations = activations(net,validation_mat,2,"OutputAs","rows");
Y = tsne(conv1activations);
figure;gscatter(Y(:,1),Y(:,2),validation_labels);
layer3 = activations(net,validation_mat,3,"OutputAs","rows");
Y = tsne(layer3);
figure;gscatter(Y(:,1),Y(:,2),validation_labels);
layer4 = activations(net,validation_mat,4,"OutputAs","rows");
Y = tsne(layer4);
figure;gscatter(Y(:,1),Y(:,2),validation_labels);
layer5 = activations(net,validation_mat,5,"OutputAs","rows");
Y = tsne(layer5);
figure;gscatter(Y(:,1),Y(:,2),validation_labels);
softactivations = activations(net,validation_mat,6,"OutputAs","rows");
Y = tsne(softactivations);
figure;gscatter(Y(:,1),Y(:,2),validation_labels);
