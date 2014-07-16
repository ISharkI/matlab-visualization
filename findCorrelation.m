function [ out ] = findCorrelation( inputsig )
%UNTITLED Summary of this function goes here
%   parameter: target
%   0=autocorrelation, 1=short 802.11g training sequence, 2=long 802.11g
%   training sequence, 3=user-defined signal
argsLength=inputsig(1);
if (argsLength==0)
    error('not enough arguments');
end
targ=inputsig(2);
sig1=inputsig(argsLength+2:end);


                if (targ==0);
                    sig2=sig1;
                elseif (targ==1);
                        load('shortt.mat');
                        sig2=shortt;
                elseif(targ==2)
                        load('longt.mat');
                        sig2=longt;
                else                 
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
    
    
                end
[result,lags]=(xcorr(sig1,sig2));
pos = lags(abs(result)>=(max(abs(result))*1));
out=sig1(pos:end);

end

