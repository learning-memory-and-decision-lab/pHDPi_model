function output=genOutcomes_new(input)



numOutcomes=input.numOutcomes; % how long should the block of trials be?
sigma = input.sigma;           % standard deviation of the generative dist...
Haz=input.haz;             % probability of a change-point on any given trial
screenWidth=input.screenWidth; %
drift = input.drift;          % drift rate of random walk



% Initialize stuff:
mean=round(rand(1).*screenWidth); % initialize mean
outcome=nan(numOutcomes, 1); % this will be an array of outcomes
distMean=nan(numOutcomes, 1);% this will be an array of distribution mean
cp=zeros(numOutcomes, 1);     % this will be an array of binary change-point variable


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
    
    mean_vec = 25+round(rand(1,3).*250);

    for i=1:numOutcomes
        mean = mean_vec(mod(i,3)+1);
   while~isfinite(outcome(i))|outcome(i)>screenWidth|outcome(i)<1;
        outcome(i)=round(normrnd(mean, sigma));
    end
        distMean(i)=mean;
    end


    
end




output.mean=distMean;
output.outcome=outcome;
output.cp = cp;
output.noise = sigma;


