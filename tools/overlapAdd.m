function [y,outBuffer]=overlapAdd(x,h_left,h_right,inBuffer)
L=length(x);
% M=length(h);
N=length(inBuffer); %N >= L+M-1
inBuffer=[inBuffer(:,1)+ifft(fft(h_left,N).*fft(x(:,1),N)),inBuffer(:,2)+ifft(fft(h_right,N).*fft(x(:,2),N))];
y=inBuffer(1:L,:);
outBuffer=[inBuffer(L+1:N,:); zeros(L,2)];
end