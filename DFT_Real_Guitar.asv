% Sam Stone and Isaac Lawson-Hughes
function DFT_Real_Guitar()
close all
Fs = 4410;
T = 1/Fs;
Nzp = 2^15;
% Read audiofiles
x_E = audioread('E_string.wav').';
x_A = audioread('A_string.wav').';
X_A_H = fftshift(fft(x_A.*hamming(size(x_A,2))',Nzp));

t = ((-Nzp/2):(Nzp/2-1))*Fs/Nzp; % used to plot DFT

% A
figure;
subplot(2,1,1); plot(t,20*log10(abs(X_A)));
title('|X_A| in db vs f');
xlim([0 1000]);
ylim auto;
subplot(2,1,2); plot(t,20*log10(abs(X_A_H)));
title('|X_A| with hamming window in db vs f');
xlim([0 1000]);
ylim auto;

% D
figure;
subplot(2,1,1); plot(t,20*log10(abs(X_D)));
title('|X_D| in db vs f');
xlim([0 1000]);
ylim auto;
subplot(2,1,2); plot(t,20*log10(abs(X_D_H)));
title('|X_D| with hamming window in db vs f');
xlim([0 1000]);
ylim auto;

% E
figure;
subplot(2,1,1); plot(t,20*log10(abs(X_E)));
title('|X_E| in db vs f');
xlim([0 1000]);
ylim auto;
subplot(2,1,2); plot(t,20*log10(abs(X_E_H)));
title('|X_E| with hamming window in db vs f');
xlim([0 1000]);
ylim auto;

