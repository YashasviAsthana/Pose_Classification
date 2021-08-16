# Pose_Classification
This project is about analyzing the relationship between foot pressure and pose of a person while performing Taiji routine.

This is the final submission of the Term Project (Course 583 Pattern Recognition and Machine Learning - Dr. Yanxi Liu) by Yashasvi Asthana.

Data set is now AVAILABLE on the LPAC website: http://vision.cse.psu.edu/research/dynamicsFromKinematics/index.shtml


- clustering.m has the first task of clustering the poses (all the code used throughout the project for evaluation purposes is also present but commented out)
- baseline.m has the training code for SVM classifier
- CNN.m has the training code for CNN classifier

Note: Both the trained models are included with names 'svmModel.mat' and 'cnn.mat', and can be used for testing purposes.

All the other scripts are supporting scripts or functions:
- avgs.m (to calculate avg poses)
- createMovie.m (to create a Mocap motion movie - usage is in clustering.m)
- footMovie.m (to create a Foot pressure movie)
- visualizeAvgPoses.m (to display all the average clustered poses - usage is in clustering.m)
- rankingFeat.m (to rank best features based on Varaince Ratio Scores)

Important Label file   
- poseLabels.mat (generated after clustering 24 poses using clustering.m)
