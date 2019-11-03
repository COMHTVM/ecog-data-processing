%% Read Neuralynx Inputs v0.1
% readInputs.m
% Author: Raaj Chatterjee
% eBrain Lab SFU
% raajc@sfu.ca
%% Import from Neuralynx Input Channels
clear;
%change each time
patient_num = '477';
cd 477_020/inputs; %All .ncs files with data stored should be in this folder, empty files should be deleted
num_inputs = 2;

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
%data=zeros(size(sorted_filenames,1),numel(Samples));
data=zeros(num_inputs,numel(Samples));

for i=1:num_inputs %size(sorted_filenames,1)
    i
filetoread=sorted_filenames{i};
[Timestamps, ChannelNumbers, SampleFrequencies, NumberOfValidSamples, Samples, Header] = ...
    Nlx2MatCSC(filetoread,[1 1 1 1 1], 1, 1, [] );
data(i,:)=reshape(Samples,1,size(Samples,1)*size(Samples,2));
end
cd .. % Return to original directory
cd ..
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

%% Detect TMS peaks
detect_from_datapoint = 0; % Cut off peaks from pre-stimulus data
peak_thres = 30000; % ADC saturates at 32768 or 2^15
nstim = 150; % Number of expected total stimulations
kchan = 2;
npoints = length(EEG.data(kchan,:));

[~,loc] = findpeaks(EEG.data(kchan,:),'MinPeakHeight',peak_thres); % Find TMS pulses from the first data channel
loc = loc(loc > detect_from_datapoint);
loc = cluster_loc_1D(loc,nstim,@mean); %Remove multiple repeated peaks via kmeans clustering
print = strcat(num2str(nstim)," Peaks found")
%% Sanity Check on Events
t = 0:1/Fs:length(EEG.data(1,:))/Fs-1/Fs; % Get Seconds
figure
plot(t,EEG.data(kchan,:))
for i=1:length(loc)
xline(t(round(loc(i))));
end
%% Load EEGLAB Events
EEG.event='';

for j=1:length(loc)
     if j < 51
        EEG.event(j,1).type = 'Pre-Sham';
     elseif j>50 && j<101
        EEG.event(j,1).type = 'Active';
     else
         EEG.event(j,1).type = 'Post-Sham';
     end
     EEG.event(j,1).latency = loc(j); %latency in samples
     EEG.event(j,1).urevent = j;
end
print = "Stimulation events loaded to EEGLAB"
eeglab redraw
%% Resample to 2000 Hz
if Fs > 2000
    EEG = pop_resample( EEG, 2000);
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off'); 
    eeglab redraw;
end
%% Export events
export_event = EEG.event;
event_file_name = strcat(patient_num,'_eeglab_event.mat');
save(event_file_name, 'export_event');
print = strcat(event_file_name,' has been saved')