% Sam Stone and Isaac Lawson-Hughes
function DFT_2_Sine(f1,f2,a,N,Nzp)
Fs = 4410; % in hertz
T = 1/Fs;
t = (0:(N-1))*T;
x = sin(2*pi*f1*t)+a*sin(2*pi*f2*t);
X = fftshift(fft(x,Nzp));
figure; plot(t,x);

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

% First Subplot, |X| in db vs. f
figure
subplot(2,1,1); plot((((-Nzp/2):(Nzp/2-1))*Fs/Nzp),log(abs(X))/log(10));
title('|X| in db vs. f');
xlabel('f/pi');
ylabel('|X|');

% Second Subplot, |Y| in db vs. f
y = x.*w;
Y = fftshift(fft(y,Nzp));
subplot(2,1,2); plot((((-Nzp/2):(Nzp/2-1))*Fs/Nzp),log(abs(Y))/log(10));
title('|Y| in db vs. f/pi');
xlabel('f');
ylabel('|Y|');
