function status = createMovie(data,movieName,startIndex,endIndex)
% Use this function to plot the data in 3D and save the movie

figure(1)
xlabel('x')
ylabel('y')
zlabel('z')
txt = ['1','2','3','4','5','6','7','8','9',"10","11","12"]';
for i=startIndex:endIndex
    tt = squeeze(data(i,:,:));
    scatter3(tt(:,1),tt(:,2),tt(:,3))
    text(tt(:,1),tt(:,2),tt(:,3),txt)
    line(tt(10:12,1),tt(10:12,2),tt(10:12,3)) % leg 1
    line(tt(7:9,1),tt(7:9,2),tt(7:9,3)) % leg 2
    line(tt([7,10],1),tt([7,10],2),tt([7,10],3)) % pelvis
    line(tt(1:3,1),tt(1:3,2),tt(1:3,3)) % arm 1
    line(tt(4:6,1),tt(4:6,2),tt(4:6,3)) % arm 2
    line(tt([1,4],1),tt([1,4],2),tt([1,4],3)) % neckline
    line(tt([1,7],1),tt([1,7],2),tt([1,7],3)) % torso1
    line(tt([4,10],1),tt([4,10],2),tt([4,10],3)) % torso2
    M(i-startIndex+1) = getframe(1);
    clf(1);
end
v = VideoWriter(movieName);
v.Quality = 95; % change quality
v.FrameRate = 10; % change frame rate
open(v);
writeVideo(v,M);
close(v);
status=1;
end

