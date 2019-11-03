%% Import from Neuralynx Data
clear;

%change each time
patient_num = '477';
experiment = '020';
cd 477_020; %All .ncs files with data stored should be in this folder, empty files should be deleted

namefile=dir('*.ncs'); % Get all .ncs files
all_file_details = struct2cell(namefile);
data_file_index = cell2mat(all_file_details(4,:)) >= 40000; %Files less than 40 kBytes will be removed
all_filenames = all_file_details(1,data_file_index)';
sorted_filenames = natsort(all_filenames); % Sort Filenames in order of channel number

channel_name = regexp(sorted_filenames, '\d+', 'match', 'once');
channel_num = cellfun(@str2num,channel_name);

% Get number of samples from first file in the folder
filetoread=sorted_filenames{1};
[Timestamps, ChannelNumbers, SampleFrequencies, NumberOfValidSamples, Samples, Header] = ...
    Nlx2MatCSC(filetoread,[1 1 1 1 1], 1, 1, [] );

% Initialize data from single channel
data=zeros(size(sorted_filenames,1),numel(Samples));

for i=1:size(sorted_filenames,1)
    i
filetoread=sorted_filenames{i};
[Timestamps, ChannelNumbers, SampleFrequencies, NumberOfValidSamples, Samples, Header] = ...
    Nlx2MatCSC(filetoread,[1 1 1 1 1], 1, 1, [] );
data(i,:)=reshape(Samples,1,size(Samples,1)*size(Samples,2));
end
cd .. % Return to original directory

%% Load and save to EEGLAB
eeglab
Fs=SampleFrequencies(1);
EEG = pop_importdata('setname','ecogdata_data','data',data,'srate',Fs);
for i=1:length(channel_num)
EEG.chanlocs(i).labels=num2str(channel_num(i));
EEG.urchanlocs(i).labels=num2str(channel_num(i));
end
pop_saveset( EEG );
eeglab redraw
%% Manual Peak Extraction from Data (only if inputs are unsueable)
% Fs = 2000;
% t_pre_sham_start = round(7.66*Fs);
% t_active_start = round(131.33*Fs);
% t_post_sham_start = round(254.71*Fs);
% sample_step = 2*Fs;
% 
% loc = horzcat(t_pre_sham_start:sample_step:t_pre_sham_start+49*sample_step,...
%     t_active_start:sample_step:t_active_start+49*sample_step,...
%     t_post_sham_start:sample_step:t_post_sham_start+49*sample_step);
%% Resample if required
if Fs > 2000
    EEG = pop_resample( EEG, 2000);
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off'); 
    eeglab redraw;
    print = 'Data resampled'
end
print = strcat('Sample rate: ',num2str(Fs))
%% Import Events 
load(strcat(patient_num,'_eeglab_event.mat'));
EEG.event = export_event;
eeglab redraw
loc = extractfield(EEG.event,'latency');
print= "Events loaded"
%% Sanity Check on Events
t = 0:1/Fs:length(EEG.data(1,:))/Fs-1/Fs; % Get Seconds
figure
plot(t,EEG.data(1,:))
for i=1:length(loc)
xline(t(round(loc(i))));
end
%% Load Channel Locations (load from .xyz file)
EEG=pop_chanedit(EEG);
%% Scale data to microvolts:
EEG.data = EEG.data*0.000000030517578125000001*10^6;
print = "Data scaled from ADC to microvolts"
%% Discard channels without locations
chan_remove_cell = {};
j=1;
for i=1:length(EEG.chanlocs)
if isempty(EEG.chanlocs(i).theta)
chan_remove_cell{j} = EEG.chanlocs(i).labels;
j = j+1;
end
end
EEG = pop_select( EEG, 'nochannel',chan_remove_cell);
% Save as new Dataset
EEG.setname='eeg_all_chan_removed';
EEG = eeg_checkset( EEG );
pop_saveset( EEG );
eeglab redraw
print = "Missing channels removed"
%% Epoch [-1 1]
EEG = eeg_checkset( EEG );
EEG = pop_epoch( EEG, {  }, [-1  1], 'newname', 'eeg_all_chan_removed epochs', 'epochinfo', 'yes');
%% Delete noisy channels (try using
if strcmp(patient_num, '477')
    EEG = pop_select( EEG, 'nochannel',{'66','67'});
end
%% Save to noisetools
x = permute(EEG.data,[2 1 3]);
save(strcat('raw_data/',patient_num,'_',experiment,'_raw_data.mat'), 'x');
print = "Raw data saved to variable x"
%% Save Active, Sham in Different Datasets
patient_experiment = strcat(patient_num,'_',experiment);
EEG = pop_saveset( EEG, 'filename','active.set','filepath',strcat('C:\\Users\\raajc\\Downloads\\Plot430\\NewDataProcessing\\',patient_experiment,'\\active\\'));
EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename','pre-sham.set','filepath',strcat('C:\\Users\\raajc\\Downloads\\Plot430\\NewDataProcessing\\',patient_experiment,'\\pre-sham\\'));
EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename','post-sham.set','filepath',strcat('C:\\Users\\raajc\\Downloads\\Plot430\\NewDataProcessing\\',patient_experiment,'\\post-sham\\'));
EEG = eeg_checkset( EEG );
%%
% load EEG
% %%
% k=6;
% figure
% for i=1:15
% subplot(5,3,i)
% plot((1:length(OUTEEG.data((1+(k-1)*15)+i-1,:,1)'))/8000,OUTEEG.data((1+(k-1)*15)+i-1,:,1)'*0.000000030517578125000001*10^6)
% end
% 
% %%
% for k=1:6
% for i=1:15
% (1+(k-1)*15)+i-1
% end
% end
% 
% %%
% figure
% for i=1:15
%     subplot(5,3,i)
% [psd,fpsd]=pwelch(OUTEEG.data(1,8000*3:end,i)',8000,0,8000,8000);
% plot(fpsd(1:100),10*log10(psd(1:100)),'r','Linewidth',1.5)
% end
% 
% 
% 
% %%
% figure
% plot((1:length(input'))/8000,input'*0.000000915527343749999970*10^6)
% xlabel('Time (s)')
% ylabel('Voltage (\muV)')
% title('Input')
% 
% %%
% close all
% for k=1:1
% figure
% for i=1:15
% subplot(5,3,i)
% plot((1:length(OUTEEG.data((1+(k-1)*15)+i-1,:,1)'))/8000,OUTEEG.data((1+(k-1)*15)+i-1,:,1)'*0.000000030517578125000001*10^6); 
% % hold on;
% % plot((1:length(OUTEEG.data((1+(k-1)*15)+i-1,:,1)'))/8000,OUTEEG.data((1+(k-1)*15)+i-1,:,2)'*0.000000030517578125000001*10^6,'r')
% title(strcat(['Chan' num2str((1+(k-1)*15)+i-1)]));
% end
% end
% 
% %%
% close all
% for k=1:6
% figure
% for i=1:15
% subplot(5,3,i)
% [psd,fpsd]=pwelch(OUTEEG.data((1+(k-1)*15)+i-1,8000*4:end,1)',8000,0,8000,8000);
% plot(fpsd(1:50),10*log10(psd(1:50)),'r','Linewidth',1.5)
% % plot((1:length(OUTEEG.data((1+(k-1)*15)+i-1,:,1)'))/8000,OUTEEG.data((1+(k-1)*15)+i-1,:,1)'*0.000000030517578125000001*10^6); 
% % hold on;
% % plot((1:length(OUTEEG.data((1+(k-1)*15)+i-1,:,1)'))/8000,OUTEEG.data((1+(k-1)*15)+i-1,:,2)'*0.000000030517578125000001*10^6,'r')
% title(strcat(['Chan' num2str((1+(k-1)*15)+i-1)]));
% xlim([0 50])
% end
% end
