load EEG

%%

EEG.data=EEG.data*0.000000030517578125000001*10^6;

figure
plot(EEG.data(1,:)); hold on;
plot([zeros(1,3119999) EEG.data(1,3120000:3420000)],'y','LineWidth',1.5); hold on
plot([zeros(1,1919999) EEG.data(1,1920000:2220000)],'r','LineWidth',1.5); hold on
plot([zeros(1,1119999) EEG.data(1,1120000:1420000)],'b','LineWidth',1.5); hold on


%%
pre=[1120000:8:1420000];
sham=[1920000:8:2220000];
post=[3120000:8:3420000];
%%


close all
for k=1:6
figure
for i=1:15
[psd_pre((1+(k-1)*15)+i-1,:),fpsd]=pwelch(EEG.data((1+(k-1)*15)+i-1,pre)',1000,0,1000,1000);
[psd_sham((1+(k-1)*15)+i-1,:),fpsd]=pwelch(EEG.data((1+(k-1)*15)+i-1,sham)',1000,0,1000,1000);
[psd_post((1+(k-1)*15)+i-1,:),fpsd]=pwelch(EEG.data((1+(k-1)*15)+i-1,post)',1000,0,1000,1000);
subplot(5,3,i)
plot(fpsd(1:50),[10*log10(psd_pre((1+(k-1)*15)+i-1,1:50))' 10*log10(psd_sham((1+(k-1)*15)+i-1,1:50))' 10*log10(psd_post((1+(k-1)*15)+i-1,1:50))'],'Linewidth',1.5)
% plot((1:length(OUTEEG.data((1+(k-1)*15)+i-1,:,1)'))/8000,OUTEEG.data((1+(k-1)*15)+i-1,:,1)'*0.000000030517578125000001*10^6); 
% hold on;
% plot((1:length(OUTEEG.data((1+(k-1)*15)+i-1,:,1)'))/8000,OUTEEG.data((1+(k-1)*15)+i-1,:,2)'*0.000000030517578125000001*10^6,'r')
title(strcat(['Chan' num2str((1+(k-1)*15)+i-1)]));
xlim([0 50])
end
end


%%
figure
plot([10*log10(mean(psd_post(:,1:50),1))' 10*log10(mean(psd_sham(:,1:50),1))' 10*log10(mean(psd_pre(:,1:50),1))'])
%%


%%
% close all
% for k=1:6
% figure
% for i=1:15
% [psd_pre,fpsd]=pwelch(EEG.data((1+(k-1)*15)+i-1,pre)',8000,0,8000,8000);
% [psd_sham,fpsd]=pwelch(EEG.data((1+(k-1)*15)+i-1,sham)',8000,0,8000,8000);
% [psd_post,fpsd]=pwelch(EEG.data((1+(k-1)*15)+i-1,post)',8000,0,8000,8000);
% subplot(5,3,i)
% plot(fpsd(1:50),[10*log10(psd_sham(1:50))-10*log10(psd_pre(1:50))  10*log10(psd_post(1:50))-10*log10(psd_pre(1:50))],'Linewidth',1.5)
% % plot((1:length(OUTEEG.data((1+(k-1)*15)+i-1,:,1)'))/8000,OUTEEG.data((1+(k-1)*15)+i-1,:,1)'*0.000000030517578125000001*10^6); 
% % hold on;
% % plot((1:length(OUTEEG.data((1+(k-1)*15)+i-1,:,1)'))/8000,OUTEEG.data((1+(k-1)*15)+i-1,:,2)'*0.000000030517578125000001*10^6,'r')
% title(strcat(['Chan' num2str((1+(k-1)*15)+i-1)]));
% xlim([0 50])
% end
% end

%%
% preMSE=[pre(1):10:pre(end)];
% shamMSE=[sham(1):10:sham(end)];
% postMSE=[post(1):10:post(end)];
%%
% data=EEG.data(1,preMSE);
% data=data-mean(data);
% data=data/std(data);
% figure
% plot(data)
% 
% MSE=multiscale_entropy(data,2,0.15,50);
% figure
% plot(MSE)

%%
for k=1:6
figure
for i=1:15
datapre=EEG.data((1+(k-1)*15)+i-1,pre);
datapre=datapre-mean(datapre);
datapre=datapre/std(datapre);
MSEpre=multiscale_entropy(datapre,2,0.15,100);
datasham=EEG.data((1+(k-1)*15)+i-1,sham);
datasham=datasham-mean(datasham);
datasham=datasham/std(datasham);
MSEsham=multiscale_entropy(datasham,2,0.15,100);
datapost=EEG.data((1+(k-1)*15)+i-1,post);
datapost=datapost-mean(datapost);
datapost=datapost/std(datapost);
MSEpost=multiscale_entropy(datapost,2,0.15,100);
subplot(5,3,i)
plot([MSEpre MSEsham MSEpost],'Linewidth',1.5)
title(strcat(['Chan' num2str((1+(k-1)*15)+i-1)]));
end
end