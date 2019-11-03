%% Plot All Active Data
OUTEEG = EEG;
figure
for i=1:length(EEG.chanlocs)
subplot(15,10,i)
hold on
plot(mean(OUTEEG.data(i,:,:),3));
title(strcat('Channel ',OUTEEG.chanlocs(i).labels));
ylim([-200 200])
end
hold off
sgtitle('Active TEPs')
%% Plot All Active Data - trying drawnow
OUTEEG = EEG;
figure
[ha,~] = tight_subplot(15,10,[0.01 0.03],[0.2 0.1],[0.01 0.01]);
for i=1:length(EEG.chanlocs)
plot(ha(i),mean(OUTEEG.data(i,:,:),3));
title(strcat('Channel ',OUTEEG.chanlocs(i).labels));
ylim([-200 200]);
drawnow
end
set(ha(1:140),'XTickLabel',''); set(ha,'YTickLabel','');
%% Get Data
load('477_active_filtered.mat')
OUTEEG_active = EEG;
load('477_pre-sham_filtered.mat')
OUTEEG_pre_sham = EEG;
load('477_post-sham_filtered.mat')
OUTEEG_post_sham = EEG;
%% Plot All Active Data - trying axes - 477
figure
set(gcf, 'Position',  [100, 100, 1200, 700])
[ha, pos] = tight_subplot(15,10,[0.02 0.03],[0.05 0.05],[0.05 0.05]);
for i=1:length(EEG.chanlocs)
axes(ha(i))
plot(mean(OUTEEG_active.data(i,:,:),3));
hold
plot(mean(OUTEEG_pre_sham.data(i,:,:),3));
plot(mean(OUTEEG_post_sham.data(i,:,:),3));
title(strcat('Channel ',OUTEEG_active.chanlocs(i).labels));
end
hl = legend('Active','Pre','Post');
location = 'northeastoutside';
newUnits = 'normalized';
set(hl,'Location', location,'Units', newUnits);
set(ha(1:140),'XTickLabel','');
%% Get Data
load('416_active_filtered.mat')
OUTEEG_active = EEG;
load('416_pre-sham_filtered.mat')
OUTEEG_pre_sham = EEG;
%% Plot All Active Data - trying axes - 416
figure
set(gcf, 'Position',  [100, 100, 1200, 700])
[ha, pos] = tight_subplot(15,13,[0.02 0.03],[0.05 0.05],[0.05 0.05]);
for i=1:length(EEG.chanlocs)
axes(ha(i))
plot(mean(OUTEEG_active.data(i,:,:),3));
hold
plot(mean(OUTEEG_pre_sham.data(i,:,:),3));
title(strcat('Channel ',OUTEEG_active.chanlocs(i).labels));
end
hl = legend('Active','Sham');
location = 'northeastoutside';
newUnits = 'normalized';
set(hl,'Location', location,'Units', newUnits);
set(ha(1:140),'XTickLabel','');
%% Get Data
load('460_active_filtered.mat')
OUTEEG_active = EEG;
load('460_pre-sham_filtered.mat')
OUTEEG_pre_sham = EEG;
load('460_post-sham_filtered.mat')
OUTEEG_post_sham = EEG;
%% Plot All Active Data - trying axes - 460
figure
set(gcf, 'Position',  [100, 100, 1200, 700])
[ha, pos] = tight_subplot(15,13,[0.02 0.03],[0.05 0.05],[0.05 0.05]);
for i=1:length(EEG.chanlocs)
axes(ha(i))
plot(mean(OUTEEG_active.data(i,:,:),3));
hold;
plot(mean(OUTEEG_pre_sham.data(i,:,:),3));
plot(mean(OUTEEG_post_sham.data(i,:,:),3));
title(strcat('Channel ',OUTEEG_active.chanlocs(i).labels));
end
% hl = legend({'Active','Pre','Post'},'Position',[1 0 0.5 1]);
set(ha(1:172),'XTickLabel','');
%% Plot time frequency - 460
figure
set(gcf, 'Position',  [100, 100, 1200, 700])
[ha, pos] = tight_subplot(15,13,[0.02 0.03],[0.05 0.05],[0.05 0.05]);
for i=1:length(EEG.chanlocs)
axes(ha(i))
stfft_func(OUTEEG_pre_sham.chanlocs(i).labels,OUTEEG_pre_sham);
title(strcat('Channel ',OUTEEG_active.chanlocs(i).labels));
end
% hl = legend({'Active','Pre','Post'},'Position',[1 0 0.5 1]);
set(ha(1:172),'XTickLabel','');
%% Plot all sham data (pre-stim)
figure
for i=1:30
subplot(5,6,i)
hold on
for j=1:50
plot(OUTEEG.data(i,:,j));
end
title(strcat('Channel ',num2str(i)));
hold off
end
%% Plot all sham data (post-stim)
figure
for i=1:30
subplot(5,6,i)
hold on
for j=101:150
plot(OUTEEG.data(i,:,j));
end
title(strcat('Channel ',num2str(i)));
hold off
end
%% Plot All Active TEPs
figure
for i=1:30
subplot(5,6,i)
hold on
plot(mean(OUTEEG.data(i,:,51:100),3));
title(strcat('Channel ',num2str(i)));
hold off
end