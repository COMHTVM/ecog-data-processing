EEG=pop_loadset('EEG430.set');

load loc430;

EEG.data=EEG.data*0.000000030517578125000001*10^6;

%%
figure
plot(EEG.data(1,:)); hold on;
plot([zeros(1,3154999) EEG.data(1,3155000:3455000)],'y','LineWidth',1.5); hold on
plot([zeros(1,1919999) EEG.data(1,1920000:2220000)],'r','LineWidth',1.5); hold on
plot([zeros(1,1119999) EEG.data(1,1120000:1420000)],'b','LineWidth',1.5); hold on
plot([zeros(1,119999) EEG.data(1,120000:420000)],'b','LineWidth',1.5); hold on


%%
pre1=[120000:8:420000];
pre2=[1120000:8:1420000];
sham=[1920000:8:2220000];
post=[3155000:8:3455000];
%%


close all
for k=1:6
figure
for i=1:15
[psd_pre1((1+(k-1)*15)+i-1,:),fpsd]=pwelch(EEG.data((1+(k-1)*15)+i-1,pre1)',1000,0,1000,1000);
[psd_pre2((1+(k-1)*15)+i-1,:),fpsd]=pwelch(EEG.data((1+(k-1)*15)+i-1,pre2)',1000,0,1000,1000);
[psd_sham((1+(k-1)*15)+i-1,:),fpsd]=pwelch(EEG.data((1+(k-1)*15)+i-1,sham)',1000,0,1000,1000);
[psd_post((1+(k-1)*15)+i-1,:),fpsd]=pwelch(EEG.data((1+(k-1)*15)+i-1,post)',1000,0,1000,1000);
subplot(5,3,i)
plot(fpsd(1:50),[10*log10(psd_pre1((1+(k-1)*15)+i-1,1:50))' 10*log10(psd_pre2((1+(k-1)*15)+i-1,1:50))' 10*log10(psd_sham((1+(k-1)*15)+i-1,1:50))' 10*log10(psd_post((1+(k-1)*15)+i-1,1:50))'],'Linewidth',1.5)
title(strcat(['Chan' num2str((1+(k-1)*15)+i-1)]));
xlim([0 50])
end
end

%%
[~,ind1]=find(loc430==1);
[~,ind2]=find(loc430==4);
RMiddleHippo=ind1:ind2;
[~,ind1]=find(loc430==7);
[~,ind2]=find(loc430==14);
RAmygdala=ind1:ind2;
[~,ind1]=find(loc430==15);
[~,ind2]=find(loc430==20);
RPosteriorHippo=ind1:ind2;
[~,ind1]=find(loc430==21);
[~,ind2]=find(loc430==26);
RInferiorAnteriorOccipital=ind1:ind2;
[~,ind1]=find(loc430==27);
[~,ind2]=find(loc430==30);
RSuperiorPosteriorOccipital=ind1:ind2;
[~,ind1]=find(loc430==33);
[~,ind2]=find(loc430==42);
RParietal=ind1:ind2;

[~,ind1]=find(loc430==51);
[~,ind2]=find(loc430==54);
LMiddleHippo=ind1:ind2;
[~,ind1]=find(loc430==43);
[~,ind2]=find(loc430==50);
LAmygdala=ind1:ind2;
[~,ind1]=find(loc430==65);
[~,ind2]=find(loc430==68);
LPosteriorHippo=ind1:ind2;
[~,ind1]=find(loc430==55);
[~,ind2]=find(loc430==60);
LInferiorAnteriorOccipital=ind1:ind2;
[~,ind1]=find(loc430==97);
[~,ind2]=find(loc430==100);
LSuperiorPosteriorOccipital=ind1:ind2;
[~,ind1]=find(loc430==69);
[~,ind2]=find(loc430==76);
LParietal=ind1:ind2;

%%
figure
subplot(2,3,1)
plot(fpsd(1:500),[mean([10*log10(mean(psd_pre1(RMiddleHippo,1:500),1));10*log10(mean(psd_pre2(RMiddleHippo,1:500),1))],1)' 10*log10(mean(psd_sham(RMiddleHippo,1:500),1))' 10*log10(mean(psd_post(RMiddleHippo,1:500),1))'],'Linewidth',1.5)
grid on
xlim([0 500])
title('RMiddleHippo');
subplot(2,3,2)
plot(fpsd(1:500),[mean([10*log10(mean(psd_pre1(RAmygdala,1:500),1));10*log10(mean(psd_pre2(RAmygdala,1:500),1))],1)' 10*log10(mean(psd_sham(RAmygdala,1:500),1))' 10*log10(mean(psd_post(RAmygdala,1:500),1))'],'Linewidth',1.5)
grid on
xlim([0 500])
title('RAmygdala');
subplot(2,3,3)
plot(fpsd(1:500),[mean([10*log10(mean(psd_pre1(RPosteriorHippo,1:500),1));10*log10(mean(psd_pre2(RPosteriorHippo,1:500),1))],1)' 10*log10(mean(psd_sham(RPosteriorHippo,1:500),1))' 10*log10(mean(psd_post(RPosteriorHippo,1:500),1))'],'Linewidth',1.5)
grid on
xlim([0 500])
title('RPosteriorHippo');
subplot(2,3,4)
plot(fpsd(1:500),[mean([10*log10(mean(psd_pre1(RInferiorAnteriorOccipital,1:500),1));10*log10(mean(psd_pre2(RInferiorAnteriorOccipital,1:500),1))],1)' 10*log10(mean(psd_sham(RInferiorAnteriorOccipital,1:500),1))' 10*log10(mean(psd_post(RInferiorAnteriorOccipital,1:500),1))'],'Linewidth',1.5)
grid on
xlim([0 500])
title('RInferiorAnteriorOccipital');
subplot(2,3,5)
plot(fpsd(1:500),[mean([10*log10(mean(psd_pre1(RSuperiorPosteriorOccipital,1:500),1));10*log10(mean(psd_pre2(RSuperiorPosteriorOccipital,1:500),1))],1)' 10*log10(mean(psd_sham(RSuperiorPosteriorOccipital,1:500),1))' 10*log10(mean(psd_post(RSuperiorPosteriorOccipital,1:500),1))'],'Linewidth',1.5)
grid on
xlim([0 500])
title('RSuperiorPosteriorOccipital');
subplot(2,3,6)
plot(fpsd(1:500),[mean([10*log10(mean(psd_pre1(RParietal,1:500),1));10*log10(mean(psd_pre2(RParietal,1:500),1))],1)' 10*log10(mean(psd_sham(RParietal,1:500),1))' 10*log10(mean(psd_post(RParietal,1:500),1))'],'Linewidth',1.5)
grid on
xlim([0 500])
title('RParietal');

%%
figure
subplot(2,3,1)
plot(fpsd(1:500),[mean([10*log10(mean(psd_pre1(LMiddleHippo,1:500),1));10*log10(mean(psd_pre2(LMiddleHippo,1:500),1))],1)' 10*log10(mean(psd_sham(LMiddleHippo,1:500),1))' 10*log10(mean(psd_post(LMiddleHippo,1:500),1))'],'Linewidth',1.5)
grid on
xlim([0 500])
title('LMiddleHippo');
subplot(2,3,2)
plot(fpsd(1:500),[mean([10*log10(mean(psd_pre1(RAmygdala,1:500),1));10*log10(mean(psd_pre2(RAmygdala,1:500),1))],1)' 10*log10(mean(psd_sham(RAmygdala,1:500),1))' 10*log10(mean(psd_post(RAmygdala,1:500),1))'],'Linewidth',1.5)
grid on
xlim([0 500])
title('LAmygdala');
subplot(2,3,3)
plot(fpsd(1:500),[mean([10*log10(mean(psd_pre1(LPosteriorHippo,1:500),1));10*log10(mean(psd_pre2(LPosteriorHippo,1:500),1))],1)' 10*log10(mean(psd_sham(LPosteriorHippo,1:500),1))' 10*log10(mean(psd_post(LPosteriorHippo,1:500),1))'],'Linewidth',1.5)
grid on
xlim([0 500])
title('LPosteriorHippo');
subplot(2,3,4)
plot(fpsd(1:500),[mean([10*log10(mean(psd_pre1(LInferiorAnteriorOccipital,1:500),1));10*log10(mean(psd_pre2(LInferiorAnteriorOccipital,1:500),1))],1)' 10*log10(mean(psd_sham(LInferiorAnteriorOccipital,1:500),1))' 10*log10(mean(psd_post(LInferiorAnteriorOccipital,1:500),1))'],'Linewidth',1.5)
grid on
xlim([0 500])
title('LInferiorAnteriorOccipital');
subplot(2,3,5)
plot(fpsd(1:500),[mean([10*log10(mean(psd_pre1(LSuperiorPosteriorOccipital,1:500),1));10*log10(mean(psd_pre2(LSuperiorPosteriorOccipital,1:500),1))],1)' 10*log10(mean(psd_sham(LSuperiorPosteriorOccipital,1:500),1))' 10*log10(mean(psd_post(RSuperiorPosteriorOccipital,1:500),1))'],'Linewidth',1.5)
grid on
xlim([0 500])
title('LSuperiorPosteriorOccipital');
subplot(2,3,6)
plot(fpsd(1:500),[mean([10*log10(mean(psd_pre1(LParietal,1:500),1));10*log10(mean(psd_pre2(LParietal,1:500),1))],1)' 10*log10(mean(psd_sham(LParietal,1:500),1))' 10*log10(mean(psd_post(LParietal,1:500),1))'],'Linewidth',1.5)
grid on
xlim([0 500])
title('LParietal');


%%
figure
subplot(2,3,1)
plot(fpsd(1:50),[mean([10*log10(mean(psd_pre1(RMiddleHippo,1:50),1));10*log10(mean(psd_pre2(RMiddleHippo,1:50),1))],1)' 10*log10(mean(psd_sham(RMiddleHippo,1:50),1))' 10*log10(mean(psd_post(RMiddleHippo,1:50),1))'],'Linewidth',1.5)
grid on
xlim([0 50])
title('RMiddleHippo');
subplot(2,3,2)
plot(fpsd(1:50),[mean([10*log10(mean(psd_pre1(RAmygdala,1:50),1));10*log10(mean(psd_pre2(RAmygdala,1:50),1))],1)' 10*log10(mean(psd_sham(RAmygdala,1:50),1))' 10*log10(mean(psd_post(RAmygdala,1:50),1))'],'Linewidth',1.5)
grid on
xlim([0 50])
title('RAmygdala');
subplot(2,3,3)
plot(fpsd(1:50),[mean([10*log10(mean(psd_pre1(RPosteriorHippo,1:50),1));10*log10(mean(psd_pre2(RPosteriorHippo,1:50),1))],1)' 10*log10(mean(psd_sham(RPosteriorHippo,1:50),1))' 10*log10(mean(psd_post(RPosteriorHippo,1:50),1))'],'Linewidth',1.5)
grid on
xlim([0 50])
title('RPosteriorHippo');
subplot(2,3,4)
plot(fpsd(1:50),[mean([10*log10(mean(psd_pre1(RInferiorAnteriorOccipital,1:50),1));10*log10(mean(psd_pre2(RInferiorAnteriorOccipital,1:50),1))],1)' 10*log10(mean(psd_sham(RInferiorAnteriorOccipital,1:50),1))' 10*log10(mean(psd_post(RInferiorAnteriorOccipital,1:50),1))'],'Linewidth',1.5)
grid on
xlim([0 50])
title('RInferiorAnteriorOccipital');
subplot(2,3,5)
plot(fpsd(1:50),[mean([10*log10(mean(psd_pre1(RSuperiorPosteriorOccipital,1:50),1));10*log10(mean(psd_pre2(RSuperiorPosteriorOccipital,1:50),1))],1)' 10*log10(mean(psd_sham(RSuperiorPosteriorOccipital,1:50),1))' 10*log10(mean(psd_post(RSuperiorPosteriorOccipital,1:50),1))'],'Linewidth',1.5)
grid on
xlim([0 50])
title('RSuperiorPosteriorOccipital');
subplot(2,3,6)
plot(fpsd(1:50),[mean([10*log10(mean(psd_pre1(RParietal,1:50),1));10*log10(mean(psd_pre2(RParietal,1:50),1))],1)' 10*log10(mean(psd_sham(RParietal,1:50),1))' 10*log10(mean(psd_post(RParietal,1:50),1))'],'Linewidth',1.5)
grid on
xlim([0 50])
title('RParietal');

%%
%%
figure
subplot(2,3,1)
plot(fpsd(1:50),[mean([10*log10(mean(psd_pre1(LMiddleHippo,1:50),1));10*log10(mean(psd_pre2(LMiddleHippo,1:50),1))],1)' 10*log10(mean(psd_sham(LMiddleHippo,1:50),1))' 10*log10(mean(psd_post(LMiddleHippo,1:50),1))'],'Linewidth',1.5)
grid on
xlim([0 50])
title('LMiddleHippo');
subplot(2,3,2)
plot(fpsd(1:50),[mean([10*log10(mean(psd_pre1(RAmygdala,1:50),1));10*log10(mean(psd_pre2(RAmygdala,1:50),1))],1)' 10*log10(mean(psd_sham(RAmygdala,1:50),1))' 10*log10(mean(psd_post(RAmygdala,1:50),1))'],'Linewidth',1.5)
grid on
xlim([0 50])
title('LAmygdala');
subplot(2,3,3)
plot(fpsd(1:50),[mean([10*log10(mean(psd_pre1(LPosteriorHippo,1:50),1));10*log10(mean(psd_pre2(LPosteriorHippo,1:50),1))],1)' 10*log10(mean(psd_sham(LPosteriorHippo,1:50),1))' 10*log10(mean(psd_post(LPosteriorHippo,1:50),1))'],'Linewidth',1.5)
grid on
xlim([0 50])
title('LPosteriorHippo');
subplot(2,3,4)
plot(fpsd(1:50),[mean([10*log10(mean(psd_pre1(LInferiorAnteriorOccipital,1:50),1));10*log10(mean(psd_pre2(LInferiorAnteriorOccipital,1:50),1))],1)' 10*log10(mean(psd_sham(LInferiorAnteriorOccipital,1:50),1))' 10*log10(mean(psd_post(LInferiorAnteriorOccipital,1:50),1))'],'Linewidth',1.5)
grid on
xlim([0 50])
title('LInferiorAnteriorOccipital');
subplot(2,3,5)
plot(fpsd(1:50),[mean([10*log10(mean(psd_pre1(LSuperiorPosteriorOccipital,1:50),1));10*log10(mean(psd_pre2(LSuperiorPosteriorOccipital,1:50),1))],1)' 10*log10(mean(psd_sham(LSuperiorPosteriorOccipital,1:50),1))' 10*log10(mean(psd_post(RSuperiorPosteriorOccipital,1:50),1))'],'Linewidth',1.5)
grid on
xlim([0 50])
title('LSuperiorPosteriorOccipital');
subplot(2,3,6)
plot(fpsd(1:50),[mean([10*log10(mean(psd_pre1(LParietal,1:50),1));10*log10(mean(psd_pre2(LParietal,1:50),1))],1)' 10*log10(mean(psd_sham(LParietal,1:50),1))' 10*log10(mean(psd_post(LParietal,1:50),1))'],'Linewidth',1.5)
grid on
xlim([0 50])
title('LParietal');