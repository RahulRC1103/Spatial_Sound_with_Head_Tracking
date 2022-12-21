function [optN,optC] = optimalN(Nx,M)
%optimalN   Determine the optimal DFT size N for block-based convolution
%
%USAGE
%   [optN,optC] = optimalN(Nx,M)
% 
%INPUT ARGUMENTS
%   Nx : length of input signal 
%    M : length of impulse response
%
%OUTPUT ARGUMENTS
%   optN : optimal DFT size for block-based convolution (OLA & OLS) which
%          aims at minimizing the algorithmic complexity  
%   optC : algorithmic complexity for the selected DFT size
%
%   optimalN(...) plots the algorithmic complexity and the optimal DFT size
%   in a new figure.  
% 
%   See also convolveFFT_OLA and convolveFFT_OLS.

%   Developed with Matlab 9.4.0.813654 (R2018a). Please send bug reports to
%
%   Author  :  Tobias May, © 2018
%              Technical University of Denmark
%              tobmay@elektro.dtu.dk
%
%   History :
%   v.0.1   2018/08/05
%   ***********************************************************************


%% CHECK INPUT ARGUMENTS
%
%
% Check for proper input arguments
if nargin ~= 2 
    help(mfilename);
    error('Wrong number of input arguments!')
end


%% SET-UP VECTOR WITH POSSIBLE DFT SIZES
% 
% 
% N must be larger than M-1 and is constraint to be a power of 2
N = 2.^(ceil(log2(M - 1)) : ceil(log2(M - 1)) + 10);

% Vector with corresponding block sizes
L = N - M + 1;


%% COMPUTE ALGORITHMIC COMPLEXITY
% 
% 
% Complexity in terms of required multiplications 
C = ceil(Nx ./ L) .* (N .* (log2(N) + 1));

% Select N that minimizes complexity
[optC,optIdx] = min(C);

% Return optimal DFT size
optN = N(optIdx);


%% PLOT ALGORITHMIC COMPLEXITY 
% 
% 
% If not output arguments are specified
if nargout == 0
    figure;
    loglog(N,C,'.-k','markersize',16)
    hold on;
    grid on;
    plot(optN,optC,'ro','markersize',12,'linewidth',2)
    set(gca,'xtick',N(1:4:end),'xticklabel',num2str(N(1:4:end)'))
    legend('complexcity C','optimal N')
    xlabel('DFT size N')
    ylabel('Complexity C')
    title(['Optimal N = ',num2str(optN)])
end

