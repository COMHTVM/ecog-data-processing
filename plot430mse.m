clear
close all

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
for k=1:6
figure
for i=1:15
    i
datapre1=EEG.data((1+(k-1)*15)+i-1,pre1);
datapre1=datapre1-mean(datapre1);
datapre1=datapre1/std(datapre1);
MSEpre1((1+(k-1)*15)+i-1,:)=multiscale_entropy(datapre1,2,0.15,100);
datapre2=EEG.data((1+(k-1)*15)+i-1,pre2);
datapre2=datapre2-mean(datapre2);
datapre2=datapre2/std(datapre2);
MSEpre2((1+(k-1)*15)+i-1,:)=multiscale_entropy(datapre2,2,0.15,100);
datasham=EEG.data((1+(k-1)*15)+i-1,sham);
datasham=datasham-mean(datasham);
datasham=datasham/std(datasham);
MSEsham((1+(k-1)*15)+i-1,:)=multiscale_entropy(datasham,2,0.15,100);
datapost=EEG.data((1+(k-1)*15)+i-1,post);
datapost=datapost-mean(datapost);
datapost=datapost/std(datapost);
MSEpost((1+(k-1)*15)+i-1,:)=multiscale_entropy(datapost,2,0.15,100);
subplot(5,3,i)
plot([MSEpre1((1+(k-1)*15)+i-1,:) MSEpre2((1+(k-1)*15)+i-1,:) MSEsham((1+(k-1)*15)+i-1,:) MSEpost((1+(k-1)*15)+i-1,:)],'Linewidth',1.5)
title(strcat(['Chan' num2str((1+(k-1)*15)+i-1)]));
end
end