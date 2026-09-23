
num        = 1;  % Figure number -- just used for label.
wid        = 17.6; % total width
hts        = [6, 6]; % height of each row
cols       = {[0.5 0.25 0.25],[0.5 0.25 0.25]}; % NUMBER of columns... or relative horizontal space dedicated to each of multiple columns within a row.

[axs,fig_] = getPLOT_axes(num, wid, hts, cols, [3], [1.5], 12, ''); % etc
set(axs,'Units','normalized');
% draw in each panel, one at a time

lw=1.5;
lw2=3;
exSub=12;
ms=10;


for xx = 1:length(axs)
    axes(axs(xx)); hold on; cla(gca)
    if xx==1


        num_subj = 32;

        hold on;
        data = task_1_gamma;
        % Compute mean and std across subjects (rows)
        meanData = mean(data, 1); % Mean across trials
        stdData = std(data, 0, 1)/sqrt(num_subj); % Standard deviation across trials

        % Define x-axis (trials)
        x = 1:size(data, 2);
        curve1 = meanData + stdData;
        curve2 = meanData - stdData;
        x2 = [x, fliplr(x)];
        inBetween = [curve1, fliplr(curve2)];
        p=fill(x2, inBetween, colorpalette('lightblue'));

        p.EdgeColor='none';
        plot(x,meanData,'color',colorpalette('darkblue'),'LineWidth',1.5)

        data = task_2_gamma;
        % Compute mean and std across subjects (rows)
        meanData = mean(data, 1); % Mean across trials
        stdData = std(data, 0, 1)/sqrt(num_subj); % Standard deviation across trials

        % Define x-axis (trials)
        x = 1:size(data, 2);
        curve1 = meanData + stdData;
        curve2 = meanData - stdData;
        x2 = [x, fliplr(x)];
        inBetween = [curve1, fliplr(curve2)];
        p=fill(x2, inBetween, colorpalette('lightred'));

        p.EdgeColor='none';
        plot(x,meanData,'color',colorpalette('darkred'),'LineWidth',1.5)
        xline(200,'--k')

        % Customize the plot
        xlabel('Trial');
        ylabel('MLE \gamma');
        %title('Global Transition Parameter')
        %legend(labels, 'Location', 'Best');
        hold off;



    elseif xx==2


        hold on;


        num_subj = 32;
        data = task_1_alpha;
        % Compute mean and std across subjects (rows)
        meanData = mean(data, 1); % Mean across trials
        stdData = std(data, 0, 1)/sqrt(num_subj); % Standard deviation across trials

        % Define x-axis (trials)
        x = 1:size(data, 2);
        curve1 = meanData + stdData;
        curve2 = meanData - stdData;
        x2 = [x, fliplr(x)];
        inBetween = [curve1, fliplr(curve2)];
        p=fill(x2, inBetween, colorpalette('lightblue'));

        p.EdgeColor='none';
        plot(x,meanData,'color',colorpalette('darkblue'),'LineWidth',1.5)

        data = task_2_alpha;
        % Compute mean and std across subjects (rows)
        meanData = mean(data, 1); % Mean across trials
        stdData = std(data, 0, 1)/sqrt(num_subj); % Standard deviation across trials

        % Define x-axis (trials)
        x = 1:size(data, 2);
        curve1 = meanData + stdData;
        curve2 = meanData - stdData;
        x2 = [x, fliplr(x)];
        inBetween = [curve1, fliplr(curve2)];
        p=fill(x2, inBetween, colorpalette('lightred'));

        p.EdgeColor='none';
        plot(x,meanData,'color',colorpalette('darkred'),'LineWidth',1.5)
        xline(200,'--k')


        xlabel('Trial');
        ylabel('MLE \alpha');
        %title('Local Transition Parameter')
        %legend(labels, 'Location', 'Best');
        hold off;



    elseif xx==3



        hold on;

        num_subj = 32;
        data = task_1_eta;
        % Compute mean and std across subjects (rows)
        meanData = mean(data, 1); % Mean across trials
        stdData = std(data, 0, 1)/sqrt(num_subj); % Standard deviation across trials

        % Define x-axis (trials)
        x = 1:size(data, 2);
        curve1 = meanData + stdData;
        curve2 = meanData - stdData;
        x2 = [x, fliplr(x)];
        inBetween = [curve1, fliplr(curve2)];
        p=fill(x2, inBetween, colorpalette('lightblue'));

        p.EdgeColor='none';
        plot(x,meanData,'color',colorpalette('darkblue'),'LineWidth',1.5)

        data = task_2_eta;
        % Compute mean and std across subjects (rows)
        meanData = mean(data, 1); % Mean across trials
        stdData = std(data, 0, 1)/sqrt(num_subj); % Standard deviation across trials

        % Define x-axis (trials)
        x = 1:size(data, 2);
        curve1 = meanData + stdData;
        curve2 = meanData - stdData;
        x2 = [x, fliplr(x)];
        inBetween = [curve1, fliplr(curve2)];
        p=fill(x2, inBetween, colorpalette('lightred'));

        p.EdgeColor='none';
        plot(x,meanData,'color',colorpalette('darkred'),'LineWidth',1.5)
        xline(200,'--k')


        % Customize the plot
        xlabel('Trial');
        ylabel('MLE \gamma');
        %title('Global Transition Parameter')
        %legend(labels, 'Location', 'Best');
        hold off;

        % Customize the plot
        xlabel('Trial');
        %title('Persistance')
        ylabel('MLE \eta');
        %legend(labels, 'Location', 'Best');
        hold off;

    elseif xx==4



        conv_pre_all_trial_lr_model = all_LR_1;
        conv_post_all_trial_lr_model = all_LR_2;



        k=20;
        hold on
        y1 = smooth(nanmedian(conv_pre_all_trial_lr_model(test_id==2,1:k)),5)';
        y2 = smooth(nanmedian(conv_pre_all_trial_lr_model(test_id==1,1:k)),5)';
        x1 = 1:k;

        std_dev_1 = nanstd(conv_pre_all_trial_lr_model(test_id==2,1:k))./sqrt(sum(test_id==2));
        x = 1: length(y1);
        curve1 = y1 + std_dev_1;
        curve2 = y1 - std_dev_1;
        x2 = [x, fliplr(x)];
        inBetween = [curve1, fliplr(curve2)];
        p=fill(x2, inBetween, colorpalette('lightblue'));
        p.EdgeColor='none';

        std_dev_2 = nanstd(conv_pre_all_trial_lr_model(test_id==1,1:k))./sqrt(sum(test_id==1));
        x = 1: length(y2);
        curve1 = y2 + std_dev_2;
        curve2 = y2 - std_dev_2;
        x3 = [x, fliplr(x)];
        inBetween = [curve1, fliplr(curve2)];
        p = fill(x3, inBetween,colorpalette('lightred'));
        p.EdgeColor='none';
        plot(x1,y1,'color',colorpalette('darkblue'),'LineWidth',1.5)
        plot(x1,y2,'color',colorpalette('darkred'),'LineWidth',1.5)
        yline(0,'--k')
        yline(1,'--k')

        kk = 20;

        hold on
        y3 = smooth(nanmedian(conv_post_all_trial_lr_model(test_id==2,1:kk)),5)';
        y4 = smooth(nanmedian(conv_post_all_trial_lr_model(test_id==1,1:kk)),5)';
        x =  k+1:k+kk;

        std_dev_1 = nanstd(conv_post_all_trial_lr_model(test_id==1,1:kk))./sqrt(sum(test_id==1));
        curve1 = y4 + std_dev_1;
        curve2 = y4 - std_dev_1;
        x2 = [x, fliplr(x)];
        inBetween = [curve1, fliplr(curve2)];
        p = fill(x2, inBetween, colorpalette('lightblue'));
        p.EdgeColor='none';
        plot(x,y4,'color',colorpalette('darkblue'),'LineWidth',1.5)

        std_dev_1 = nanstd(conv_post_all_trial_lr_model(test_id==2,1:kk))./sqrt(sum(test_id==2));
        curve1 = y3 + std_dev_1;
        curve2 = y3 - std_dev_1;
        x2 = [x, fliplr(x)];
        inBetween = [curve1, fliplr(curve2)];
        p=fill(x2, inBetween, colorpalette('lightred'));
        p.EdgeColor ='none';
        plot(x,y3,'color',colorpalette('darkred'),'LineWidth',1.5)


        ylabel('Learning Rate')
        xlabel('number of extreme events')
        xlim([0 k+kk])
        xticks([0 10 20 30 40])
        xticklabels([0 10 0 10 20])
        xline(20,'--k')
        yline(0,'--k')
        yline(1,'--k')
        ylim([-0.5 1.2])

    elseif xx==5
        hold on
        % jitter_ind = 0.2;
        x = ["Pre-reversal","Post-reversal"];
        % x1 = 1+rand(length(final_lr_pre_model(test_id==2)),1)*jitter_ind;
        % x2 = 2+rand(length(final_lr_post_model(test_id==2)),1)*jitter_ind;

        xMargin = 0.05;
        yMargin = 0.05;
        yData = median_lr_pre_model(test_id==2);
        x1 = 1 + smartJitter(yData,xMargin,yMargin);

        yData = median_lr_post_model(test_id==2);
        x2 = 2 + smartJitter(yData,xMargin,yMargin);

        plot(x1,median_lr_pre_model(test_id==2),'o','MarkerFaceColor',colorpalette('lightblue'),'MarkerEdgeColor',colorpalette('darkblue'),'MarkerSize',5,'LineWidth',1)
        plot(x2,median_lr_post_model(test_id==2),'o','MarkerFaceColor',colorpalette('lightred'),'MarkerEdgeColor',colorpalette('darkred'),'MarkerSize',5,'LineWidth',1)
        plot([1,2],[nanmean(median_lr_pre_model(test_id==2)),nanmean(median_lr_post_model(test_id==2))],'k','LineWidth',1.5)
        plot(1,nanmean(median_lr_pre_model(test_id==2)),'^','MarkerFaceColor',colorpalette('lightblue'),'MarkerEdgeColor','k','MarkerSize',10,'LineWidth',1.5)
        plot(2,nanmean(median_lr_post_model(test_id==2)),'^','MarkerFaceColor',colorpalette('lightred'),'MarkerEdgeColor','k','MarkerSize',10,'LineWidth',1.5)
        plot([0 3],[0.5,0.5],'--k')


        ylabel('Overall Median Learning Rate')
        title('CP -> OB ')
        ax = gca;
        xlim([0 3])
        xticks([1 2])
        ylim([-0.2 1.5])
        xticklabels(x)
        hold off

    elseif xx==6

        hold on
        % jitter_ind = 0.2;
        x = ["Pre-reversal","Post-reversal"];
        % x1 = 1+rand(length(final_lr_pre_model(test_id==2)),1)*jitter_ind;
        % x2 = 2+rand(length(final_lr_post_model(test_id==2)),1)*jitter_ind;

        xMargin = 0.05;
        yMargin = 0.05;
        yData = median_lr_pre_model(test_id==1);
        x1 = 1 + smartJitter(yData,xMargin,yMargin);

        yData = median_lr_post_model(test_id==1);
        x2 = 2 + smartJitter(yData,xMargin,yMargin);

        plot(x1,median_lr_pre_model(test_id==1),'o','MarkerFaceColor',colorpalette('lightred'),'MarkerEdgeColor',colorpalette('darkred'),'MarkerSize',5,'LineWidth',1)
        plot(x2,median_lr_post_model(test_id==1),'o','MarkerFaceColor',colorpalette('lightblue'),'MarkerEdgeColor',colorpalette('darkblue'),'MarkerSize',5,'LineWidth',1)
        plot([1,2],[nanmean(median_lr_pre_model(test_id==1)),nanmean(median_lr_post_model(test_id==1))],'k','LineWidth',1.5)
        plot(1,nanmean(median_lr_pre_model(test_id==1)),'^','MarkerFaceColor',colorpalette('lightred'),'MarkerEdgeColor','k','MarkerSize',10,'LineWidth',1.5)
        plot(2,nanmean(median_lr_post_model(test_id==1)),'^','MarkerFaceColor',colorpalette('lightblue'),'MarkerEdgeColor','k','MarkerSize',10,'LineWidth',1.5)
        plot([0 3],[0.5,0.5],'--k')


        ylabel('Overall Median Learning Rate')
        title('OB -> CP ')
        ax = gca;
        xlim([0 3])
        xticks([1 2])
        ylim([-0.2 1.5])
        xticklabels(x)
        hold off

    end

    setPLOT_panelLabel(gca, xx);
end

kk=annotation('textbox');
set(kk, 'string', 'Razmi et al 2025 Figure 6', 'position', [0.85 0.95 0.15 0.05], 'EdgeColor', 'none')

%
% %
% saveas(gcf,  'figure6.fig', 'fig')
% saveas(gcf,  'figure6.eps', 'epsc2')
%close(gcf)

