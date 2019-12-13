figure
xlabel('Time/ms','FontSize',14); ylabel('Amplitude/\muV','FontSize',14);
title(strcat(patient,stim_type_name,' Channel 14 Multiple Trials'), 'FontSize',14)
xlim([-1000 1000])
ylim([-5 5])
for ii = 1:12
    hold on
    pause(0.5)
    plot(-1000:1/40000*1000:1000-1/40000,x_var(:,15,ii))
end
