
function[output] = HDP_July_2024(taskData)

trialOutcome = taskData.outcome;
outcomeNoise=25;
numTrials = length(trialOutcome);
outcome_space = 300;
% Initialize nodes:
discreteOutcomes = 0:outcome_space;
max_context = 50;

% A uniform distribution prior over the means:
init_dist=ones(length(discreteOutcomes), 1)./(length(discreteOutcomes));

% Copy uniform prior for maximum number of contexts:
initStruct = zeros(length(discreteOutcomes),max_context);
for i=1:max_context
    initStruct(:,i) = init_dist;
end
nodes=struct;

% get nodes from some "prior" distribution:
comb.alpha= linspace(1,100,5);
comb.eta = 0:0.2:1;
comb.gamma = logspace(-0.25,5,5);
comb.driftVariance = logspace(-2,3,5); % [0.01,25, 225, 625, 1000];
comb.stdLogspace = logspace(2,3,5); % [100, 225, 625, 1000];
allCombos=makeAllCombos(comb);
totalSamps = length(allCombos.alpha);
nCopy = 10; % Copy of nodes with same parameters
numSamps = nCopy * totalSamps;

allMeanDriftMat=zeros(length(comb.driftVariance),length(discreteOutcomes),length(discreteOutcomes));
meanV1=(discreteOutcomes);
meanV2=(discreteOutcomes');
for i=1:length(comb.driftVariance)
    allMeanDriftMat(i,:,:)=normpdf(meanV1-meanV2, 0, comb.driftVariance(i).^.5);
end

allOutcomeLikelihoods=zeros(length(comb.driftVariance),length(comb.stdLogspace),length(discreteOutcomes));
for i=1:length(discreteOutcomes)
    for j=1:length(comb.stdLogspace)
        allOutcomeLikelihoods(i,j,:) =normpdf(discreteOutcomes(i), discreteOutcomes,comb.stdLogspace(j).^0.5)';
    end
end

nodes.sample_id = repmat(1:totalSamps,nCopy,1);
nodes.sample_id = nodes.sample_id(:);

for i=1:numSamps
    nodes.dist{i}           =initStruct;
    nodes.max_n_context(i) =max_context;
    nodes.logLike(i)             =log(1);
    nodes.currentState(i)        =1;
    nodes.nextState(i)        =1;
    nodes.alpha(i)      = allCombos.alpha(nodes.sample_id(i));
    nodes.eta(i)                =  allCombos.eta(nodes.sample_id(i));
    nodes.gamma(i)          = allCombos.gamma(nodes.sample_id(i));
    nodes.driftVariance(i)  = allCombos.driftVariance(nodes.sample_id(i));
    nodes.stdLogspace(i) = allCombos.stdLogspace(nodes.sample_id(i));
    nodes.transitionCounts{i} = zeros(nodes.max_n_context(i),nodes.max_n_context(i)); 
    %nodes.transitionCounts{i}(1,1) = 1; %
    nodes.beta{i} = zeros(1,nodes.max_n_context(i));
    nodes.beta{i}(1)= 1;
    nodes.beta{i}(2) = 0;
    nodes.mean(i,:) = zeros(1,numTrials);
end

nodes=straightStruct(nodes);


% Pre-allocate varaibles:
storePredDist=nan(numTrials, length(discreteOutcomes));
mle_dv = zeros(numTrials,1);
mle_gamma = zeros(numTrials,1);
mle_eta = zeros(numTrials,1);
mle_alpha = zeros(numTrials,1);
mle_std = zeros(numTrials,1);

% Loop through trials and do inference:
for i = 1: numTrials

    % Normalize probability across nodes:
    nodes.logLike= nodes.logLike-   logsumexp(nodes.logLike);

    % Make a prediction about the mean of the current trial:
    predDist=zeros(length(discreteOutcomes),1);
    for n = 1:length(nodes.logLike)

        % The number of active states for this node is all non-empty states plus one:
        num_state  = sum(sum(nodes.transitionCounts{n},1)~=0)+1;
        if num_state > nodes.max_n_context(n)
            num_state =nodes.max_n_context(n);
        end

        % calculate the transition probability from the current state from previous trial to any other state:
        transition_counts = nodes.alpha(n).* nodes.beta{n}(1:num_state)  +  nodes.transitionCounts{n}(nodes.currentState(n),1:num_state);
        trans_prob_vector = transition_counts./(sum(transition_counts));

        % Make the persistance probability vector:
        persistance_vector = zeros(1,num_state);
        persistance_vector(nodes.currentState(n)) = 1;

        % Prior transition matrix is a weighted sum of transition vector and
        % persistance vector:
        prior_matrix = [trans_prob_vector' , persistance_vector'] .* repmat([1- nodes.eta(n),nodes.eta(n)],length(persistance_vector),1) ;


        % Randomly select the next state
        chosen_next_context = find(rand < cumsum(prior_matrix(:)),1);
        nodes.nextState(n) =  mod(chosen_next_context,num_state);
        if nodes.nextState(n) == 0
            nodes.nextState(n) = num_state;
        end

        % Add the likelihood of the next selected state
        % for this node to the predictive distribution:
        predDist=predDist+exp(nodes.logLike(n)).*(nodes.dist{n}(:,nodes.nextState(n)));


    end

    storePredDist(i,:)=predDist;  % Note: this is predictions about mean!!!

    % Store the predicted free parameters for this trial:
    mle_dv(i,1) =  nodes.driftVariance' * exp(nodes.logLike)/sum(exp(nodes.logLike));
    mle_gamma(i,1) = nodes.gamma'* exp(nodes.logLike)/sum(exp(nodes.logLike));
    mle_eta(i,1) = nodes.eta'* exp(nodes.logLike)/sum(exp(nodes.logLike));
    mle_alpha(i,1) = nodes.alpha'* exp(nodes.logLike)/sum(exp(nodes.logLike));
    mle_std(i,1) = nodes.stdLogspace'* exp(nodes.logLike)/sum(exp(nodes.logLike));


    % Loop through nodes and update node probability and conditional
    % outcome probability distribution:
    for n=1:length(nodes.logLike)

        % Choose the closest discrete outcome to the current trial outcome
        [~,closestIndex] = min(abs(trialOutcome(i).*ones(size(discreteOutcomes))-discreteOutcomes));

        % lieklihood of the current outcome from a node with current
        % nodes mean and standard deviation:
        outcomeLikelihood = squeeze(allOutcomeLikelihoods(closestIndex,nodes.stdLogspace(n)==comb.stdLogspace,:));

        num_state = sum(sum(nodes.transitionCounts{n},1)~=0)+1;
        if num_state > nodes.max_n_context(n)
            num_state =nodes.max_n_context(n);
        end


        % Data likelihood:
        dataLike=reshape(nodes.dist{n}(:,1:num_state),[],num_state)'*outcomeLikelihood;

        if i==1
            nodes.currentState(n) =  1;
            %nodes.transitionCounts{n}(1,1) = 1;

        else

            % Transition probability vector:
            transition_counts= nodes.alpha(n).* nodes.beta{n}(1:num_state)  +  nodes.transitionCounts{n}(nodes.currentState(n),1:num_state);
            trans_prob_vector = transition_counts./(sum(transition_counts));

            % Persiatance probability vector:
            persistance_vector = zeros(1,num_state);
            persistance_vector(nodes.currentState(n)) = 1;

            % weighted Prior matrix
            prior_matrix = [trans_prob_vector' , persistance_vector'] .* repmat([1- nodes.eta(n),nodes.eta(n)],length(persistance_vector),1) ;


            % Posterior belief about the transition probabilty matrix:
            posterior_un_norm = log(prior_matrix)+log(repmat((dataLike), 1, 2));
            nodePosteriorProb=logsumexp(posterior_un_norm');
            posterior_normalized = exp(posterior_un_norm)./sum(exp(posterior_un_norm(:)));

            % Update current state and counts IF you did NOT persist
            chosen_context = find(rand < cumsum(posterior_normalized(:)),1);
            if chosen_context < num_state+1
                nodes.transitionCounts{n}(nodes.currentState(n),chosen_context)=nodes.transitionCounts{n}(nodes.currentState(n),chosen_context)+1;
                nodes.currentState(n) =  chosen_context;
            end


            if isempty(chosen_context)
                keyboard
            end

            % Update high level beta vector to include probability associated
            % with new state:
            if chosen_context == num_state && num_state < nodes.max_n_context(n)
                stick_l =  betarnd(1,nodes.gamma(n));
                nodes.beta{n}(num_state+1) = nodes.beta{n}(num_state) * (1 - stick_l);
                nodes.beta{n}(num_state)= nodes.beta{n}(num_state) * (stick_l);
            end
            nodes.logLike(n)=nodes.logLike(n) + (nodePosteriorProb(nodes.currentState(n)));
            output.nodes_ll(n,i) = nodes.logLike(n);%nodePosteriorProb(nodes.currentState(n));
        end


        % Resample betas from counts?
        counts_context = randnumtable(nodes.alpha(n)*nodes.beta{n} + zeros(nodes.max_n_context(n)),nodes.transitionCounts{n});
        beta_posterior = sum(counts_context,1);
        beta_posterior(num_state) = nodes.gamma(n);
        x = gamrnd(beta_posterior',1);
        nodes.beta{n} = (x./sum(x,1))';


        % multiply prior over parameters by their likelihood of giving rise to data:
        a=nodes.dist{n}(:,nodes.currentState(n)).* outcomeLikelihood;

        % Normalize according to total probability of data
        b=a./dataLike(nodes.currentState(n))';

        % Check for underflow issues:
        %             if any(~isfinite(b), 'all')
        %                 keyboard
        %                 disp('we have under- or over-flow problem')
        %             end


        nodes.dist{n}(:,nodes.currentState(n))=b;

        % Add drift:
        meanDriftMat=squeeze(allMeanDriftMat(comb.driftVariance==nodes.driftVariance(n),:,:));

        a = nodes.dist{n}(:,nodes.currentState(n))';

        addedrift=meanDriftMat.*repmat(a,...
            length(nodes.dist{n}(:,nodes.currentState(n))), 1);
        addedrift=sum(addedrift, 2);

        nodes.dist{n}(:,nodes.currentState(n))=addedrift;


        % Normalize the distribution:
        nodes.dist{n}(:,nodes.currentState(n))= nodes.dist{n}(:,nodes.currentState(n))./(sum(nodes.dist{n}(:,nodes.currentState(n))));

    end


    % Propogate particles to next time step:
    nodeNums =1:length(nodes.logLike);

    % init keepNodes
    keepNodes                   =struct;
    keepNodes.dist              =[];
    keepNodes.logLike           =[];
    keepNodes.currentState      =[];
    keepNodes.nextState      =[];
    keepNodes.alpha     =[];
    keepNodes.eta        =[];
    keepNodes.gamma        =[];
    keepNodes.eta        =[];
    keepNodes.driftVariance        =[];
    keepNodes.transitionCounts  =[];
    keepNodes.sample_id  = [];
    keepNodes.beta  =[];
    keepNodes.mean=[];
    keepNodes.stdLogspace =[];

    someEleProbs=nodes.logLike- logsumexp(nodes.logLike);
    someEleProbs(someEleProbs<-200) = -200;
    total_ids = (max(nodes.sample_id)); % each node has a unique ID

    for ii=1:total_ids

        sample_someEleProbs=exp(someEleProbs(nodes.sample_id == ii))./(sum(exp(someEleProbs(nodes.sample_id == ii))));

        % d is a group of nodes with identical hyperparams:
        d = zeros(nCopy,1);

        % resample within each group of identical nodes
        for k =1:nCopy
            d(k)=find(rand<=cumsum((sample_someEleProbs)),1);
        end

        % find out the unique IDs of the resampled nodes:
        d = d + (ii-1) * nCopy;

        subpop_prob = exp(someEleProbs(nodes.sample_id == ii));
        keepNodes.logLike      = [keepNodes.logLike; repmat(log(sum(subpop_prob)/(nCopy)),nCopy,1) ];
        keepNodes.currentState = [keepNodes.currentState; nodes.currentState(nodeNums(d))];
        keepNodes.nextState = [keepNodes.nextState; nodes.nextState(nodeNums(d))];
        keepNodes.dist         = [keepNodes.dist; nodes.dist(nodeNums(d))];
        keepNodes.alpha    = [keepNodes.alpha; nodes.alpha(nodeNums(d))];
        keepNodes.transitionCounts = [keepNodes.transitionCounts; nodes.transitionCounts(nodeNums(d))];
        keepNodes.eta    = [keepNodes.eta; nodes.eta(nodeNums(d))];
        keepNodes.gamma    = [keepNodes.gamma; nodes.gamma(nodeNums(d))];
        keepNodes.driftVariance    = [keepNodes.driftVariance; nodes.driftVariance(nodeNums(d))];
        keepNodes.beta    = [keepNodes.beta; nodes.beta(nodeNums(d))];
        keepNodes.max_n_context = nodes.max_n_context;
        keepNodes.sample_id = [keepNodes.sample_id; repmat(ii,nCopy,1)];
        keepNodes.mean=[keepNodes.mean; nodes.mean(nodeNums(d),:)];
        keepNodes.stdLogspace = [keepNodes.stdLogspace; nodes.stdLogspace(nodeNums(d),:)];
    end
    nodes = keepNodes;


end


% Convert predictions about meean to predictions about outcome:
meanToOutMatrix=nan(length(discreteOutcomes), length(discreteOutcomes));
for i = 1:length(discreteOutcomes)
    meanToOutMatrix(i,:)=normpdf(discreteOutcomes, discreteOutcomes(i), outcomeNoise)';
end

allOutPredMat = zeros(size(storePredDist));
for i = 1:size(storePredDist, 1)
    meanPredMat=repmat(storePredDist(i,:), length(discreteOutcomes), 1);
    outPredMat=sum(meanPredMat.*meanToOutMatrix, 2);
    allOutPredMat(i,:)=outPredMat./sum(outPredMat);
end


% Predictions of the model:
maxP = zeros(numTrials,1);
for i = 1:size(storePredDist, 1)
    if any(isfinite(allOutPredMat(i,:)))
        maxP(i)=  find(allOutPredMat(i,:)==max(allOutPredMat(i,:)),1);
    else
        maxP(i)=nan;
    end
end




output.gamma = nodes.gamma;
output.eta = nodes.eta;
output.driftVariance = nodes.driftVariance;
output.alpha = nodes.alpha;
output.predDist = storePredDist;
output.logLike = nodes.logLike;
output.prediction = maxP;
output.stdLogspace = nodes.stdLogspace;
output.outcome = taskData.outcome;
%output.mu = taskData.mu;
%output.cp = taskData.cp;
output.mle_dv = mle_dv;
output.mle_gamma = mle_gamma;
output.mle_eta = mle_eta;
output.mle_alpha = mle_alpha;
output.mle_std = mle_std;

