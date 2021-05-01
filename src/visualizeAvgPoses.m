function status = visualizeAvgPoses(avg_mat)
%VISUALIZEAVGPOSES does what its name suggests
%   avg_mat should be a Nx50 matrix with the first 2 columns containing
% the cluster_id and number of poses in the cluster. Rest of the columns
% should be divided into 4 sets (x,y,z,Prob) of 12 joints. eg. row - cluster_id,num_poses,
% x1,x2,...,x12,y1,y2,...,y12,z1,z2,...,z12,...,Prob1,Prob2,...,Prob12

for i=1:size(avg_mat,1)
    figure;
    tt = [avg_mat(i,3:14)' avg_mat(i,15:26)' avg_mat(i,27:38)'];
    scatter3(tt(:,1),tt(:,2),tt(:,3))
    line(tt(10:12,1),tt(10:12,2),tt(10:12,3)) % leg 1
    line(tt(7:9,1),tt(7:9,2),tt(7:9,3)) % leg 2
    line(tt([7,10],1),tt([7,10],2),tt([7,10],3)) % pelvis
    line(tt(1:3,1),tt(1:3,2),tt(1:3,3)) % arm 1
    line(tt(4:6,1),tt(4:6,2),tt(4:6,3)) % arm 2
    line(tt([1,4],1),tt([1,4],2),tt([1,4],3)) % neckline
    line(tt([1,7],1),tt([1,7],2),tt([1,7],3)) % torso1
    line(tt([4,10],1),tt([4,10],2),tt([4,10],3)) % torso2
end
status = 1;
end

