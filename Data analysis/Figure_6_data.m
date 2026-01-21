    
myDir = 'BakstSimulation/'; %gets directory
myFiles = dir(fullfile(myDir,'*.mat')); %gets all wav files in struct
trialOutcome = zeros(length(myFiles),400);
belief = zeros(length(myFiles),400);
test_id = zeros(length(myFiles),1);
train_id = zeros(length(myFiles),1);
model_cp = zeros(length(myFiles),400);
num_sub = length(myFiles)/2;

for i = 1:length(myFiles)
     baseFileName = myFiles(i).name;
    fullFileName = fullfile(myDir, baseFileName);


    load(fullFileName)


    trialOutcome(i,:) = output.outcome;
    belief(i,:) = output.prediction;
    model_cp(i,:) = output.cp;

    if contains(baseFileName,'_1_2')
          test_id(i) = 2;
    else
          test_id(i) = 1;
    end
end

trial_LR = nan(length(myFiles),400);
trial_LR(:,1:end-1) = (belief(:,2:end) - belief(:,1:end-1))./(trialOutcome(:,1:end-1) - belief(:,1:end-1));

k = 20; % number of changepoints
kk = 25;

pre_switch_early = nan(length(myFiles),kk);
pre_switch_late = nan(length(myFiles),kk);
post_switch_early = nan(length(myFiles),kk);
post_switch_late = nan(length(myFiles),kk);

cp_trial_1 = zeros(length(myFiles),30);
cp_trial_2 = zeros(length(myFiles),30);
all_LR_1 = nan(length(myFiles),k);
all_LR_2 = nan(length(myFiles),kk);

switch_index = 200;
twin = 50;

% Find cps
for i=1:length(myFiles)

        cp = find(model_cp(i,1:switch_index)==1,k);
        all_cp = find(model_cp(i,1:switch_index)==1);
        cp_trial_1(i,1:length(all_cp)) = all_cp;
        all_LR_1(i,1:length(cp)) = trial_LR(i,cp);

        cp = find(model_cp(i,switch_index+1:end)==1,kk) + switch_index;
        all_cp = find(model_cp(i,switch_index+1:end)==1) + switch_index;
        cp_trial_2(i,1:length(all_cp)) = all_cp;
        all_LR_2(i,1:length(cp)) = trial_LR(i,cp);

end

all_LR_1(isoutlier(all_LR_1,'quartiles')) =nan;
all_LR_2(isoutlier(all_LR_2,'quartiles')) =nan;

pre_lr_sel = cp_trial_1;
post_lr_sel =cp_trial_2;

pre_lr_sel(isoutlier(all_LR_1,'quartiles')) = nan;
post_lr_sel(isoutlier(all_LR_2,'quartiles')) = nan;


for i=1:length(myFiles)  
        cp = find((model_cp(i,1:twin)==1),k);
        [val,~]=intersect(pre_lr_sel(i,:),cp);
        pre_switch_early(i,1:length(val)) = trial_LR(i,val);

        cp = find(model_cp(i,switch_index-twin+1:switch_index)==1,k) + 150;
        [val,~]=intersect(pre_lr_sel(i,:),cp);
        pre_switch_late(i,1:length(val)) = trial_LR(i,val);

        cp = find(model_cp(i,switch_index+1:switch_index+twin)==1,kk) + 200;
        [val,~]=intersect(post_lr_sel(i,:),cp);
        post_switch_early(i,1:length(val)) = trial_LR(i,val);

        cp = find(model_cp(i,end-twin+1:end)==1,kk) + 350;
        [val,~]=intersect(post_lr_sel(i,:),cp);
        post_switch_late(i,1:length(val)) = trial_LR(i,val);


         cp = find(model_cp(i,1:switch_index)==1);
        [val,~]=intersect(pre_lr_sel(i,:),cp);    
         median_lr_pre_model(i,:) = nanmedian(trial_LR(i,val));

        cp = find(model_cp(i,switch_index+1:end)==1)+200;
        [val,~]=intersect(post_lr_sel(i,:),cp);    
         median_lr_post_model(i,:) = nanmedian(trial_LR(i,val));

end





final_lr_pre_model = nanmedian(pre_switch_late,2);
pre_RW = sort(final_lr_pre_model(test_id ==1));

 nanmedian(pre_RW) +  iqr(pre_RW)/2
 nanmedian(pre_RW) -   iqr(pre_RW)/2

pre_CP = sort(final_lr_pre_model(test_id ==2));

 nanmedian(pre_CP) +  iqr(pre_CP)/2
 nanmedian(pre_CP) -   iqr(pre_CP)/2

final_lr_post_model = nanmedian(post_switch_late,2);

 post_CP = sort(final_lr_post_model(test_id ==1));

 nanmedian(post_CP) +  iqr(post_CP)/2
 nanmedian(post_CP) -   iqr(post_CP)/2


 post_RW = sort(final_lr_post_model(test_id ==2));

 nanmedian(post_RW) +  iqr(post_RW)/2
 nanmedian(post_RW) -   iqr(post_RW)/2

 nanmedian(final_lr_pre_model(test_id ==2))
 nanmedian(final_lr_post_model(test_id ==1))


 p = ranksum(pre_RW,post_RW)
 p = ranksum(pre_CP,post_CP)

  [r,p] = ttest2(pre_CP-post_CP,pre_RW-post_RW)

mean(pre_CP-post_CP)



bakst2023_task_2

