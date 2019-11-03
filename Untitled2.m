%% Plot All Active Data
figure
for i=1:255
subplot(16,16,i)
hold on
for j=1:2
plot(OUTEEG.data(i,:,j));
end
title(strcat('Channel ',OUTEEG.chanlocs(i).labels));
hold off
end
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