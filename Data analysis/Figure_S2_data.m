

task_names = {'Changepoint' 'Oddball' 'Reversal' 'Sequence'};

p_model = '/Users/niloufarrazmi/Brown Dropbox/Niloufar Razmi/2024/Projects/HDP/Paper/Code/Figure codes/final figure codes/model data final check/changepoint/';
p_humans = '/Users/niloufarrazmi/Brown Dropbox/Niloufar Razmi/2024/Projects/HDP/Paper/Code/Figure codes/final figure codes/humans data final check/Changepoint task/';

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


p_model = '/Users/niloufarrazmi/Brown Dropbox/Niloufar Razmi/2024/Projects/HDP/Paper/Code/Figure codes/final figure codes/model data final check/Oddball/';
p_humans = '/Users/niloufarrazmi/Brown Dropbox/Niloufar Razmi/2024/Projects/HDP/Paper/Code/Figure codes/final figure codes/humans data final check/Oddball task/';


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

p_model = '/Users/niloufarrazmi/Brown Dropbox/Niloufar Razmi/2024/Projects/HDP/Paper/Code/Figure codes/final figure codes/model data final check/Reversal/';
p_humans = '/Users/niloufarrazmi/Brown Dropbox/Niloufar Razmi/2024/Projects/HDP/Paper/Code/Figure codes/final figure codes/humans data final check/Reversal task/';


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


p_model = '/Users/niloufarrazmi/Brown Dropbox/Niloufar Razmi/2024/Projects/HDP/Paper/Code/Figure codes/final figure codes/model data final check/Sequence/';
p_humans = '/Users/niloufarrazmi/Brown Dropbox/Niloufar Razmi/2024/Projects/HDP/Paper/Code/Figure codes/final figure codes/humans data final check/Sequence task/';


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


diff_norm_SSE_humans_1 = (norm_SSE_humans_1(~late_phase))-(norm_SSE_humans_1(late_phase));
diff_norm_SSE_humans_2 = (norm_SSE_humans_2(~late_phase))-(norm_SSE_humans_2(late_phase));
diff_norm_SSE_humans_3 = (norm_SSE_humans_3(~late_phase))-(norm_SSE_humans_3(late_phase));
diff_norm_SSE_humans_4 = (norm_SSE_humans_4(~late_phase))-(norm_SSE_humans_4(late_phase));


subplot(2,2,1)
hold on
histogram(diff_norm_SSE_humans_1)
xline(-3,'--r','LineWidth',2)
title('Changepoint Task')

subplot(2,2,2)
hold on
histogram(diff_norm_SSE_humans_2)
xline(-3,'--r','LineWidth',2)
title('Oddball Task')

subplot(2,2,3)
hold on
histogram(diff_norm_SSE_humans_3)
xline(-3,'--r','LineWidth',2)
title('Reversal Task')

subplot(2,2,4)
hold on
histogram(diff_norm_SSE_humans_4)
xline(-3,'--r','LineWidth',2)
title('Sequence Task')

% Humans

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
