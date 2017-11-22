% Sam Stone and Isaac Lawson-Hughes
% DFT 

function DFT_1_Sine(f1,N,Nzp)

Fs = 4410; % in hertz
f = (1:N)*(1/Fs);
x = sin(2*pi*f1*f);
X = fftshift(fft(x,Nzp));

% Hamming Window
w = hamming(N);
w = w.'; % transpose
% Second figure, hamming windows vs. N
figure
n = 0:(size(w,2)-1);
plot(n,w);
title('hamming window vs. n');
xlabel('n');
ylabel('w');
axis([0 N 0 1]);

% First Subplot, |X| in db vs. f
figure
subplot(2,1,1); plot((((-Nzp/2):(Nzp/2-1))*Fs/Nzp),20*log10(abs(X)));
title('|X| in db vs. f');
xlabel('f/pi');
ylabel('|X|');
xlim([0 Fs/2]);
ylim auto;
subplot(2,1,1); plot((((-Nzp/2):(Nzp/2-1))*Fs/Nzp),abs(X));
title('|X| in db vs. f');
xlabel('f/pi');
ylabel('|X|');
%axis([0 Fs/2 0 10]);

% Second Subplot, |Y| in db vs. f
y = x.*w;
Y = fftshift(fft(y,Nzp));
subplot(2,1,2); plot((((-Nzp/2):(Nzp/2-1))*Fs/Nzp),20*log10(abs(Y)));
subplot(2,1,2); plot((((-Nzp/2):(Nzp/2-1))*Fs/Nzp),abs(Y));
title('|X| in db vs. f with hamming window');
xlabel('f');
ylabel('|X|');
xlim([0 Fs/2]);
ylim auto;
