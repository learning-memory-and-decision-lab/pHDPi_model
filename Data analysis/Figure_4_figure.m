
num        = 1;  
wid        = 17.6; % total width
hts        = [6, 6]; % height of each row
cols       = {3,3}; % NUMBER of columns... or relative horizontal space dedicated to each of multiple columns within a row.

[axs,fig_] = getPLOT_axes(num, wid, hts, cols, [4], [2], 12, ''); % etc
set(axs,'Units','normalized');

lw=1.5;
lw2=3;
exSub=12;
ms=10;


for xx = 1:length(axs)
    axes(axs(xx)); hold on; cla(gca)
    if xx==1


for i=1:200
    mid_point = i;
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

    all_tasks_mid = [task_1_coord;task_2_coord;task_3_coord;task_4_coord];


    % Step 3.1: Compute distances from new points to original points
    D_new = pdist2(all_tasks_mid, all_tasks); % m × n matrix

    % Step 3.2: Center the original distance matrix
    n = size(all_tasks,1);
    H = eye(n) - ones(n)/n;
    B = -0.5 * H * D.^2 * H; % Gram matrix from original D

    % Step 3.3: Eigen decomposition from classical MDS
    [U, S] = eig(B);
    [eigvals_sorted, idx] = sort(diag(S), 'descend');
    U = U(:,idx(1:k));
    Lambda = diag(eigvals_sorted(1:k)); % Top-k eigenvalues

    % Step 3.4: Embed new points
    G = -0.5 * (D_new.^2 - mean(D_new.^2, 2) - mean(D.^2) + mean(D(:).^2));
    Y_new = G * U * inv(sqrt(Lambda)); % m × k matrix

    all_X(:,i) = Y_new(:, 1);
    all_Y(:,i) = Y_new(:, 1);

    hold on; % Hold on to plot multiple groups
    for j = 1:length(groups)
        scatter(mean(Y_new(groups{j}, 1)), mean(Y_new(groups{j}, 2)), 50, colors(j, :).*(i*0.0025+0.5), 'filled', 'DisplayName', task_names{j});


        if i ==200
        X = Y_new(groups{j},:);

        error_ellipse(X,color(j))


         end
    end

end
xlabel('Dimension 1');
ylabel('Dimension 2');


    elseif xx==2
hold on
data = [y1(end) y2(end) y3(end) y4(end)]';
err = [e1(end) e2(end) e3(end) e4(end)];
bar(task_labels,data) 
hold on
er = errorbar(x1,data,err);    
er.Color = [0 0 0];                            
er.LineStyle = 'none'; 
ylabel('Euclidean Distance')
title(["Distance", "from Origin"])
hold off



    elseif xx==3

bar(Y_data)
hold on
er = errorbar(X_axis,Y_data,err_svm);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off

ylabel('Out-of-Sample Accuracy')
title(["Generalization Rate", "of SVM Classfier "])
xticks(1:4)
xticklabels(task_names)
ylim([0.5 1])


    elseif xx==4

% labels = {'Changepoint Task', 'Oddball Task', 'Reversal Task', 'Sequence Task'};
% colors = lines(4); % Generates 4 distinct RGB colors
% matrices = {task_1_gamma, task_2_gamma, task_3_gamma, task_4_gamma};
% num_subj = 40;
% 
% 
hold on;

% % Iterate over the matrices to compute mean, std, and plot
%     data = task_1_gamma;
% 
%     % Compute mean and std across subjects (rows)
%     meanData = mean(data, 1); % Mean across trials
%     stdData = std(data, 0, 1)/sqrt(num_subj); % Standard deviation across trials
% 
%     % Define x-axis (trials)
%     x = 1:size(data, 2);
% 
%     curve1 = meanData + stdData;
%     curve2 = meanData - stdData;
%     x2 = [x, fliplr(x)];
%     inBetween = [curve1, fliplr(curve2)];
%     p = fill(x2, inBetween, colorpalette('lightred'));
% 
%       plot(x,meanData,'color',colorpalette('darkred'),'LineWidth',1.5)
% 


% Customize the plot
xlabel('Trial');
ylabel('MLE \gamma');
title(["Global Transition", "Parameter"])
hold off;



    elseif xx==5
% 
% labels = {'Changepoint Task', 'Oddball Task', 'Reversal Task', 'Sequence Task'};
% colors = lines(4); % Generates 4 distinct RGB colors
% matrices = {task_1_alpha, task_2_alpha, task_3_alpha, task_4_alpha};
% num_subj = 40;
% 
% hold on;
% 
% % Iterate over the matrices to compute mean, std, and plot
% for i = 1:length(matrices)
%     data = matrices{i};
% 
%     % Compute mean and std across subjects (rows)
%     meanData = mean(data, 1); % Mean across trials
%     stdData = std(data, 0, 1)/sqrt(num_subj); % Standard deviation across trials
% 
%     % Define x-axis (trials)
%     x = 1:size(data, 2);
% 
%     % Plot the shaded area for std
%     h = fill([x, fliplr(x)], [meanData + stdData, fliplr(meanData - stdData)], ...
%          colors(i, :), 'FaceAlpha', 0.2, 'EdgeColor', 'none');
% 
%     h.Annotation.LegendInformation.IconDisplayStyle = 'off';
% 
%     % Plot the mean line
%     plot(x, meanData, 'Color', colors(i, :), 'LineWidth', 2);
% end
% 
% % Customize the plot
xlabel('Trial');
ylabel('MLE \alpha');
title(["Local Transition", "Parameter"])
hold off;


    elseif xx==6
% 
labels = {'Changepoint Task', 'Oddball Task', 'Reversal Task', 'Sequence Task'};
colors = lines(4); % Generates 4 distinct RGB colors
matrices = {task_1_eta, task_2_eta, task_3_eta, task_4_eta};
num_subj = 40;

hold on;
% 
% Iterate over the matrices to compute mean, std, and plot
for i = 1:length(matrices)
    data = matrices{i};

    % Compute mean and std across subjects (rows)
    meanData = mean(data, 1); % Mean across trials
    stdData = std(data, 0, 1)/sqrt(num_subj); % Standard deviation across trials

    % Define x-axis (trials)
    x = 1:size(data, 2);

    % % Plot the shaded area for std
    % h = fill([x, fliplr(x)], [meanData + stdData, fliplr(meanData - stdData)], ...
    %      colors(i, :), 'FaceAlpha', 0.2, 'EdgeColor', 'none');
    % 
    % h.Annotation.LegendInformation.IconDisplayStyle = 'off';

    % Plot the mean line
    plot(x, meanData, 'Color', colors(i, :), 'LineWidth', 2);
end
% 
% Customize the plot
xlabel('Trial');
title('Persistance')
ylabel('MLE \eta');
legend(labels, 'Location', 'Best');
hold off;



    end

    setPLOT_panelLabel(gca, xx);
end

  kk=annotation('textbox');
  set(kk, 'string', 'Razmi et al 2025 Figure 4', 'position', [0.85 0.95 0.15 0.05], 'EdgeColor', 'none')

% 
% %
saveas(gcf,  'figure4.fig', 'fig')
saveas(gcf,  'figure4.eps', 'epsc2')
%close(gcf)