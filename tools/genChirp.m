function [x,t] = genChirp(fs,f0,T,f1,phi0,isExp)
%genChirp   Create a chirp signal
% 
%USAGE
%   [x,t] = genChirp(fs)
%   [x,t] = genChirp(fs,f0,T,f1,phi0,bExp)
%  
%INPUT ARGUMENTS
%      fs : sampling frequency in Hertz
%      f0 : instantaneous frequency in Hertz at time 0 (default, f0 = 0)
%       T : duration of chirp in seconds (default, T = 0.2)
%      f1 : instantaneous frequency in Hertz at time T (default, fs / 2)
%    phi0 : phase offset (default, phi0 = 0)
%   isExp : binary flag indicating if the chirp frequency changes
%           exponentially with time (default, isExp = true) 
%           isExp = true : the frequency increases exponentially with time
%           isExp = false : the frequency increases linearly with time 
% 
%OUTPUT ARGUMENTS
%   x : chirp signal [fs * T x 1]
%   t : time vector in seconds [fs * T x 1]
% 
%   genChirp(...) plots the chirp signal in a new figure.

%   Developed with Matlab 9.2.0.538062 (R2017a). Please send bug reports to
%   
%   Author  :  Tobias May, © 2017
%              Technical University of Denmark
%              tobmay@elektro.dtu.dk
%
%   History :
%   v.0.1   2017/08/19
%   ***********************************************************************


%% CHECK INPUT ARGUMENTS
%
%
% Check for proper input arguments
if nargin < 1 || nargin > 6
    help(mfilename);
    error('Wrong number of input arguments!')
end

% Set default values
if nargin < 6 || isempty(isExp); isExp = true;   end
if nargin < 5 || isempty(phi0);  phi0  = 0;      end
if nargin < 4 || isempty(f1);    f1    = fs / 2; end
if nargin < 3 || isempty(T);     T     = 200E-3; end
if nargin < 2 || isempty(f0);    f0    = 1;      end


%% CREATE CHIRP SIGNAL
% 
% 
% Discrete-time vector
Ts = 1 / fs;
t = (0:Ts:(T-Ts))';

% Select linear or exponential chirp
if isExp %exponential chirp
    % Check if f0 is larger than 0.5
    if f0 < 0.5
        error('The exponential sweep requires "f0 >= 0.5"')
    end
    
    % Instantaneous phase function
    % -- ADD YOUR CODE HERE ----------------------------------------------
    w0=2*pi*f0;
    w1=2*pi*f1;
    theta = w0*T/log(w1/w0)*(exp(t/T*log(w1/w0))-1);
else  %linear chirp
    % Rate of frequency change
    k = (f1 - f0) / T;
    
    % Instantaneous phase function
    theta = 2 * pi * (f0 + k/2 .* t) .* t + phi0;   
end

% Create chirp signal
x = sin(theta);


%% PLOT SIGNAL
% 
% 
% If no output arguments are specified
if nargout == 0
    figure;
    plot(t,x);
    xlabel('Time (s)')
    ylabel('Amplitude')
    if isExp
        title('Exponential chirp signal')
    else
        title('Linear chirp signal')
    end
    xlim([t(1) t(end)])
end