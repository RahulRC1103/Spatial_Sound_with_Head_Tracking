function [ s ] = genMeasSig( Tsweep, fs, f0, f1, Tsilence, Tfadein,  Tfadeout, isExp )
%Generates a measurement signal with the given parameters, using the
%genChirp() function.
% 
%USAGE
%   s = genMeasSig(Tsweep, fs, fstart, fstop, Tsilence, Tfadein, Tfadeout, isExp)
%  
%INPUT ARGUMENTS
%    Tsweep : length of the sweep signal [s]
%        fs : sampling frequency in Hertz
%        f0 : starting frequency in Hertz
%        f1 : stopping frequency in Hertz
%  Tsilence : silent interval after the
%             actual excitation signal ends [s]
%   Tfadein : fade in time [s]
%  Tfadeout : fade out time [s]
%     isExp : binary flag, 'true' for exponential sweep, 'false' for linear
% 
%OUTPUT ARGUMENTS
%   s : measurement signal (sweep signal with windowing and added silence) [N x 1]


%% Set default values for params
% 
% 
if nargin < 2 || nargin > 8
    error('Incorrect number of input arguments.')
end
if nargin < 8 || isempty(isExp)
    isExp = 1;
end
if nargin < 7 || isempty(Tfadeout)
    Tfadeout = 1e-4; % 0.1 ms
end
if nargin < 6 || isempty(Tfadein)
    Tfadein = 2e-3; % 2 ms
end
if nargin < 5 || isempty(Tsilence)
    Tsilence = Tsweep;
end
if nargin < 4 || isempty(f1)
    f1 = fs/2;
end
if nargin < 3 || isempty(f0)
    f0 = 10;
end

%% Generate sweep using provided parameters
% 
% 
[s, t] = genChirp(fs,f0,Tsweep,f1,0,isExp);


%% Windowing and zero-padding
% 
% % Length of sweep in samples
Nsweep = size(s,1); 

% Length of post-sweep silent interval in samples
Nsilence = ceil(Tsilence.*fs);

% Fade-in and fade-out lengths in samples
Nin = ceil(Tfadein.*fs);
Nout = ceil(Tfadeout.*fs);

% Reduce abrupt discontinuities at signal start and end by windowing, using
% the fade() function.
s = fade(s, Nin, Nout);

% Pad with zeros using the padZeros() function. 
s = padZeros(s, Nsilence);

end

