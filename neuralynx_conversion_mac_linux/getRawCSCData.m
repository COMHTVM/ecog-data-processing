%
%reads the raw data from a neuralynx CSC file.
%
%urut/april04
function [Timestamps, ChannelNumbers, SampleFrequencies, NumberOfValidSamples, Samples, Header] = getRawCSCData( filename, fromInd, toInd, mode )
if nargin==3
    mode=2;
end

FieldSelection(1) = 1;%timestamps
FieldSelection(2) = 1;
FieldSelection(3) = 1;%sample freq
FieldSelection(4) = 1;
FieldSelection(5) = 1;%samples
ExtractHeader = 1;

ExtractMode = mode; % 2 = extract record index range; 4 = extract timestamps range.
ModeArray(1)=fromInd;
ModeArray(2)=toInd;

[Timestamps, ChannelNumbers, SampleFrequencies, NumberOfValidSamples, Samples, Header] = Nlx2MatCSC_v3(filename, FieldSelection, ExtractHeader, ExtractMode,ModeArray);

%flatten
Samples=Samples(:);

