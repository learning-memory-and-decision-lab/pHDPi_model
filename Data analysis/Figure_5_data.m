

task_names = {'Changepoint' 'Oddball' 'Reversal' 'Sequence'};

p_model = 'model data final check/changepoint/';
p_humans = 'humans data final check/Changepoint task/';

discreteOutcomes = 0:300;
outcomeNoise = 25;
numTrials = 200;

% Changepoint Task:
num_subs_model = 120;
num_subs_human = 120;
n_trial_early = 30;
n_trial_late = 30;
late_phase = [false(num_subs_human,1);true(num_subs_human,1)];



task_type = 1;
SSE_humans_1 = nan(size(late_phase));
SSE_model_1 =  nan(size(late_phase));


for n = 1:num_subs_human
    subID = n;
    saveFN = [p_humans,'sub',sprintf('%.0f',subID),'_',sprintf('%.0f',task_type),'.mat'];
    load(saveFN)

    outcome = output.outcome;
    prediction = output.prediction;

    cp = output.cp;
    sel = zeros(size(outcome));
    sel(1:n_trial_early) =1;
    sel(cp==1) = 0;
    sel=logical(sel);
    SSE_humans_1(n) = sum((outcome(sel) -prediction(sel)).^2);

    sel = zeros(size(outcome));
    sel(end-n_trial_late+1:end) =1;
    sel(cp==1) = 0;
    sel = logical(sel);
    SSE_humans_1(n+num_subs_human) = sum((outcome(sel) -prediction(sel)).^2);

     saveFN = [p_model,'sub',sprintf('%.0f',subID),'_',sprintf('%.0f',task_type),'.mat'];
    load(saveFN)

    outcome = output.outcome;
    prediction = output.prediction;


     cp = output.cp;
    sel = zeros(size(outcome));
    sel(1:n_trial_early) =1;
    sel(cp==1) = 0;
    sel=logical(sel);

    SSE_model_1(n) = nansum((outcome(sel) -prediction(sel)).^2);

    SSE_model_1(n) = sum((outcome(sel) -prediction(sel)).^2);


    sel = zeros(size(outcome));
    sel(end-n_trial_late+1:end) =1;
    sel(cp==1) = 0;
    sel = logical(sel);
    SSE_model_1(n+num_subs_human) = sum((outcome(sel) -prediction(sel)).^2);


   
    
end

norm_SSE_model_1 = zscore(SSE_model_1);
norm_SSE_humans_1 = zscore(SSE_humans_1);




%% Oddball:


p_model = 'model data final check/Oddball/';
p_humans = 'humans data final check/Oddball task/';


task_type = 2;
SSE_humans_2 = nan(size(late_phase));
SSE_model_2 =  nan(size(late_phase));


for n = 1:num_subs_human
    subID = n;
    saveFN = [p_humans,'sub',sprintf('%.0f',subID),'_',sprintf('%.0f',task_type),'.mat'];
    load(saveFN)

    outcome = output.outcome;
    prediction = output.prediction;
    cp = output.cp;

    sel = zeros(size(outcome));
    sel(1:n_trial_early) =1;
    sel(cp==1) = 0;
    sel=logical(sel);
    SSE_humans_2(n) = sum((outcome(sel) -prediction(sel)).^2);

    sel = zeros(size(outcome));
    sel(end-n_trial_late+1:end) =1;
    sel(cp==1) = 0;
    sel = logical(sel);
    SSE_humans_2(n+num_subs_human) = sum((outcome(sel) -prediction(sel)).^2);
   
    saveFN = [p_model,'sub',sprintf('%.0f',subID),'_',sprintf('%.0f',task_type),'.mat'];
    load(saveFN)

    outcome = output.outcome;
    prediction = output.prediction;
    cp = output.cp;

    sel = zeros(size(outcome));
    sel(1:n_trial_early) =1;
    sel(cp==1) = 0;
    sel=logical(sel);
    SSE_model_2(n) = sum((outcome(sel) -prediction(sel)).^2);

    sel = zeros(size(outcome));
    sel(end-n_trial_late+1:end) =1;
    sel(cp==1) = 0;
    sel = logical(sel);
    SSE_model_2(n+num_subs_human) = sum((outcome(sel) -prediction(sel)).^2);


end

norm_SSE_model_2 = zscore(SSE_model_2);
norm_SSE_humans_2 = zscore(SSE_humans_2);


%% Reversal Task:
[c_light, c_dark] =  get_color_shade(task_type);
[c_lighter, c_darker] =  get_color_shade(task_type+2);

p_model = 'model data final check/Reversal/';
p_humans = 'humans data final check/Reversal task/';


task_type = 3;
SSE_humans_3 = nan(size(late_phase));
SSE_model_3 =  nan(size(late_phase));


for n = 1:num_subs_human
    subID = n;
    saveFN = [p_humans,'sub',sprintf('%.0f',subID),'_',sprintf('%.0f',task_type),'.mat'];
    load(saveFN)

    outcome = output.outcome;
    prediction = reshape(output.prediction,size(outcome));
    cp = output.cp;


    sel = zeros(size(outcome));
    sel(1:n_trial_early) =1;
    sel(cp==1) = 0;
    sel=logical(sel);
    SSE_humans_3(n) = sum((outcome(sel) -prediction(sel)).^2);

    sel = zeros(size(outcome));
    sel(end-n_trial_late+1:end) =1;
    sel(cp==1) = 0;
    sel = logical(sel);
    SSE_humans_3(n+num_subs_human) = sum((outcome(sel) -prediction(sel)).^2);
    
    saveFN = [p_model,'sub',sprintf('%.0f',subID),'_',sprintf('%.0f',task_type),'.mat'];
    load(saveFN)

    outcome = output.outcome;
    prediction = output.prediction;
    cp = output.cp;
    sel = zeros(size(outcome));
    sel(1:n_trial_early) =1;
    sel(cp==1) = 0;
    sel=logical(sel);
    SSE_model_3(n) = sum((outcome(sel) -prediction(sel)).^2);

    sel = zeros(size(outcome));
    sel(end-n_trial_late+1:end) =1;
    sel(cp==1) = 0;
    sel = logical(sel);
    SSE_model_3(n+num_subs_human) = sum((outcome(sel) -prediction(sel)).^2);


end

norm_SSE_model_3 = zscore(SSE_model_3);
norm_SSE_humans_3 = zscore(SSE_humans_3);



%% Sequence Task:


p_model = 'model data final check/Sequence/';
p_humans = 'humans data final check/Sequence task/';


task_type = 4;
SSE_humans_4 = nan(size(late_phase));
SSE_model_4 =  nan(size(late_phase));


for n = 1:num_subs_human
    subID = n;
    saveFN = [p_humans,'sub',sprintf('%.0f',subID),'_',sprintf('%.0f',task_type),'.mat'];
    load(saveFN)
    outcome = output.outcome;
    prediction = reshape(output.prediction,size(outcome));
    SSE_humans_4(n) = sum((outcome(1:n_trial_early) -prediction(1:n_trial_early)).^2);
    SSE_humans_4(n+num_subs_human) = sum((outcome(end-n_trial_late+1:end) -prediction(end-n_trial_late+1:end)).^2);

    saveFN = [p_model,'sub',sprintf('%.0f',subID),'_',sprintf('%.0f',task_type),'.mat'];
    load(saveFN)
    outcome = output.outcome;
    prediction = output.prediction;
    SSE_model_4(n) = sum((outcome(1:n_trial_early) -prediction(1:n_trial_early)).^2);
    SSE_model_4(n+num_subs_human) = sum((outcome(end-n_trial_late+1:end) -prediction(end-n_trial_late+1:end)).^2);


end

norm_SSE_model_4 = zscore(SSE_model_4);
norm_SSE_humans_4 = zscore(SSE_humans_4);


%% plot

diff_norm_SSE_model_1 = (norm_SSE_model_1(~late_phase))-(norm_SSE_model_1(late_phase));
diff_norm_SSE_model_2 = (norm_SSE_model_2(~late_phase))-(norm_SSE_model_2(late_phase));
diff_norm_SSE_model_3 = (norm_SSE_model_3(~late_phase))-(norm_SSE_model_3(late_phase));
diff_norm_SSE_model_4 = (norm_SSE_model_4(~late_phase))-(norm_SSE_model_4(late_phase));


% 
% a = find(abs(norm_SSE_humans_1(late_phase))>3);
 outliers_humans_1 = ones(size(norm_SSE_humans_1));
% outliers_humans_1(a+120) = 0;
% outliers_humans_1(a) = 0;
% 
% 
% a = find(abs(norm_SSE_humans_2(late_phase))>3);
 outliers_humans_2 = ones(size(norm_SSE_humans_2));
% outliers_humans_2(a+120) = 0;
% outliers_humans_2(a) = 0;
% 
% a = find(abs(norm_SSE_humans_3(late_phase))>3);
 outliers_humans_3 = ones(size(norm_SSE_humans_3));
% outliers_humans_3(a+120) = 0;
% outliers_humans_3(a) = 0;
% 
% 
% a = find(abs(norm_SSE_humans_4(late_phase))>3);
 outliers_humans_4 = ones(size(norm_SSE_humans_3));
% outliers_humans_4(a+120) = 0;
% outliers_humans_4(a) = 0;

a = find(abs(norm_SSE_humans_1(late_phase))>3);
outliers_humans_1 = ones(size(norm_SSE_humans_1));
outliers_humans_1(a+120) = 0;
outliers_humans_1(a) = 0;


a = find(abs(norm_SSE_humans_2(late_phase))>3);
outliers_humans_2 = ones(size(norm_SSE_humans_2));
outliers_humans_2(a+120) = 0;
outliers_humans_2(a) = 0;

a = find(abs(norm_SSE_humans_3(late_phase))>3);
outliers_humans_3 = ones(size(norm_SSE_humans_3));
outliers_humans_3(a+120) = 0;
outliers_humans_3(a) = 0;

a = find(abs(norm_SSE_humans_4(late_phase))>3);
outliers_humans_4 = ones(size(norm_SSE_humans_3));
outliers_humans_4(a+120) = 0;
outliers_humans_4(a) = 0;

diff_norm_SSE_humans_1 = (norm_SSE_humans_1(~late_phase&outliers_humans_1))-(norm_SSE_humans_1(late_phase&outliers_humans_1));
diff_norm_SSE_humans_2 = (norm_SSE_humans_2(~late_phase&outliers_humans_2))-(norm_SSE_humans_2(late_phase&outliers_humans_2));
diff_norm_SSE_humans_3 = (norm_SSE_humans_3(~late_phase&outliers_humans_3))-(norm_SSE_humans_3(late_phase&outliers_humans_3));
diff_norm_SSE_humans_4 = (norm_SSE_humans_4(~late_phase&outliers_humans_4))-(norm_SSE_humans_4(late_phase&outliers_humans_4));


all_SSE_humans = [diff_norm_SSE_humans_1;diff_norm_SSE_humans_2;diff_norm_SSE_humans_3;diff_norm_SSE_humans_4];

all_SSE_models = [diff_norm_SSE_model_1;diff_norm_SSE_model_2;diff_norm_SSE_model_3;diff_norm_SSE_model_4];



fprintf('Human overall dSSE mean %.2f, SEM = %.2f\n', ...
        mean(all_SSE_humans), std(all_SSE_humans)./sqrt(length((all_SSE_humans))))


fprintf('Model overall dSSE mean %.2f, SEM = %.2f\n', ...
        mean(all_SSE_models), std(all_SSE_models)./sqrt(length((all_SSE_models))))



fprintf('Human changepoint dSSE median %.2f\n', ...
        median(all_SSE_humans(1:120)))

fprintf('Human other tasks dSSE median %.2f\n', ...
        median(all_SSE_humans(121:end)))


fprintf('Model changepoint dSSE median %.2f\n', ...
        median(all_SSE_models(1:120)))

fprintf('Model other tasks dSSE median %.2f\n', ...
        median(all_SSE_models(121:end)))




% changepoint task vs all
n_bootstrap = 1000;
confidence_interval_1 = nan(n_bootstrap,1);
confidence_interval_2 = nan(n_bootstrap,1);
confidence_interval_3 = nan(n_bootstrap,1);
confidence_interval_4 = nan(n_bootstrap,1);

for i =1:n_bootstrap

    rand_sample = randsample(diff_norm_SSE_humans_1,length(diff_norm_SSE_humans_1),true);
    confidence_interval_1(i,1) = median(rand_sample);
    
    rand_sample = randsample(diff_norm_SSE_humans_2,length(diff_norm_SSE_humans_2),true);
    confidence_interval_2(i,1) = median(rand_sample);

    rand_sample = randsample(diff_norm_SSE_humans_3,length(diff_norm_SSE_humans_3),true);
    confidence_interval_3(i,1) = median(rand_sample);

    
    rand_sample = randsample(diff_norm_SSE_humans_4,length(diff_norm_SSE_humans_4),true);
    confidence_interval_4(i,1) = median(rand_sample);

end


l_perc_humans_1 = prctile(confidence_interval_1,2.5);
u_perc_humans_1 = prctile(confidence_interval_1,97.5);

l_perc_humans_2 = prctile(confidence_interval_2,2.5);
u_perc_humans_2 = prctile(confidence_interval_2,97.5);

l_perc_humans_3 = prctile(confidence_interval_3,2.5);
u_perc_humans_3 = prctile(confidence_interval_3,97.5);

l_perc_humans_4 = prctile(confidence_interval_4,2.5);
u_perc_humans_4 = prctile(confidence_interval_4,97.5);

[p_humans_1, h, stats] = signrank(diff_norm_SSE_humans_1);
[p_humans_2, h, stats] = signrank(diff_norm_SSE_humans_2);
[p_humans_3, h, stats] = signrank(diff_norm_SSE_humans_3);
[p_humans_4, h, stats] = signrank(diff_norm_SSE_humans_4);


pstr = @(p) sprintf('%s%.3f', repmat('< ',1,p<.001), max(p,.001));
fprintf('Human subs median dSSE for changepoint task is %.2f, 95%% CI [%.2f, %.2f], p = %s\n', ...
        median(diff_norm_SSE_humans_1), l_perc_humans_1, u_perc_humans_1, pstr(p_humans_1))

fprintf('Human subs median dSSE for oddball task is %.2f, 95%% CI [%.2f, %.2f], p = %s\n', ...
        median(diff_norm_SSE_humans_2), l_perc_humans_2, u_perc_humans_2, pstr(p_humans_2))
fprintf('Human subs median dSSE for reversal task is %.2f, 95%% CI [%.2f, %.2f], p = %s\n', ...
        median(diff_norm_SSE_humans_3), l_perc_humans_3, u_perc_humans_3, pstr(p_humans_3))
fprintf('Human subs median dSSE for sequence task is %.2f, 95%% CI [%.2f, %.2f], p = %s\n', ...
        median(diff_norm_SSE_humans_4), l_perc_humans_4, u_perc_humans_4, pstr(p_humans_4))

% Model
n_bootstrap = 1000;
confidence_interval_1 = nan(n_bootstrap,1);
confidence_interval_2 = nan(n_bootstrap,1);
confidence_interval_3 = nan(n_bootstrap,1);
confidence_interval_4 = nan(n_bootstrap,1);

for i =1:n_bootstrap

    rand_sample = randsample(diff_norm_SSE_model_1,length(diff_norm_SSE_model_1),true);
    confidence_interval_1(i,1) = median(rand_sample);
    
    rand_sample = randsample(diff_norm_SSE_model_2,length(diff_norm_SSE_model_2),true);
    confidence_interval_2(i,1) = median(rand_sample);

    rand_sample = randsample(diff_norm_SSE_model_3,length(diff_norm_SSE_model_3),true);
    confidence_interval_3(i,1) = median(rand_sample);

    
    rand_sample = randsample(diff_norm_SSE_model_4,length(diff_norm_SSE_model_4),true);
    confidence_interval_4(i,1) = median(rand_sample);

end

l_perc_model_1 = prctile(confidence_interval_1,2.5);
u_perc_model_1 = prctile(confidence_interval_1,97.5);

l_perc_model_2 = prctile(confidence_interval_2,2.5);
u_perc_model_2 = prctile(confidence_interval_2,97.5);

l_perc_model_3 = prctile(confidence_interval_3,2.5);
u_perc_model_3 = prctile(confidence_interval_3,97.5);

l_perc_model_4 = prctile(confidence_interval_4,2.5);
u_perc_model_4 = prctile(confidence_interval_4,97.5);

[p_model_1, h, stats] = signrank(diff_norm_SSE_model_1);
[p_model_2, h, stats] = signrank(diff_norm_SSE_model_2);
[p_model_3, h, stats] = signrank(diff_norm_SSE_model_3);
[p_model_4, h, stats] = signrank(diff_norm_SSE_model_4);


pstr = @(p) sprintf('%s%.3f', repmat('< ',1,p<.001), max(p,.001));
fprintf('Model median dSSE for changepoint task is %.2f, 95%% CI [%.2f, %.2f], p = %s\n', ...
        median(diff_norm_SSE_model_1), l_perc_model_1, u_perc_model_1, pstr(p_model_1))

fprintf('Model median dSSE for oddball task is %.2f, 95%% CI [%.2f, %.2f], p = %s\n', ...
        median(diff_norm_SSE_model_2), l_perc_model_2, u_perc_model_2, pstr(p_model_2))
fprintf('Model median dSSE for reversal task is %.2f, 95%% CI [%.2f, %.2f], p = %s\n', ...
        median(diff_norm_SSE_model_3), l_perc_model_3, u_perc_model_3, pstr(p_model_3))
fprintf('Model median dSSE for sequence task is %.2f, 95%% CI [%.2f, %.2f], p = %s\n', ...
        median(diff_norm_SSE_model_4), l_perc_model_4, u_perc_model_4, pstr(p_model_4))


% changepoint task vs all
n_bootstrap = 1000;
confidence_interval_model_1 = nan(n_bootstrap,1);
confidence_interval_model_2 = nan(n_bootstrap,1);
confidence_interval_model_3 = nan(n_bootstrap,1);
confidence_interval_model_4 = nan(n_bootstrap,1);

for i =1:n_bootstrap

    rand_sample = randsample(diff_norm_SSE_model_1,length(diff_norm_SSE_model_1),true);
    confidence_interval_model_1(i,1) = median(rand_sample);
    
    rand_sample = randsample(diff_norm_SSE_model_2,length(diff_norm_SSE_model_2),true);
    confidence_interval_model_2(i,1) = median(rand_sample);

    rand_sample = randsample(diff_norm_SSE_model_3,length(diff_norm_SSE_model_3),true);
    confidence_interval_model_3(i,1) = median(rand_sample);

    
    rand_sample = randsample(diff_norm_SSE_model_4,length(diff_norm_SSE_model_4),true);
    confidence_interval_model_4(i,1) = median(rand_sample);

end

l_perc_model_1 = prctile(confidence_interval_model_1,2.5);
u_perc_model_1 = prctile(confidence_interval_model_1,97.5);

l_perc_model_2 = prctile(confidence_interval_model_2,2.5);
u_perc_model_2 = prctile(confidence_interval_model_2,97.5);

l_perc_model_3 = prctile(confidence_interval_model_3,2.5);
u_perc_model_3 = prctile(confidence_interval_model_3,97.5);

l_perc_model_4 = prctile(confidence_interval_model_4,2.5);
u_perc_model_4 = prctile(confidence_interval_model_4,97.5);



std(all_SSE_humans)./length(all_SSE_humans)
std(all_SSE_models)./length(all_SSE_models)

mean(all_SSE_humans)
mean(all_SSE_models)

[r,p] = ttest2(all_SSE_humans,all_SSE_models)


% Chnagepoint Task:
num_subs_model = 120;
num_subs_human = 120;
n_trial = 6;
task_type = 1;
p_model = 'model data final check/changepoint/';
p_humans = 'humans data final check/Changepoint task/';


for i=1:n_trial

    for n = 1:num_subs_human


        subID = n;
        saveFN = [p_humans,'sub',sprintf('%.0f',subID),'_',sprintf('%.0f',task_type),'.mat'];
        load(saveFN)

        outcome = output.outcome;
        prediction = output.prediction;
        cp = output.cp;

        for ct = 1:length(cp)
            if cp(ct) == 1 || ct ==1
                TAC(ct) = 0;
            else
                TAC(ct) = TAC(ct-1) + 1;
            end

        end

        newBlock=false(size(outcome));
        newBlock(1)=true;
        [~, UP, PE]=computeLR(outcome,prediction, newBlock);
        prediction_error(1:length(PE),1) = PE;
        update(1:length(PE),1) = UP;

        x = find(TAC == i-1,2);
        y = find(TAC == 0,3);
        z = find(TAC == i-1);

        if x(2) < y(3)
            early_update(n,1) = update(x(2));
            early_pred(n,1) = prediction_error(x(2));
        end

        ult_late_update(n,1) = update(z(end));
        ult_late_pred(n,1) = prediction_error(z(end));

    end

    


    xes=[ones(size(early_pred)),early_pred];
    [C2,bint] = regress(early_update,xes);

    postCPtrialLR_early_human(i)=C2(2);
    postCPtrialLR_early_human_std(i,:)= bint(2,:);

    late_pred = [ult_late_pred]; 
    late_update = [ult_late_update]; 

    xes=[ones(size(late_pred)),late_pred];
    [C2,bint] = regress(late_update,xes);

    postCPtrialLR_late_human(i)=C2(2);
    postCPtrialLR_late_human_std(i,:)= bint(2,:);


end

for i=1:n_trial

    for n = 1:num_subs_model

        saveFN = [p_model,'/','sub',sprintf('%.0f',n),'_',sprintf('%.0f',task_type),'.mat'];
        load(saveFN)

        cp = output.cp;
        outcome = output.outcome;
        prediction = output.prediction;


        for ct = 1:length(cp)
            if cp(ct) == 1 || ct ==1
                TAC(ct) = 0;
            else
                TAC(ct) = TAC(ct-1) + 1;
            end

        end
        newBlock=false(size(outcome));
        newBlock(1)=true;
        [~, UP, PE]=computeLR(outcome,prediction, newBlock);
        prediction_error(1:length(PE),1) = PE;
        update(1:length(PE),1) = UP;
        x = find(TAC == i-1,2);
        y = find(TAC == 0,3);
        z = find(TAC == i-1);
        if x(2) < y(3)
            early_update(n,1) = update(x(2));
            early_pred(n,1) = prediction_error(x(2));
        end

       ult_late_update(n,1) = update(z(end));
        ult_late_pred(n,1) = prediction_error(z(end));

    
    end
    xes=[ones(size(early_pred)),early_pred];
    [C2,bint] = regress(early_update,xes);
    postCPtrialLR_early(i)=C2(2);
    postCPtrialLR_early_std(i,:) = bint(2,:);

    late_pred = [ult_late_pred];
    late_update = [ult_late_update];


    xes=[ones(size(late_pred)),late_pred];
    [C2,bint] = regress(late_update,xes);

    postCPtrialLR_late(i)=C2(2);
    postCPtrialLR_late_std(i,:) = bint(2,:);


end


% Oddball Task


p_model = 'model data final check/Oddball/';
p_humans = 'humans data final check/Oddball task/';

% 
% n_trial_early = 60;
% n_trial_late = 60;

n_trial_early = 60;
n_trial_late = 60;
task_type = 2;

for i=1:n_trial
    for n = 1:num_subs_human
        subID = n;
        saveFN = [p_humans,'sub',sprintf('%.0f',subID),'_',sprintf('%.0f',task_type),'.mat'];
        load(saveFN)

        outcome = output.outcome;
        prediction = output.prediction;
        cp = output.cp;
        
        for ct = 1:length(cp)
            if cp(ct) == 1 || ct ==1
                TAC(ct) = 0;
            else
                TAC(ct) = TAC(ct-1) + 1;
            end

        end

        newBlock=false(size(outcome));
        newBlock(1)=true;
        [~, UP, PE]=computeLR(outcome,prediction, newBlock);
        prediction_error(1:length(PE),1) = PE;
        update(1:length(PE),1) = UP;

        x = find(TAC == i-1,2);
        y = find(TAC == 0,3);
        z = find(TAC == i-1);

        if x(2) < y(3)
            early_update(n,1) = update(x(2));
            early_pred(n,1) = prediction_error(x(2));
        end

        late_update(n,1) = update(z((end-1)));
        late_pred(n,1) = prediction_error(z((end-1)));


    end

    xes=[ones(size(early_pred)),early_pred];
    [C2,bint] = regress(early_update,xes);
    postODDtrialLR_early_human(i)=C2(2);
    postODDtrialLR_early_human_std(i,:)= bint(2,:);


    xes=[ones(size(late_pred)),late_pred];
    [C2,bint] = regress(late_update,xes);
    postODDtrialLR_late_human(i)=C2(2);
    postODDtrialLR_late_human_std(i,:)= bint(2,:);

end



for i=1:n_trial

    for n = 1:num_subs_model

        saveFN = [p_model,'/','sub',sprintf('%.0f',n),'_',sprintf('%.0f',task_type),'.mat'];
        load(saveFN)

        outcome = output.outcome;

        prediction = output.prediction;

        cp = output.cp;

        for ct = 1:length(cp)
            if cp(ct) == 1 || ct ==1
                TAC(ct) = 0;
            else
                TAC(ct) = TAC(ct-1) + 1;
            end

        end
        newBlock=false(size(outcome));
        newBlock(1)=true;
        [~, UP, PE]=computeLR(outcome,prediction, newBlock);
        prediction_error(1:length(PE),1) = PE;
        update(1:length(PE),1) = UP;
        x = find(TAC == i-1,2);
        y = find(TAC == 0,3);
        z = find(TAC == i-1);
        if x(2) < y(3)
            early_update(n,1) = update(x(2));
            early_pred(n,1) = prediction_error(x(2));
        end

        late_update(n,1) = update(z(end-1));
        late_pred(n,1) = prediction_error(z(end-1));

    end

 


xes=[ones(size(early_pred)),early_pred];
[C2,bint] = regress(early_update,xes);
postODDtrialLR_early(i)=C2(2);
postODDtrialLR_early_std(i,:) = bint(2,:);

xes=[ones(size(late_pred)),late_pred];
[C2,bint] = regress(late_update,xes);
postODDtrialLR_late(i)=C2(2);
postODDtrialLR_late_std(i,:) = bint(2,:);


end




% Reversal Task:
p_model = 'model data final check/Reversal/';
p_humans = 'humans data final check/Reversal task/';
 n_trial_early = 60;
 n_trial_late = 60;


n_trial_early = 50;
n_trial_late = 50;
task_type = 3;
[c_light, c_dark] =  get_color_shade(task_type);
[c_lighter, c_darker] =  get_color_shade(task_type+2);

postRPtrialPE_early_humans = zeros(num_subs_human,1);
postRPtrial_Mu_PE_early_humans = zeros(num_subs_human,1);
postRPtrialPE_late_humans = zeros(num_subs_human,1);
postRPtrial_Mu_PE_late_humans = zeros(num_subs_human,1);

jitter_ind = 0.2;

for n = 1:num_subs_human

    subID = n;
    saveFN = [p_humans,'sub',sprintf('%.0f',subID),'_',sprintf('%.0f',task_type),'.mat'];
    load(saveFN)

    outcome = output.outcome;
    prediction = output.prediction;
    cp = output.cp;
    means = unique(output.mu);
    empricial_mu = output.mu;
    empricial_mu(output.mu==means(1)) = mean(outcome(output.mu==means(1)));
    empricial_mu(output.mu==means(2)) = mean(outcome(output.mu==means(2)));

    [postRPtrialPE_early_humans(n,:), postRPtrial_Mu_PE_early_humans(n,:)] = dynamic_LR_reversal(outcome(1:n_trial_early),prediction(1:n_trial_early),empricial_mu(1:n_trial_early),output.cp(1:n_trial_early));
    [postRPtrialPE_late_humans(n,:), postRPtrial_Mu_PE_late_humans(n,:)] = dynamic_LR_reversal(outcome(end-n_trial_late+1:end),prediction(end-n_trial_late+1:end),empricial_mu(end-n_trial_late+1:end),output.cp(end-n_trial_late+1:end));
    [postRPtrialPE_late_humans(n,:), postRPtrial_Mu_PE_late_humans(n,:)] = dynamic_LR_reversal(outcome(100-n_trial_late+1:100),prediction(100-n_trial_late+1:100),empricial_mu(100-n_trial_late+1:100),output.cp(100-n_trial_late+1:100));

    TAC = zeros(size(cp));
    for ct = 1:length(cp)
        if cp(ct) == 1 || ct ==1
            TAC(ct) = 0;
        else
            TAC(ct) = TAC(ct-1) + 1;
        end
    end

    numTrial = 1:length(cp);
    sel = find(cp ==1 & numTrial' < n_trial_early+1);

    mu_pdf =0;
    outcome_pdf =0;
    for i=sel'
        mu_pdf = mu_pdf + normpdf(prediction(i+1),output.mu(i),25);
        outcome_pdf = outcome_pdf + normpdf(prediction(i+1),output.outcome(i),25);
    end


    early_mu_like(n,1) = mu_pdf./length(sel);
    early_outcome_like(n,1) = outcome_pdf./length(sel);

    numTrial = 1:length(cp);
    sel = find(cp ==1 & numTrial'>3* n_trial_early);

    sel(sel==200) = [];
    mu_pdf =0;
    outcome_pdf =0;
    for i=sel'
        mu_pdf = mu_pdf + normpdf(prediction(i+1),output.mu(i),25);
        outcome_pdf = outcome_pdf + normpdf(prediction(i+1),output.outcome(i),25);
    end

    late_mu_like(n,1) = mu_pdf./length(sel);
    late_outcome_like(n,1) = outcome_pdf./length(sel);
end



for n = 1:num_subs_model

    saveFN = [p_model,'/','sub',sprintf('%.0f',n),'_',sprintf('%.0f',task_type),'.mat'];
    load(saveFN)
    cp = output.cp;
    prediction = output.prediction;
    outcome = output.outcome;

    means = unique(output.mu);
    empricial_mu = output.mu;
    empricial_mu(output.mu==means(1)) = mean(outcome(output.mu==means(1)));
    empricial_mu(output.mu==means(2)) = mean(outcome(output.mu==means(2)));

    % 
    [postRPtrialPE_early(n,:) postRPtrial_Mu_PE_early(n,:)] = dynamic_LR_reversal(outcome(1:n_trial_early),prediction(1:n_trial_early),empricial_mu(1:n_trial_early),output.cp(1:n_trial_early));
    [postRPtrialPE_late(n,:) postRPtrial_Mu_PE_late(n,:)] = dynamic_LR_reversal(outcome(end-n_trial_late+1:end),prediction(end-n_trial_late+1:end),empricial_mu(end-n_trial_late+1:end),output.cp(end-n_trial_late+1:end));
    [postRPtrialPE_late(n,:) postRPtrial_Mu_PE_late(n,:)] = dynamic_LR_reversal(outcome(50-n_trial_late+1:100),prediction(50-n_trial_late+1:100),empricial_mu(50-n_trial_late+1:100),output.cp(50-n_trial_late+1:100));
  
end




% Sequence Task:
 n_trial_early = 30;
  n_trial_late = 30;

n_trial_early = 30;
n_trial_late = 30;
task_type = 4;
[c_light, c_dark] =  get_color_shade(task_type);
[c_lighter, c_darker] =  get_color_shade(task_type+2);


p_model = 'model data final check/Sequence/';
p_humans = 'humans data final check/Sequence task/';


for n = 1:num_subs_human

    subID = n;
    saveFN = [p_humans,'sub',sprintf('%.0f',subID),'_',sprintf('%.0f',task_type),'.mat'];
    load(saveFN)

    outcome = output.outcome;
    prediction = output.prediction;

 
    means = unique(output.mu);
    empricial_mu = output.mu;

   
    [postSPtrialPE_early_humans(n,:), postSPtrial_Mu_PE_early_humans(n,:)] = dynamic_LR_Sequence(outcome(1:n_trial_early),prediction(1:n_trial_early),empricial_mu(1:n_trial_early));
    [postSPtrialPE_late_humans(n,:), postSPtrial_Mu_PE_late_humans(n,:)] = dynamic_LR_Sequence(outcome(end-n_trial_late+1:end),prediction(end-n_trial_late+1:end),empricial_mu(end-n_trial_late+1:end));

end


[r,p] = ttest2(postRPtrialPE_early_humans,postRPtrialPE_late_humans)
[r,p] = ttest2(postRPtrial_Mu_PE_early_humans,postRPtrial_Mu_PE_late_humans)


for n = 1:num_subs_model

    saveFN = [p_model,'/','sub',sprintf('%.0f',n),'_',sprintf('%.0f',task_type),'.mat'];
    load(saveFN)

    outcome = output.outcome;
    prediction = output.prediction;


    means = unique(output.mu);
    empricial_mu = output.mu;
    %empricial_mu(output.mu==means(1)) = mean(outcome(output.mu==means(1)));
    %empricial_mu(output.mu==means(2)) = mean(outcome(output.mu==means(2)));

    [postSPtrialPE_early_model(n,:) postSPtrial_Mu_PE_early_model(n,:)] = dynamic_LR_Sequence(outcome(1:n_trial_early),prediction(1:n_trial_early),empricial_mu(1:n_trial_early));
    [postSPtrialPE_late_model(n,:) postSPtrial_Mu_PE_late_model(n,:)] = dynamic_LR_Sequence(outcome(end-n_trial_late+1:end),prediction(end-n_trial_late+1:end),empricial_mu(end-n_trial_late+1:end));
   
end



fprintf('Reversal task beta 1 for humans, first 60 trials: Mean: %.2f, SEM: %.2f\n', ...
        mean(postRPtrialPE_early_humans), std(postRPtrialPE_early_humans)./sqrt(length(postRPtrialPE_early_humans)))

fprintf('Reversal task beta 1 for humans, last 60 trials: Mean: %.2f, SEM: %.2f\n', ...
        mean(postRPtrialPE_late_humans), std(postRPtrialPE_late_humans)./sqrt(length(postRPtrialPE_late_humans)))

fprintf('Reversal task beta 2 for humans, first 60 trials: Mean: %.2f, SEM: %.2f\n', ...
        mean(postRPtrial_Mu_PE_early_humans), std(postRPtrial_Mu_PE_early_humans)./sqrt(length(postRPtrial_Mu_PE_early_humans)))

fprintf('Reversal task beta 2 for humans, last 60 trials: Mean: %.2f, SEM: %.2f\n', ...
        mean(postRPtrial_Mu_PE_late_humans), std(postRPtrial_Mu_PE_late_humans)./sqrt(length(postRPtrial_Mu_PE_late_humans)))



fprintf('Seqence task beta 1 for humans, first 60 trials: Mean: %.2f, SEM: %.2f\n', ...
        mean(postSPtrialPE_early_humans), std(postSPtrialPE_early_humans)./sqrt(length(postSPtrialPE_early_humans)))

fprintf('Seqence task beta 1 for humans, last 60 trials: Mean: %.2f, SEM: %.2f\n', ...
        mean(postSPtrialPE_late_humans), std(postSPtrialPE_late_humans)./sqrt(length(postSPtrialPE_late_humans)))

fprintf('Seqence task beta 2 for humans, first 60 trials: Mean: %.2f, SEM: %.2f\n', ...
        mean(postSPtrial_Mu_PE_early_humans), std(postSPtrial_Mu_PE_early_humans)./sqrt(length(postSPtrial_Mu_PE_early_humans)))

fprintf('Seqence task beta 2 for humans, last 60 trials: Mean: %.2f, SEM: %.2f\n', ...
        mean(postSPtrial_Mu_PE_late_humans), std(postSPtrial_Mu_PE_late_humans)./sqrt(length(postSPtrial_Mu_PE_late_humans)))

% Model

fprintf('Reversal task beta 1 for model, first 60 trials: Mean: %.2f, SEM: %.2f\n', ...
        mean(postRPtrialPE_early), std(postRPtrialPE_early)./sqrt(length(postRPtrialPE_early)))

fprintf('Reversal task beta 1 for model, last 60 trials: Mean: %.2f, SEM: %.2f\n', ...
        mean(postRPtrialPE_late), std(postRPtrialPE_late)./sqrt(length(postRPtrialPE_late)))

fprintf('Reversal task beta 2 for model, first 60 trials: Mean: %.2f, SEM: %.2f\n', ...
        mean(postRPtrial_Mu_PE_early), std(postRPtrial_Mu_PE_early)./sqrt(length(postRPtrial_Mu_PE_early)))

fprintf('Reversal task beta 2 for model, last 60 trials: Mean: %.2f, SEM: %.2f\n', ...
        mean(postRPtrial_Mu_PE_late), std(postRPtrial_Mu_PE_late)./sqrt(length(postRPtrial_Mu_PE_late)))



fprintf('Seqence task beta 1 for model, first 60 trials: Mean: %.2f, SEM: %.2f\n', ...
        mean(postSPtrialPE_early_model), std(postSPtrialPE_early_model)./sqrt(length(postSPtrialPE_early_model)))

fprintf('Seqence task beta 1 for model, last 60 trials: Mean: %.2f, SEM: %.2f\n', ...
        mean(postSPtrialPE_late_model), std(postSPtrialPE_late_model)./sqrt(length(postSPtrialPE_late_model)))

fprintf('Seqence task beta 2 for model, first 60 trials: Mean: %.2f, SEM: %.2f\n', ...
        mean(postSPtrial_Mu_PE_early_model), std(postSPtrial_Mu_PE_early_model)./sqrt(length(postSPtrial_Mu_PE_early_model)))

fprintf('Seqence task beta 2 for model, last 60 trials: Mean: %.2f, SEM: %.2f\n', ...
        mean(postSPtrial_Mu_PE_late_model), std(postSPtrial_Mu_PE_late_model)./sqrt(length(postSPtrial_Mu_PE_late_model)))

