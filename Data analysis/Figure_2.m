

num        = 1;  
wid        = 17.6; 
hts        = [4,4,4,4]; 
cols       = {[0.5 0.25 0.25],[0.5 0.25 0.25],[0.5 0.25 0.25],[0.5 0.25 0.25]}; 

[axs,fig_] = getPLOT_axes(num, wid, hts, cols, [2], [2], 10, ''); 
set(axs,'Units','normalized');

lw=1;
lw2=3;
exSub=12;
ms=10;

task_names = {'Changepoint' 'Oddball' 'Reversal' 'Sequence'};
n_trial = 50;

for xx = 1:length(axs)
    axes(axs(xx)); hold on; cla(gca)
    if xx==1

        set(gca,'Visible','off'); %'off' or 'on'


    elseif xx==2


        task_type = 1;
        p_model = 'model data final check/changepoint/';
        p_humans = 'humans data final check/Changepoint task/';
        subID = 110;
        saveFN = [p_model,'sub',sprintf('%.0f',subID),'_',sprintf('%.0f',task_type),'.mat'];
        load(saveFN)
        outcome = output.outcome;
        mean = output.mu./3;
        hold on
        plot(mean(1:50),'k','LineWidth',2)
        scatter(1:50,outcome(1:50),'MarkerFaceColor','r','MarkerEdgeColor','k')
        xlabel('Trial')
        ylabel('Outcome')
        title(["Changepoint", "Task"])
        xlim([1 50])
        ylim([0 100])
        hold off


    elseif xx==3


        task_type = 2;
        p_model = 'model data final check/oddball/';
        p_humans = 'humans data final check/Oddball task/';
        saveFN = [p_model,'sub',sprintf('%.0f',subID),'_',sprintf('%.0f',task_type),'.mat'];
        load(saveFN)
        outcome = output.outcome;
        mean = output.mu./3;
        hold on
        plot(mean(1:50),'k','LineWidth',2)
        scatter(1:50,outcome(1:50),'MarkerFaceColor','r','MarkerEdgeColor','k')
        xlabel('Trial')
        ylabel('Outcome')
        title(["Oddball", "Task"])
        xlim([1 50])
        ylim([0 100])
        hold off



    elseif xx==4



        set(gca,'Visible','off'); %'off' or 'on'



    elseif xx==5

        task_type = 3;
        subID = 3;
        p_model = 'model data final check/reversal/';
        p_humans = 'humans data final check/Reversal task/';
        saveFN = [p_model,'sub',sprintf('%.0f',subID),'_',sprintf('%.0f',task_type),'.mat'];
        load(saveFN)
        outcome = output.outcome;
        mean = output.mu;
        hold on
        plot(mean(1:50),'k','LineWidth',2)
        scatter(1:50,outcome(1:50),'MarkerFaceColor','r','MarkerEdgeColor','k')
        xlabel('Trial')
        ylabel('Outcome')
        title(["Reversal", "Task"])
        xlim([1 50])
        ylim([0 100])
        hold off


    elseif xx==6

        task_type = 4;
        p_model = 'model data final check/Sequence/';
        p_humans = 'humans data final check/Sequence task/';
        saveFN = [p_model,'sub',sprintf('%.0f',subID),'_',sprintf('%.0f',task_type),'.mat'];
        load(saveFN)
        outcome = output.outcome;
        mean = output.mu;
        hold on
        plot(mean(1:15),'k','LineWidth',2)
        scatter(1:15,outcome(1:15),'MarkerFaceColor','r','MarkerEdgeColor','k')
        xlabel('Trial')
        ylabel('Outcome')
        title(["Sequence", "Task"])
        xlim([1 15])
        ylim([0 100])
        hold off

    elseif xx==7

        set(gca,'Visible','off'); %'off' or 'on'

    elseif xx==8

        std = 25/3;
        subID = 9;
        taskType = 1;
        filename = ['sim_sub',num2str(subID),'_',num2str(taskType),'.mat'];
        load(filename);

        hold on
        mu = data_1.maxP(1:n_trial)./3;
        plot(mu,'k','LineWidth',2)
        outcome = normrnd(mu,std);
        scatter(1:n_trial,outcome,'MarkerFaceColor','r','MarkerEdgeColor','k')
        ylim([0 100])
        xlim([1 50])
        ylabel('Outcome')
        xlabel('Trial')
        title(["Changepoint-like","Enviroment"])


    elseif xx==9
        subID = 9;
        taskType = 2;
        filename = ['sim_sub',num2str(subID),'_',num2str(taskType),'.mat'];
        load(filename)
        hold on
        mu = data_2.maxP(1:n_trial)./3;
        plot(mu,'k','LineWidth',2)
        outcome = normrnd(mu,std);
        scatter(1:n_trial,outcome,'MarkerFaceColor','r','MarkerEdgeColor','k')
        ylim([0 100])
        xlim([1 50])
        ylabel('Outcome')
        xlabel('Trial')
        title(["Oddball-like","Enviroment"])

    elseif xx==10
        set(gca,'Visible','off'); %'off' or 'on'


    elseif xx==11
        subID = 5;
        taskType = 3;
        filename = ['sim_sub',num2str(subID),'_',num2str(taskType),'.mat'];
        load(filename)
        hold on
        mu = data_3.maxP(51:end)./3;
        plot(mu,'k','LineWidth',2)
        outcome = normrnd(mu,std);
        scatter(1:n_trial,outcome,'MarkerFaceColor','r','MarkerEdgeColor','k')
        ylim([0 100])
        ylabel('Outcome')
        xlabel('Trial')
        xlim([1 50])
        title(["Reversal-like","Enviroment"])

    elseif xx==12
        subID = 1;
        taskType = 4;
        filename = ['sim_sub',num2str(subID),'_',num2str(taskType),'.mat'];
        load(filename)
        hold on
        mu = data_4.maxP(1:n_trial)./3;
        plot(mu,'k','LineWidth',2)
        outcome = normrnd(mu,std);
        scatter(1:n_trial,outcome,'MarkerFaceColor','r','MarkerEdgeColor','k')
        ylim([0 100])
        xlim([1 50])
        ylabel('Outcome')
        xlabel('Trial')
        title(["Sequence-like","Enviroment"])
    end

    setPLOT_panelLabel(gca, xx);
end


%
% %
% saveas(gcf,  'figure2.fig', 'fig')
% saveas(gcf,  'figure2.eps', 'epsc2')
%close(gcf)