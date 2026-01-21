% makeFig1



% 1 column (maximum width 8.5 cm),
% 1.5 columns (maximum width 11.6 cm)
% 2 columns (maximum width 17.6 cm)


num        = 1;  % Figure number -- just used for label.
wid        = 17.6; % total width
hts        = [6, 6]; % height of each row
cols       = {[0.5 0.25 0.25],[0.5 0.25 0.25]}; % NUMBER of columns... or relative horizontal space dedicated to each of multiple columns within a row.
% cols Note... if you put a set of numbers that add to 1 in a cell, then the
% column will be split unevenly into columns according to the proportions
% specified.

% 5th and 6th inputs here define spacing between figures... which you may
% need to play with if you have really large labels.
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

    
   
% 
% for i = 1:length(pre_all_trial_lr)
%     %y = [pre_all_trial_lr(i,:),post_all_trial_lr(i,:)];   
%      y = pre_all_trial_lr(i,:);
%     nan_del = ~isnan(y);
%     true_y = y(nan_del);
%     filt_y =  smooth(true_y,5);
%     y(nan_del) = filt_y;
%     conv_all_trial_lr(i,:) = y;
% end

conv_all_trial_lr = pre_all_trial_lr;

k = 18;
hold on
y3 = smooth(nanmedian(conv_all_trial_lr(sub_cond==2,1:k)),5)';
y4 = smooth(nanmedian(conv_all_trial_lr(sub_cond==1,1:k)),5)';

std_dev_1 = nanstd(conv_all_trial_lr(sub_cond==2,1:k))./sqrt(sum(sub_cond==2));
x =  1:k; %k:2*k-1;
curve1 = y3 + std_dev_1(1:k);
curve2 = y3 - std_dev_1(1:k);
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];
p=fill(x2, inBetween, colorpalette('lightred'));
p.EdgeColor = 'none';
plot(x,y3,'color',colorpalette('darkred'),'LineWidth',1.5)
std_dev_2 = nanstd(conv_all_trial_lr(sub_cond==1,1:k))./sqrt(sum(sub_cond==1));
x =  1:k; %k:2*k-1;
curve1 = y4 + std_dev_2(1:k);
curve2 = y4 - std_dev_2(1:k);
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];
p=fill(x2, inBetween, colorpalette('lightblue'));
p.EdgeColor = 'none';
plot(x,y4,'color',colorpalette('darkblue'),'LineWidth',1.5)
yline(1,'--k')
yline(0,'--k')

ylabel('Learning Rate')
xlabel('number of extreme events')


% 
% 
% for i = 1:length(post_all_trial_lr)
%     y = post_all_trial_lr(i,:);
%     nan_del = ~isnan(y);
%     true_y = y(nan_del);
%     filt_y =  smooth(true_y,5);
%     y(nan_del) = filt_y;
%     conv_post_all_trial_lr(i,:) = y;
% end

conv_post_all_trial_lr = post_all_trial_lr;

hold on
kk = 20; % find(sum(isnan(conv_post_all_trial_lr))>63/2) -1;
y1 = smooth(nanmedian(conv_post_all_trial_lr(sub_cond==2,1:kk)),5)';
y2 = smooth(nanmedian(conv_post_all_trial_lr(sub_cond==1,1:kk)),5)';
x1 = k+1:k+kk;

std_dev_1 = nanstd(conv_post_all_trial_lr(sub_cond==2,1:kk))./sqrt(sum(sub_cond==2));
x = x1;
curve1 = y1 + std_dev_1(1:kk);
curve2 = y1 - std_dev_1(1:kk);
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];
p=fill(x2, inBetween, colorpalette('lightblue'));
p.EdgeColor = 'none';

std_dev_2 = nanstd(conv_post_all_trial_lr(sub_cond==1,1:kk))./sqrt(sum(sub_cond==2));
x = x1;
curve1 = y2 + std_dev_2(1:kk);
curve2 = y2 - std_dev_2(1:kk);
x3 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];
p = fill(x3, inBetween,colorpalette('lightred'));
p.EdgeColor = 'none';
plot(x1,y1,'color',colorpalette('darkblue'),'LineWidth',1.5)
plot(x1,y2,'color',colorpalette('darkred'),'LineWidth',1.5)
yline(1,'--k')
yline(0,'--k')
xline(18,'--k')
ylim([-0.5 1.2])
xticks([0 10 20 30 40])
xticklabels([0 10 0 10 20])


    elseif xx==2

hold on
x = ["Pre-reversal","Post-reversal"];

%jitter_ind = 0.2;
% x1 = 1+rand(size(final_lr_pre(sub_cond==1,:),1),1)*jitter_ind;
% x2 = 2+rand(size(final_lr_post(sub_cond==1,:),1),1)*jitter_ind;

xMargin = 0.07;
yMargin = 0.07;
yData = final_lr_pre(sub_cond==1,end);
x1 = 1 + smartJitter(yData,xMargin,yMargin);

yData = final_lr_post(sub_cond==1,end);
x2 = 2 + smartJitter(yData,xMargin,yMargin);

hold on
plot(x1,median_lr_pre(sub_cond==1,end),'o','MarkerFaceColor',colorpalette('lightblue'),'MarkerEdgeColor',colorpalette('darkblue'),'MarkerSize',5,'LineWidth',1)
plot(x2,median_lr_post(sub_cond==1,end),'o','MarkerFaceColor',colorpalette('lightred'),'MarkerEdgeColor',colorpalette('darkred'),'MarkerSize',5,'LineWidth',1)

plot([1,2],[nanmean(median_lr_pre(sub_cond==1,end)),nanmean(median_lr_post(sub_cond==1,end))],'k','LineWidth',1.5)
plot(1,nanmean(median_lr_pre(sub_cond==1,end)),"^",'MarkerFaceColor',colorpalette('lightblue'),'MarkerEdgeColor','k','MarkerSize',10,'LineWidth',1.5)
plot(2,nanmean(median_lr_post(sub_cond==1,end)),"^",'MarkerFaceColor',colorpalette('lightred'),'MarkerEdgeColor','k','MarkerSize',10,'LineWidth',1.5)
plot([0 3],[0.5,0.5],'--k')    
% [r,p] = ttest(all_LR_1_emp(sub_cond==1,end),all_LR_2_emp(sub_cond==2,end))
% [r,p] = ttest(all_LR_1_emp(sub_cond==2,end),all_LR_2_emp(sub_cond==1,end))

plot([0 3],[0.5,0.5],'--k')             
ylabel('Overall Median Learning Rate ')
title('CP -> OB')
ax = gca;
xlim([0 3])
xticks([1 2])
ylim([-0.2 1.5])
xticklabels(x)
hold off



    elseif xx==3
hold on
% jitter_ind = 0.2;
x = ["Pre-reversal","Post-reversal"];
% x1 = 1+rand(size(final_lr_pre(sub_cond==2,:),1),1)*jitter_ind;
% x2 = 2+rand(size(final_lr_post(sub_cond==2,:),1),1)*jitter_ind;
xMargin = 0.07;
yMargin = 0.07;
yData = median_lr_pre(sub_cond==2,end);
x1 = 1 + smartJitter(yData,xMargin,yMargin);

yData = median_lr_post(sub_cond==2,end);
x2 = 2 + smartJitter(yData,xMargin,yMargin);

plot(x1,median_lr_pre(sub_cond==2,end),'o','MarkerFaceColor',colorpalette('lightred'),'MarkerEdgeColor',colorpalette('darkred'),'MarkerSize',5,'LineWidth',1)
plot(x2,median_lr_post(sub_cond==2,end),'o','MarkerFaceColor',colorpalette('lightblue'),'MarkerEdgeColor',colorpalette('darkblue'),'MarkerSize',5,'LineWidth',1)
plot([1,2],[nanmean(median_lr_pre(sub_cond==2)),nanmean(median_lr_post(sub_cond==2))],'k','LineWidth',1.5)
plot(1,nanmean(median_lr_pre(sub_cond==2)),"^",'MarkerFaceColor',colorpalette('lightred'),'MarkerEdgeColor','k','MarkerSize',10,'LineWidth',1.5)
plot(2,nanmean(median_lr_post(sub_cond==2)),"^",'MarkerFaceColor',colorpalette('lightblue'),'MarkerEdgeColor','k','MarkerSize',10,'LineWidth',1.5)
plot([0 3],[0.5,0.5],'--k')    
% [r,p] = ttest(all_LR_1_emp(sub_cond==1,end),all_LR_2_emp(sub_cond==2,end))
% [r,p] = ttest(all_LR_1_emp(sub_cond==2,end),all_LR_2_emp(sub_cond==1,end))

ylabel('Overall Median Learning Rate')
title('OB -> CP')
ax = gca;
xlim([0 3])
xticks([1 2])
ylim([-0.2 1.5])
xticklabels(x)
hold off


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
saveas(gcf,  'figure6.fig', 'fig')
saveas(gcf,  'figure6.eps', 'epsc2')
%close(gcf)


diff_cond_1 = median_lr_post(sub_cond==2,end) -  median_lr_pre(sub_cond==2,end) ;
diff_cond_2 =  median_lr_pre(sub_cond==1,end) - median_lr_post(sub_cond==1,end);
nanmean(diff_cond_1)
nanmean(diff_cond_2)

[h,p] = ranksum(diff_cond_1,diff_cond_2)


diff_cond_1 =  median_lr_pre_model(test_id==2,end) - median_lr_post_model(test_id==2,end) ;
diff_cond_2 = median_lr_post_model(test_id==1,end) - median_lr_pre_model(test_id==1,end);

nanmean(diff_cond_1)
nanmean(diff_cond_2)

[h,p] = ranksum(diff_cond_1,diff_cond_2)
