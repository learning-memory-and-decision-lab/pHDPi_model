   

task_names = {'Changepoint' 'Oddball' 'Reversal' 'Sequence'};


% Changepoint Task:
num_subs_model = 40;
n_trial_early = 50;
n_trial_late = 60;
n_trial =50;
seq_n_trials = 15;
task_type = 1;
LR_1 = 1;
LR_2 = 0.5;
LR_3 = 0.1;
SSE_model_all_1 = nan(num_subs_model,6);
SSE_model_all_2 =nan(num_subs_model,6);
SSE_model_all_3 = nan(num_subs_model,6);
SSE_model_all_4 = nan(num_subs_model,6);



p = 'model data final check/changepoint/';

for n = 1:num_subs_model


    subID =  n;
    saveFN = [p,'sub',sprintf('%.0f',subID),'_',sprintf('%.0f',task_type),'.mat'];
    load(saveFN)

    numTrials = length(output.outcome);

    if numTrials>199
    outputStd =25;
    newBlock=false(size(output.outcome));
    newBlock(1)=true;
    hazRate =0.1;
    driftRate = 0.1;
    bayes_prediction = zeros(numTrials,1);
    delta_estiamte_1 = zeros(numTrials,1);
    delta_estiamte_2 = zeros(numTrials,1);
    delta_estiamte_3 = zeros(numTrials,1);
    errBased_RU      = [0.9 0.9];
  

    outcome = output.outcome;

       
    cp = output.cp;
    prediction = zeros(200,1);
    prediction(1:200,1) = output.prediction;
  
    for i=1:numTrials

        if i==1
            bayes_prediction(i) = 150;
            delta_estiamte_1(i) = 150/3;
            delta_estiamte_2(i) = 150/3;
            delta_estiamte_3(i) = 150/3;

        else
            bayes_prediction(i) = bayes_prediction(i-1) + errBased_UP(1);
            delta_estiamte_1(i) = delta_estiamte_1(i-1) + LR_1 * pred_error_1;
            delta_estiamte_2(i) = delta_estiamte_2(i-1) + LR_2 *pred_error_2;
            delta_estiamte_3(i) = delta_estiamte_3(i-1) + LR_3 *pred_error_3;


        end

        PE = outcome(i).*3-bayes_prediction(i);
        pred_error_1 =outcome(i) -  delta_estiamte_1(i);
        pred_error_2 =outcome(i) -  delta_estiamte_2(i);
        pred_error_3 =outcome(i) -  delta_estiamte_3(i);

        % Step 2 = compute surprise and uncertainty according
        % to prediction error
        [errBased_pOdd,errBased_RU,errBased_LR,errBased_UP,totUnc]=...
            getTrialVarsFromPEs_cannon([outputStd; outputStd],...
            [PE; 0], hazRate, [1; 0], [false, false], ...
            errBased_RU(2), 0, 1, 1, [driftRate; driftRate]...
            , [true; true], 300);

    end

    [B1, ~, ~, ~, ~] = frugFun5_wRange((outcome),0.1,outputStd/3 , 0, 1, false...
        , 150/3, .1,[0 100]);

    [B2, ~, ~, ~, ~] = frugFun5_uniformOddballs_wRange((outcome),0.1,outputStd/3 , driftRate/3,  false...
        , 150/3, .1,[0 100]);


    bayes_response = B1(1:end-1);
    odd_bayes_response = B2(1:end-1);
    bayes_prediction = bayes_prediction./3;

 

    SSE_model_all_1(n,1) = mean((outcome(n_trial:end) - bayes_response(n_trial:end)').^2);
    SSE_model_all_1(n,2) = mean((outcome(n_trial:end) - bayes_prediction(n_trial:end)).^2);
    SSE_model_all_1(n,3) = mean((outcome(n_trial:end) - delta_estiamte_1(n_trial:end)).^2);
    SSE_model_all_1(n,4) = mean((outcome(n_trial:end) - delta_estiamte_2(n_trial:end)).^2);
    SSE_model_all_1(n,5) = mean((outcome(n_trial:end) - delta_estiamte_3(n_trial:end)).^2);
    SSE_model_all_1(n,6) = mean((outcome(n_trial:end) - prediction(n_trial:end)).^2);


    % find the min SSE of current run: 
    min_sse_error = min(SSE_model_all_1(n,:));

    % subtract the min SSE:
    SSE_model_rel_1(n,:) = SSE_model_all_1(n,:) - min_sse_error;
    log_SSE_model_rel_1 = log(SSE_model_rel_1);
    log_SSE_model_rel_1((log_SSE_model_rel_1)==-inf) = 0;
    end

end



n_trial=100;

% Oddball Task:
task_type =2;

p = 'model data final check/Oddball/';


for n = 1:num_subs_model

    subID =  n;
    saveFN = [p,'sub',sprintf('%.0f',subID),'_',sprintf('%.0f',task_type),'.mat'];
    load(saveFN)

    numTrials = min(length(output.outcome),200);

    if numTrials>199
    outputStd =25;
    newBlock=false(size(output.outcome));
    newBlock(1)=true;
    hazRate =0.1;
    driftRate = 5;
    bayes_prediction = zeros(numTrials,1);
    delta_estiamte_1 = zeros(numTrials,1);
    delta_estiamte_2 = zeros(numTrials,1);
    delta_estiamte_3 = zeros(numTrials,1);
    errBased_RU      = [0.9 0.9];
  

       outcome = output.outcome(1:200);

    cp = output.cp;
    cp = cp(1:numTrials);
    prediction = zeros(200,1);
    prediction(1:200,1) = output.prediction(1:200);
  
    for i=1:numTrials

        if i==1
            bayes_prediction(i) = 150;
            delta_estiamte_1(i) = 150/3;
            delta_estiamte_2(i) = 150/3;
            delta_estiamte_3(i) = 150/3;

        else
            bayes_prediction(i) = bayes_prediction(i-1) + errBased_UP(1);
            delta_estiamte_1(i) = delta_estiamte_1(i-1) + LR_1 * pred_error_1;
            delta_estiamte_2(i) = delta_estiamte_2(i-1) + LR_2 *pred_error_2;
            delta_estiamte_3(i) = delta_estiamte_3(i-1) + LR_3 *pred_error_3;


        end

        PE = outcome(i).*3-bayes_prediction(i);
        pred_error_1 =outcome(i) -  delta_estiamte_1(i);
        pred_error_2 =outcome(i) -  delta_estiamte_2(i);
        pred_error_3 =outcome(i) -  delta_estiamte_3(i);

        % Step 2 = compute surprise and uncertainty according
        % to prediction error
        [errBased_pOdd,errBased_RU,errBased_LR,errBased_UP,totUnc]=...
            getTrialVarsFromPEs_cannon([outputStd; outputStd],...
            [PE; 0], hazRate, [1; 0], [false, false], ...
            errBased_RU(2), 0, 1, 1, [driftRate; driftRate]...
            , [true; true], 300);

    end

    [B1, ~, ~, ~, ~] = frugFun5_wRange((outcome),0.1,25/3 , 0, 1, false...
        , 150/3, .1,[0 100]);

        [B2, ~, ~, ~, ~] = frugFun5_uniformOddballs_wRange((outcome),0.1,outputStd/3 , driftRate/3,  false...
        , 150/3, .1,[0 100]);

    bayes_response = B1(1:end-1);
    odd_bayes_response = B2(1:end-1)';
    bayes_prediction = bayes_prediction./3;



    sel=find(cp);
    tnum = 1:length(outcome);
    sel= cp~=1 & tnum'>(n_trial); %& tnum'<allCPs(7);

    SSE_model_all_2(n,1) = mean((outcome(sel) - bayes_response(sel)').^2);
    SSE_model_all_2(n,2) = mean((outcome(sel) - bayes_prediction(sel)).^2);
    SSE_model_all_2(n,3) = mean((outcome(sel) - delta_estiamte_1(sel)).^2);
    SSE_model_all_2(n,4) = mean((outcome(sel) - delta_estiamte_2(sel)).^2);
    SSE_model_all_2(n,5) = mean((outcome(sel) - delta_estiamte_3(sel)).^2);
    SSE_model_all_2(n,6) = mean((outcome(sel) - prediction(sel)).^2);

    % find the min SSE of current run: 
    min_sse_error = min(SSE_model_all_2(n,:));

    % subtract the min SSE:
    SSE_model_rel_2(n,:) = SSE_model_all_2(n,:) - min_sse_error;
    log_SSE_model_rel_2 = log(SSE_model_rel_2);
    log_SSE_model_rel_2((log_SSE_model_rel_2)==-inf) = 0;

    end

end


% Reversal Task:
num_subs_model = 40;
task_type =3;
rev_list = [16,27,31:40];
p = 'model data final check/Reversal/';

for n = 1:num_subs_model

    subID =  n;
    saveFN = [p,'sub',sprintf('%.0f',subID),'_',sprintf('%.0f',task_type),'.mat'];
    load(saveFN)

    numTrials = min(length(output.outcome),200);

    if numTrials>199
    outputStd =25;
    newBlock=false(size(output.outcome));
    newBlock(1)=true;
    hazRate =0.1;
    driftRate = 0.1;
    bayes_prediction = zeros(numTrials,1);
    delta_estiamte_1 = zeros(numTrials,1);
    delta_estiamte_2 = zeros(numTrials,1);
    delta_estiamte_3 = zeros(numTrials,1);
    errBased_RU      = [0.9 0.9];


    outcome = output.outcome(1:numTrials);
 


    cp = output.cp;
    prediction = zeros(numTrials,1);
    prediction((1:numTrials),1) = output.prediction(1:numTrials);
  
    for i=1:numTrials

        if i==1
            bayes_prediction(i) = 150/3;
            delta_estiamte_1(i) = 150/3;
            delta_estiamte_2(i) = 150/3;
            delta_estiamte_3(i) = 150/3;

        else
            bayes_prediction(i) = bayes_prediction(i-1) + errBased_UP(1);
            delta_estiamte_1(i) = delta_estiamte_1(i-1) + LR_1 * pred_error_1;
            delta_estiamte_2(i) = delta_estiamte_2(i-1) + LR_2 *pred_error_2;
            delta_estiamte_3(i) = delta_estiamte_3(i-1) + LR_3 *pred_error_3;


        end

        PE = outcome(i)-bayes_prediction(i);
        pred_error_1 =outcome(i) -  delta_estiamte_1(i);
        pred_error_2 =outcome(i) -  delta_estiamte_2(i);
        pred_error_3 =outcome(i) -  delta_estiamte_3(i);

        % Step 2 = compute surprise and uncertainty according
        % to prediction error
        [errBased_pOdd,errBased_RU,errBased_LR,errBased_UP,totUnc]=...
            getTrialVarsFromPEs_cannon([outputStd; outputStd],...
            [PE; 0], hazRate, [1; 0], [false, false], ...
            errBased_RU(2), 0, 1, 1, [driftRate; driftRate]...
            , [true; true], 300);

    end

    [B1, ~, ~, ~, ~] = frugFun5_wRange((outcome),0.1,outputStd , 0, 1, false...
        , 150/3, .1,[0 100]);
    bayes_response = B1(1:end-1);
    %bayes_prediction = bayes_prediction;

  
    SSE_model_all_3(n,1) = mean((outcome(sel) - bayes_response(sel)').^2);
    SSE_model_all_3(n,2) = mean((outcome(sel) - bayes_prediction(sel)).^2);
    SSE_model_all_3(n,3) = mean((outcome(sel) - delta_estiamte_1(sel)).^2);
    SSE_model_all_3(n,4) = mean((outcome(sel) - delta_estiamte_2(sel)).^2);
    SSE_model_all_3(n,5) = mean((outcome(sel) - delta_estiamte_3(sel)).^2);
    SSE_model_all_3(n,6) = mean((outcome(sel) - prediction(sel)).^2);

    % find the min SSE of current run: 
    min_sse_error = min(SSE_model_all_3(n,:));

    % subtract the min SSE:
    SSE_model_rel_3(n,:) = SSE_model_all_3(n,:) - min_sse_error;
    log_SSE_model_rel_3 = log(SSE_model_rel_3);
    log_SSE_model_rel_3((log_SSE_model_rel_3)==-inf) = 0;

    end
end

% Sequence Task:
num_subs_model = 40;
task_type = 4;
seq_list = [15,24,26,27,31:40];
p = 'model data final check/Sequence/';

for n = 1:num_subs_model

    subID =  n;
    saveFN = [p,'sub',sprintf('%.0f',subID),'_',sprintf('%.0f',task_type),'.mat'];
    load(saveFN)

    numTrials = min(length(output.outcome),200);

    if numTrials > 199
    outputStd =25;
    newBlock=false(size(output.outcome));
    newBlock(1)=true;
    hazRate =0.1;
    driftRate = 0.1;
    bayes_prediction = zeros(numTrials,1);
    delta_estiamte_1 = zeros(numTrials,1);
    delta_estiamte_2 = zeros(numTrials,1);
    delta_estiamte_3 = zeros(numTrials,1);
    errBased_RU      = [0.9 0.9];
  
    outcome = output.outcome(1:numTrials);

    prediction = zeros(200,1);
    prediction(1:200,1) = output.prediction(1:numTrials);

    for i=1:numTrials

        if i==1
            bayes_prediction(i) = 150;
            delta_estiamte_1(i) = 150/3;
            delta_estiamte_2(i) = 150/3;
            delta_estiamte_3(i) = 150/3;

        else
            bayes_prediction(i) = bayes_prediction(i-1) + errBased_UP(1);
            delta_estiamte_1(i) = delta_estiamte_1(i-1) + LR_1 * pred_error_1;
            delta_estiamte_2(i) = delta_estiamte_2(i-1) + LR_2 *pred_error_2;
            delta_estiamte_3(i) = delta_estiamte_3(i-1) + LR_3 *pred_error_3;


        end

        PE = outcome(i)-bayes_prediction(i);
        pred_error_1 =outcome(i) -  delta_estiamte_1(i);
        pred_error_2 =outcome(i) -  delta_estiamte_2(i);
        pred_error_3 =outcome(i) -  delta_estiamte_3(i);

        % Step 2 = compute surprise and uncertainty according
        % to prediction error
        [errBased_pOdd,errBased_RU,errBased_LR,errBased_UP,totUnc]=...
            getTrialVarsFromPEs_cannon([outputStd; outputStd],...
            [PE; 0], hazRate, [1; 0], [false, false], ...
            errBased_RU(2), 0, 1, 1, [driftRate; driftRate]...
            , [true; true], 100);

    end

    [B1, ~, ~, ~, ~] = frugFun5_wRange((outcome),0.1,25/3 , 0, 1, false...
        , 150/3, .1,[0 100]);
    bayes_response = B1(1:end-1);
    
 
    SSE_model_all_4(n,1) = mean((outcome(sel) - bayes_response(sel)').^2);
    SSE_model_all_4(n,2) = mean((outcome(sel) - bayes_prediction(sel)).^2);
    SSE_model_all_4(n,3) = mean((outcome(sel) - delta_estiamte_1(sel)).^2);
    SSE_model_all_4(n,4) = mean((outcome(sel) - delta_estiamte_2(sel)).^2);
    SSE_model_all_4(n,5) = mean((outcome(sel) - delta_estiamte_3(sel)).^2);
    SSE_model_all_4(n,6) = mean((outcome(sel) - prediction(sel)).^2);


    % find the min SSE of current run: 
    min_sse_error = min(SSE_model_all_4(n,:));

    % subtract the min SSE:
    SSE_model_rel_4(n,:) = SSE_model_all_4(n,:) - min_sse_error;
    log_SSE_model_rel_4 = log(SSE_model_rel_4);
    log_SSE_model_rel_4((log_SSE_model_rel_4)==-inf) = 0;
    end

end

