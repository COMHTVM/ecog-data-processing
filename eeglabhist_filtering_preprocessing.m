% EEGLAB history file generated on the 03-Oct-2019
% ------------------------------------------------
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename','EEG477_020_chan_removed.set','filepath','C:\\Users\\raajc\\Downloads\\Plot430\\');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
EEG = eeg_checkset( EEG );
EEG = pop_epoch( EEG, {  }, [0.01           1], 'newname', 'eeg_all_chan_removed epochs', 'epochinfo', 'yes');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off'); 
EEG = eeg_checkset( EEG );
EEG = pop_select( EEG, 'nochannel',{'86' '87'});
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'gui','off'); 
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
EEG = eeg_checkset( EEG );
%% EEG Lab Filtering
figure; pop_spectopo(EEG, 1, [20         800], 'EEG' , 'percent', 15, 'freqrange',[0 300],'electrodes','off');
EEG = pop_eegfiltnew(EEG, 'locutoff',57,'hicutoff',63,'revfilt',1,'plotfreqz',1);
%[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 3,'setname','eeg_all_chan_removed_epochs_notch60','overwrite','on','gui','off'); 
EEG = pop_eegfiltnew(EEG, 'locutoff',115,'hicutoff',125,'revfilt',1,'plotfreqz',1);
%[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 3,'setname','eeg_all_chan_removed_epochs_notch60120','overwrite','on','gui','off'); 
EEG = pop_eegfiltnew(EEG, 'locutoff',175,'hicutoff',185,'revfilt',1,'plotfreqz',1);
%[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 3,'setname','eeg_all_chan_removed_epochs_notch60120180','overwrite','on','gui','off'); 
EEG = pop_eegfiltnew(EEG, 'locutoff',235,'hicutoff',245,'revfilt',1,'plotfreqz',1);
%[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 6,'setname','eeg_all_chan_removed_epochs_notch60120180240','overwrite','on','gui','off'); 
EEG = pop_eegfiltnew(EEG, 'locutoff',0,'hicutoff',280,'plotfreqz',1);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 3,'setname','eeg_all_chan_removed_epochs_notch60_120_180_240_lp280','gui','off'); 
EEG = eeg_checkset( EEG );
figure; pop_spectopo(EEG, 1, [20         800], 'EEG' , 'percent', 15, 'freqrange',[0 300],'electrodes','off');
eeglab redraw;
%% Using adaptive power line filter
dim = size(EEG.data);
fs = 2000;
figure; pop_spectopo(EEG, 1, [20         800], 'EEG' , 'percent', 30, 'freqrange',[0 300],'electrodes','off');
for ii = 1:dim(3)
EEG.data(:,:,ii) = removePLI_multichan(EEG.data(:,:,ii), fs, 4, [50,0.2,1], [0.1,4,1],1);
end
figure; pop_spectopo(EEG, 1, [20         800], 'EEG' , 'percent', 30, 'freqrange',[0 300],'electrodes','off');
