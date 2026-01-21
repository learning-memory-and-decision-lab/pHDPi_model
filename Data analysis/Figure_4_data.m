

p = 'Model Data/';
sub_model = 40;
num_trials = 200;
task_names = {'Changepoint' 'Oddball' 'Reversal' 'Sequence'};

task_1_gamma = nan(sub_model,num_trials);
task_1_alpha = nan(sub_model,num_trials);
task_1_eta = nan(sub_model,num_trials);
task_1_dv = nan(sub_model,num_trials);
task_1_std = nan(sub_model,num_trials);

task_2_gamma = nan(sub_model,num_trials);
task_2_alpha = nan(sub_model,num_trials);
task_2_eta = nan(sub_model,num_trials);
task_2_dv = nan(sub_model,num_trials);
task_2_std = nan(sub_model,num_trials);


task_3_gamma = nan(sub_model,num_trials);
task_3_alpha = nan(sub_model,num_trials);
task_3_eta = nan(sub_model,num_trials);
task_3_dv = nan(sub_model,num_trials);
task_3_std = nan(sub_model,num_trials);


task_4_gamma = nan(sub_model,num_trials);
task_4_alpha = nan(sub_model,num_trials);
task_4_eta = nan(sub_model,num_trials);
task_4_dv = nan(sub_model,num_trials);
task_4_std = nan(sub_model,num_trials);



% Model
for n = 1:sub_model

    saveFN = [p,'/sub',sprintf('%.0f',n),'_',sprintf('%.0f',1),'.mat'];
    load(saveFN)


    task_1_gamma(n,1:length(output.mle_gamma)) = output.mle_gamma;
    task_1_alpha(n,1:length(output.mle_alpha)) = output.mle_alpha;
    task_1_eta(n,1:length(output.mle_eta)) = output.mle_eta;
    task_1_dv(n,1:length(output.mle_dv)) = output.mle_dv;
    task_1_std(n,1:length(output.mle_std)) = output.mle_std;

    saveFN = [p,'/sub',sprintf('%.0f',n),'_',sprintf('%.0f',2),'.mat'];
    load(saveFN)

    task_2_gamma(n,1:length(output.mle_gamma)) = output.mle_gamma;
    task_2_alpha(n,1:length(output.mle_alpha)) = output.mle_alpha;
    task_2_eta(n,1:length(output.mle_eta)) = output.mle_eta;
    task_2_dv(n,1:length(output.mle_dv)) = output.mle_dv;
    task_2_std(n,1:length(output.mle_std)) = output.mle_std;

    saveFN = [p,'/sub',sprintf('%.0f',n),'_',sprintf('%.0f',3),'.mat'];
    load(saveFN)

    task_3_gamma(n,1:length(output.mle_gamma)) = output.mle_gamma;
    task_3_alpha(n,1:length(output.mle_alpha)) = output.mle_alpha;
    task_3_eta(n,1:length(output.mle_eta)) = output.mle_eta;
    task_3_dv(n,1:length(output.mle_dv)) = output.mle_dv;
    task_3_std(n,1:length(output.mle_std)) = output.mle_std;

    saveFN = [p,'/sub',sprintf('%.0f',n),'_',sprintf('%.0f',4),'.mat'];
    load(saveFN)

    task_4_gamma(n,1:length(output.mle_gamma)) = output.mle_gamma;
    task_4_alpha(n,1:length(output.mle_alpha)) = output.mle_alpha;
    task_4_eta(n,1:length(output.mle_eta)) = output.mle_eta;
    task_4_dv(n,1:length(output.mle_dv)) = output.mle_dv;
    task_4_std(n,1:length(output.mle_std)) = output.mle_std;


end

task_1_gamma(33,:) = [];
task_1_alpha(33,:) = [];
task_1_eta(33,:) = [];
task_1_dv(33,:) = [];
task_1_std(33,:) = [];

task_1_gamma(32,:) = [];
task_1_alpha(32,:) = [];
task_1_eta(32,:) = [];
task_1_dv(32,:) = [];
task_1_std(32,:) = [];


task_4_gamma(:,end) = [];
task_4_alpha(:,end) = [];
task_4_eta(:,end) = [];
task_4_dv(:,end) = [];
task_4_std(:,end) = [];


task_4_gamma(27,:) = [];
task_4_alpha(27,:) = [];
task_4_eta(27,:) = [];
task_4_dv(27,:) = [];
task_4_std(27,:) = [];


task_1_gamma_zc = zscore(task_1_gamma,0,2);
task_2_gamma_zc = zscore(task_2_gamma,0,2);
task_3_gamma_zc = zscore(task_3_gamma,0,2);
task_4_gamma_zc = zscore(task_4_gamma,0,2);

task_1_alpha_zc = zscore(task_1_alpha,0,2);
task_2_alpha_zc = zscore(task_2_alpha,0,2);
task_3_alpha_zc = zscore(task_3_alpha,0,2);
task_4_alpha_zc = zscore(task_4_alpha,0,2);

task_1_eta_zc = zscore(task_1_eta,0,2);
task_2_eta_zc = zscore(task_2_eta,0,2);
task_3_eta_zc = zscore(task_3_eta,0,2);
task_4_eta_zc = zscore(task_4_eta,0,2);

task_1_dv_zc = zscore(task_1_dv,0,2);
task_2_dv_zc = zscore(task_2_dv,0,2);
task_3_dv_zc = zscore(task_3_dv,0,2);
task_4_dv_zc = zscore(task_4_dv,0,2);

task_1_std_zc = zscore(task_1_std,0,2);
task_2_std_zc = zscore(task_2_std,0,2);
task_3_std_zc = zscore(task_3_std,0,2);
task_4_std_zc = zscore(task_4_std,0,2);


num = 38 + 40 + 40 + 39;

%% Original MDS:


mid_point = 200;

task_1_coord = [task_1_gamma_zc(:,mid_point) - task_1_gamma_zc(:,1), task_1_alpha_zc(:,mid_point)-task_1_alpha_zc(:,1), ...
    task_1_eta_zc(:,mid_point)-task_1_eta_zc(:,1), task_1_dv_zc(:,mid_point)-task_1_dv_zc(:,1), ...
    task_1_std_zc(:,mid_point)-task_1_std_zc(:,1)];

task_2_coord = [task_2_gamma_zc(:,mid_point)-task_2_gamma_zc(:,1), task_2_alpha_zc(:,mid_point)-task_2_alpha_zc(:,1), ...
    task_2_eta_zc(:,mid_point)-task_2_eta_zc(:,1), task_2_dv_zc(:,mid_point)-task_2_dv_zc(:,1), ...
    task_2_std_zc(:,mid_point)-task_2_std_zc(:,1)];

task_3_coord = [task_3_gamma_zc(:,mid_point)-task_3_gamma_zc(:,1), task_3_alpha_zc(:,mid_point)-task_3_alpha_zc(:,1), ...
    task_3_eta_zc(:,mid_point)-task_3_eta_zc(:,1), task_3_dv_zc(:,mid_point)-task_3_dv_zc(:,1), ...
    task_3_std_zc(:,mid_point)-task_3_std_zc(:,1)];

task_4_coord = [task_4_gamma_zc(:,mid_point)-task_4_gamma_zc(:,1), task_4_alpha_zc(:,mid_point)-task_4_alpha_zc(:,1), ...
    task_4_eta_zc(:,mid_point)-task_4_eta_zc(:,1), task_4_dv_zc(:,mid_point)-task_4_dv_zc(:,1), ...
    task_4_std_zc(:,mid_point)-task_4_std_zc(:,1)];

all_tasks = [task_1_coord;task_2_coord;task_3_coord;task_4_coord];


 
D = pdist(all_tasks); % Euclidean distances
D = squareform(D);

% Step 2: Apply classical MDS (metric)
[Y, eigvals] = cmdscale(D,2); % Y is n × m where m ≤ n


all_X = nan(num,200);
all_Y = nan(num,200);
k =2;

% Define group boundaries and labels
groups = {1:38, 39:78, 79:118, 119:157};
task_labels = {'Changepoint Task', 'Oddball Task', 'Reversal Task', 'Sequence Task'};
colors = lines(4); % Generates 4 distinct RGB colors
color = ['c','r','y','m'];





%% Parameters Distance:

% average distance
task_1_gamma_zc = zscore(task_1_gamma,0,2);
task_2_gamma_zc = zscore(task_2_gamma,0,2);
task_3_gamma_zc = zscore(task_3_gamma,0,2);
task_4_gamma_zc = zscore(task_4_gamma,0,2);

task_1_alpha_zc = zscore(task_1_alpha,0,2);
task_2_alpha_zc = zscore(task_2_alpha,0,2);
task_3_alpha_zc = zscore(task_3_alpha,0,2);
task_4_alpha_zc = zscore(task_4_alpha,0,2);

task_1_eta_zc = zscore(task_1_eta,0,2);
task_2_eta_zc = zscore(task_2_eta,0,2);
task_3_eta_zc = zscore(task_3_eta,0,2);
task_4_eta_zc = zscore(task_4_eta,0,2);

task_1_dv_zc = zscore(task_1_dv,0,2);
task_2_dv_zc = zscore(task_2_dv,0,2);
task_3_dv_zc = zscore(task_3_dv,0,2);
task_4_dv_zc = zscore(task_4_dv,0,2);

task_1_std_zc = zscore(task_1_std,0,2);
task_2_std_zc = zscore(task_2_std,0,2);
task_3_std_zc = zscore(task_3_std,0,2);
task_4_std_zc = zscore(task_4_std,0,2);

task_1_dist = sqrt((task_1_gamma_zc(:,end) - task_1_gamma_zc(:,1)).^2 + ((task_1_alpha_zc(:,end)) - (task_1_alpha_zc(:,1))).^2 + ...
    ((task_1_eta_zc(:,end)) - (task_1_eta_zc(:,1))).^2 + ((task_1_dv_zc(:,end)) - (task_1_dv_zc(:,1))).^2 +...
    ((task_1_std_zc(:,end)) - (task_1_std_zc(:,1))).^2);

task_2_dist = sqrt(((task_2_gamma_zc(:,end)) - (task_2_gamma_zc(:,1))).^2 + ((task_2_alpha_zc(:,end)) - (task_2_alpha_zc(:,1))).^2 + ...
    ((task_2_eta_zc(:,end)) - (task_2_eta_zc(:,1))).^2 + ((task_2_dv_zc(:,end)) - (task_2_dv_zc(:,1))).^2 +...
    ((task_2_std_zc(:,end)) - (task_2_std_zc(:,1))).^2);


task_3_dist = sqrt(((task_3_gamma_zc(:,end)) - (task_3_gamma_zc(:,1))).^2 + ((task_3_alpha_zc(:,end)) - (task_3_alpha_zc(:,1))).^2 + ...
    ((task_3_eta_zc(:,end)) - (task_3_eta_zc(:,1))).^2 + ((task_3_dv_zc(:,end)) - (task_3_dv_zc(:,1))).^2 +...
    ((task_3_std_zc(:,end)) - (task_3_std_zc(:,1))).^2);

task_4_dist = sqrt(((task_4_gamma_zc(:,end)) - (task_4_gamma_zc(:,1))).^2 + ((task_4_alpha_zc(:,end)) - (task_4_alpha_zc(:,1))).^2 + ...
    ((task_4_eta_zc(:,end)) - (task_4_eta_zc(:,1))).^2 + ((task_4_dv_zc(:,end)) - (task_4_dv_zc(:,1))).^2 +...
    ((task_4_std_zc(:,end)) - (task_4_std_zc(:,1))).^2);


% Plot
task_labels = ["Changepoint Model","Oddball Model","Reversal Model" "Sequence Model"];
num_models = length(task_labels);
y1 = median(task_1_dist);
y2 = median(task_2_dist);
y3 = median(task_3_dist);
y4 = median(task_4_dist);
x1= 1:num_models;
e1 = std(task_1_dist)./sqrt(length(task_1_dist));
e2 = std(task_2_dist)./sqrt(length(task_2_dist));
e3 = std(task_3_dist)./sqrt(length(task_3_dist));
e4 = std(task_4_dist)./sqrt(length(task_4_dist));


% STAT
% std(task_1_dist)./sqrt(length(task_1_dist))
% std([task_3_dist;task_4_dist;task_2_dist])./sqrt(length([task_3_dist;task_4_dist;task_2_dist]))

% % median(task_1_dist)
% median([task_3_dist;task_4_dist;task_2_dist])
% [r,p] = ttest2(task_1_dist,[task_3_dist;task_4_dist;task_2_dist])


% Predictors:
X_data(:,1) = [task_1_gamma(:,end);task_2_gamma(:,end);task_3_gamma(:,end);task_4_gamma(:,end)];
X_data(:,2) = [task_1_alpha(:,end);task_2_alpha(:,end);task_3_alpha(:,end);task_4_alpha(:,end)];
X_data(:,3) = [task_1_eta(:,end);task_2_eta(:,end);task_3_eta(:,end);task_4_eta(:,end)];
X_data(:,4) = [task_1_dv(:,end);task_2_dv(:,end);task_3_dv(:,end);task_4_dv(:,end)];
X_data(:,5) = [task_1_std(:,end);task_2_std(:,end);task_3_std(:,end);task_4_std(:,end)];

% labels:
num = 38 + 40 + 40 + 39;

labels = [ones(38,1);2 .*ones(40,1);3.*ones(40,1);4.*ones(39,1)];

% changepoint task vs all
Y_data = double(labels ==1);
n_bootstrap = 100;
accuracy_1 = nan(n_bootstrap,1);
for i =1:n_bootstrap
    sel = randi(length(Y_data),length(Y_data),1);
    sel_x = X_data(sel,:);
    sel_y = Y_data(sel,:);
    Mdl = fitcsvm(X_data,Y_data);
    CVSVMModel = crossval(Mdl);
    accuracy_1(i,1) = 1-kfoldLoss(CVSVMModel,'Mode','average');
end


% oddball task vs all
Y_data = double(labels ==2);
n_bootstrap = 100;
accuracy_2 = nan(n_bootstrap,1);
for i =1:n_bootstrap
    sel = randi(length(Y_data),length(Y_data),1);
    sel_x = X_data(sel,:);
    sel_y = Y_data(sel,:);
    Mdl = fitcsvm(X_data,Y_data);
    CVSVMModel = crossval(Mdl);
    accuracy_2(i,1) = 1-kfoldLoss(CVSVMModel,'Mode','average');
end


% reversal task vs all
Y_data = double(labels ==3);
n_bootstrap = 100;
accuracy_3 = nan(n_bootstrap,1);
for i =1:n_bootstrap
    sel = randi(length(Y_data),length(Y_data),1);
    sel_x = X_data(sel,:);
    sel_y = Y_data(sel,:);
    Mdl = fitcsvm(X_data,Y_data);
    CVSVMModel = crossval(Mdl);
    accuracy_3(i,1) = 1-kfoldLoss(CVSVMModel,'Mode','average');
end

% sequence task vs all
Y_data = double(labels ==4);
n_bootstrap = 100;
accuracy_4 = nan(n_bootstrap,1);
for i =1:n_bootstrap
    sel = randi(length(Y_data),length(Y_data),1);
    sel_x = X_data(sel,:);
    sel_y = Y_data(sel,:);
    Mdl = fitcsvm(X_data,Y_data);
    CVSVMModel = crossval(Mdl);
    accuracy_4(i,1) = 1-kfoldLoss(CVSVMModel,'Mode','average');
end


err_svm = [std(accuracy_1)./sqrt(n_bootstrap),std(accuracy_2)./sqrt(n_bootstrap),std(accuracy_3)./sqrt(n_bootstrap),nanstd(accuracy_4)./sqrt(n_bootstrap)];

Y_data = [mean(accuracy_1),mean(accuracy_2),mean(accuracy_3),nanmean(accuracy_4)];

% err_svm =
% 
%     0.0016    0.0005    0.0013    0.0003
% 
% Y_data =
% 
%     0.8632    0.9643    0.8956    0.9749


X_axis = 1:4;


