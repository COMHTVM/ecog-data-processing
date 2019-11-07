%% Plot
%% Select Variable:
x_var = x;
% x_var = x_interp;
%x_var = x_baseline_detrend;
%x_var = x_exp_detrend;
%x_var = x_rereferenced;
% x_var = x_clean_line;
%% Select patient
patient = '477';
stim_type = 'pre-sham';

if strcmp(stim_type, 'active')
    stim_type_name = ' Active Stimulation ';
    stim_epochs = 51:100;
elseif strcmp(stim_type, 'pre-sham')
    stim_type_name = ' Pre-Stimulation Sham ';
    stim_epochs = 1:50;
else 
    stim_type_name = ' Pre-Stimulation Sham ';
    stim_epochs = 101:150;
end
% Frequency parameters
size_x = size(x_var);
Fs = 2000;
Nx = size_x(1);
nsc = floor(Nx/4.5);
nov = floor(nsc/2);
nff = max(256,2^nextpow2(nsc));
max_freq = 300;

fig = figure;

%% Spectral
for ii = 1:2:size_x(2)
hold on
[pxx, f] = nt_spect_plot(x_var(:,ii,stim_epochs), nsc, nov, nff, Fs);
line = plot(f,abs(pxx).^0.5);
line.MarkerSize = str2double(EEG.chanlocs(ii).labels); % Using MarkerSize as a dummy numeric variable
end
set(gca,'yscale','log');
xlim([f(1) max_freq]);
xlabel('Hz'); ylabel('Hz^{-0.5}', 'interpreter', 'tex');
title(strcat(patient,stim_type_name,' Re-referenced WelchPSD'), 'FontSize',14)

dcm_obj = datacursormode(fig);
set(dcm_obj,'UpdateFcn',@myfrequpdatefcn)
%% TEP
tep_integral = zeros(size_x(2),1);
for ii = 1:size_x(2)
hold on
tep = mean(x_var(:,ii,stim_epochs),3);
line = plot(-1000:0.5:1000-0.5,tep);
line.MarkerSize = str2double(EEG.chanlocs(ii).labels); % Using MarkerSize as a dummy numeric variable
tep_integral(ii)=max(tep(2020:3000))-min(tep(2020:3000));
end
xlim([-200 1000]);
xlabel('milliSeconds'); ylabel('microVolts');
title(strcat(patient,stim_type_name,' TEP'), 'FontSize',14)
dcm_obj = datacursormode(fig);
set(dcm_obj,'UpdateFcn',@myupdatefcn)

%% Process
%% interpolate data:
x_interp = cubic_interp(x,25,2000,2000);
%% Baseline detrend
% t_vec = -1000:0.5:999.5;
% figure
% hold on;
% plot(t_vec,x_interp(:,4,51));
[x_baseline_detrend]=nt_detrend(x_interp,0,[zeros(1,3000) ones(1,1000)]','polynomials',3,3);
% plot(t_vec,x_low_detrend);
% title('Baseline Removal (500-1000ms)','FontSize',14);
% legend('Raw','Baseline Removed');
% ylabel('microVolts');xlabel('milliSeconds');
%% Exponential detrend
artifact_start = 2025;
% figure
% w_high_detrend = [0.5*ones(artifact_start,1);ones(size_x(1)-artifact_start,1)]; 
x_exp_detrend = nt_detrend(x_baseline_detrend(artifact_start:size_x(1),:,:),1,[],'exp',5,3,200);
% plot(x_high_detrend);
% sgtitle('460 Exponential Detrending')
% legend('Raw','Low-order', 'High-order windowed');
%% Re-reference
[x_rereferenced, ref] =  nt_rereference(x_baseline_detrend); 
%% Line Noise filter - zapline
x_clean_line = nt_zapline(x_rereferenced, 60/2000);
%% Save
save('460_epoched_interp_baseline_cleanline.mat','x','x_interp','x_baseline_detrend', 'x_clean_line');