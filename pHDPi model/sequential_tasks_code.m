
function sequential_tasks_code(subID,taskData,taskType_1,taskType_2)



rng('subID')
outcomeNoise=noise;
numTrials = 300;
input.numOutcomes = numTrials; % how long should the block of trials be?
input.sigma       = outcomeNoise;      % standard deviation of the generative dist...
input.haz         = hazard ;             % probability of a change-point on any given trial
input.safe        = 1;       % except that we set hazard rate equal to zero for "safe" trials after a change-point
input.screenWidth = 300; %
input.drift_1 = drift_1;
input.drift_2 = drift_2;
input.taskType_1    = taskType_1;
input.taskType_2    = taskType_2;
taskData=gen_two_tasks(input);
taskData.noise = outcomeNoise^2;
taskData.haz = hazard;


[output] = pHDPi_sequential_effect(taskData);

output.outcome = taskData.outcome;
output.mu = taskData.mean;
output.noise = outcomeNoise^2;
output.cp = taskData.cp;
% output.drift_1 = drift_1^2;
% output.drift_2 = drift_2^2;
% output.haz = hazard;

filename = ['sub',num2str(subID),'_',num2str(taskType_1),'_',num2str(taskType_2)];
save(filename,'output')
