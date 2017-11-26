% Sam Stone and Isaac Lawson-Hughes
function [x_E,x_A,x_D] = DFT_Real_Guitar()
Fs = 4410;
T = 1/Fs;
Nzp = 2^15;
% Read audiofiles
x_E = audioread('E_string.wav').';
x_A = audioread('A_string.wav').';
x_D = audioread('D_string.wav').';
% Plot A,D,E
figure;
t_A = (0:(size(x_A,2)-1))*T;
t_D = (0:(size(x_D,2)-1))*T;
t_E = (0:(size(x_E,2)-1))*T;
subplot(3,1,1); plot(t_E,x_E);
title('E');
subplot(3,1,2); plot(t_A,x_A)
title('A');
subplot(3,1,3); plot(t_D,x_D)
title('D');

% Extract 4 to 5 seconds of A,D,E and plot
x_E = x_E((4*Fs):(5*Fs));
x_D = x_D((4*Fs):(5*Fs));
x_A = x_A((4*Fs):(5*Fs));
figure;
t_A = (0:(size(x_A,2)-1))*T;
t_D = (0:(size(x_D,2)-1))*T;
t_E = (0:(size(x_E,2)-1))*T;
t_A = t_A + 4;
t_D = t_D + 4;
t_E = t_E + 4;
subplot(3,1,1); plot(t_E,x_E);
title('E');
subplot(3,1,2); plot(t_A,x_A)
title('A');
subplot(3,1,3); plot(t_D,x_D)
title('D');
% Compute DFT using FFT without hamming window
X_E = fftshift(fft(x_E,Nzp));
X_D = fftshift(fft(x_D,Nzp));
X_A = fftshift(fft(x_A,Nzp));
% Compute DFT with hamming window
X_E_H = fftshift(fft(x_E.*hamming(size(x_E,2))',Nzp));
X_D_H = fftshift(fft(x_D.*hamming(size(x_D,2))',Nzp));
X_A_H = fftshift(fft(x_A.*hamming(size(x_A,2))',Nzp));

t = ((-Nzp/2):(Nzp/2-1))*Fs/Nzp; % used to plot DFT

% A
figure;
subplot(2,1,1); plot(t,log(abs(X_A))/log(10));
title('|X_A| in db vs f');
axis([0 1000 -3 3]);
subplot(2,1,2); plot(t,log(abs(X_A_H))/log(10));
title('|X_A| with hamming window in db vs f');
axis([0 1000 -3 3]);

% D
figure;
subplot(2,1,1); plot(t,log(abs(X_D))/log(10));
title('|X_D| in db vs f');
axis([0 1000 -3 3]);
subplot(2,1,2); plot(t,log(abs(X_D_H))/log(10));
title('|X_D| with hamming window in db vs f');
axis([0 1000 -3 3]);

% E
figure;
subplot(2,1,1); plot(t,log(abs(X_E))/log(10));
title('|X_E| in db vs f');
axis([0 1000 -3 3]);
subplot(2,1,2); plot(t,log(abs(X_E_H))/log(10));
title('|X_E| with hamming window in db vs f');
axis([0 1000 -3 3]);


