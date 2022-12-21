function x = padZeros(x,nZeros)
%padZeros   Zero-pad input signal
%
%USAGE
%   x = padZeros(x,nZeros)
%
%INPUT ARGUMENTS
%        x : single-channel input signal [N x 1]
%   nZeros : number of zeros that should be added to the end of x
%
%OUTPUT ARGUMENTS
%   x : zero-padded signal [N + nZeros x 1]

%   Developed with Matlab 8.3.0.532 (R2014a). Please send bug reports to:
%
%   Author  :  Tobias May, © 2014
%              Technical University of Denmark (DTU)
%              tobmay@elektro.dtu.dk
%
%   History :
%   v.0.1   2014/07/17
%   ***********************************************************************


%% CHECK INPUT ARGUMENTS
%
%
% Check for proper input arguments
if nargin < 2 || nargin > 2
    help(mfilename);
    error('Wrong number of input arguments!')
end

% Check if "nZeros" are integers
if any(rem( nZeros,1) ~= 0)
    error('"nZeros" must be integer-valued.')
end

% Check if input is a vector
if min(size(x)) > 1
    error('Input signal x must be a vector.')
else
    % Ensure x is a colum vector
    x = x(:);
end


%% PERFORM ZERO-PADDING
%
%
% Zero-padding
% -- ADD YOUR CODE HERE ----------------------------------------------

if any(nZeros > 0)

    % Determine number of channels
    nChannels = size(x,2);
    
    switch numel(nZeros)
        case 1
            % Preceding zeros
            x = cat(1,x,zeros(nZeros,nChannels));
        case 2
            % Preceding and appended zeros
            x = cat(1,zeros(nZeros(1),nChannels),x,...
                zeros(nZeros(2),nChannels));
        otherwise
            error('"nZeros" must be either one or two-dimensional.')
    end
end