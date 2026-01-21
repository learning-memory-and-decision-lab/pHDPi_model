

num        = 1;  % Figure number -- just used for label.
wid        = 17.6; % total width
hts        = [5, 5]; % height of each row
cols       = {4,4}; % NUMBER of columns... or relative horizontal space dedicated to each of multiple columns within a row.

[axs,fig_] = getPLOT_axes(num, wid, hts, cols, [4], [2], 10, ''); % etc
set(axs,'Units','normalized');
% draw in each panel, one at a time

lw=1.5;
lw2=3;
exSub=12;
ms=10;


for xx = 1:length(axs)
    axes(axs(xx)); hold on; cla(gca)
    if xx==1

      jitter_ind = 0.1;

hold on
x1 = 1 + 0.25* jitter_ind;
e = errorbar(x1,median(diff_norm_SSE_model_1),std(diff_norm_SSE_model_1)./sqrt(num_subs_human),'Color',colorpalette('darkblue'),'LineWidth',1)
e.Marker = 'square';
e.MarkerFaceColor = colorpalette('lightblue');
x1 = 1 + 0.5* jitter_ind;
e=errorbar(x1,median(diff_norm_SSE_model_2),std(diff_norm_SSE_model_2)./sqrt(num_subs_human),'Color',colorpalette('darkred'),'LineWidth',1)
e.Marker = 'square';
e.MarkerFaceColor = colorpalette('lightred');


x1 = 1 + 0.75* jitter_ind;
e=errorbar(x1,median(diff_norm_SSE_model_3),std(diff_norm_SSE_model_3)./sqrt(num_subs_human),'Color',colorpalette('darkyellow'),'LineWidth',1)
e.Marker = 'square';
e.MarkerFaceColor = colorpalette('lightyellow');


x1 = 1 + 1* jitter_ind;
e = errorbar(x1,median(diff_norm_SSE_model_4),std(diff_norm_SSE_model_4)./sqrt(num_subs_human),'Color',colorpalette('darkmagenta'),'LineWidth',1)
e.Marker = 'square';
e.MarkerFaceColor = colorpalette('lightmagenta');




hold on
x1 = 2 + 0.25* jitter_ind;
e = errorbar(x1,median(diff_norm_SSE_humans_1),std(diff_norm_SSE_humans_1)./sqrt(num_subs_human),'Color',colorpalette('darkblue'),'LineWidth',1)
e.Marker = 'square';
e.MarkerFaceColor = colorpalette('lightblue');

x1 = 2 + 0.5* jitter_ind;
e = errorbar(x1,median(diff_norm_SSE_humans_2),std(diff_norm_SSE_humans_2)./sqrt(num_subs_human),'Color',colorpalette('darkred'),'LineWidth',1)
e.Marker = 'square';
e.MarkerFaceColor = colorpalette('lightred');

x1 = 2 + 0.75* jitter_ind;
e = errorbar(x1,median(diff_norm_SSE_humans_3),std(diff_norm_SSE_humans_3)./sqrt(num_subs_human),'Color',colorpalette('darkyellow'),'LineWidth',1)
e.Marker = 'square';
e.MarkerFaceColor = colorpalette('lightyellow');

x1 = 2 + 1* jitter_ind;
e = errorbar(x1,median(diff_norm_SSE_humans_4),std(diff_norm_SSE_humans_4)./sqrt(num_subs_human),'Color',colorpalette('darkmagenta'),'LineWidth',1)
e.Marker = 'square';
e.MarkerFaceColor = colorpalette('lightmagenta');



xticks([1,2])
xlim([0,3])
ylabel(["SSE(zscore):","Early Phase - Late Phase"])
xticklabels({'Model','Humans'})
legend(task_names)




    elseif xx==2

       hold on

y1 = (postCPtrialLR_early_human);
x = 1: length(y1);
% curve1 = postCPtrialLR_early_human_std(:,2)';
% curve2 = postCPtrialLR_early_human_std(:,1)';
% x2 = [x, fliplr(x)];
% inBetween = [curve1, fliplr(curve2)];
% p1 = fill(x2, inBetween,colorpalette('lightblue'));
% p1.FaceAlpha = 0.4;
% p1.EdgeColor='none';
plot(y1,'color',colorpalette('lightblue'),'LineWidth',2)


y1 = (postCPtrialLR_early);
x = 1: length(y1);
% curve1 = postCPtrialLR_early_std(:,2)';
% curve2 = postCPtrialLR_early_std(:,1)';
% x2 = [x, fliplr(x)];
% inBetween = [curve1, fliplr(curve2)];
% p1 = fill(x2, inBetween,colorpalette('lightred'));
% p1.FaceAlpha = 0.4;
% p1.EdgeColor='none';
plot(y1,'color',colorpalette('lightred'),'LineWidth',2)


xlabel('Trial After Changepoint')
ylabel('Learning Rate')
title(["Learning Rate", "After Changepoint"])
% 
legend({'humans','', 'model',''})
ylim([0 1])
xlim([1 5])
xticks([1 2 3 4 5])
hold off
    elseif xx==3
       hold on
y1 = (postCPtrialLR_late_human);
x = 1: length(y1);
% curve1 = postCPtrialLR_late_human_std(:,2)';
% curve2 = postCPtrialLR_late_human_std(:,1)';
% x2 = [x, fliplr(x)];
% inBetween = [curve1, fliplr(curve2)];
% p1 = fill(x2, inBetween,colorpalette('darkblue'));
% p1.FaceAlpha = 0.4;
% p1.EdgeColor='none';
plot(y1,'color',colorpalette('darkblue'),'LineWidth',2)


y1 = (postCPtrialLR_late);
x = 1: length(y1);
% curve1 = postCPtrialLR_late_std(:,2)';
% curve2 = postCPtrialLR_late_std(:,1)';
% x2 = [x, fliplr(x)];
% inBetween = [curve1, fliplr(curve2)];
% p1 = fill(x2, inBetween,colorpalette('darkred'));
% p1.FaceAlpha = 0.4;
% p1.EdgeColor='none';
plot(y1,'color',colorpalette('darkred'),'LineWidth',2)



xlabel('Trial After Changepoint')
ylabel('Learning Rate')
title(["Learning Rate", "After Changepoint"])
legend({'humans','', 'model',''})
ylim([0 1])
xlim([1 5])
xticks([1 2 3 4 5])
hold off

    elseif xx==4
        hold on
y1 = (postODDtrialLR_early_human);
x = 1: length(y1);
% curve1 = postODDtrialLR_early_human_std(:,2)';
% curve2 = postODDtrialLR_early_human_std(:,1)';
% x2 = [x, fliplr(x)];
% inBetween = [curve1, fliplr(curve2)];
% p1 = fill(x2, inBetween,colorpalette('lightblue'));
% p1.FaceAlpha = 0.4;
% p1.EdgeColor='none';
plot(y1,'color',colorpalette('lightblue'),'LineWidth',2)

y1 = (postODDtrialLR_late_human);
x = 1: length(y1);
% curve1 = postODDtrialLR_late_human_std(:,2)';
% curve2 = postODDtrialLR_late_human_std(:,1)';
% x2 = [x, fliplr(x)];
% inBetween = [curve1, fliplr(curve2)];
% p1 = fill(x2, inBetween,colorpalette('darkblue'));
% p1.FaceAlpha = 0.4;
% p1.EdgeColor='none';
plot(y1,'color',colorpalette('darkblue'),'LineWidth',2)

hold on
y1 = (postODDtrialLR_early);
% x = 1: length(y1);
% curve1 = postODDtrialLR_early_std(:,2)';
% curve2 = postODDtrialLR_early_std(:,1)';
% x2 = [x, fliplr(x)];
% inBetween = [curve1, fliplr(curve2)];
% p1 = fill(x2, inBetween,colorpalette('lightred'));
% p1.FaceAlpha = 0.4;
% p1.EdgeColor='none';
plot(y1,'color',colorpalette('lightred'),'LineWidth',2)


y1 = (postODDtrialLR_late);
% x = 1: length(y1);
% curve1 = postODDtrialLR_late_std(:,2)';
% curve2 = postODDtrialLR_late_std(:,1)';
% x2 = [x, fliplr(x)];
% inBetween = [curve1, fliplr(curve2)];
% p1 = fill(x2, inBetween,colorpalette('darkred'));
% p1.FaceAlpha = 0.4;
% p1.EdgeColor='none';
plot(y1,'color',colorpalette('darkred'),'LineWidth',2)

xlabel('Trial After Oddball')
ylabel('Learning Rate')
title(["Learning Rate", "After Oddball"])
legend({'humans-early','', 'humans-late','',  'model-early','','model-late',''})
ylim([0 1])
xlim([1 5])
xticks([1 2 3 4 5])
hold off


    elseif xx==5
hold on
x1 = 1 - jitter_ind;
x2 = 2 - jitter_ind;
e=errorbar([x1 x2],[mean(postRPtrialPE_early_humans) mean(postRPtrialPE_late_humans)],[std(postRPtrialPE_early_humans)./sqrt(num_subs_human) std(postRPtrialPE_late_humans)./sqrt(num_subs_human)])
e.Marker = "square";
e.MarkerEdgeColor = colorpalette('darkblue');
e.MarkerFaceColor = colorpalette('lightblue');
e.LineWidth = 1;

x1 = 1 + jitter_ind;
x2 = 2 + jitter_ind;
e=errorbar([x1 x2],[mean(postRPtrialPE_early) mean(postRPtrialPE_late)],[std(postRPtrialPE_early)./sqrt(num_subs_human) std(postRPtrialPE_late)./sqrt(num_subs_human)])
e.Marker = "square";
e.MarkerEdgeColor = colorpalette('darkred');
e.MarkerFaceColor = colorpalette('lightred');
e.LineWidth = 1;


xticks([1,2])
xlim([0,3])
xticklabels({'Early Phase','Late Phase'})
legend('Humans','Model')
ylabel('(Outcome-Prediction) Coefficient')
title('Reversal Task')


    elseif xx==6

hold on
x1 = 1 - jitter_ind;
x2 = 2 - jitter_ind;
e=errorbar([x1 x2],[mean(postRPtrial_Mu_PE_early_humans) mean(postRPtrial_Mu_PE_late_humans)],[std(postRPtrial_Mu_PE_early_humans)./sqrt(num_subs_human) std(postRPtrial_Mu_PE_late_humans)./sqrt(num_subs_human)])
e.Marker = "square";
e.MarkerEdgeColor = colorpalette('darkblue');
e.MarkerFaceColor = colorpalette('lightblue');
e.LineWidth = 1;

x1 = 1 + jitter_ind;
x2 = 2 + jitter_ind;
e=errorbar([x1 x2],[mean(postRPtrial_Mu_PE_early) mean(postRPtrial_Mu_PE_late)],[std(postRPtrial_Mu_PE_early)./sqrt(num_subs_human) std(postRPtrial_Mu_PE_late)./sqrt(num_subs_human)])
e.Marker = "square";
e.MarkerEdgeColor = colorpalette('darkred');
e.MarkerFaceColor = colorpalette('lightred');
e.LineWidth = 1;

xticks([1,2])
xlim([0,3])
xticklabels({'Early Phase','Late Phase'})
ylabel('(Mu-Prediction) Coefficient')
title('Reversal Task')
[r,p] = ttest((postRPtrialPE_early_humans), (postRPtrialPE_late_humans))




    elseif xx==7

hold on
x1 = 1 - jitter_ind;
x2 = 2 - jitter_ind;
e=errorbar([x1 x2],[mean(postSPtrialPE_early_humans) mean(postSPtrialPE_late_humans)],[std(postSPtrialPE_early_humans)./sqrt(num_subs_human) std(postSPtrialPE_late_humans)./sqrt(num_subs_human)])
e.Marker = "square";
e.MarkerEdgeColor = colorpalette('darkblue');
e.MarkerFaceColor = colorpalette('lightblue');
e.LineWidth = 1;

x1 = 1 + jitter_ind;
x2 = 2 + jitter_ind;
e =errorbar([x1 x2],[mean(postSPtrialPE_early_model) mean(postSPtrialPE_late_model)],[std(postSPtrialPE_early_model)./sqrt(num_subs_human) std(postSPtrialPE_late_model)./sqrt(num_subs_human)])
e.Marker = "square";
e.MarkerEdgeColor = colorpalette('darkred');
e.MarkerFaceColor = colorpalette('lightred');
e.LineWidth = 1;
[r,p] = ttest((postSPtrial_Mu_PE_early_humans), (postSPtrial_Mu_PE_late_humans))


xticks([1,2])
xlim([0,3])
ylabel('(Outcome-Prediction) Coefficient')
xticklabels({'Early Phase','Late Phase'})
title('Sequence Task')




    elseif xx==8

       hold on
x1 = 1 - jitter_ind;
x2 = 2 - jitter_ind;
e=errorbar([x1 x2],[mean(postSPtrial_Mu_PE_early_humans) mean(postSPtrial_Mu_PE_late_humans)],[std(postSPtrial_Mu_PE_early_humans)./sqrt(num_subs_human) std(postSPtrial_Mu_PE_late_humans)./sqrt(num_subs_human)])
e.Marker = "square";
e.MarkerEdgeColor = colorpalette('darkblue');
e.MarkerFaceColor = colorpalette('lightblue');
e.LineWidth = 1;

x1 = 1 + jitter_ind;
x2 = 2 + jitter_ind;
e = errorbar([x1 x2],[mean(postSPtrial_Mu_PE_early_model) mean(postSPtrial_Mu_PE_late_model)],[std(postSPtrial_Mu_PE_early_model)./sqrt(num_subs_human) std(postSPtrial_Mu_PE_late_model)./sqrt(num_subs_human)]);
e.Marker = "square";
e.MarkerEdgeColor = colorpalette('darkred');
e.MarkerFaceColor = colorpalette('lightred');
e.LineWidth = 1;

xticks([1,2])
xlim([0,3])
ylabel('(Mu-Prediction) Coefficient')
xticklabels({'Early Phase','Late Phase'})
title('Sequence Task')


    end

    setPLOT_panelLabel(gca, xx);
end

  kk=annotation('textbox');
  set(kk, 'string', 'Razmi et al 2025 Figure 5', 'position', [0.85 0.95 0.15 0.05], 'EdgeColor', 'none')


%
saveas(gcf,  'figure5.fig', 'fig')
saveas(gcf,  'figure5.eps', 'epsc2')
%close(gcf)