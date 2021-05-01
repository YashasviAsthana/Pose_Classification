function avg_mat = avgs(train_mat,idx)
%AVGS Calculates the average of all the poses in respective clusters
%   train_mat (Nx48) is the matrix with original pose data 
% output avg_mat will be of size (Num_clusters X 54) with first 2 columns
% containing the cluster_id and the number of poses in cluster resp.
avg_mat = zeros(size(idx));
for i=1:size(idx)
    labelid = find(avg_mat(:,1)==idx(i));
    if(isempty(labelid))
        avg_mat(i,1) = idx(i); %class label
        avg_mat(i,2) = 1; % counter to finally take avg
        avg_mat(i,3:54) = train_mat(i,:);
    else
        avg_mat(labelid,2) = avg_mat(labelid,2) + 1;
        avg_mat(labelid,3:54) = avg_mat(labelid,3:54) + train_mat(i,:);
    end
end
remIndx = avg_mat(:,1)==0;
avg_mat(remIndx,:) = []; % removing excess rows
avg_mat(:,3:54) = avg_mat(:,3:54)./avg_mat(:,2); % calculating average
end

