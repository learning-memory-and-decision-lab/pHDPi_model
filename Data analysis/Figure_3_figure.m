% makeFig1



% 1 column (maximum width 8.5 cm),
% 1.5 columns (maximum width 11.6 cm)
% 2 columns (maximum width 17.6 cm)


num        = 1;  % Figure number -- just used for label.
wid        = 17.6; % total width
hts        = [4, 4, 4]; % height of each row
cols       = {4,4,4}; % NUMBER of columns... or relative horizontal space dedicated to each of multiple columns within a row.
% cols Note... if you put a set of numbers that add to 1 in a cell, then the
% column will be split unevenly into columns according to the proportions
% specified.

% 5th and 6th inputs here define spacing between figures... which you may
% need to play with if you have really large labels.
[axs,fig_] = getPLOT_axes(num, wid, hts, cols, [], [], 12, ''); % etc
set(axs,'Units','normalized');
% draw in each panel, one at a time

lw=1.5;
lw2=3;
exSub=12;
ms=10;


for xx = 1:length(axs)
    axes(axs(xx)); hold on; cla(gca)
    if xx==1

        p = '/Users/niloufarrazmi/Brown Dropbox/Niloufar Razmi/2024/Projects/HDP/Paper/Code/may_8_data/';
        n_trials = 50;
        task_type = 1;
        subID = 1;
        saveFN = [p,'sub',sprintf('%.0f',subID),'_',sprintf('%.0f',task_type),'.mat'];
        load(saveFN)
        hold on
        imagesc(output.predDist(1:n_trials,:)')
        scatter(1:n_trials,output.outcome(1:n_trials),'MarkerFaceColor',colorpalette('darkred'),'MarkerEdgeColor','k')
        plot(output.prediction(1:n_trials),'k','LineWidth',1.5)
        xlabel('Trials')
        ylabel('Outcomes')
        clim([0 0.05])
        xlim([1 n_trials])
        yticks([0:60:300])
        yticklabels([0:20:100])
        ylim([0 300])
        set(gca, 'box', 'off')
        title(["Changepoint", "Task"])




    elseif xx==2

        task_type = 2;
        subID = 2;
        saveFN = [p,'sub',sprintf('%.0f',subID),'_',sprintf('%.0f',task_type),'.mat'];
        load(saveFN)
        hold on
        imagesc(output.predDist(1:n_trials,:)')
        scatter(1:n_trials,output.outcome(1:n_trials),'MarkerFaceColor',colorpalette('darkred'),'MarkerEdgeColor','k')
        plot(output.prediction(1:n_trials),'k','LineWidth',1.5)
        xlabel('Trials')
        ylabel('Outcomes')
        clim([0 0.05])
        xlim([1 n_trials])
        yticks([0:60:300])
        yticklabels([0:20:100])
        ylim([0 300])
        title(["Oddball", "Task"])

    elseif xx==3
        task_type = 3;
        subID = 6;
        saveFN = [p,'sub',sprintf('%.0f',subID),'_',sprintf('%.0f',task_type),'.mat'];
        load(saveFN)
        hold on
        imagesc(output.predDist(1:n_trials,:)')
        scatter(1:n_trials,output.outcome(1:n_trials),'MarkerFaceColor',colorpalette('darkred'),'MarkerEdgeColor','k')
        plot(output.prediction(1:n_trials),'k','LineWidth',1.5)
        xlabel('Trials')
        ylabel('Outcomes')
        clim([0 0.05])
        xlim([1 n_trials])
        yticks([0:60:300])
        yticklabels([0:20:100])
        ylim([0 300])

        title(["Reversal", "Task"])

    elseif xx==4
        task_type = 4;
        subID = 1;
        saveFN = [p,'sub',sprintf('%.0f',subID),'_',sprintf('%.0f',task_type),'.mat'];
        load(saveFN)
        hold on
        imagesc(output.predDist(1:seq_n_trials,:)')
        scatter(1:seq_n_trials,output.outcome(1:seq_n_trials),'MarkerFaceColor',colorpalette('darkred'),'MarkerEdgeColor','k')
        plot(output.prediction(1:seq_n_trials),'k','LineWidth',1.5)
        xlabel('Trials')
        ylabel('Outcomes')
        clim([0 0.05])
        xlim([1 seq_n_trials])
        yticks([0:60:300])
        yticklabels([0:20:100])
        ylim([0 300])
        title(["Sequence", "Task"])

    elseif xx==5

        task_type = 1;
        subID = 1;
        saveFN = [p,'sub',sprintf('%.0f',subID),'_',sprintf('%.0f',task_type),'.mat'];
        load(saveFN)
        hold on
        imagesc(output.predDist(end-n_trials+1:end,:)')
        scatter(1:n_trials,output.outcome(end-n_trials+1:end),'MarkerFaceColor',colorpalette('darkred'),'MarkerEdgeColor','k')
        plot(output.prediction(end-n_trials+1:end),'k','LineWidth',1.5)
        box off
        xlabel('Trials')
        ylabel('Outcomes')
        clim([0 0.05])
        xlim([1 n_trials])
        yticks([0:60:300])
        yticklabels([0:20:100])
        ylim([0 300])
    elseif xx==6


        task_type = 2;
        subID = 2;
        saveFN = [p,'sub',sprintf('%.0f',subID),'_',sprintf('%.0f',task_type),'.mat'];
        load(saveFN)
        hold on
        imagesc(output.predDist(end-n_trials+1:end,:)')
        scatter(1:n_trials,output.outcome(end-n_trials+1:end),'MarkerFaceColor',colorpalette('darkred'),'MarkerEdgeColor','k')
        plot(output.prediction(end-n_trials+1:end),'k','LineWidth',1.5)
        box off
        xlabel('Trials')
        ylabel('Outcomes')
        clim([0 0.05])
        xlim([1 n_trials])
        yticks([0:60:300])
        yticklabels([0:20:100])
        ylim([0 300])



    elseif xx==7



        task_type = 3;
        subID = 5;
        saveFN = [p,'sub',sprintf('%.0f',subID),'_',sprintf('%.0f',task_type),'.mat'];
        load(saveFN)
        hold on
        imagesc(output.predDist(end-n_trials+1:end,:)')
        scatter(1:n_trials,output.outcome(end-n_trials+1:end),'MarkerFaceColor',colorpalette('darkred'),'MarkerEdgeColor','k')
        plot(output.prediction(end-n_trials+1:end),'k','LineWidth',1.5)
        box off
        xlabel('Trials')
        ylabel('Outcomes')
        clim([0 0.05])
        xlim([1 n_trials])
        yticks([0:60:300])
        yticklabels([0:20:100])
        ylim([0 300])

    elseif xx==8

        task_type = 4;
        subID = 1;
        saveFN = [p,'sub',sprintf('%.0f',subID),'_',sprintf('%.0f',task_type),'.mat'];
        load(saveFN)
        hold on
        imagesc(output.predDist(end-seq_n_trials+1:end,:)')
        scatter(1:seq_n_trials,output.outcome(end-seq_n_trials+1:end),'MarkerFaceColor',colorpalette('darkred'),'MarkerEdgeColor','k')
        plot(output.prediction(end-seq_n_trials+1:end),'k','LineWidth',1.5)
        box off
        xlabel('Trials')
        ylabel('Outcomes')
        clim([0 0.05])
        xlim([1 seq_n_trials])
        yticks([0:60:300])
        yticklabels([0:20:100])
        ylim([0 300])
        colorbar

    elseif xx==9

        numSubs = size(log_SSE_model_rel_1,1);
        x = [ "Fixed LR = 1","Fixed LR = 0.1","Fixed LR = 0.5" "Oddball Model","Changepoint Model","pHDP Model"];
        y = [ mean((log_SSE_model_rel_1(:,3))) ,mean((log_SSE_model_rel_1(:,5))),mean((log_SSE_model_rel_1(:,4))), mean((log_SSE_model_rel_1(:,2))), mean((log_SSE_model_rel_1(:,1))),  mean((log_SSE_model_rel_1(:,6)))];
        subplot_1 = bar(x,y);
        errbar = [std((log_SSE_model_rel_1(:,3))) ,std((log_SSE_model_rel_1(:,5))),std((log_SSE_model_rel_1(:,4))), std((log_SSE_model_rel_1(:,2))), std((log_SSE_model_rel_1(:,1))),  std((log_SSE_model_rel_1(:,6)))];
        hold on
        er = errorbar(1:6,y,errbar./sqrt(numSubs));
        er.Color = [0 0 0];
        er.LineStyle = 'none';
        subplot_1.FaceColor = 'flat';
        subplot_1.CData(1,:) = [0.8500 0.3250 0.0980];
        subplot_1.CData(2,:) = [0.8500*0.5 0.3250*0.5 0.0980*0.5];
        subplot_1.CData(3,:) = [0.8500*0.2 0.3250*0.2 0.0980*0.2];
        subplot_1.CData(4,:) = [0.9290 0.6940 0.1250];
        subplot_1.CData(5,:) = [0 0.4470 0.7410];
        subplot_1.CData(6,:) = [0.4660 0.6740 0.1880];
        ylabel('\Delta Sum of Squared Error')


    elseif xx==10

        numSubs = size(log_SSE_model_rel_2,1);
        x = [ "Fixed LR = 1","Fixed LR = 0.1","Fixed LR = 0.5" "Oddball Model","Changepoint Model","pHDP Model"];
        y = [ mean((log_SSE_model_rel_2(:,3))) ,mean((log_SSE_model_rel_2(:,5))),mean((log_SSE_model_rel_2(:,4))), mean((log_SSE_model_rel_2(:,2))), mean((log_SSE_model_rel_2(:,1))),  mean((log_SSE_model_rel_2(:,6)))];
        subplot_2 = bar(x,y);
        errbar = [std((log_SSE_model_rel_2(:,3))) ,std((log_SSE_model_rel_2(:,5))),std((log_SSE_model_rel_2(:,4))), std((log_SSE_model_rel_2(:,2))), std((log_SSE_model_rel_2(:,1))),  std((log_SSE_model_rel_2(:,6)))];
        hold on
        er = errorbar(1:6,y,errbar./sqrt(numSubs));
        er.Color = [0 0 0];
        er.LineStyle = 'none';
        ax = gca;
        subplot_2.FaceColor = 'flat';
        subplot_2.CData(1,:) = [0.8500 0.3250 0.0980];
        subplot_2.CData(2,:) = [0.8500*0.5 0.3250*0.5 0.0980*0.5];
        subplot_2.CData(3,:) = [0.8500*0.2 0.3250*0.2 0.0980*0.2];
        subplot_2.CData(4,:) = [0.9290 0.6940 0.1250];
        subplot_2.CData(5,:) = [0 0.4470 0.7410];
        subplot_2.CData(6,:) = [0.4660 0.6740 0.1880];
        ylabel('\Delta Sum of Squared Error')

    elseif xx==11

        numSubs = size(log_SSE_model_rel_3,1);
        x = [ "Fixed LR = 1","Fixed LR = 0.1","Fixed LR = 0.5" "Oddball Model","Changepoint Model","pHDP Model"];
        y = [ mean((log_SSE_model_rel_3(:,3))) ,mean((log_SSE_model_rel_3(:,5))),mean((log_SSE_model_rel_3(:,4))), mean((log_SSE_model_rel_3(:,2))), mean((log_SSE_model_rel_3(:,1))),  mean((log_SSE_model_rel_3(:,6)))];
        subplot_3 = bar(x,y);
        errbar = [std((log_SSE_model_rel_3(:,3))) ,std((log_SSE_model_rel_3(:,5))),std((log_SSE_model_rel_3(:,4))), std((log_SSE_model_rel_3(:,2))), std((log_SSE_model_rel_3(:,1))),  std((log_SSE_model_rel_3(:,6)))];
        hold on
        er = errorbar(1:6,y,errbar./sqrt(numSubs));
        er.Color = [0 0 0];
        er.LineStyle = 'none';
        subplot_3.FaceColor = 'flat';
        subplot_3.CData(1,:) = [0.8500 0.3250 0.0980];
        subplot_3.CData(2,:) = [0.8500*0.5 0.3250*0.5 0.0980*0.5];
        subplot_3.CData(3,:) = [0.8500*0.2 0.3250*0.2 0.0980*0.2];
        subplot_3.CData(4,:) = [0.9290 0.6940 0.1250];
        subplot_3.CData(5,:) = [0 0.4470 0.7410];
        subplot_3.CData(6,:) = [0.4660 0.6740 0.1880];
        ylabel('\Delta Sum of Squared Error')

    elseif xx==12

        numSubs = size(log_SSE_model_rel_4,1);
        x = [ "Fixed LR = 1","Fixed LR = 0.1","Fixed LR = 0.5" "Oddball Model","Changepoint Model","pHDP Model"];
        y = [ mean((log_SSE_model_rel_4(:,3))) ,mean((log_SSE_model_rel_4(:,5))),mean((log_SSE_model_rel_4(:,4))), mean((log_SSE_model_rel_4(:,2))), mean((log_SSE_model_rel_4(:,1))),  mean((log_SSE_model_rel_4(:,6)))];
        subplot_4 = bar(x,y);
        errbar = [std((log_SSE_model_rel_4(:,3))) ,std((log_SSE_model_rel_4(:,5))),std((log_SSE_model_rel_4(:,4))), std((log_SSE_model_rel_4(:,2))), std((log_SSE_model_rel_4(:,1))),  std((log_SSE_model_rel_4(:,6)))];
        hold on
        er = errorbar(1:6,y,errbar./sqrt(numSubs));
        er.Color = [0 0 0];
        er.LineStyle = 'none';
        subplot_4.FaceColor = 'flat';
        subplot_4.CData(1,:) = [0.8500 0.3250 0.0980];
        subplot_4.CData(2,:) = [0.8500*0.5 0.3250*0.5 0.0980*0.5];
        subplot_4.CData(3,:) = [0.8500*0.2 0.3250*0.2 0.0980*0.2];
        subplot_4.CData(4,:) = [0.9290 0.6940 0.1250];
        subplot_4.CData(5,:) = [0 0.4470 0.7410];
        subplot_4.CData(6,:) = [0.4660 0.6740 0.1880];
        ylabel('\Delta Sum of Squared Error')





    end

    setPLOT_panelLabel(gca, xx);
end

  kk=annotation('textbox');
  set(kk, 'string', 'Razmi et al 2025 Figure 3', 'position', [0.85 0.95 0.15 0.05], 'EdgeColor', 'none')


%
saveas(gcf,  'figure3.fig', 'fig')
saveas(gcf,  'figure3.eps', 'epsc2')
%close(gcf)