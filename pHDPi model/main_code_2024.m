
function main_code_2024(subID,taskType,noise,drift,hazard)

rng(subID)
outcomeNoise = noise;
numTrials = 200;
input.numOutcomes = numTrials; % how long should the block of trials be?
input.sigma       = outcomeNoise;      % standard deviation of the generative dist...
input.haz         = hazard ;             % probability of a change-point on any given trial
input.safe        = 1;       % except that we set hazard rate equal to zero for "safe" trials after a change-point
input.screenWidth = 300; %
input.drift       = drift;     % drift rate of random walk
input.taskType    = taskType;
taskData = genOutcomes_new(input);
taskData.noise = outcomeNoise^2;
taskData.drift = drift^2;
taskData.haz = hazard;
[output] = HDP_July_2024(taskData);

output.outcome = taskData.outcome;
output.mu = taskData.mean;
output.cp = taskData.cp;
output.noise = outcomeNoise^2;
output.drift = drift^2;
output.haz = hazard;


filename = ['sub',num2str(subID),'_',num2str(taskType)];
save(filename,'output')
