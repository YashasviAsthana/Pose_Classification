% clf;
clearvars;
load('./10subject_MocapData/Xtest_Test_on_7_3D_Mocap.mat');
size_m = size(Mocap);
% %Normalizing the Data
% for i=1:size_m(2)
%     for j = 1:size_m(3)
%     NormMocap(:,i,j) = normalize(Mocap(:,i,j));
%     end
% end
% % uncomment the lines below to visualize the Mocap data in 3D
% %createMovie(Mocap,'Original Mocap.avi',800,1500);
% % createMovie(NormMocap,'Normalized Mocap.avi',800,1500);
% % creating a Nx52 matrix for clustering
train_mat=[];
for i=1:size_m(1)
    dist_arm1 = sqrt(sum((Mocap(i,1,1:3) - Mocap(i,3,1:3)).^2)); % right shoulder to wrist
    dist_arm2 = sqrt(sum((Mocap(i,4,1:3) - Mocap(i,6,1:3)).^2)); % left shoulder to wrist
    dist_leg1 = sqrt(sum((Mocap(i,7,1:3) - Mocap(i,9,1:3)).^2)); % right hip to ankle
    dist_leg2 = sqrt(sum((Mocap(i,10,1:3) - Mocap(i,12,1:3)).^2)); % left hip to ankle
    train_mat(i,:) = [Mocap(i,:,1),Mocap(i,:,2),...
         Mocap(i,:,3),Mocap(i,:,4),dist_arm1,dist_arm2,dist_leg1,dist_leg2];
end
% % for i=1:size_m(1)
% %      norm_train_mat(i,:) = [NormMocap(i,:,1),NormMocap(i,:,2),...
% %          NormMocap(i,:,3),NormMocap(i,:,4)];
% % end
% 
%% evaluating number of clusters based on all the features
% rng('default');
% kmeansfunc = @(X,K)(kmeans(X, K,'MaxIter',500, 'emptyaction', 'singleton', 'replicate',5,'start','uniform'));
% eva = evalclusters(train_mat,kmeansfunc,'CalinskiHarabasz','KList',[20:30]);
% figure;
% hold on;
% ylabel('Calinski Harabasz Score');
% xlabel('K Value');
% plot(eva.InspectedK(2:end),eva.CriterionValues(2:end))
% hold off

%% k-means clustering
rng('default');
% %normMat = normalize(train_mat);
C = zeros(24,52);
C(1,:) = mean(train_mat(1:423,:),1);
C(2,:) = mean(train_mat(424:1399,:),1);
C(3,:) = mean(train_mat(1400:4051,:),1);
C(4,:) = mean(train_mat(4052:4779,:),1);
C(5,:) = mean(train_mat(4780:5427,:),1);
C(6,:) = mean(train_mat(5428:8059,:),1);
C(7,:) = mean(train_mat(8060:11107,:),1);
C(8,:) = mean(train_mat(11108:13901,:),1);
C(9,:) = mean(train_mat(13902:15953,:),1);
C(10,:) = mean(train_mat(15954:17223,:),1);
C(11,:) = mean(train_mat(17224:19757,:),1);
C(12,:) = mean(train_mat(19758:20265,:),1);
C(13,:) = mean(train_mat(20264:21049,:),1);
C(14,:) = mean(train_mat(21050:22415,:),1);
C(15,:) = mean(train_mat(22416:23115,:),1);
C(16,:) = mean(train_mat(23116:24183,:),1);
C(17,:) = mean(train_mat(24184:25409,:),1);
C(18,:) = mean(train_mat(25410:26701,:),1);
C(19,:) = mean(train_mat(26702:28428,:),1);
C(20,:) = mean(train_mat(28428:29051,:),1);
C(21,:) = mean(train_mat(29052:29605,:),1);
C(22,:) = mean(train_mat(29606:30944,:),1);
C(23,:) = mean(train_mat(30944:31671,:),1);
C(24,:) = mean(train_mat(31672:end,:),1);
%C(24,:) = mean(train_mat(32722:end,:),1);
[idxKmeans,means] = kmeans(train_mat,24,'MaxIter',500,'start',C);
save('poseLabels','idxKmeans');
avg_mat = avgs(train_mat,idxKmeans); % calc avg poses in cluster
visualizeAvgPoses(avg_mat); % visualizing avg poses
%[idxKmeans, order] = sort(idxKmeans);
%train_mat = train_mat(order,:);
%rankedFeatures = rankingfeat(train_mat,categorical(idxKmeans));
%% k-means clustering with top features
% topFeatures = rankedFeatures(1:15,:);
% for i = 1:size(topFeatures,1)
%     new_train_mat(:,i) = train_mat(:,topFeatures(i,1));
% end
% newidxKmeans = kmeans(new_train_mat,25,'MaxIter',500, 'replicate',5,'start','uniform');
%avg_mat = avgs(train_mat,idx); % calc avg poses in cluster
%visualizeAvgPoses(avg_mat); % visualizing avg poses

%% dbscan clustering
%normMat = normalize(train_mat);
%dist = pdist2(train_mat,train_mat);
%idx = dbscan(train_mat,1740,100);
%avg_mat = avgs(train_mat,idx); % calc avg poses in cluster
%visualizeAvgPoses(avg_mat); % visualizing avg poses

