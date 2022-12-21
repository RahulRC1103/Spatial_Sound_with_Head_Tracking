function y = convolveFFT_OLS(x,h,N,bZeroPad)
%convolveFFT_OLS   Overlap-save method for FIR filtering using the FFT.
% 
%USAGE
%   y = convolveFFT_OLS(x,h)
%   y = convolveFFT_OLS(x,h,N,bZeroPad)
% 
%INPUT ARGUMENTS
%          x : input sequence [Nx x 1]
%          h : impulse response [M x 1]
%          N : DFT size (default, N = optimalN(Nx,M))
%   bZeroPad : binary flag indicating if the input x should be zero-padded 
%              if bZeroPad == true, the input sequence will be zero-padded
%                             to a length of Nx + M - 1, which produces an
%                             output identical to linear convolution 
%              if bZeroPad == false, the length of the input will not be
%                             changed, which means that the tail of the
%                             impulse response will be cut-off
%              (default, bZeroPad = false)  
% 
%OUTPUT ARGUMENTS
%   y : output sequence [Nx|Nx + M - 1 x 1]
% 
%   See also convolve, convolveFFT_OLA and optimalN.

%   Developed with Matlab 9.2.0.538062 (R2017a). Please send bug reports to
%   
%   Author  :  Tobias May, © 2017
%              Technical University of Denmark (DTU)
%              tobmay@elektro.dtu.dk
%
%   History :
%   v.0.1   2017/08/12
%   ***********************************************************************


%% CHECK INPUT ARGUMENTS
%
%
% Check for proper input arguments
if nargin < 2 || nargin > 4
    help(mfilename);
    error('Wrong number of input arguments!')
end

% Set default values
if nargin < 4 || isempty(bZeroPad); bZeroPad = false; end

% Get dimensions
xDim = size(x);
hDim = size(h);

% Check if x and h are vectors
if min(xDim) > 1 || min(hDim) > 1
    error('x and h must be vectors.')
else
    % Ensure column vectors
    x = x(:);
    h = h(:);
    
    % Dimensionality of x and h
    Nx = max(xDim);
    M = max(hDim);
    
    % Add M - 1 preceding zeros
    x = cat(1,zeros(M-1,1),x);

    % Perform zero-padding
    if bZeroPad
        % Append M - 1 zeros 
        x = cat(1,x,zeros(M-1,1));
        
        % Output signal length
        Ny = Nx + M - 1;
    else
        % Output signal length
        Ny = Nx;
    end
    
    % Total signal length that is processed
    Ntotal = numel(x);
end

% If N was not predefined, the optimal DFT size N will be determined 
if nargin < 3 || isempty(N)
    N = optimalN(Ntotal,M); 
end


%% OBTAIN SPECTRUM OF FIR FILTER
% 
% 
% Block length
L = N - M + 1;

% Zero-pad impulse response
h = cat(1,h,zeros(N - M,1));

% Compute H[k]
H = fft(h);


%% BLOCK-BASED CONVOLUTION IN THE FREQUENCY DOMAIN
% 
% 
% Number of blocks
nBlocks = ceil(Ntotal / L);

% Zero-pad input such that an integer number of blocks can be processed
x = cat(1,x,zeros(nBlocks * L - Nx,1));

% Allocate memory
y = zeros(nBlocks * L,1);

% Loop over the number of blocks
for ii = 1 : nBlocks

    % Extract ii-th block (L input samples plus M - 1 preceeding samples)
    xm = x((1:L + M - 1) + (ii-1) * L);
    
    % DFT
    Xm = fft(xm);
    
    % Multiplication with spectrum of impulse response
    Ym = Xm .* H;
    
    % IDFT
    ym = ifft(Ym);
        
    % Overlap-save L output samples (discard first M - 1 points)
    y((1:L) + (ii-1) * L) = ym(M:L + M - 1);
end

% Trim output signal
y = y(1:Ny);

