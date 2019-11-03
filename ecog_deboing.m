x_deboinged = zeros(size(x));
size_x = size(x);
event_samp = 1975;
for ii = 1:size_x(2)
channel = ii
for jj = 1:size_x(3)
forward = nt_deboing(x(:,ii,jj),event_samp);
% try 
% backward = nt_deboing(flip(forward), event_samp);
% deboinged = flip(backward);
% catch
deboinged = forward;
% warning(strcat('Channel ', num2str(ii), ',trial ', num2str(jj),' was not successfully deboinged'))
% end
x_deboinged(:,ii,jj) = deboinged; 
end
end
%%
save('460_deboinged_minus12p5ms_samp.mat','x_deboinged');
%%
% figure
% for j = 1:185
% hold on 
% plot(-1000:0.5:1000-0.5,[mean(x(:,j,1:50),3),mean(x_deboinged(:,j,1:50),3)],'LineWidth',0.75)
% end 
figure
for j = 1:185
hold on 
plot(-1000:0.5:1000-0.5,x_deboinged(:,j,48),'LineWidth',0.75)
end 
xlabel('milliSeconds','FontSize',14)
ylabel('microVolts','FontSize',14)
title('Ringing Artifact removal (Active)','FontSize',14)
ylim([-500 500])
xlim([-100 100])