% Samuel Stone and Isaac Lawson-Hughes
function [x,X] = DFT_Synth_Guitar(fo)
%fo = 82.41;
Fs = 4410;
Nzp = 2^15;
T = 1/Fs;
% Amplitudes and Phases of the A&P FS
A = [0 0.07 0.025 0.013 0.007 0.003 0.002 0.0004 0.0003 0.0002 0.0001];
phase = 2*pi*rand(1,10);
t = 0:T:1; % time varies from zero to 1 seconds with the standard Fs
% Compute the FS for time t
x=0;
for i=1:10
    x =x+ A(i)*cos(fo*i*t+phase(i));
end

% %% Test written to show FS
% % NOT PART OF THE ACTUAL PROJECT
% xmag = abs(x);
% xphase = angle(x);
% figure;
% plot(t,xmag);
% title('x in terms of t');
% axis([0 0.15 -1 1]);
% 
%% DFT of the FS
figure;
X= fftshift(fft(x,Nzp));
X_H = fftshift(fft(x.*hamming(size(x,2))',Nzp));
N = size(X,2);
f = ((-N/2):(N/2-1))*Fs/Nzp;
subplot(2,1,1); plot(f,abs(X));
title('|X| in terms of f');
axis([0 1000 0 200]);
subplot(2,1,2); plot(f,abs(X_H));
title('|X| in terms of f with hamming window');
axis([0 1000 0 200]);
