function [h_cross] = crossfade(h_pre, h_post)

N = length(h_pre);
f = 1/(2*N);
t = linspace(0,2*N-1,2*N);
w = (-cos(2*pi*f*t)/2+0.5)';
pre_w = w(N+1:2*N).*h_pre;
post_w = w(1:N).* h_post;
h_cross = pre_w + post_w;

end