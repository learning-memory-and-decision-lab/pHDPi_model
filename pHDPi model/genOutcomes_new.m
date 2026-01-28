function output=genOutcomes_new(input)

% OK create one function to generate outcomes for all task types.


% make some outcomes for helicopter task.
% oddballCondition




% pick some
numOutcomes=input.numOutcomes; % how long should the block of trials be?
sigma = input.sigma;           % standard deviation of the generative dist...
Haz=input.haz   ;             % probability of a change-point on any given trial
safe=input.safe;
screenWidth=input.screenWidth; %
drift = input.drift;          % drift rate of random walk
lambda = 0.5;



% Initialize stuff:
mean=round(rand(1).*screenWidth); % initialize mean
outcome=nan(numOutcomes, 1); % this will be an array of outcomes
distMean=nan(numOutcomes, 1);% this will be an array of distribution mean
cp=zeros(numOutcomes, 1);     % this will be an array of binary change-point variable
s=safe;


if input.taskType ==1
    % changepoint
    
  
    for i = 1:numOutcomes
        if rand<Haz 
            mean=round(rand(1).*300);
            cp(i)=1;
        end
        while ~isfinite(outcome(i))|outcome(i)>300|outcome(i)<1;
            outcome(i)=round(normrnd(mean, sigma));
        end
        distMean(i)=mean;
    end
    
    
    
    
    
elseif input.taskType ==2
    % oddball
    
    
    % generative process for oddball trials:
    for i = 1:numOutcomes
        
        
        % if first trial
        if i >1
            trialDrift=normrnd(0,drift);
            if  (distMean(i-1)+trialDrift)>0&&(distMean(i-1)+trialDrift)<screenWidth
                mean= distMean(i-1)+trialDrift;
            else   % If the drift would push you off screen, drift in other direction.
                mean= distMean(i-1)-trialDrift;
            end
        end
        
        
        % Select whether oddball occurrs:
        if rand<Haz 
            outcome(i)=rand.*screenWidth;
            cp(i)=1;
        else
            while ~isfinite(outcome(i))|outcome(i)>screenWidth|outcome(i)<1;
                outcome(i)=round(normrnd(mean, sigma));
            end
        end
        distMean(i)=mean;
    end
    
    
    
elseif input.taskType==3

    % reversal
    a = [1,2];
    context = randi(2);
    mean_vec =[0 0];
    while var(unique(mean_vec)) < 300
        mean_vec = 25 + round(rand(1,2).*250);
    end

    for i = 1:numOutcomes
        if rand<Haz
            context = (a(a~=context));

            cp(i)=1;
        end
        mean=mean_vec(context);
        while ~isfinite(outcome(i))|outcome(i)>screenWidth|outcome(i)<1;
            outcome(i)=round(normrnd(mean, sigma));
        end
        distMean(i)=mean;
    end

elseif input.taskType ==4
    
    mean_vec =  25+round(rand(1,3).*250);

    for i=1:numOutcomes
        mean = mean_vec(mod(i,3)+1);
   while~isfinite(outcome(i))|outcome(i)>screenWidth|outcome(i)<1;
        outcome(i)=round(normrnd(mean, sigma));
    end
        distMean(i)=mean;
    end



elseif input.taskType ==5

 
% generative process for non-markovian task:

trigram_transition(:,1,1) = [ 0, 1, 0];
trigram_transition(:,2,1) = [ 0, 0, 1];
trigram_transition(:,3,1) = [ 1, 0, 0];

trigram_transition(:,1,2) = [ 0, 1, 0];
trigram_transition(:,2,2) = [ 0, 1,0];
trigram_transition(:,3,2) = [ 1, 0, 0];

trigram_transition(:,1,3) = [ 0, 0, 1];
trigram_transition(:,2,3) = [ 1, 0, 0];
trigram_transition(:,3,3) = [ 1, 0, 0];
c = randi(3);
c_minus_1 = randi(3);
mean_vec =  25+round(rand(1,3).*250);
keyboard
for i = 1:numOutcomes
    if rand < Haz
        prob_vec = squeeze(trigram_transition(:,c_minus_1,c));
        c = find(rand < cumsum(prob_vec),1);
        c_minus_1 = c;
    end
   while~isfinite(outcome(i))|outcome(i)>screenWidth|outcome(i)<1;
        outcome(i)=round(normrnd(mean_vec(c), sigma));
   end
   distMean(i)=mean_vec(c);
   
end


    
end




output.mean=distMean;
output.outcome=outcome;
output.cp = cp;
output.noise = sigma;


