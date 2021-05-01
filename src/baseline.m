%clf;
clearvars;
foot_data = load('./10subject_MocapData/Ytest_Test_on_7_kPa.mat').Y;
load('./10subject_MocapData/footmask/Mask.mat');
labels = load('poseLabels.mat').idxKmeans;
size_m = size(foot_data);
M = 2521;
% Creating training matrix
data_mat = zeros(size_m(1),M);
for i=1:size_m(1)
    % applying mask
    data_mat(i,:) = [(squeeze(foot_data(i,:)).*Mask(:)'),labels(i)];
end

%% split
splitRatio = 0.80;
trainSize = ceil(size_m(1)*splitRatio);
train_mat = zeros(trainSize,M);
test_mat = zeros(1-trainSize,M);
train_target_mat=[];
test_target_mat=[];
total_train = 0;
total_test = 0;
for i=1:24
    temp_idx = data_mat(:,end)==i;
    catcount = sum(temp_idx);
    trainCount = ceil(catcount*splitRatio);
    testCount = catcount - trainCount;
    [a,order] = sort(temp_idx,'descend');
    temp_mat = data_mat(order,:);
    train_mat(total_train+1:total_train+trainCount,:) = temp_mat(1:trainCount,:);
    test_mat(total_test+1:total_test+testCount,:) = temp_mat(trainCount+1:trainCount+testCount,:);
    total_train = total_train + trainCount;
    total_test = total_test + testCount;
end
svmModel = fitcecoc(train_mat(:,1:end-1),train_mat(:,end));
save('svmModel','svmModel');
train_acc = 1 - loss(svmModel,train_mat(:,1:end-1),train_mat(:,end))
test_acc = 1 - loss(svmModel,test_mat(:,1:end-1),test_mat(:,end))
confusionchart(categorical(test_mat(:,end)),predict(svmModel,test_mat(:,1:end-1)),'ColumnSummary',"column-normalized");
