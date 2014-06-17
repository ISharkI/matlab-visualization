function [ output ] = correlation( inputsig )
%UNTITLED Summary of this function goes here
%   1 'length of signal 1' [signal 1] [signal 2]
argsLength=inputsig(1);
if (argsLength==0)
    error('not enough arguments');
end
length1=inputsig(2);
sig1=inputsig(argsLength+2:argsLength+1+length1);


%get second signal from disk
prompt = 'Please enter name of mat-file containing the second signal in time domain: ';
str = input(prompt,'s');
if isempty(str)
    error('ERROR: No Filename defined!');
end
if (exist('inputFileLocation', 'file') ~= 2) == 0
     error('ERROR: Found no inputsig File!');
end

load(str);
    
    % check if file is correct
    % this means it contains two vertical arrays v (values) and t (time)
    
    if ~exist('t','var') || ~exist('v','var')
        error('ERROR: Found no valid inputsig File!');
    else
        dimt = size(t);
        dimv = size(v);
        if (dimt(2) > 1 || dimv(2) > 1 || dimt(1) ~= dimv(1))
            error('ERROR: Found no valid inputsig File!');
        end
    end
    
    % return signal
    sig2 = rot90(v);
    sampleDist2 = t(2)-t(1);
    

output=xcorr(sig1,sig2);

end

