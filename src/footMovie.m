clearvars;
foot_data = load('./10subject_MocapData/Ytest_Test_on_7_kPa.mat').Y;
load('./10subject_MocapData/footmask/Mask.mat');
startIndex=800;endIndex=1500;
figure(1)
xlabel('x')
ylabel('y')

for i=startIndex:endIndex
    tt = squeeze(foot_data(i,:,:)).*Mask(:,:);
    %scatter(tt(:,:),tt(:,:))
    %imshow(Mask(:,:),'InitialMagnification','fit');
    %imshow(imfuse(Mask(:,:),tt,'falsecolor','ColorChannels',[2 1 0]),[0 100],'InitialMagnification','fit')
    imshow(tt,[0 50],'InitialMagnification','fit');
    M(i-startIndex+1) = getframe(1);
    clf(1);
end
v = VideoWriter('footPressure.avi');
v.Quality = 95; % change quality
v.FrameRate = 10; % change frame rate
open(v);
writeVideo(v,M);
close(v);