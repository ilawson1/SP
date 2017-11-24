% Samuel Stone and Isaac Lawson-Hughes
function fo_est = DFT_Tuner(x,b_E,b_A,b_D)
% First, Find the DFT of x and each filter
% See NS_29 3/16
Nzp = 2^15;
Fs = 4410;
X = fftshift(fft(x,Nzp));
B_E = fftshift(fft(b_E,Nzp));
B_D = fftshift(fft(b_D,Nzp));
B_A = fftshift(fft(b_A,Nzp));
% Find the product of the signal and the filter
y_E = X.*B_E;
y_A = X.*B_A;
y_D = X.*B_D;

% Find the power of each output with sum of squares
power_E = sum(y_E.^2)/size(y_E,2);
power_A = sum(y_A.^2)/size(y_A,2);
power_D = sum(y_D.^2)/size(y_D,2);
comp = [power_E ;power_A; power_D];
ref = [B_E B_A B_D];
[v,ind] = max(comp);
band = ref(ind);

%% Hamming window stuff
L  = length(x);
w = hamming(L)';
x_h = x.*w;
X_H = fftshift(fft(x_h,Nzp));
 figure; plot((1:size(X,2)),20*log10(abs(X)));
 figure; plot((1:size(X_H,2)),20*log10(abs(X_H)));
Y_H = X_H.*band;
figure; plot((1:size(Y_H,2)).*Fs,20*log10(abs(Y_H)));
hold on
plot((1:size(band,2)).*Fs,20*log10(abs(band)));

end