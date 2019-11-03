clear
close all

load MSEpost
load MSEpre1
load MSEpre2
load MSEsham
%%
pre1=[120000:8:420000];
pre2=[1120000:8:1420000];
sham=[1920000:8:2220000];
post=[3151000:8:3451000];

%%
for k=1:6
figure
for i=1:15
subplot(5,3,i)
plot([MSEpre1((1+(k-1)*15)+i-1,:)' MSEpre2((1+(k-1)*15)+i-1,:)' MSEsham((1+(k-1)*15)+i-1,:)' MSEpost((1+(k-1)*15)+i-1,:)'],'Linewidth',1.5)
title(strcat(['Chan' num2str((1+(k-1)*15)+i-1)]));
end
end

%%
load loc430

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
plot([mean([(mean(MSEpre1(RMiddleHippo,1:100),1));(mean(MSEpre2(RMiddleHippo,1:100),1))],1)' (mean(MSEsham(RMiddleHippo,1:100),1))' (mean(MSEpost(RMiddleHippo,1:100),1))'],'Linewidth',1.5)
grid on
xlim([0 100])
title('RMiddleHippo');
subplot(2,3,2)
plot([mean([(mean(MSEpre1(RAmygdala,1:100),1));(mean(MSEpre2(RAmygdala,1:100),1))],1)' (mean(MSEsham(RAmygdala,1:100),1))' (mean(MSEpost(RAmygdala,1:100),1))'],'Linewidth',1.5)
grid on
xlim([0 100])
title('RAmygdala');
subplot(2,3,3)
plot([mean([(mean(MSEpre1(RPosteriorHippo,1:100),1));(mean(MSEpre2(RPosteriorHippo,1:100),1))],1)' (mean(MSEsham(RPosteriorHippo,1:100),1))' (mean(MSEpost(RPosteriorHippo,1:100),1))'],'Linewidth',1.5)
grid on
xlim([0 100])
title('RPosteriorHippo');
subplot(2,3,4)
plot([mean([(mean(MSEpre1(RInferiorAnteriorOccipital,1:100),1));(mean(MSEpre2(RInferiorAnteriorOccipital,1:100),1))],1)' (mean(MSEsham(RInferiorAnteriorOccipital,1:100),1))' (mean(MSEpost(RInferiorAnteriorOccipital,1:100),1))'],'Linewidth',1.5)
grid on
xlim([0 100])
title('RInferiorAnteriorOccipital');
subplot(2,3,5)
plot([mean([(mean(MSEpre1(RSuperiorPosteriorOccipital,1:100),1));(mean(MSEpre2(RSuperiorPosteriorOccipital,1:100),1))],1)' (mean(MSEsham(RSuperiorPosteriorOccipital,1:100),1))' (mean(MSEpost(RSuperiorPosteriorOccipital,1:100),1))'],'Linewidth',1.5)
grid on
xlim([0 100])
title('RSuperiorPosteriorOccipital');
subplot(2,3,6)
plot([mean([(mean(MSEpre1(RParietal,1:100),1));(mean(MSEpre2(RParietal,1:100),1))],1)' (mean(MSEsham(RParietal,1:100),1))' (mean(MSEpost(RParietal,1:100),1))'],'Linewidth',1.5)
grid on
xlim([0 100])
title('RParietal');

%%
figure
subplot(2,3,1)
plot([mean([(mean(MSEpre1(LMiddleHippo,1:100),1));(mean(MSEpre2(LMiddleHippo,1:100),1))],1)' (mean(MSEsham(LMiddleHippo,1:100),1))' (mean(MSEpost(LMiddleHippo,1:100),1))'],'Linewidth',1.5)
grid on
xlim([0 100])
title('LMiddleHippo');
subplot(2,3,2)
plot([mean([(mean(MSEpre1(RAmygdala,1:100),1));(mean(MSEpre2(RAmygdala,1:100),1))],1)' (mean(MSEsham(RAmygdala,1:100),1))' (mean(MSEpost(RAmygdala,1:100),1))'],'Linewidth',1.5)
grid on
xlim([0 100])
title('LAmygdala');
subplot(2,3,3)
plot([mean([(mean(MSEpre1(LPosteriorHippo,1:100),1));(mean(MSEpre2(LPosteriorHippo,1:100),1))],1)' (mean(MSEsham(LPosteriorHippo,1:100),1))' (mean(MSEpost(LPosteriorHippo,1:100),1))'],'Linewidth',1.5)
grid on
xlim([0 100])
title('LPosteriorHippo');
subplot(2,3,4)
plot([mean([(mean(MSEpre1(LInferiorAnteriorOccipital,1:100),1));(mean(MSEpre2(LInferiorAnteriorOccipital,1:100),1))],1)' (mean(MSEsham(LInferiorAnteriorOccipital,1:100),1))' (mean(MSEpost(LInferiorAnteriorOccipital,1:100),1))'],'Linewidth',1.5)
grid on
xlim([0 100])
title('LInferiorAnteriorOccipital');
subplot(2,3,5)
plot([mean([(mean(MSEpre1(LSuperiorPosteriorOccipital,1:100),1));(mean(MSEpre2(LSuperiorPosteriorOccipital,1:100),1))],1)' (mean(MSEsham(LSuperiorPosteriorOccipital,1:100),1))' (mean(MSEpost(RSuperiorPosteriorOccipital,1:100),1))'],'Linewidth',1.5)
grid on
xlim([0 100])
title('LSuperiorPosteriorOccipital');
subplot(2,3,6)
plot([mean([(mean(MSEpre1(LParietal,1:100),1));(mean(MSEpre2(LParietal,1:100),1))],1)' (mean(MSEsham(LParietal,1:100),1))' (mean(MSEpost(LParietal,1:100),1))'],'Linewidth',1.5)
grid on
xlim([0 100])
title('LParietal');